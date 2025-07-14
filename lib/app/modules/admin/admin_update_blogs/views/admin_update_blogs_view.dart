import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_update_blogs_controller.dart';

class AdminUpdateBlogsView extends GetView<AdminUpdateBlogsController> {
  const AdminUpdateBlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Berita', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: controller.pickThumbnail,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                    image: controller.thumbnailFile.value != null
                        ? DecorationImage(
                            image: FileImage(controller.thumbnailFile.value!),
                            fit: BoxFit.cover,
                          )
                        : controller.thumbnailFileBytes.value != null
                            ? DecorationImage(
                                image: MemoryImage(controller.thumbnailFileBytes.value!),
                                fit: BoxFit.cover,
                              )
                            : controller.berita.thumbnail != null
                                ? DecorationImage(
                                    image: NetworkImage(controller.berita.thumbnail!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                  ),
                  child: (controller.thumbnailFile.value == null &&
                          controller.thumbnailFileBytes.value == null &&
                          controller.berita.thumbnail == null)
                      ? const Center(
                          child: Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: "Judul Berita",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: controller.isiController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Isi Berita",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              controller.tagList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: "Kategori",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      value: controller.selectedCategory.value,
                      items: controller.tagList
                          .map((tag) => DropdownMenuItem<int>(
                                value: tag['id'],
                                child: Text(tag['name']),
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedCategory.value = value ?? controller.tagList[0]['id'];
                      },
                    ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.updateBerita,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      : const Text(
                          "Update Berita",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
