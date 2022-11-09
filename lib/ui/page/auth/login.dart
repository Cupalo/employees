import 'package:employees/api/base_api.dart';
import 'package:employees/controllers.dart/auth_controller.dart';
import 'package:employees/default/theme.dart';
import 'package:employees/ui/widget/base/form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          color: Colors.blue,
          padding: BaseTheme.marginRectangularLarge,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              CircleAvatar(
                radius: 120,
                child: text(
                  authController.authState.value == BaseApi.login
                      ? 'Login'
                      : 'Register',
                ),
              ),
              Expanded(child: Container()),
              FormWidget(
                hint: 'Email',
                rxString: authController.email,
              ),
              Expanded(child: Container()),
              FormWidget(
                hint: 'Password',
                rxString: authController.password,
                obsecure: true,
              ),
              Expanded(child: Container()),
              TextButton(
                onPressed: () {
                  if (authController.authState.value == BaseApi.login) {
                    authController.authState.value = BaseApi.register;
                  } else {
                    authController.authState.value = BaseApi.login;
                  }
                  if (kDebugMode) {
                    print(authController.authState.value);
                  }
                },
                child: Text(
                  authController.authState.value == BaseApi.login
                      ? 'Dont have account? Register!'
                      : 'Already have account? Login!',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Get.focusScope != null) {
            if (Get.focusScope!.hasPrimaryFocus) {
              Get.focusScope!.unfocus();
            }
          }
          if (kDebugMode) {
            print(authController.email.value);
            print(authController.password.value);
          }
          if (authController.email.isNotEmpty &&
              authController.password.isNotEmpty) {
            authController.auth(
              authController.email.value,
              authController.password.value,
              authController.authState.value,
            );
          }
        },
        child: const Icon(Icons.login),
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
}
