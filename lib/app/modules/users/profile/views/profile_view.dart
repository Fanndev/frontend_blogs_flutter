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
        title: Text("Profile"),
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
                  Icon(Icons.person_outline, size: 100, color: Colors.grey),
                  SizedBox(height: 24),
                  Text(
                    "Anda belum login",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text("Login"),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text("Register"),
                  ),
                ],
              ),
            ),
          );
        }

        // Sudah login: tampilkan profile
        return Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),
            const SizedBox(height: 16),
            Text(
              auth.username.value.isNotEmpty ? auth.username.value : "Nama Pengguna",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.snackbar("Edit Profile", "Fitur belum tersedia");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
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
                    Get.snackbar("Logout", "Berhasil logout");
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
