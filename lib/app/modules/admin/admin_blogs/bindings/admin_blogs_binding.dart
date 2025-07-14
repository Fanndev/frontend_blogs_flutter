import 'package:get/get.dart';

import '../controllers/admin_blogs_controller.dart';

class AdminBlogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminBlogsController>(
      () => AdminBlogsController(),
    );
  }
}
