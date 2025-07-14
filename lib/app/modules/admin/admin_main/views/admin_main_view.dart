import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/modules/users/main/controllers/main_controller.dart';

class AdminMainView extends StatelessWidget {
  AdminMainView({super.key});
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: 'My Tickets'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }
}