import 'package:hirup_aing/data/models/activity_enums.dart';
import 'package:hirup_aing/data/models/category_model.dart';

class ActivityMaster {
  final String id;
  final String name;
  final String? description;
  final DateTime startTime; // Hanya jam:menit:detik
  final DateTime endTime; // Hanya jam:menit:detik
  final bool isRecurring;
  final Frequency frequency;
  final List<Days>? daysOfWeek; // Untuk aktivitas mingguan
  final List<int>? datesOfMonth; // Untuk aktivitas bulanan (tanggal)
  final List<Days>? daysOfMonth; // Untuk aktivitas bulanan (hari)
  final List<Category> categories;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ActivityMaster({
    required this.id,
    required this.name,
    this.description,
    required this.startTime,
    required this.endTime,
    this.isRecurring = false,
    required this.frequency,
    this.daysOfWeek,
    this.datesOfMonth,
    this.daysOfMonth,
    required this.categories,
    required this.userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : this.createdAt = createdAt ?? DateTime.now(),
        this.updatedAt = updatedAt ?? DateTime.now();

  // Membuat salinan dengan atribut yang diperbarui
  ActivityMaster copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    bool? isRecurring,
    Frequency? frequency,
    List<Days>? daysOfWeek,
    List<int>? datesOfMonth,
    List<Days>? daysOfMonth,
    List<Category>? categories,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ActivityMaster(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isRecurring: isRecurring ?? this.isRecurring,
      frequency: frequency ?? this.frequency,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      datesOfMonth: datesOfMonth ?? this.datesOfMonth,
      daysOfMonth: daysOfMonth ?? this.daysOfMonth,
      categories: categories ?? this.categories,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Parse daysOfWeek dari string berseparator koma menjadi list Days
  static List<Days>? parseDaysOfWeek(String? daysString) {
    if (daysString == null || daysString.isEmpty) return null;
    
    return daysString.split(',').map((day) {
      final index = int.tryParse(day.trim());
      if (index == null || index < 1 || index > 7) {
        return null;
      }
      // Mengkonversi dari 1-7 (Senin-Minggu) ke enum Days
      return Days.values[index - 1];
    }).where((day) => day != null).cast<Days>().toList();
  }

  // Parse datesOfMonth dari string berseparator koma menjadi list int
  static List<int>? parseDatesOfMonth(String? datesString) {
    if (datesString == null || datesString.isEmpty) return null;
    
    return datesString.split(',').map((date) {
      return int.tryParse(date.trim());
    }).where((date) => date != null && date >= 1 && date <= 31).cast<int>().toList();
  }

  // Konversi dari JSON
  factory ActivityMaster.fromJson(Map<String, dynamic> json) {
    return ActivityMaster(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isRecurring: json['isRecurring'] ?? false,
      frequency: Frequency.values.firstWhere(
        (f) => f.toString() == 'Frequency.${json['frequency']}',
        orElse: () => Frequency.DAILY,
      ),
      daysOfWeek: json['daysOfWeek'] != null 
          ? (json['daysOfWeek'] as List).map((day) => 
              Days.values.firstWhere(
                (d) => d.toString() == 'Days.${day}',
                orElse: () => Days.MONDAY,
              )
            ).toList() 
          : null,
      datesOfMonth: json['datesOfMonth'] != null 
          ? parseDatesOfMonth(json['datesOfMonth'])
          : null,
      daysOfMonth: json['daysOfMonth'] != null 
          ? (json['daysOfMonth'] as List).map((day) => 
              Days.values.firstWhere(
                (d) => d.toString() == 'Days.${day}',
                orElse: () => Days.MONDAY,
              )
            ).toList() 
          : null,
      categories: json['categories'] != null 
          ? (json['categories'] as List).map((c) => Category.fromJson(c)).toList()
          : [],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isRecurring': isRecurring,
      'frequency': frequency.toString().split('.').last,
      'daysOfWeek': daysOfWeek?.map((day) => day.toString().split('.').last).toList(),
      'datesOfMonth': datesOfMonth,
      'daysOfMonth': daysOfMonth?.map((day) => day.toString().split('.').last).toList(),
      'categories': categories.map((c) => c.toJson()).toList(),
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}