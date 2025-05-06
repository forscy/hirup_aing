import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hirup_aing/constants/feature_constant.dart';
import 'package:hirup_aing/data/models/user_model.dart';
import 'package:hirup_aing/data/providers/auth_provider.dart';
import 'package:hirup_aing/screens/home/semua_fitur_screen.dart';
import 'package:hirup_aing/screens/home/widgets/feature_grid_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        // Logout button
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality here
              // For example, you can call a logout method from your auth provider
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome to the Home Screen! ${authState.user?.name} as a ${authState.user?.role}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fitur Pilihan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Lihat Semua Button
                      TextButton(
                        onPressed: () {
                          // Navigate to the "Lihat Semua" screen
                          context.push(SemuaFiturScreen.routeName);
                        },
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FeatureGridWidget(
                    features:
                        getFeatureList(
                          authState.user?.role ?? UserRole.user,
                        ).take(3).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
