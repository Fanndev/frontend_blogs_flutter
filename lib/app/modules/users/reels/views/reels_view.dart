import 'package:blogs_apps/app/middleware/auth.controller.dart';
import 'package:blogs_apps/app/modules/users/reels/components/comment_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:blogs_apps/app/modules/users/reels/controllers/reels_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:blogs_apps/app/data/comment.model.dart';

class ReelsView extends StatefulWidget {
  ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final ReelsController controller = Get.put(ReelsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[600]!,
                child: Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          );
        } else {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.reels.length,
            itemBuilder: (context, index) {
              final reel = controller.reels[index];
              final showFullText = false.obs; // untuk setiap item

              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      reel.thumbnail ?? "https://source.unsplash.com/random/800x1200?news",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            reel.title ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            final text = reel.isi ?? "";
                            final displayText = (showFullText.value || text.length <= 150)
                                ? text
                                : "${text.substring(0, 150)}... ";

                            return GestureDetector(
                              onTap: () => showFullText.toggle(),
                              child: RichText(
                                text: TextSpan(
                                  text: displayText,
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                  children: [
                                    if (text.length > 150 && !showFullText.value)
                                      TextSpan(
                                        text: "Lainnya",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    right: 16,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              final auth = Get.find<AuthController>();
                              if (!auth.isLoggedIn.value) {
                                Get.defaultDialog(
                                  title: "Belum Login",
                                  middleText: "Anda harus login terlebih dahulu untuk mengomentari.",
                                  textCancel: "Batal",
                                  textConfirm: "Login",
                                  onConfirm: () {
                                    Get.back();
                                    Get.toNamed('/login');
                                  },
                                );
                                return;
                              }

                              showCommentsModal(
                                context,
                                reel.comments ?? <CommentModel>[],
                                beritaId: reel.id!,
                              );
                            },
                            icon: Icon(Icons.comment, color: Colors.white, size: 28),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${reel.comments?.length ?? 0}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
