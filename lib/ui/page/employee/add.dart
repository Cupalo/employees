import 'package:employees/controllers.dart/data_controller.dart';
import 'package:employees/default/theme.dart';
import 'package:employees/ui/widget/base/form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployee extends StatelessWidget {
  AddEmployee({
    Key? key,
    this.id,
  }) : super(key: key);
  final int? id;
  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTheme.appBar(DataController.add),
      body: Container(
        padding: BaseTheme.marginRectangularLarge,
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
              flex: 2,
              child: Container(),
            ),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(2, 2),
                    color: Colors.blue,
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: const Icon(
                Icons.person,
                size: 40,
              ),
            ),
            Expanded(child: Container()),
            FormWidget(
              hint: 'Name',
              rxString: dataController.name,
            ),
            Expanded(child: Container()),
            FormWidget(
              hint: 'Job',
              rxString: dataController.job,
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget text(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 60,
      ),
    );
  }

  onPressed() {
    if (Get.focusScope != null) {
      if (Get.focusScope!.hasPrimaryFocus) {
        Get.focusScope!.unfocus();
      }
    }
    if (kDebugMode) {
      print(dataController.name.value);
      print(dataController.job.value);
    }
    if (dataController.name.isNotEmpty && dataController.job.isNotEmpty) {
      if (id == null) {
        dataController.addEmployee(
          dataController.name.value,
          dataController.job.value,
        );
      } else {
        dataController.editEmployee(
          dataController.name.value,
          dataController.job.value,
          id!,
        );
      }
    }
  }
}
