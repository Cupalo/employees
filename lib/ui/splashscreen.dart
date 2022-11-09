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
      body: Container(
        width: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.people_outline,
              size: 120,
              shadows: [
                Shadow(
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  color: Colors.white,
                )
              ],
            ),
            Text(
              'Employees',
              style: TextStyle(
                fontSize: 60,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
