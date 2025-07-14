import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/modules/auth/login/controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // sesuaikan dengan splash untuk konsistensi
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo atau teks aplikasi
                const Text(
                  "Blogs App",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Username
                TextField(
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.login();
                          },
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol ke Register jika ingin
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  child: const Text("Belum punya akun? Daftar di sini"),
                ),
              ],
            )),
      ),
    );
  }
}
