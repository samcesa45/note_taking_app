import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/controllers/theme_controller.dart';

class ShowSettingsSheet extends ConsumerWidget {
  const ShowSettingsSheet({super.key});
  void _showSettingsSheet(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeControllerProvider);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.brightness_4_outlined),
              title: const Text('Select Theme'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Theme'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<ThemeMode>(
                            title: const Text('System'),
                            value: ThemeMode.system,
                            groupValue: currentThemeMode,
                            onChanged: (ThemeMode? value) {
                              ref
                                  .read(themeControllerProvider.notifier)
                                  .setThemeMode(value!);
                              Navigator.pop(context);
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Light'),
                            value: ThemeMode.light,
                            groupValue: currentThemeMode,
                            onChanged: (ThemeMode? value) {
                              ref
                                  .read(themeControllerProvider.notifier)
                                  .setThemeMode(value!);
                              Navigator.pop(context);
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Dark'),
                            value: ThemeMode.dark,
                            groupValue: currentThemeMode,
                            onChanged: (ThemeMode? value) {
                              ref
                                  .read(themeControllerProvider.notifier)
                                  .setThemeMode(value!);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => _showSettingsSheet(context, ref),
    );
  }
}
