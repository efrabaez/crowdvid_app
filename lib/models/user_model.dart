class User {
  final int? userId;
  final String? email;
  final String? password;
  final String? name;
  final String? lastName;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  const User({
    required this.userId,
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    required this.createdAt,
    required this.modifiedAt,
  });

  @override
  String toString() {
    return '{userId: $userId, email: $email, password: $password, lastName: $lastName, created_at: $createdAt, modified_at: $modifiedAt}';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      lastName: json['lastName'],
      createdAt: json['created_at'],
      modifiedAt: json['modified_at'],
    );
  }
}
