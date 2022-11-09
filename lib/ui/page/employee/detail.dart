import 'package:employees/controllers.dart/data_controller.dart';
import 'package:employees/default/theme.dart';
import 'package:employees/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  Detail({Key? key, required this.id}) : super(key: key);
  final int id;
  final DataController dataController = Get.put(DataController());

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
              return Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  color: Colors.blue,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                )
                              ],
                              image: DecorationImage(
                                image:
                                    NetworkImage(snapshot.data!.avatar ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            '${snapshot.data!.firstName ?? ''} ${snapshot.data!.lastName ?? ''}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 2,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        ],
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
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.blue,
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
          // color: Colors.white,
          ),
    );
  }
}
