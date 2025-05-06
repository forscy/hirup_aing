import 'package:hirup_aing/data/models/activity_enums.dart';
import 'package:hirup_aing/data/models/activity_instance_model.dart';
import 'package:hirup_aing/data/models/activity_master_model.dart';
import 'package:hirup_aing/data/models/category_model.dart';
import 'package:hirup_aing/data/models/user_model.dart';
import 'package:hirup_aing/data/mock/mock_users.dart';
import 'package:hirup_aing/data/mock/mock_categories.dart';
import 'package:hirup_aing/data/mock/mock_activity_masters.dart';
import 'package:hirup_aing/data/mock/mock_activity_instances.dart';

/// Service untuk mengakses semua mock data
class MockDataService {
  // User Services
  static User? authenticateUser(String email, String password) {
    return MockUsers.validateLogin(email, password);
  }

  static User? getUserById(String id) {
    return MockUsers.getById(id);
  }

  static User? getUserByEmail(String email) {
    return MockUsers.getByEmail(email);
  }

  // Category Services
  static List<Category> getUserCategories(String userId) {
    return MockCategories.getByUserId(userId);
  }

  static Category? getCategoryById(String id) {
    return MockCategories.getById(id);
  }

  // Activity Master Services
  static List<ActivityMaster> getUserActivities(String userId) {
    return MockActivityMasters.getByUserId(userId);
  }

  static ActivityMaster? getActivityMasterById(String id) {
    return MockActivityMasters.getById(id);
  }

  static List<ActivityMaster> getActivitiesByCategory(String categoryId) {
    return MockActivityMasters.getByCategory(categoryId);
  }

  static List<ActivityMaster> getActivitiesByFrequency(Frequency frequency) {
    return MockActivityMasters.getByFrequency(frequency);
  }

  // Activity Instance Services
  static List<ActivityInstance> getActivityInstances(String activityMasterId) {
    return MockActivityInstances.getByActivityMasterId(activityMasterId);
  }

  static ActivityInstance? getActivityInstanceById(String id) {
    return MockActivityInstances.getById(id);
  }

  static List<ActivityInstance> getInstancesByDate(DateTime date) {
    return MockActivityInstances.getByDate(date);
  }

  // Mendapatkan semua aktivitas untuk pengguna pada tanggal tertentu
  static List<Map<String, dynamic>> getUserDailyActivities(
    String userId,
    DateTime date,
  ) {
    return MockActivityInstances.getUserActivitiesByDate(userId, date);
  }

  // Mendapatkan semua aktivitas untuk pengguna dalam rentang tanggal
  static Map<DateTime, List<Map<String, dynamic>>> getUserActivitiesByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) {
    final Map<DateTime, List<Map<String, dynamic>>> result = {};

    // Generate list of dates in the range
    final daysToGenerate = endDate.difference(startDate).inDays + 1;
    for (int i = 0; i < daysToGenerate; i++) {
      final date = DateTime(startDate.year, startDate.month, startDate.day + i);

      final activities = getUserDailyActivities(userId, date);
      if (activities.isNotEmpty) {
        result[date] = activities;
      }
    }

    return result;
  }

  // Update status aktivitas
  static ActivityInstance updateActivityStatus(
    String instanceId,
    ActivityStatus newStatus,
  ) {
    final instance = MockActivityInstances.getById(instanceId);

    if (instance == null) {
      throw Exception('Instance aktivitas tidak ditemukan');
    }

    final updatedInstance = instance.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    // Dalam implementasi nyata, ini akan menyimpan ke database
    // Di sini kita hanya mengembalikan instance yang sudah diubah
    return updatedInstance;
  }

  // Mendapatkan statistik aktivitas pengguna
  static Map<String, dynamic> getUserActivityStatistics(
    String userId,
    DateTime date,
  ) {
    // Mendapatkan aktivitas bulan ini
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final activities = MockActivityInstances.getUserActivitiesByDate(
      userId,
      date,
    );
    final monthlyActivities = getUserActivitiesByDateRange(
      userId,
      firstDayOfMonth,
      lastDayOfMonth,
    );

    // Hitung status
    int completed = 0;
    int pending = 0;
    int postponed = 0;
    int cancelled = 0;

    monthlyActivities.forEach((_, dailyActivities) {
      for (final activity in dailyActivities) {
        final instance = activity['instance'] as ActivityInstance;
        switch (instance.status) {
          case ActivityStatus.COMPLETED:
            completed++;
            break;
          case ActivityStatus.PENDING:
            pending++;
            break;
          case ActivityStatus.POSTPONED:
            postponed++;
            break;
          case ActivityStatus.CANCELLED:
            cancelled++;
            break;
        }
      }
    });

    // Hitung per kategori
    final Map<String, int> activitiesByCategory = {};
    final categories = MockCategories.getByUserId(userId);

    for (final category in categories) {
      activitiesByCategory[category.name] = 0;
    }

    monthlyActivities.forEach((_, dailyActivities) {
      for (final activity in dailyActivities) {
        final master = activity['master'] as ActivityMaster;
        for (final category in master.categories) {
          activitiesByCategory[category.name] =
              (activitiesByCategory[category.name] ?? 0) + 1;
        }
      }
    });

    return {
      'today': {
        'total': activities.length,
        'completed':
            activities
                .where(
                  (a) =>
                      (a['instance'] as ActivityInstance).status ==
                      ActivityStatus.COMPLETED,
                )
                .length,
        'pending':
            activities
                .where(
                  (a) =>
                      (a['instance'] as ActivityInstance).status ==
                      ActivityStatus.PENDING,
                )
                .length,
        'postponed':
            activities
                .where(
                  (a) =>
                      (a['instance'] as ActivityInstance).status ==
                      ActivityStatus.POSTPONED,
                )
                .length,
        'cancelled':
            activities
                .where(
                  (a) =>
                      (a['instance'] as ActivityInstance).status ==
                      ActivityStatus.CANCELLED,
                )
                .length,
      },
      'month': {
        'total': completed + pending + postponed + cancelled,
        'completed': completed,
        'pending': pending,
        'postponed': postponed,
        'cancelled': cancelled,
      },
      'categories': activitiesByCategory,
    };
  }
}
