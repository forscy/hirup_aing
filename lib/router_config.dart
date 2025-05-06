import 'package:hirup_aing/screens/common/not_found_screen.dart';
import 'package:hirup_aing/screens/common/unauthorized_screen.dart';
import 'package:hirup_aing/screens/common/under_maintenance_screen.dart';
import 'package:hirup_aing/screens/auth/login_screen.dart';
import 'package:hirup_aing/screens/home/home_screen.dart';
import 'package:hirup_aing/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class AppRouter {
  static GoRouter router(WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(
        ref.read(authProvider.notifier).stream,
      ),
      redirect: (context, state) {
        final isLoggedIn = authState.isLoggedIn;
        final isGoingToLogin = state.matchedLocation == LoginScreen.routeName;

        // If not logged in and not going to login, redirect to login
        if (!isLoggedIn && !isGoingToLogin) {
          return LoginScreen.routeName;
        }

        // If logged in and going to login, redirect to home
        if (isLoggedIn && isGoingToLogin) {
          return '/';
        }

        // No redirection needed
        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
        // Error handling routes
        GoRoute(
          path: UnauthorizedScreen.routeName,
          builder: (context, state) => const UnauthorizedScreen(),
        ),
        GoRoute(
          path: NotFoundScreen.routeName,
          builder: (context, state) => const NotFoundScreen(),
        ),
        GoRoute(
          path: UnderMaintenanceScreen.routeName,
          builder: (context, state) => const UnderMaintenanceScreen(),
        ),
      ],
      errorBuilder: (context, state) => NotFoundScreen(), // Handle 404 errors
    );
  }
}

// Helper class to create a Listenable from a StateNotifier stream
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
