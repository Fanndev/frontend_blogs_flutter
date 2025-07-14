import 'dart:io';
import 'dart:typed_data';

import 'package:blogs_apps/app/data/api.service.dart';
import 'package:blogs_apps/app/data/berita.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminUpdateBlogsController extends GetxController {
  final titleController = TextEditingController();
  final isiController = TextEditingController();

  var tagList = <Map<String, dynamic>>[].obs;
  var selectedCategory = RxnInt();

  var isLoading = false.obs;

  var thumbnailFile = Rxn<File>();
  var thumbnailFileBytes = Rxn<Uint8List>();
  var thumbnailFileName = ''.obs;

  late BeritaModel berita;

  @override
  void onInit() {
    super.onInit();
    berita = Get.arguments as BeritaModel;
    titleController.text = berita.title ?? '';
    isiController.text = berita.isi ?? '';
    selectedCategory.value = berita.tags?.isNotEmpty == true ? berita.tags!.first : null;

    fetchTags();
  }

  Future<void> fetchTags() async {
    try {
      final response = await ApiService.getAllTags();
      final data = response.data['data'];
      tagList.value = List<Map<String, dynamic>>.from(data);

      // Jika kategori belum ada, pilih default
      if (selectedCategory.value == null && tagList.isNotEmpty) {
        selectedCategory.value = tagList[0]['id'];
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat kategori: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> pickThumbnail() async {
    try {
      if (kIsWeb) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.single.bytes != null) {
          thumbnailFileBytes.value = result.files.single.bytes!;
          thumbnailFileName.value = result.files.single.name;
        }
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.single.path != null) {
          thumbnailFile.value = File(result.files.single.path!);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memilih gambar: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> updateBerita() async {
    final title = titleController.text.trim();
    final isi = isiController.text.trim();
    final categoryId = selectedCategory.value;

    if (title.isEmpty || isi.isEmpty || categoryId == null) {
      Get.snackbar(
        "Validasi",
        "Judul, isi, dan kategori wajib diisi.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final Map<String, dynamic> formData = {
        "title": title,
        "isi": isi,
        "tags": [categoryId],
      };

      if (kIsWeb && thumbnailFileBytes.value != null) {
        await ApiService.updateBeritaWithBytes(
          id: berita.id!,
          data: formData,
          fileBytes: thumbnailFileBytes.value!,
          filename: thumbnailFileName.value,
        );
      } else if (thumbnailFile.value != null) {
        await ApiService.updateBerita(
          berita.id!,
          formData,
          file: thumbnailFile.value,
        );
      } else {
        // Update tanpa gambar
        await ApiService.updateBerita(berita.id!, formData);
      }

      Get.back();
      Get.snackbar("Sukses", "Berita berhasil diperbarui",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui berita: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    isiController.dispose();
    super.onClose();
  }
}
