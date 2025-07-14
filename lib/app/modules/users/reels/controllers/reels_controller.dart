import 'package:blogs_apps/app/data/comment.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/data/berita.model.dart';
import 'package:blogs_apps/app/data/api.service.dart';

class ReelsController extends GetxController {
  var reels = <BeritaModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReels();
  }

  Future<void> postComment({
    required int beritaId,
    required String content,
  }) async {
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await ApiService.createComment({
        'berita': beritaId,
        'content': content,
      });

      Get.back(); // tutup loading

      // Update state lokal agar realtime
      final index = reels.indexWhere((item) => item.id == beritaId);
      if (index != -1) {
        if (reels[index].comments == null) {
          reels[index].comments = [];
        }
        reels[index].comments!.add(
          CommentModel.fromJson(response.data),
        );
        reels.refresh();
      }

      Get.snackbar(
        "Berhasil",
        "Komentar berhasil dikirim",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Gagal mengirim komentar: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchReels() async {
    try {
      isLoading(true);
      final response = await ApiService.getAllBerita();
      final List data = response.data['data'];
      reels.value = data.map((e) => BeritaModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat reels: $e");
    } finally {
      isLoading(false);
    }
  }
}
