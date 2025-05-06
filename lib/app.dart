import 'package:hirup_aing/config/themes/custom_theme.dart';
import 'package:hirup_aing/data/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hirup_aing/router_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _routerConfig;

  @override
  void initState() {
    super.initState();
    _routerConfig = AppRouter.router(context);
  }

  @override
  Widget build(BuildContext context) {
    Color seedColor = Colors.blue;
    return ListenableBuilder(
      listenable: context.watch<SettingsProvider>(),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Application Name',
          theme: AppTheme.lightTheme(
            seedColor: seedColor,
            fontFamily: context.watch<SettingsProvider>().fontFamily,
          ),
          darkTheme: AppTheme.darkTheme(
            seedColor: seedColor,
            fontFamily: context.watch<SettingsProvider>().fontFamily,
          ),
          themeMode: context.watch<SettingsProvider>().themeMode,
          routerConfig: _routerConfig,
        );
      },
    );
  }
}
