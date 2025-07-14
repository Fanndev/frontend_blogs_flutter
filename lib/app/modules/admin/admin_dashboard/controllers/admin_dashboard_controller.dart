import 'package:get/get.dart';
import '../../../../data/api.service.dart';

class AdminDashboardController extends GetxController {
  var isLoading = false.obs;
  var beritaCount = 0.obs;
  var categoryCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardSummary();
  }

  Future<void> fetchDashboardSummary() async {
    try {
      isLoading.value = true;

      final beritaResponse = await ApiService.getAllBerita();
      final beritaList = beritaResponse.data['data'] as List;
      beritaCount.value = beritaList.length;

      final kategoriResponse = await ApiService.getAllTags();
      final kategoriList = kategoriResponse.data['data'] as List;
      categoryCount.value = kategoriList.length;
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data dashboard: $e", backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
    } finally {
      isLoading.value = false;
    }
  }
}
