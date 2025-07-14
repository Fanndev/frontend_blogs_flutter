import 'package:blogs_apps/app/data/api.service.dart';
import 'package:blogs_apps/app/data/berita.model.dart';
import 'package:get/get.dart';

class AdminBlogsController extends GetxController {
  var beritaList = <BeritaModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBerita();
  }

  Future<void> fetchBerita() async {
    try {
      isLoading.value = true;
      final response = await ApiService.getAllBerita();

      final dataList = response.data['data'] as List;
      beritaList.value = dataList.map((e) => BeritaModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat berita: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBerita(int id) async {
    try {
      isLoading.value = true;
      final response = await ApiService.deleteBerita(id);

      // Optional: Tampilkan pesan sukses dari API jika ada
      Get.snackbar(
        "Sukses",
        response.data['message'] ?? "Berita berhasil dihapus",
        backgroundColor: Get.theme.snackBarTheme.backgroundColor ?? Get.theme.primaryColor,
        colorText: Get.theme.snackBarTheme.actionTextColor ?? Get.theme.colorScheme.onPrimary,
      );

      await fetchBerita();
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus berita: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
