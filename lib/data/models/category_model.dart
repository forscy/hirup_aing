class Category {
  final String id;
  final String name;
  final String userId;

  Category({
    required this.id,
    required this.name,
    required this.userId,
  });

  // Membuat salinan dengan atribut yang diperbarui
  Category copyWith({
    String? id,
    String? name,
    String? userId,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }

  // Konversi dari JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      userId: json['userId'],
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
    };
  }
}