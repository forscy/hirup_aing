import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hirup_aing/app.dart';

Future<void> main() async {
  // Ensure Flutter is initialized before calling any platform channels
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the app intl indonesian wib
  await initializeDateFormatting('id_ID', null);

  try {
    // Run the app with ProviderScope for Riverpod
    runApp(const ProviderScope(child: MyApp()));
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
