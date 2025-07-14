import 'package:get/get.dart';
import 'package:blogs_apps/app/data/berita.model.dart';
import 'package:blogs_apps/app/data/api.service.dart';

class HomeController extends GetxController {
  var beritaList = <BeritaModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBerita();
  }

 Future<void> fetchBerita() async {
  try {
    print('[HomeController] Mulai fetch berita...');
    isLoading(true);

    final response = await ApiService.getAllBerita();
    print('[HomeController] Response data: ${response.data}');

    final List data = response.data['data'];
    beritaList.value = data.map((e) => BeritaModel.fromJson(e)).toList();

    print('[HomeController] Berhasil fetch dan parsing berita: ${beritaList.length} items.');
  } catch (e, stackTrace) {
    print('[HomeController] ERROR: $e');
    print('[HomeController] StackTrace: $stackTrace');
    Get.snackbar("Error", "Gagal memuat berita: $e");
  } finally {
    isLoading(false);
    print('[HomeController] Selesai fetch berita.');
  }
}

}
