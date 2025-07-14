import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_category_controller.dart';

class AdminCategoryView extends GetView<AdminCategoryController> {
  const AdminCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Kategori'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tags.isEmpty) {
          return const Center(child: Text("Belum ada kategori."));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.tags.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final tag = controller.tags[index];
            return Dismissible(
              key: Key(tag.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (_) async {
                return await Get.dialog(
                  AlertDialog(
                    title: const Text("Konfirmasi"),
                    content: const Text("Yakin ingin menghapus kategori ini?"),
                    actions: [
                      TextButton(onPressed: () => Get.back(result: false), child: const Text("Batal")),
                      ElevatedButton(onPressed: () => Get.back(result: true), child: const Text("Hapus")),
                    ],
                  ),
                );
              },
              onDismissed: (_) => controller.deleteTag(tag.id),
              child: ListTile(
                tileColor: Colors.grey[200],
                title: Text(tag.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await Get.dialog(
                      AlertDialog(
                        title: const Text("Konfirmasi"),
                        content: const Text("Yakin ingin menghapus kategori ini?"),
                        actions: [
                          TextButton(onPressed: () => Get.back(result: false), child: const Text("Batal")),
                          ElevatedButton(onPressed: () => Get.back(result: true), child: const Text("Hapus")),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      controller.deleteTag(tag.id);
                    }
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text("Tambah Kategori"),
        content: TextField(
          controller: controller.nameController,
          decoration: const InputDecoration(
            labelText: "Nama Kategori",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.nameController.clear();
              Get.back();
            },
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: controller.addTag,
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
