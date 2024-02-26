import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/extensions/string.dart';
import 'package:smilarm/providers/preferences/preferences.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  void showThemeDialog(
    BuildContext context,
    PreferencesNotifier preferencesNotifier,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Choose Theme'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          actions: [
            for (final themeMode in ThemeMode.values)
              CupertinoActionSheetAction(
                onPressed: () {
                  preferencesNotifier.setTheme(themeMode);
                  Navigator.pop(context);
                },
                child: Text(
                  themeMode.name.capitalize(),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final preferences = ref.watch(preferencesProvider);
    final preferencesNotifier = ref.read(preferencesProvider.notifier);

    return CupertinoPageScaffold(
      child: CupertinoListSection.insetGrouped(
        header: const SafeArea(child: Text('Settings')),
        children: [
          CupertinoListTile(
            leading: const Icon(CupertinoIcons.brightness),
            title: const Text('Theme'),
            trailing: CupertinoActionSheetAction(
              onPressed: () => showThemeDialog(context, preferencesNotifier),
              child: Text(preferences.themeMode.name.capitalize()),
            ),
          ),
          const CupertinoListTile(
            leading: Icon(CupertinoIcons.info),
            title: Text('Version'),
            trailing: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
