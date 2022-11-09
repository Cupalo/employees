import 'package:employees/controllers.dart/auth_controller.dart';
import 'package:employees/default/theme.dart';
import 'package:employees/ui/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        authController.checkToken();
        Get.off(Root());
      },
    );
    return Scaffold(
      appBar: BaseTheme.appBar('splash'),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: const Center(
          // child: Image(
          //   image: AssetImage('assets/Logo.png'),
          // ),
          child: Text('EMPLOYEES'),
        ),
      ),
    );
  }
}
