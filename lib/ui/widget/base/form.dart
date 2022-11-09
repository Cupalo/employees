import 'package:employees/default/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required this.rxString,
    this.hint,
    this.obsecure,
  }) : super(key: key);
  final RxString rxString;
  final String? hint;
  final bool? obsecure;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: BaseTheme.marginAll,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        child: TextFormField(
          initialValue: rxString.value,
          onChanged: (value) {
            rxString.value = value;
          },
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          obscureText: obsecure ?? false,
        ),
      );
    });
  }
}
