import 'package:employees/controllers.dart/data_controller.dart';
import 'package:employees/default/theme.dart';
import 'package:employees/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  Detail({Key? key, required this.id}) : super(key: key);
  final int id;
  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTheme.appBar(''),
      body: FutureBuilder<Employee?>(
        future: dataController.getDetail(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 1),
                              color: Colors.grey,
                              blurRadius: 1,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 120,
                              foregroundImage:
                                  NetworkImage(snapshot.data!.avatar ?? ''),
                              child: Text(
                                snapshot.data!.firstName == null
                                    ? ''
                                    : snapshot.data!.firstName!.substring(0, 1),
                                style: const TextStyle(
                                  fontSize: 120,
                                ),
                              ),
                              onForegroundImageError: (exception, stackTrace) {
                                throw exception;
                              },
                            ),
                            Text(
                              '${snapshot.data!.firstName ?? ''} ${snapshot.data!.lastName ?? ''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: BaseTheme.fontSizeVeryLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: BaseTheme.marginRectangular,
                        child: Column(
                          children: [
                            card('First Name', snapshot.data!.firstName ?? ''),
                            card('Last Name', snapshot.data!.lastName ?? ''),
                            card('Email', snapshot.data!.email ?? ''),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No Data'),
              );
            }
          }
        },
      ),
    );
  }

  Widget card(String text1, String text2) {
    return Container(
      margin: BaseTheme.marginVertical,
      padding: BaseTheme.marginRectangular,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: text(text1),
          ),
          text(': '),
          Expanded(
            flex: 2,
            child: text(text2),
          ),
        ],
      ),
    );
  }

  Widget text(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
