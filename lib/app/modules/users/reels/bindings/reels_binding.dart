import 'package:get/get.dart';

import '../controllers/reels_controller.dart';
import 'package:blogs_apps/app/middleware/auth.controller.dart';

class ReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReelsController>(
      () => ReelsController(),
    );
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
