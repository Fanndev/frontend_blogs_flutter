import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/modules/users/main/controllers/main_controller.dart';

class MainView extends StatelessWidget {
  MainView({super.key});
  final MainController controller = Get.put(MainController());

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
                    icon: Icon(Icons.home),
                    label: 'Berita',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Cari',
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
