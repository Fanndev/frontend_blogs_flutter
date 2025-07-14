import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxString username = ''.obs;
  RxString? email = ''.obs; // jika ingin email

  void login(String user, [String? userEmail]) {
    isLoggedIn.value = true;
    username.value = user;
    if (userEmail != null) {
      email?.value = userEmail;
    }
  }

  void logout() {
    isLoggedIn.value = false;
    username.value = '';
    email?.value = '';
  }
}
