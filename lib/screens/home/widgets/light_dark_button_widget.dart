import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirup_aing/data/providers/settings_provider.dart';
import 'package:flutter/material.dart';

class LightDarkButtonWidget extends ConsumerStatefulWidget {
  const LightDarkButtonWidget({super.key});

  @override
  ConsumerState<LightDarkButtonWidget> createState() =>
      _LightDarkButtonWidgetState();
}

class _LightDarkButtonWidgetState extends ConsumerState<LightDarkButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.wb_sunny
            : Icons.nightlight_round,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.yellow
                : Colors.blueGrey,
      ),
      onPressed: () {
        ref
            .watch(themeModeProvider.notifier)
            .updateThemeMode(
              Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
      },
    );
  }
}
