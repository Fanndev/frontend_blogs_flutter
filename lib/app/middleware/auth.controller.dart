import 'package:get/get.dart';
import 'package:blogs_apps/app/data/user.model.dart';

class AuthController extends GetxController {
  var user = UserModel().obs;
  var isLoggedIn = false.obs;

  void login(UserModel userData) {
    user.value = userData;
    isLoggedIn.value = true;
  }

  void logout() {
    user.value = UserModel();
    isLoggedIn.value = false;
  }
}
