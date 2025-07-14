import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../controllers/detail_blogs_controller.dart';
import 'package:blogs_apps/app/middleware/auth.controller.dart';

class DetailBlogsView extends GetView<DetailBlogsController> {
  const DetailBlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 200,
                height: 20,
                color: Colors.white,
              ),
            ),
          );
        }

        final berita = controller.berita.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Berita
              berita.thumbnail != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        berita.thumbnail!,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.image, size: 100, color: Colors.white),
                    ),

              const SizedBox(height: 16),

              // Judul
              Text(
                berita.title ?? "-",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                berita.createdAt != null
                    ? "Dipublikasikan pada ${DateFormat('dd MMM yyyy').format(berita.createdAt!.toLocal())}"
                    : "Tanggal tidak tersedia",
                style: TextStyle(color: Colors.grey[600]),
              ),

              const SizedBox(height: 16),

              // Isi Berita
              Text(
                berita.isi ?? "-",
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),

              const SizedBox(height: 24),
              const Divider(),

              // Komentar
              const Text(
                "Komentar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              if (berita.comments != null && berita.comments!.isNotEmpty)
                Column(
                  children: berita.comments!.map((comment) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          comment.username != null && comment.username!.isNotEmpty
                              ? comment.username![0].toUpperCase()
                              : "?",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(comment.username ?? "Anonim"),
                      subtitle: Text(comment.content ?? ""),
                      trailing: Text(
                        comment.createdAt != null
                            ? DateFormat('dd MMM yyyy').format(comment.createdAt!.toLocal())
                            : "",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    );
                  }).toList(),
                )
              else
                const Text("Belum ada komentar.", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 24),

              // Form Komentar
              if (auth.isLoggedIn.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tulis Komentar",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.commentController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Tulis komentar anda...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => ElevatedButton(
                          onPressed: controller.isCommentLoading.value
                              ? null
                              : controller.postComment,
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 45)),
                          child: controller.isCommentLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text("Kirim Komentar"),
                        )),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: () => Get.toNamed('/login'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
                  child: const Text("Login untuk mengomentari"),
                ),

              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}
