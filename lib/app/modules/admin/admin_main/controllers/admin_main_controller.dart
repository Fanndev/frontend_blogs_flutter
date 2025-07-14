import 'package:get/get.dart';
import 'package:blogs_apps/app/modules/users/home/views/home_view.dart';
import 'package:blogs_apps/app/modules/users/reels/views/reels_view.dart';
import 'package:blogs_apps/app/modules/users/profile/views/profile_view.dart';

class AdminMainController extends GetxController {
  var currentIndex = 0.obs;

  final pages = [
     HomeView(),
     ReelsView(),
     ProfileView(),
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
