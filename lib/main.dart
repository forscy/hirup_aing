import 'package:hirup_aing/data/providers/settings_provider.dart';
import 'package:hirup_aing/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hirup_aing/app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Ensure Flutter is initialized before calling any platform channels
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the app intl indonesian wib
  await initializeDateFormatting('id_ID', null);

  try {
    // Initialize settings with error handling
    final settingsService = SettingsService();
    final settingsController = SettingsProvider(settingsService);

    try {
      await settingsController.loadSettings();
    } catch (e) {
      // Handle error loading settings or server time
      // Continue with default settings
      debugPrint('Error loading settings or server time: $e');
    }

    runApp(
      MultiProvider(
        providers: [
          // App state
          ChangeNotifierProvider(create: (_) => settingsController),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    // Log any initialization errors
    debugPrint('Error during app initialization: $e');
    debugPrint(stackTrace.toString());

    // Run a minimal fallback app if initialization fails
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Failed to initialize app: $e')),
        ),
      ),
    );
  }
}
