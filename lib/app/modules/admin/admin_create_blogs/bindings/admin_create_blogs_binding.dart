import 'package:get/get.dart';

import '../controllers/admin_create_blogs_controller.dart';

class AdminCreateBlogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCreateBlogsController>(
      () => AdminCreateBlogsController(),
    );
  }
}
