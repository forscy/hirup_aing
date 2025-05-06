import 'package:hirup_aing/data/models/user_model.dart';

final List<Map<String, dynamic>> mockUsers = [
  {
    'id': '1',
    'email': 'admin@hirupaing.com',
    'password': 'admin123', // Dalam produksi, password harus di-hash
    'name': 'Admin Hirup Aing',
    'role': 'ADMIN',
    'createdAt': '2023-01-01T00:00:00Z',
    'updatedAt': '2023-01-01T00:00:00Z',
  },
  {
    'id': '2',
    'email': 'user@example.com',
    'password': 'password123',
    'name': 'Pengguna Biasa',
    'role': 'USER',
    'createdAt': '2023-01-02T00:00:00Z',
    'updatedAt': '2023-01-02T00:00:00Z',
  },
  {
    'id': '3',
    'email': 'test@test.com',
    'password': 'test123',
    'name': 'Akun Test',
    'role': 'USER',
    'createdAt': '2023-01-03T00:00:00Z',
    'updatedAt': '2023-01-03T00:00:00Z',
  },
];

class MockUsers {
  // Daftar pengguna untuk testing
  static final List<Map<String, dynamic>> _users = mockUsers;

  // Method untuk mendapatkan semua pengguna dalam format User object
  static List<User> getAll() {
    return _users.map((data) => User.fromJson(data)).toList();
  }

  // Validasi login
  static User? validateLogin(String email, String password) {
    try {
      final userData = _users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
      );
      return User.fromJson(userData);
    } catch (e) {
      return null; // Return null jika validasi gagal
    }
  }

  // Mendapatkan user berdasarkan ID
  static User? getById(String id) {
    try {
      final userData = _users.firstWhere((user) => user['id'] == id);
      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  // Mendapatkan user berdasarkan email
  static User? getByEmail(String email) {
    try {
      final userData = _users.firstWhere((user) => user['email'] == email);
      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  // Register user baru
  static User? register(String email, String password, String name) {
    // Cek apakah email sudah terdaftar
    final existingUser = getByEmail(email);
    if (existingUser != null) {
      return null; // Email sudah terdaftar
    }

    // Buat user baru
    final newUser = {
      'id': 'user-${_users.length + 1}',
      'email': email,
      'password': password,
      'name': name,
      'role': 'USER',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    // Tambahkan ke daftar pengguna
    _users.add(newUser);

    return User.fromJson(newUser);
  }
}
