import 'package:employees/default/theme.dart';
import 'package:employees/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employees/api/base_api.dart';

class DataController extends GetxController {
  static const String add = 'Add';
  static String edit = 'Edit';
  var query = ''.obs;
  var content = ''.obs;
  var page = 1.obs;
  var isLoading = false.obs;
  var isCanGetMore = false.obs;
  var isGetMoreLoading = false.obs;
  var dataState = 'Add'.obs;
  var name = ''.obs;
  var job = ''.obs;
  RxList<Employee> listEmployee = List<Employee>.empty().obs;

  void refreshPage() {
    page.value = 1;
  }

  Future<List<Employee>?> getData() async {
    isLoading.value = true;
    var response = await BaseApi.getList();

    if (response != null) {
      listEmployee.value = response;
      isCanGetMore.value = true;
      isLoading.value = false;
      return response;
    } else {
      isLoading.value = false;
      return null;
    }
  }

  Future<List<Employee>?> getMore() async {
    page.value++;
    isGetMoreLoading.value = true;
    var response = await BaseApi.getList(page: page.value);

    if (response != null) {
      if (response.isNotEmpty) {
        listEmployee.addAll(response);
        isCanGetMore.value = true;
      } else {
        page.value--;
        isCanGetMore.value = false;
      }

      isGetMoreLoading.value = false;

      return response;
    } else {
      isGetMoreLoading.value = false;
      return null;
    }
  }

  Future<Employee?> getDetail(int id) async {
    var response = await BaseApi.getDetail(id);

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<dynamic> addEmployee(String name, String job) async {
    var body = {
      'name': name,
      'job': job,
    };
    var response = await BaseApi.addEmployee(body);

    if (response != null) {
      Get.defaultDialog(
        title: 'Employee Added',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('name : ${response['name']}'),
            Text('job : ${response['job']}'),
            Text('id : ${response['id']}'),
            Text('createdAt : ${BaseTheme.dateFormat(response['createdAt'])}'),
          ],
        ),
        onConfirm: () => Get.close(2),
      );
      return response;
    } else {
      return null;
    }
  }

  Future<Employee?> editEmployee(String name, String job, int id) async {
    var response = await BaseApi.getDetail(id);

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }
}
