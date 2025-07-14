import 'package:blogs_apps/app/data/comment.model.dart';

class BeritaModel {
  final int? id;
  final String? title;
  final String? isi;
  final String? thumbnail;
  final DateTime? createdAt;
  List<CommentModel>? comments;

  BeritaModel({
    this.id,
    this.title,
    this.isi,
    this.thumbnail,
    this.createdAt,
    this.comments,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
      id: json['id'],
      title: json['title'],
      isi: json['isi'],
      thumbnail: json['thumbnail'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      comments: json['comments'] != null
    ? CommentModel.fromJsonList(json['comments'] as List)
    : [],
    );
  }
}
