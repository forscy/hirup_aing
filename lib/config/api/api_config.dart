class ApiConfig {
  // Base URL
  static const String baseUrl = 'https://api.hirupaing.com/api/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';

  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';

  // Activity Endpoints
  static const String activities = '/activities';
  static const String activityInstances = '/activity-instances';

  // Category Endpoints
  static const String categories = '/categories';

  // Statistics Endpoints
  static const String statistics = '/statistics';
}
