import 'package:blogs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_blogs_controller.dart';

class AdminBlogsView extends GetView<AdminBlogsController> {
  const AdminBlogsView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Berita'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADMIN_CREATE_BLOGS);
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.beritaList.isEmpty) {
          return const Center(child: Text("Belum ada berita."));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.beritaList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final berita = controller.beritaList[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: berita.thumbnail != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          berita.thumbnail!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.image, size: 40, color: Colors.grey),
                title: Text(
                  berita.title ?? "Tanpa Judul",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  berita.createdAt != null
                      ? "Dipublikasikan: ${berita.createdAt!.toLocal().toString().split(' ')[0]}"
                      : "",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Get.toNamed(Routes.ADMIN_UPDATE_BLOGS, arguments: berita);
                    } else if (value == 'delete') {
                      Get.defaultDialog(
                        title: "Konfirmasi",
                        middleText: "Yakin ingin menghapus berita ini?",
                        textConfirm: "Hapus",
                        textCancel: "Batal",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          Get.back();
                          controller.deleteBerita(berita.id!);
                        },
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit, color: Colors.blue),
                        title: Text("Edit"),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text("Hapus"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
