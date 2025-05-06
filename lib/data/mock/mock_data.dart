import 'package:hirup_aing/data/models/activity_enums.dart';
import 'package:hirup_aing/data/models/activity_instance_model.dart';
import 'package:hirup_aing/data/models/activity_master_model.dart';
import 'package:hirup_aing/data/models/category_model.dart';
import 'package:hirup_aing/data/models/user_model.dart';

class MockData {
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

  // Contoh kategori untuk user pertama
  static final List<Category> categoriesUser1 = [
    Category(
      id: 'cat-001',
      name: 'Ibadah',
      userId: 'user-001',
    ),
    Category(
      id: 'cat-002',
      name: 'Kewajiban',
      userId: 'user-001',
    ),
    Category(
      id: 'cat-003',
      name: 'Kesehatan',
      userId: 'user-001',
    ),
    Category(
      id: 'cat-004',
      name: 'Kuliah',
      userId: 'user-001',
    ),
    Category(
      id: 'cat-005',
      name: 'Pendidikan',
      userId: 'user-001',
    ),
  ];

  // Contoh kategori untuk user kedua
  static final List<Category> categoriesUser2 = [
    Category(
      id: 'cat-006',
      name: 'Kerja',
      userId: 'user-002',
    ),
    Category(
      id: 'cat-007',
      name: 'Olahraga',
      userId: 'user-002',
    ),
    Category(
      id: 'cat-008',
      name: 'Keluarga',
      userId: 'user-002',
    ),
  ];

  // Gabungan semua kategori
  static final List<Category> allCategories = [
    ...categoriesUser1,
    ...categoriesUser2,
  ];

  // Contoh aktivitas master untuk user pertama
  static final List<ActivityMaster> activitiesMasterUser1 = [
    // Aktivitas Solat Subuh (daily)
    ActivityMaster(
      id: 'act-001',
      name: 'Solat Subuh',
      startTime: DateTime(2025, 5, 5, 5, 0), // 05:00
      endTime: DateTime(2025, 5, 5, 5, 10),  // 05:10
      isRecurring: true,
      frequency: Frequency.DAILY,
      categories: [
        categoriesUser1[0], // Ibadah
        categoriesUser1[1], // Kewajiban
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
      endTime: DateTime(2025, 5, 6, 5, 15),   // 05:15
      isRecurring: true,
      frequency: Frequency.DAILY,
      categories: [
        categoriesUser1[2], // Kesehatan
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
      endTime: DateTime(2025, 5, 6, 7, 0),   // 07:00
      isRecurring: true,
      frequency: Frequency.MONTHLY,
      datesOfMonth: [6], // Tanggal 6 setiap bulan
      categories: [
        categoriesUser1[2], // Kesehatan
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
      endTime: DateTime(2025, 6, 9, 9, 20),   // 09:20
      isRecurring: true,
      frequency: Frequency.WEEKLY,
      daysOfWeek: [Days.MONDAY], // Setiap hari Senin
      categories: [
        categoriesUser1[3], // Kuliah
        categoriesUser1[4], // Pendidikan
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
      endTime: DateTime(2025, 5, 6, 10, 0),  // 10:00
      isRecurring: true,
      frequency: Frequency.DAILY,
      daysOfWeek: [Days.MONDAY, Days.TUESDAY, Days.WEDNESDAY, Days.THURSDAY, Days.FRIDAY],
      categories: [
        categoriesUser2[0], // Kerja
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
      endTime: DateTime(2025, 5, 6, 7, 0),   // 07:00
      isRecurring: true,
      frequency: Frequency.WEEKLY,
      daysOfWeek: [Days.SATURDAY, Days.SUNDAY], // Weekend
      categories: [
        categoriesUser2[1], // Olahraga
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

  // Gabungan semua instance aktivitas
  static final List<ActivityInstance> allActivityInstances = [
    ...activityInstancesUser1,
    // Instance untuk user lain bisa ditambahkan di sini
  ];

  // Fungsi untuk mendapatkan semua aktivitas per hari untuk user tertentu
  static List<Map<String, dynamic>> getActivitiesForDate(String userId, DateTime date) {
    final List<Map<String, dynamic>> result = [];
    
    // Filter hanya instance yang milik aktivitas master user ini
    final userMasterIds = allActivitiesMaster
        .where((master) => master.userId == userId)
        .map((master) => master.id)
        .toList();
    
    // Filter instance yang sesuai tanggal dan milik user ini
    final instances = allActivityInstances.where((instance) =>
        userMasterIds.contains(instance.activityMasterId) &&
        instance.activityDate.year == date.year &&
        instance.activityDate.month == date.month &&
        instance.activityDate.day == date.day).toList();
    
    // Gabungkan data master dan instance
    for (var instance in instances) {
      final master = allActivitiesMaster.firstWhere(
        (m) => m.id == instance.activityMasterId,
        orElse: () => throw Exception('Activity Master not found'),
      );
      
      result.add({
        'instance': instance,
        'master': master,
        'categories': master.categories,
      });
    }
    
    return result;
  }
}