import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/modules/admin/admin_main/controllers/admin_main_controller.dart';

class AdminMainView extends StatelessWidget {
  AdminMainView({super.key});
  final AdminMainController controller = Get.put(AdminMainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Colors.deepPurple, // atau biru sesuai preferensi
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.backup_table),
                    label: 'berita',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: 'category',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Akun',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}