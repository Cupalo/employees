import 'package:employees/controllers.dart/auth_controller.dart';
import 'package:employees/ui/page/employee/add.dart';
import 'package:employees/ui/page/employee/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employees/controllers.dart/data_controller.dart';
import 'package:employees/default/theme.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final DataController dataController = Get.put(DataController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => dataController.getData());
    return Obx(() {
      return Scaffold(
        appBar: BaseTheme.appBar('EMPLOYEES', actions: [
          IconButton(
            onPressed: () => logoutDialog(),
            icon: const Icon(Icons.logout),
          )
        ]),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
                if (dataController.isCanGetMore.value) {
                  dataController.getMore();
                }
              }
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () {
              dataController.refreshPage();
              return Future.delayed(
                Duration.zero,
                () => dataController.getData(),
              );
            },
            child: ListView(
              children: [
                dataController.isLoading.value
                    ? SizedBox(
                        height: Get.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : dataController.listEmployee.isEmpty
                        ? const Center(
                            child: Text('No Data'),
                          )
                        : ListView.builder(
                            padding: BaseTheme.marginVertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: dataController.listEmployee.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Get.to(
                                  Detail(
                                      id: dataController
                                              .listEmployee[index].id ??
                                          0),
                                ),
                                child: ListTile(
                                  contentPadding: BaseTheme.marginAll,
                                  leading: CircleAvatar(
                                    radius: 30,
                                    foregroundImage: NetworkImage(
                                      dataController
                                              .listEmployee[index].avatar ??
                                          '',
                                    ),
                                    onForegroundImageError:
                                        (exception, stackTrace) {
                                      throw exception;
                                    },
                                    child: Text(
                                      dataController.listEmployee[index]
                                                  .firstName ==
                                              null
                                          ? ''
                                          : dataController
                                              .listEmployee[index].firstName!
                                              .substring(0, 1),
                                    ),
                                  ),
                                  title: Text(
                                    '${(dataController.listEmployee[index].firstName ?? '')} ${(dataController.listEmployee[index].lastName ?? '')}',
                                  ),
                                  subtitle: Text(dataController
                                          .listEmployee[index].email ??
                                      ''),
                                ),
                              );
                            },
                          ),
                Visibility(
                  visible: dataController.isGetMoreLoading.value ? true : false,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(AddEmployee()),
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  logoutDialog() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure ?',
      onConfirm: () {
        authController.logout();
      },
      textCancel: 'Cancel',
    );
  }
}
