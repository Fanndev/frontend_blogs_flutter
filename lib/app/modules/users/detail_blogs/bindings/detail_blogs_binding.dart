import 'package:get/get.dart';

import '../controllers/detail_blogs_controller.dart';

class DetailBlogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBlogsController>(
      () => DetailBlogsController(),
    );
  }
}
