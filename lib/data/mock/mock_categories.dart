import 'package:hirup_aing/data/models/category_model.dart';

class MockCategories {
  // Contoh kategori untuk user pertama
  static final List<Category> categoriesUser1 = [
    Category(id: 'cat-001', name: 'Ibadah', userId: 'user-001'),
    Category(id: 'cat-002', name: 'Kewajiban', userId: 'user-001'),
    Category(id: 'cat-003', name: 'Kesehatan', userId: 'user-001'),
    Category(id: 'cat-004', name: 'Kuliah', userId: 'user-001'),
    Category(id: 'cat-005', name: 'Pendidikan', userId: 'user-001'),
  ];

  // Contoh kategori untuk user kedua
  static final List<Category> categoriesUser2 = [
    Category(id: 'cat-006', name: 'Kerja', userId: 'user-002'),
    Category(id: 'cat-007', name: 'Olahraga', userId: 'user-002'),
    Category(id: 'cat-008', name: 'Keluarga', userId: 'user-002'),
  ];

  // Gabungan semua kategori
  static final List<Category> allCategories = [
    ...categoriesUser1,
    ...categoriesUser2,
  ];

  // Mendapatkan semua kategori
  static List<Category> getAll() {
    return allCategories;
  }

  // Mendapatkan kategori berdasarkan id
  static Category? getById(String id) {
    try {
      return allCategories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // Mendapatkan kategori berdasarkan user id
  static List<Category> getByUserId(String userId) {
    return allCategories
        .where((category) => category.userId == userId)
        .toList();
  }

  // Mendapatkan kategori berdasarkan nama dan user id
  static Category? getByNameAndUserId(String name, String userId) {
    try {
      return allCategories.firstWhere(
        (category) => category.name == name && category.userId == userId,
      );
    } catch (e) {
      return null;
    }
  }
}
