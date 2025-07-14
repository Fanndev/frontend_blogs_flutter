import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/api.service.dart';
import '../../../../data/tag.model.dart';

class AdminCategoryController extends GetxController {
  var isLoading = false.obs;
  var tags = <TagModel>[].obs;
  final TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTags();
  }

  Future<void> fetchTags() async {
    try {
      isLoading.value = true;
      final response = await ApiService.getAllTags();
      final List data = response.data['data'];
      tags.value = data.map((e) => TagModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat kategori: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTag() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar("Validasi", "Nama kategori wajib diisi", backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      await ApiService.createTag({'name': name});
      Get.back();
      nameController.clear();
      fetchTags();
      Get.snackbar("Sukses", "Kategori berhasil ditambahkan", backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal menambahkan kategori: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTag(int id) async {
    try {
      isLoading.value = true;
      await ApiService.deleteTag(id);
      fetchTags();
      Get.snackbar("Sukses", "Kategori berhasil dihapus", backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus kategori: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
