import 'package:hirup_aing/data/models/user_model.dart';

class MockUsers {
  // Contoh dua user
  static final List<User> users = [
    User(
      id: 'user-001',
      email: 'ahmad@email.com',
      password: 'password123', // Dalam kasus nyata, password harusnya ter-hash
      name: 'Ahmad',
      role: UserRole.USER,
      createdAt: DateTime(2025, 1, 1),
      updatedAt: DateTime(2025, 1, 1),
    ),
    User(
      id: 'user-002',
      email: 'budi@email.com',
      password: 'password456',
      name: 'Budi',
      role: UserRole.ADMIN,
      createdAt: DateTime(2025, 1, 2),
      updatedAt: DateTime(2025, 1, 2),
    ),
  ];

  // Mendapatkan semua user
  static List<User> getAll() {
    return users;
  }

  // Mendapatkan user berdasarkan id
  static User? getById(String id) {
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  // Mendapatkan user berdasarkan email
  static User? getByEmail(String email) {
    try {
      return users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  // Validasi login
  static User? validateLogin(String email, String password) {
    try {
      return users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }
}
