class User {
  final int? userId;
  final String? email;
  final String? password;
  final String? name;
  final String? lastName;
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final int code;
  final String message;

  const User({
    required this.userId,
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    required this.createdAt,
    required this.modifiedAt,
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return '{userId: $userId, email: $email, password: $password, name: $name, lastName: $lastName, created_at: $createdAt, modified_at: $modifiedAt, code: $code, message: $message}';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json.containsKey('userId') ? json['userId'] : 0,
      email: json.containsKey('email') ? json['email'] : '',
      password: json.containsKey('password') ? json['password'] : '',
      name: json.containsKey('name') ? json['name'] : '',
      lastName: json.containsKey('lastname') ? json['lastname'] : '',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      code: json['code'],
      message: json['message'],
    );
  }
}
