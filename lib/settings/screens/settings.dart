import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motionpal/settings/logic/bools.dart';
import 'package:simple_icons/simple_icons.dart';

import '../logic/themes.dart';
import '../widgets/buttons.dart';

List<bool> _getThemeModeBools(ThemeMode selectedThemeMode) {
  return List.generate(ThemeMode.values.length, (index) {
    return index == selectedThemeMode.index;
  });
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeModeProvider);
    bool isKMPH = ref.watch(isKMPHProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            SettingsButton(
              icon: SimpleIcons.github,
              text: 'Github Repo',
              onPressed: (context) {
                // TODO open the github repo
              },
            ),
            //settings switch button for changing distance between km and mph
            SettingsToggleButtons(
              icon: Icons.speed,
              text: 'Speed',
              onPressed: (i) {
                if (i == 0) {
                  ref.read(isKMPHProvider.notifier).updateIsKMPH(true);
                } else {
                  ref.read(isKMPHProvider.notifier).updateIsKMPH(false);
                }
              },
              isSelected: [isKMPH, !isKMPH],
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("km/h"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("mph"),
                )
              ],
            ),

            SettingsToggleButtons(
                icon: Theme.of(context).brightness == Brightness.light
                    ? Icons.wb_sunny_outlined
                    : Icons.dark_mode,
                text: "Theme",
                isSelected: _getThemeModeBools(themeMode),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('System'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Light'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Dark'),
                  ),
                ],
                onPressed: (index) {
                  ref
                      .read(themeModeProvider.notifier)
                      .updateThemeMode(ThemeMode.values[index]);
                })
          ],
        ),
      ),
    );
  }
}
