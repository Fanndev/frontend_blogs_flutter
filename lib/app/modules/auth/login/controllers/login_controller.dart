import 'package:blogs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/middleware/auth.controller.dart';
import 'package:blogs_apps/app/data/api.service.dart';

class LoginController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Form tidak lengkap",
        "Username dan password wajib diisi.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiService.login({
        'username': username,
        'password': password,
      });

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = data['access'] ?? data['token'];

        if (token != null) {
          await ApiService.setToken(token);
          authController.login(username);

          Get.snackbar(
            "Login Berhasil",
            "Selamat datang, $username!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(12),
            borderRadius: 8,
            duration: Duration(seconds: 2),
          );

          // ✅ Redirect ke MainView atau ReelsView setelah login
          Future.delayed(Duration(milliseconds: 800), () {
            Get.offAllNamed(Routes.MAIN);
          });
        } else {
          throw "Token tidak ditemukan pada response.";
        }
      } else {
        throw data['message'] ?? "Gagal login, periksa kembali username dan password.";
      }
    } catch (e) {
      Get.snackbar(
        "Gagal Login",
        "$e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
