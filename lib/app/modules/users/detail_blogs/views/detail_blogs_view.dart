import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_blogs_controller.dart';

class DetailBlogsView extends GetView<DetailBlogsController> {
  const DetailBlogsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailBlogsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailBlogsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
