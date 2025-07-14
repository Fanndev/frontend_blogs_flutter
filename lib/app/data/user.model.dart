class UserModel {
  final int? id;
  final String? username;
  final String? role;
  final String? lastLogin;

  UserModel({
    this.id,
    this.username,
    this.role,
    this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      role: json['role'],
      lastLogin: json['last_login'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
      'last_login': lastLogin,
    };
  }
}
