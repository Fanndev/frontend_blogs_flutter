import 'package:blogs_apps/app/data/comment.model.dart';

class BeritaModel {
  final int? id;
  final String? title;
  final String? isi;
  final String? thumbnail;
  final List<int>? tags;
  final DateTime? createdAt;
  List<CommentModel>? comments;

  BeritaModel({
    this.id,
    this.title,
    this.isi,
    this.thumbnail,
    this.createdAt,
    this.comments,
    this.tags,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
      id: json['id'],
      title: json['title'],
      isi: json['isi'],
      thumbnail: json['thumbnail'],
      tags: json['tags'] != null ? List<int>.from(json['tags']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      comments: json['comments'] != null
    ? CommentModel.fromJsonList(json['comments'] as List)
    : [],
    );
  }
}
