import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/data/api.service.dart';
import 'package:blogs_apps/app/data/berita.model.dart';

class DetailBlogsController extends GetxController {
  var isLoading = true.obs;
  var berita = BeritaModel().obs;

  var isCommentLoading = false.obs;
  final commentController = TextEditingController();

  late int beritaId;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is int) {
      beritaId = Get.arguments as int;
      fetchDetail();
    } else {
      Get.snackbar("Error", "ID Berita tidak valid",
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading.value = false;
    }
  }

  Future<void> fetchDetail() async {
  try {
    isLoading.value = true;
    print("📌 Fetching detail berita dengan ID: $beritaId"); // Tambahkan ini untuk debug ID

    final response = await ApiService.getBeritaDetail(beritaId);

    print("📌 Response dari API getBeritaDetail: ${response.data}"); // Debug data dari backend
    print("📌 Data setelah parsing ke BeritaModel:");
    print("ID: ${berita.value.id}");
    print("Title: ${berita.value.title}");
    print("Isi: ${berita.value.isi}");
    print("Thumbnail: ${berita.value.thumbnail}");
    print("Comments: ${berita.value.comments}");


    berita.value = BeritaModel.fromJson(response.data['data']);

    print("📌 Data setelah parsing ke BeritaModel: ${berita.value}"); // Debug object model
  } catch (e) {
    Get.snackbar("Error", "Gagal memuat detail berita: $e",
        backgroundColor: Colors.red, colorText: Colors.white);
    print("❌ Error saat fetchDetail: $e");
  } finally {
    isLoading.value = false;
  }
}


  Future<void> postComment() async {
    final content = commentController.text.trim();
    if (content.isEmpty) {
      Get.snackbar("Error", "Komentar tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isCommentLoading.value = true;

      await ApiService.createComment({
        'berita': beritaId,
        'content': content,
      });

      commentController.clear();

      await fetchDetail(); // refresh komentar
      Get.snackbar("Sukses", "Komentar berhasil dikirim",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal mengirim komentar: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isCommentLoading.value = false;
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
