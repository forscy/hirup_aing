import 'package:hirup_aing/data/models/activity_enums.dart';
import 'package:hirup_aing/data/models/activity_master_model.dart';
import 'package:hirup_aing/data/mock/mock_categories.dart';

class MockActivityMasters {
  // Contoh aktivitas master untuk user pertama
  static final List<ActivityMaster> activitiesMasterUser1 = [
    // Aktivitas Solat Subuh (daily)
    ActivityMaster(
      id: 'act-001',
      name: 'Solat Subuh',
      startTime: DateTime(2025, 5, 5, 5, 0), // 05:00
      endTime: DateTime(2025, 5, 5, 5, 10), // 05:10
      isRecurring: true,
      frequency: Frequency.DAILY,
      categories: [
        MockCategories.categoriesUser1[0], // Ibadah
        MockCategories.categoriesUser1[1], // Kewajiban
      ],
      userId: 'user-001',
      createdAt: DateTime(2025, 5, 1),
      updatedAt: DateTime(2025, 5, 1),
    ),

    // Aktivitas Push Up Pagi (daily)
    ActivityMaster(
      id: 'act-002',
      name: 'Push Up Pagi',
      startTime: DateTime(2025, 5, 6, 5, 11), // 05:11
      endTime: DateTime(2025, 5, 6, 5, 15), // 05:15
      isRecurring: true,
      frequency: Frequency.DAILY,
      categories: [
        MockCategories.categoriesUser1[2], // Kesehatan
      ],
      userId: 'user-001',
      createdAt: DateTime(2025, 5, 1),
      updatedAt: DateTime(2025, 5, 1),
    ),

    // Aktivitas Renang (monthly)
    ActivityMaster(
      id: 'act-003',
      name: 'Renang',
      startTime: DateTime(2025, 5, 6, 6, 0), // 06:00
      endTime: DateTime(2025, 5, 6, 7, 0), // 07:00
      isRecurring: true,
      frequency: Frequency.MONTHLY,
      datesOfMonth: [6], // Tanggal 6 setiap bulan
      categories: [
        MockCategories.categoriesUser1[2], // Kesehatan
      ],
      userId: 'user-001',
      createdAt: DateTime(2025, 5, 1),
      updatedAt: DateTime(2025, 5, 1),
    ),

    // Aktivitas Kuliah PPL (weekly)
    ActivityMaster(
      id: 'act-004',
      name: 'Kuliah PPL Teori',
      startTime: DateTime(2025, 6, 9, 7, 50), // 07:50
      endTime: DateTime(2025, 6, 9, 9, 20), // 09:20
      isRecurring: true,
      frequency: Frequency.WEEKLY,
      daysOfWeek: [Days.MONDAY], // Setiap hari Senin
      categories: [
        MockCategories.categoriesUser1[3], // Kuliah
        MockCategories.categoriesUser1[4], // Pendidikan
      ],
      userId: 'user-001',
      createdAt: DateTime(2025, 6, 1),
      updatedAt: DateTime(2025, 6, 1),
    ),
  ];

  // Contoh aktivitas master untuk user kedua
  static final List<ActivityMaster> activitiesMasterUser2 = [
    // Aktivitas Meeting Harian
    ActivityMaster(
      id: 'act-005',
      name: 'Meeting Harian',
      startTime: DateTime(2025, 5, 6, 9, 0), // 09:00
      endTime: DateTime(2025, 5, 6, 10, 0), // 10:00
      isRecurring: true,
      frequency: Frequency.DAILY,
      daysOfWeek: [
        Days.MONDAY,
        Days.TUESDAY,
        Days.WEDNESDAY,
        Days.THURSDAY,
        Days.FRIDAY,
      ],
      categories: [
        MockCategories.categoriesUser2[0], // Kerja
      ],
      userId: 'user-002',
      createdAt: DateTime(2025, 5, 1),
      updatedAt: DateTime(2025, 5, 1),
    ),

    // Aktivitas Jogging Pagi
    ActivityMaster(
      id: 'act-006',
      name: 'Jogging Pagi',
      startTime: DateTime(2025, 5, 6, 6, 0), // 06:00
      endTime: DateTime(2025, 5, 6, 7, 0), // 07:00
      isRecurring: true,
      frequency: Frequency.WEEKLY,
      daysOfWeek: [Days.SATURDAY, Days.SUNDAY], // Weekend
      categories: [
        MockCategories.categoriesUser2[1], // Olahraga
      ],
      userId: 'user-002',
      createdAt: DateTime(2025, 5, 1),
      updatedAt: DateTime(2025, 5, 1),
    ),
  ];

  // Gabungan semua aktivitas master
  static final List<ActivityMaster> allActivitiesMaster = [
    ...activitiesMasterUser1,
    ...activitiesMasterUser2,
  ];

  // Mendapatkan semua aktivitas master
  static List<ActivityMaster> getAll() {
    return allActivitiesMaster;
  }

  // Mendapatkan aktivitas master berdasarkan id
  static ActivityMaster? getById(String id) {
    try {
      return allActivitiesMaster.firstWhere((activity) => activity.id == id);
    } catch (e) {
      return null;
    }
  }

  // Mendapatkan aktivitas master berdasarkan user id
  static List<ActivityMaster> getByUserId(String userId) {
    return allActivitiesMaster
        .where((activity) => activity.userId == userId)
        .toList();
  }

  // Mendapatkan aktivitas master berdasarkan kategori
  static List<ActivityMaster> getByCategory(String categoryId) {
    return allActivitiesMaster
        .where(
          (activity) =>
              activity.categories.any((category) => category.id == categoryId),
        )
        .toList();
  }

  // Mendapatkan aktivitas master berdasarkan frekuensi
  static List<ActivityMaster> getByFrequency(Frequency frequency) {
    return allActivitiesMaster
        .where((activity) => activity.frequency == frequency)
        .toList();
  }
}
