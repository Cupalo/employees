import 'package:employees/api/base_api.dart';
import 'package:employees/ui/page/auth/login.dart';
import 'package:employees/ui/page/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  GetStorage storage = GetStorage();
  var isLogin = false.obs;

  var authState = 'login'.obs;

  var email = ''.obs;
  var password = ''.obs;
  var userToken = ''.obs;

  void checkToken() {
    if (storage.read('token') != null) {
      userToken.value = storage.read('token');
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
  }

  Future<void> auth(String email, String password, String state) async {
    var body = {
      'email': email,
      'password': password,
    };
    var response = await BaseApi.auth(body, state);

    if (response != null) {
      isLogin.value = true;
      storage.write('token', response);
      userToken.value = response;
      Get.offAll(Home());
    }
  }

  Future<void> logout() async {
    isLogin.value = false;
    storage.remove('token');
    userToken.value = '';
    authState.value = 'login';
    Get.offAll(Login());
  }
}
