import 'package:hirup_aing/config/themes/custom_theme.dart';
import 'package:hirup_aing/data/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hirup_aing/router_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the theme mode and font family from providers
    final fontFamily = ref.watch(fontFamilyProvider);

    // Create router
    final router = AppRouter.router(ref);

    // Use a consistent seed color
    const seedColor = Colors.blue;

    return MaterialApp.router(
      title: 'Application Name',
      theme: AppTheme.lightTheme(seedColor: seedColor, fontFamily: fontFamily),
      // darkTheme: AppTheme.darkTheme(
      //   seedColor: seedColor,
      //   fontFamily: fontFamily,
      // ),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
