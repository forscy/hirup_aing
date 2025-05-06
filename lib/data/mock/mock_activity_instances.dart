import 'package:hirup_aing/data/models/activity_enums.dart';
import 'package:hirup_aing/data/models/activity_instance_model.dart';
import 'package:hirup_aing/data/mock/mock_activity_masters.dart';

class MockActivityInstances {
  // Instance aktivitas untuk user pertama
  static final List<ActivityInstance> activityInstancesUser1 = [
    // Solat Subuh tanggal 5 Mei - Ditunda
    ActivityInstance(
      id: 'ins-001',
      activityDate: DateTime(2025, 5, 5),
      status: ActivityStatus.POSTPONED, // Ditunda
      activityMasterId: 'act-001', // Solat Subuh
      createdAt: DateTime(2025, 5, 5),
      updatedAt: DateTime(2025, 5, 5),
    ),

    // Solat Subuh tanggal 6 Mei - Selesai
    ActivityInstance(
      id: 'ins-002',
      activityDate: DateTime(2025, 5, 6),
      status: ActivityStatus.COMPLETED, // Selesai
      activityMasterId: 'act-001', // Solat Subuh
      createdAt: DateTime(2025, 5, 6),
      updatedAt: DateTime(2025, 5, 6),
    ),

    // Push Up Pagi tanggal 6 Mei - Ditunda
    ActivityInstance(
      id: 'ins-003',
      activityDate: DateTime(2025, 5, 6),
      status: ActivityStatus.POSTPONED, // Ditunda
      activityMasterId: 'act-002', // Push Up Pagi
      createdAt: DateTime(2025, 5, 6),
      updatedAt: DateTime(2025, 5, 6),
    ),

    // Renang tanggal 6 Mei - Batalkan
    ActivityInstance(
      id: 'ins-004',
      activityDate: DateTime(2025, 5, 6),
      status: ActivityStatus.CANCELLED, // Batalkan
      activityMasterId: 'act-003', // Renang
      createdAt: DateTime(2025, 5, 6),
      updatedAt: DateTime(2025, 5, 6),
    ),

    // Renang tanggal 6 Juni - Selesai
    ActivityInstance(
      id: 'ins-005',
      activityDate: DateTime(2025, 6, 6),
      status: ActivityStatus.COMPLETED, // Selesai
      activityMasterId: 'act-003', // Renang
      createdAt: DateTime(2025, 6, 6),
      updatedAt: DateTime(2025, 6, 6),
    ),

    // Kuliah PPL Teori tanggal 9 Juni - Belum
    ActivityInstance(
      id: 'ins-006',
      activityDate: DateTime(2025, 6, 9),
      status: ActivityStatus.PENDING, // Belum
      activityMasterId: 'act-004', // Kuliah PPL
      createdAt: DateTime(2025, 6, 1),
      updatedAt: DateTime(2025, 6, 1),
    ),
  ];

  // Instance aktivitas untuk user kedua
  static final List<ActivityInstance> activityInstancesUser2 = [
    // Meeting Harian tanggal 6 Mei - Selesai
    ActivityInstance(
      id: 'ins-007',
      activityDate: DateTime(2025, 5, 6),
      status: ActivityStatus.COMPLETED, // Selesai
      activityMasterId: 'act-005', // Meeting Harian
      createdAt: DateTime(2025, 5, 6),
      updatedAt: DateTime(2025, 5, 6),
    ),

    // Jogging Pagi tanggal 4 Mei (Minggu) - Selesai
    ActivityInstance(
      id: 'ins-008',
      activityDate: DateTime(2025, 5, 4), // Minggu
      status: ActivityStatus.COMPLETED, // Selesai
      activityMasterId: 'act-006', // Jogging Pagi
      createdAt: DateTime(2025, 5, 4),
      updatedAt: DateTime(2025, 5, 4),
    ),
  ];

  // Gabungan semua instance aktivitas
  static final List<ActivityInstance> allActivityInstances = [
    ...activityInstancesUser1,
    ...activityInstancesUser2,
  ];

  // Mendapatkan semua instance aktivitas
  static List<ActivityInstance> getAll() {
    return allActivityInstances;
  }

  // Mendapatkan instance aktivitas berdasarkan id
  static ActivityInstance? getById(String id) {
    try {
      return allActivityInstances.firstWhere((instance) => instance.id == id);
    } catch (e) {
      return null;
    }
  }

  // Mendapatkan instance aktivitas berdasarkan master id
  static List<ActivityInstance> getByActivityMasterId(String activityMasterId) {
    return allActivityInstances
        .where((instance) => instance.activityMasterId == activityMasterId)
        .toList();
  }

  // Mendapatkan instance aktivitas berdasarkan tanggal
  static List<ActivityInstance> getByDate(DateTime date) {
    return allActivityInstances
        .where(
          (instance) =>
              instance.activityDate.year == date.year &&
              instance.activityDate.month == date.month &&
              instance.activityDate.day == date.day,
        )
        .toList();
  }

  // Mendapatkan instance aktivitas berdasarkan status
  static List<ActivityInstance> getByStatus(ActivityStatus status) {
    return allActivityInstances
        .where((instance) => instance.status == status)
        .toList();
  }

  // Mendapatkan instance aktivitas berdasarkan rentang tanggal
  static List<ActivityInstance> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return allActivityInstances
        .where(
          (instance) =>
              instance.activityDate.isAfter(
                startDate.subtract(Duration(days: 1)),
              ) &&
              instance.activityDate.isBefore(endDate.add(Duration(days: 1))),
        )
        .toList();
  }

  // Mendapatkan semua aktivitas untuk user tertentu pada tanggal tertentu (lengkap dengan master)
  static List<Map<String, dynamic>> getUserActivitiesByDate(
    String userId,
    DateTime date,
  ) {
    final List<Map<String, dynamic>> result = [];

    // Dapatkan semua ID aktivitas master milik user
    final userMasterIds =
        MockActivityMasters.getByUserId(userId).map((m) => m.id).toList();

    // Filter instance yang sesuai tanggal dan milik user ini
    final instances =
        allActivityInstances
            .where(
              (instance) =>
                  userMasterIds.contains(instance.activityMasterId) &&
                  instance.activityDate.year == date.year &&
                  instance.activityDate.month == date.month &&
                  instance.activityDate.day == date.day,
            )
            .toList();

    // Gabungkan data master dan instance
    for (var instance in instances) {
      final master = MockActivityMasters.getById(instance.activityMasterId);

      if (master != null) {
        result.add({
          'instance': instance,
          'master': master,
          'categories': master.categories,
        });
      }
    }

    return result;
  }
}
