import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hirup_aing/config/api/api_config.dart';
import 'package:hirup_aing/data/mock/mock_users.dart';
import 'package:hirup_aing/data/models/auth_response_model.dart';
import 'package:hirup_aing/data/models/user_model.dart';
import 'package:hirup_aing/services/api/dio_client.dart';

class AuthService {
  final DioClient _dioClient = DioClient();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final bool _useMockData = true; // Set false ketika API sudah tersedia

  // Login user
  Future<AuthResponse> login(String email, String password) async {
    try {
      if (_useMockData) {
        // Simulasi delay jaringan
        await Future.delayed(const Duration(seconds: 1));

        // Validasi dengan mock data
        final user = MockUsers.validateLogin(email, password);

        if (user != null) {
          // Generate token dummy
          final token = 'mock-token-${DateTime.now().millisecondsSinceEpoch}';
          final refreshToken =
              'mock-refresh-token-${DateTime.now().millisecondsSinceEpoch}';

          // Simpan token ke secure storage
          await _secureStorage.write(key: 'auth_token', value: token);
          await _secureStorage.write(key: 'refresh_token', value: refreshToken);

          return AuthResponse(
            success: true,
            message: 'Login berhasil',
            data: AuthData(
              token: token,
              refreshToken: refreshToken,
              user: user,
            ),
          );
        } else {
          return AuthResponse(
            success: false,
            message: 'Email atau password salah',
          );
        }
      } else {
        // Gunakan API yang sebenarnya
        final response = await _dioClient.dio.post(
          ApiConfig.login,
          data: {'email': email, 'password': password},
        );

        final authResponse = AuthResponse.fromJson(response.data);

        if (authResponse.success && authResponse.data != null) {
          // Simpan token ke secure storage
          await _secureStorage.write(
            key: 'auth_token',
            value: authResponse.data!.token,
          );
          await _secureStorage.write(
            key: 'refresh_token',
            value: authResponse.data!.refreshToken,
          );
        }

        return authResponse;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      return AuthResponse(
        success: false,
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    }
  }

  // Register user
  Future<AuthResponse> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      if (_useMockData) {
        // Simulasi delay jaringan
        await Future.delayed(const Duration(seconds: 1));

        // Cek apakah email sudah terdaftar
        final existingUser = MockUsers.getByEmail(email);
        if (existingUser != null) {
          return AuthResponse(success: false, message: 'Email sudah terdaftar');
        }

        // Register user baru
        final newUser = MockUsers.register(email, password, name);
        if (newUser != null) {
          // Generate token dummy
          final token = 'mock-token-${DateTime.now().millisecondsSinceEpoch}';
          final refreshToken =
              'mock-refresh-token-${DateTime.now().millisecondsSinceEpoch}';

          // Simpan token ke secure storage
          await _secureStorage.write(key: 'auth_token', value: token);
          await _secureStorage.write(key: 'refresh_token', value: refreshToken);

          return AuthResponse(
            success: true,
            message: 'Registrasi berhasil',
            data: AuthData(
              token: token,
              refreshToken: refreshToken,
              user: newUser,
            ),
          );
        } else {
          return AuthResponse(
            success: false,
            message: 'Gagal mendaftarkan pengguna',
          );
        }
      } else {
        // Gunakan API yang sebenarnya
        final response = await _dioClient.dio.post(
          ApiConfig.register,
          data: {'name': name, 'email': email, 'password': password},
        );

        final authResponse = AuthResponse.fromJson(response.data);

        if (authResponse.success && authResponse.data != null) {
          // Simpan token ke secure storage
          await _secureStorage.write(
            key: 'auth_token',
            value: authResponse.data!.token,
          );
          await _secureStorage.write(
            key: 'refresh_token',
            value: authResponse.data!.refreshToken,
          );
        }

        return authResponse;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Register error: $e');
      }
      return AuthResponse(
        success: false,
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    }
  }

  // Logout user
  Future<bool> logout() async {
    try {
      if (_useMockData) {
        // Simulasi delay jaringan
        await Future.delayed(const Duration(seconds: 1));

        // Hapus token dari secure storage
        await _secureStorage.delete(key: 'auth_token');
        await _secureStorage.delete(key: 'refresh_token');

        return true;
      } else {
        // Ambil token dari secure storage
        final token = await _secureStorage.read(key: 'auth_token');

        // Panggil API logout
        await _dioClient.dio.post(
          ApiConfig.logout,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        // Hapus token dari secure storage
        await _secureStorage.delete(key: 'auth_token');
        await _secureStorage.delete(key: 'refresh_token');

        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
      return false;
    }
  }

  // Cek status autentikasi user
  Future<bool> isAuthenticated() async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      return token != null;
    } catch (e) {
      return false;
    }
  }

  // Ambil info user yang sedang login
  Future<User?> getCurrentUser() async {
    try {
      if (_useMockData) {
        // Ambil token dari secure storage
        final token = await _secureStorage.read(key: 'auth_token');

        // Dalam mock environment, kita anggap token valid dan return user pertama
        if (token != null) {
          return MockUsers.getAll()[1];
        }

        return null;
      } else {
        // Panggil API untuk mendapatkan info user
        final response = await _dioClient.dio.get(ApiConfig.userProfile);

        if (response.statusCode == 200) {
          return User.fromJson(response.data['data']['user']);
        }

        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Get current user error: $e');
      }
      return null;
    }
  }
}
