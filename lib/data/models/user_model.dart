enum UserRole { USER, ADMIN }

class User {
  final String id;
  final String email;
  final String password; // Dalam aplikasi sebenarnya, ini tidak disimpan di model klien
  final String name;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email, 
    required this.password,
    required this.name,
    this.role = UserRole.USER,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Membuat salinan dengan atribut yang diperbarui
  User copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Konversi dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      role: UserRole.values.firstWhere(
        (role) => role.toString() == 'UserRole.${json['role']}',
        orElse: () => UserRole.USER,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'role': role.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}