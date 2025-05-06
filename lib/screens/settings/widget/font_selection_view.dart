import 'package:hirup_aing/data/providers/settings_provider.dart';
import 'package:hirup_aing/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FontSelectionView extends ConsumerWidget {
  const FontSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFont = ref.watch(fontFamilyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Font')),
      body: ListView.builder(
        itemCount: SettingsService.availableFonts.length,
        itemBuilder: (context, index) {
          final fontFamily = SettingsService.availableFonts[index];
          final isSelected = currentFont == fontFamily;

          return ListTile(
            title: Text(
              fontFamily,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              'Sample text with $fontFamily font',
              style: TextStyle(fontFamily: fontFamily),
            ),
            trailing: isSelected ? const Icon(Icons.check) : null,
            onTap: () {
              ref
                  .read(fontFamilyProvider.notifier)
                  .updateFontFamily(fontFamily);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
