import 'package:dio/dio.dart';
import 'package:employees/models/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BaseApi {
  static Dio dio = Dio();

  // static var queryparameter = {'api_key': '45a7134d61b082ded030355d36218ca4'};
  static String baseApi = 'https://reqres.in/api/';
  static String employee = 'users';
  static String login = 'login';
  static String register = 'register';

  static Future<String?> auth(var body, String state) async {
    var api = baseApi + state;
    try {
      var response = await dio.post(
        api,
        data: body,
        // queryParameters: body,
        options: Options(
          // headers: headers,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (kDebugMode) {
        print(api);
        print('Status Code : ${response.statusCode}');
      }

      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200) {
        var token = response.data['token'];
        return token;
      } else {
        Get.snackbar('Authentication', '${state.capitalizeFirst} Failed');
        return null;
      }
    } on DioError {
      Get.snackbar('Authentication', 'Something went wrong');
      return null;
    } catch (e) {
      Get.snackbar('Authentication', e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  static Future<List<Employee>?> getList({int page = 1}) async {
    var api = '$baseApi$employee?page=$page';
    try {
      var response = await dio.get(api);

      if (kDebugMode) {
        print('Status Code : ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var list = List<Employee>.from(
            response.data['data'].map((e) => Employee.fromJson(e))).toList();
        return list;
      } else {
        return null;
      }
    } on DioError {
      Get.snackbar('Get Data', 'Something went wrong');
      return null;
    } catch (e) {
      Get.snackbar('Get Data', e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  static Future<Employee?> getDetail(int id) async {
    try {
      var response = await dio.get(
        '$baseApi$employee/$id',
      );

      if (kDebugMode) {
        print('Status Code : ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var list = Employee.fromJson(response.data['data']);
        return list;
      } else {
        return null;
      }
    } on DioError {
      Get.snackbar('Get Data', 'Something went wrong');
      return null;
    } catch (e) {
      Get.snackbar('Get Data', e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  static Future<dynamic> addEmployee(var body) async {
    var api = baseApi + employee;
    try {
      var response = await dio.post(
        api,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (kDebugMode) {
        print(api);
        print('Status Code : ${response.statusCode}');
      }

      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 201) {
        // var token = response.data;
        // return token;
        return response.data;
      } else {
        Get.snackbar('Authentication', 'Add Employee Failed');
        return null;
      }
    } on DioError {
      Get.snackbar('Authentication', 'Something went wrong');
      return null;
    } catch (e) {
      Get.snackbar('Authentication', e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  static Future<dynamic> editEmployee(var body, int id) async {
    var api = '$baseApi$employee/$id';
    try {
      var response = await dio.put(
        api,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (kDebugMode) {
        print(api);
        print('Status Code : ${response.statusCode}');
      }

      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        Get.snackbar('Authentication', 'Edit Employee Failed');
        return null;
      }
    } on DioError {
      Get.snackbar('Authentication', 'Something went wrong');
      return null;
    } catch (e) {
      Get.snackbar('Authentication', e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  static Future<dynamic> deleteEmployee(int id) async {
    var api = '$baseApi$employee/$id';
    try {
      var response = await dio.delete(
        api,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (kDebugMode) {
        print(api);
        print('Status Code : ${response.statusCode}');
      }

      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        Get.snackbar('Authentication', 'Delete Employee Failed');
        return null;
      }
    } on DioError {
      Get.snackbar('Authentication', 'Something went wrong');
      return null;
    } catch (e) {
      Get.snackbar('Authentication', e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
