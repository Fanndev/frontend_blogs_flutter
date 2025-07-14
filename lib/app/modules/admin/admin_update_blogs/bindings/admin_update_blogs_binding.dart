import 'package:get/get.dart';

import '../controllers/admin_update_blogs_controller.dart';

class AdminUpdateBlogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminUpdateBlogsController>(
      () => AdminUpdateBlogsController(),
    );
  }
}
