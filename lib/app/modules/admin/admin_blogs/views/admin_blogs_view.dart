import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_blogs_controller.dart';

class AdminBlogsView extends GetView<AdminBlogsController> {
  const AdminBlogsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminBlogsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminBlogsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
