import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirup_aing/data/models/user_model.dart';
import 'package:hirup_aing/services/api/auth_service.dart';

// State untuk Auth
class AuthState {
  final User? user;
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;

  AuthState({
    this.user,
    this.isLoading = false,
    this.isLoggedIn = false,
    this.errorMessage,
  });

  // Membuat salinan dengan atribut yang diperbarui
  AuthState copyWith({
    User? user,
    bool? isLoading,
    bool? isLoggedIn,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage,
    );
  }

  // Helper untuk menampilkan loading state
  AuthState setLoading() {
    return copyWith(isLoading: true, errorMessage: null);
  }

  // Helper untuk menampilkan error
  AuthState setError(String message) {
    return copyWith(isLoading: false, errorMessage: message);
  }
}

// Notifier untuk Auth
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService = AuthService();

  AuthNotifier() : super(AuthState()) {
    // Check login status saat inisialisasi
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = state.setLoading();
    try {
      // Cek apakah user sudah login
      final isLoggedIn = await _authService.isAuthenticated();
      if (isLoggedIn) {
        // Ambil data user saat ini
        final user = await _authService.getCurrentUser();
        if (user != null) {
          state = state.copyWith(
            user: user,
            isLoading: false,
            isLoggedIn: true,
          );
          return;
        }
      }

      // Jika tidak ada user atau tidak login
      state = state.copyWith(user: null, isLoading: false, isLoggedIn: false);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking auth status: $e');
      }
      state = state.setError('Kesalahan saat memeriksa status autentikasi');
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.setLoading();
    try {
      final response = await _authService.login(email, password);

      if (response.success && response.data != null) {
        state = state.copyWith(
          user: response.data!.user,
          isLoading: false,
          isLoggedIn: true,
          errorMessage: null,
        );
        return true;
      } else {
        state = state.setError(response.message);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      state = state.setError('Kesalahan saat login');
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    state = state.setLoading();
    try {
      final response = await _authService.register(name, email, password);

      if (response.success && response.data != null) {
        state = state.copyWith(
          user: response.data!.user,
          isLoading: false,
          isLoggedIn: true,
          errorMessage: null,
        );
        return true;
      } else {
        state = state.setError(response.message);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during registration: $e');
      }
      state = state.setError('Kesalahan saat registrasi');
      return false;
    }
  }

  Future<void> logout() async {
    state = state.setLoading();
    try {
      final success = await _authService.logout();
      if (success) {
        state = state.copyWith(
          user: null,
          isLoading: false,
          isLoggedIn: false,
          errorMessage: null,
        );
      } else {
        state = state.setError('Gagal logout');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during logout: $e');
      }
      state = state.setError('Kesalahan saat logout');
    }
  }

  Future<void> refreshUserData() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        state = state.copyWith(user: user, errorMessage: null);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error refreshing user data: $e');
      }
    }
  }
}

// Provider untuk Auth
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
