import 'package:blogs_apps/app/data/comment.model.dart';
import 'package:blogs_apps/app/modules/users/reels/controllers/reels_controller.dart';
import 'package:blogs_apps/app/middleware/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showCommentsModal(BuildContext context, List<CommentModel> comments, {required int beritaId}) {
  final commentList = comments.obs;
  final commentController = TextEditingController();
  final auth = Get.find<AuthController>();
  final controller = Get.find<ReelsController>();
  final scrollController = ScrollController();

  showBarModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => SafeArea(
      child: Column(
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    final comment = commentList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          (comment.username ?? "U")[0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(comment.username ?? "User"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.content ?? ""),
                          const SizedBox(height: 4),
                          Text(
                            comment.createdAt != null
                                ? DateFormat('dd MMM yyyy HH:mm').format(comment.createdAt!)
                                : "",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "Tambahkan komentar...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () async {
                      final text = commentController.text.trim();
                      if (text.isEmpty) return;

                      try {
                        await controller.postComment(
                          beritaId: beritaId,
                          content: text,
                        );

                        // Tambahkan komentar secara lokal agar muncul tanpa refresh
                        commentList.add(
                          CommentModel(
                            id: DateTime.now().millisecondsSinceEpoch,
                            content: text,
                            username: auth.username.value,
                            createdAt: DateTime.now(),
                          ),
                        );

                        commentController.clear();

                        // Scroll otomatis ke bawah setelah kirim
                        await Future.delayed(Duration(milliseconds: 300));
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      } catch (e) {
                        Get.snackbar(
                          "Error",
                          "Gagal mengirim komentar: $e",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
