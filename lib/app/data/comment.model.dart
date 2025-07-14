class CommentModel {
  final int? id;
  final String? content;
  final String? username;
  final DateTime? createdAt;

  CommentModel({
    this.id,
    this.content,
    this.username,
    this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'],
      username: json['user'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  static List<CommentModel> fromJsonList(List<dynamic> list) {
    return list.map((item) => CommentModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}
