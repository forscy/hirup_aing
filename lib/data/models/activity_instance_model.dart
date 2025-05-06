import 'package:hirup_aing/data/models/activity_enums.dart';

class ActivityInstance {
  final String id;
  final DateTime activityDate;
  final ActivityStatus status;
  final String? notes;
  final String activityMasterId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ActivityInstance({
    required this.id,
    required this.activityDate,
    required this.status,
    this.notes,
    required this.activityMasterId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // Membuat salinan dengan atribut yang diperbarui
  ActivityInstance copyWith({
    String? id,
    DateTime? activityDate,
    ActivityStatus? status,
    String? notes,
    String? activityMasterId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ActivityInstance(
      id: id ?? this.id,
      activityDate: activityDate ?? this.activityDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      activityMasterId: activityMasterId ?? this.activityMasterId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Konversi dari JSON
  factory ActivityInstance.fromJson(Map<String, dynamic> json) {
    return ActivityInstance(
      id: json['id'],
      activityDate: DateTime.parse(json['activityDate']),
      status: ActivityStatus.values.firstWhere(
        (status) => status.toString() == 'ActivityStatus.${json['status']}',
        orElse: () => ActivityStatus.PENDING,
      ),
      notes: json['notes'],
      activityMasterId: json['activityMasterId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activityDate': activityDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'notes': notes,
      'activityMasterId': activityMasterId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
