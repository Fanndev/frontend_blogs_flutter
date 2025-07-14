import 'package:blogs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/middleware/auth.controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (!auth.isLoggedIn.value) {
          // Belum login: tampilkan tombol login & register besar
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_outline, size: 100, color: Colors.grey),
                  const SizedBox(height: 24),
                  const Text(
                    "Anda belum login",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.LOGIN),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Register"),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Sudah login: tampilkan profile
        final username = (auth.user.value.username ?? "").isNotEmpty
    ? auth.user.value.username!
    : "Pengguna";


        final profileImageUrl = "https://ui-avatars.com/api/"
            "?name=$username"
            "&background=random"
            "&color=ffffff"
            "&size=256";

        return Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImageUrl),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.snackbar("Edit Profile", "Fitur belum tersedia",
                    backgroundColor: Colors.blueAccent,
                    colorText: Colors.white);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Get.defaultDialog(
                  title: "Logout",
                  middleText: "Apakah kamu yakin ingin logout?",
                  textCancel: "Batal",
                  textConfirm: "Logout",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    auth.logout();
                    Get.back();
                    Get.snackbar("Logout", "Berhasil logout",
                        backgroundColor: Colors.green,
                        colorText: Colors.white);
                  },
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
