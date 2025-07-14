import 'package:blogs_apps/app/modules/admin/admin_blogs/controllers/admin_blogs_controller.dart';
import 'package:blogs_apps/app/modules/admin/admin_category/controllers/admin_category_controller.dart';
import 'package:blogs_apps/app/modules/admin/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/modules/admin/admin_dashboard/views/admin_dashboard_view.dart';
import 'package:blogs_apps/app/modules/admin/admin_blogs/views/admin_blogs_view.dart';
import 'package:blogs_apps/app/modules/admin/admin_category/views/admin_category_view.dart';
import 'package:blogs_apps/app/modules/admin/admin_profile/views/admin_profile_view.dart';

class AdminMainController extends GetxController {
  @override
void onInit() {
  super.onInit();
  Get.lazyPut(() => AdminDashboardController());
  Get.lazyPut(() => AdminBlogsController());
  Get.lazyPut(() => AdminCategoryController());
}

  var currentIndex = 0.obs;

  final pages = [
     AdminDashboardView(),
     AdminBlogsView(),
     AdminCategoryView(),
     AdminProfileView(),
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
