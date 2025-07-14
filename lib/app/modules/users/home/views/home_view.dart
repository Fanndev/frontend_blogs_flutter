import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogs_apps/app/modules/users/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar dengan shadow
                Material(
                  elevation: 2,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search News",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Most Related
                const Text(
                  "Berita Terkini",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.beritaList.length,
                    itemBuilder: (context, index) {
                      final item = controller.beritaList[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed('/detail-berita', arguments: item);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 280,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Image.network(
                                  item.thumbnail ??
                                      "https://source.unsplash.com/random/300x200?news",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time,
                                            size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(
                                          item.createdAt.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(width: 16),
                                        Icon(Icons.comment,
                                            size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Berita Lainnya
                const Text(
                  "Berita Lainnya",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.beritaList.length,
                  itemBuilder: (context, index) {
                    final item = controller.beritaList[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed('/detail-berita', arguments: item);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.thumbnail ??
                                  "https://source.unsplash.com/random/100x100?news",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item.title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                item.createdAt.toString(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
