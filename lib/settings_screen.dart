import 'package:flutter/material.dart';
import 'package:setting_app/utils/app_theme.dart';
import 'package:setting_app/widgets/bottom_nav.dart';
import 'package:setting_app/widgets/circle_Icon.dart';
import 'package:setting_app/widgets/danger_zone_divider.dart';
import 'package:setting_app/widgets/learn_more.dart';
import 'package:setting_app/widgets/setting_tile.dart';

import 'controller/ThemeController.dart';

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});
  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  final ThemeController controller = ThemeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Settings',
          themeMode: controller.mode,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          home: SettingsScreen(controller: controller),
        );
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.controller});
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
      ),
      bottomNavigationBar: BottomNav(selectedIndex: 4),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          SettingTile(
            leading: CircleIcon(color: const Color(0xFF2F80ED), icon: Icons.person),
            title: 'Account',
            subtitle: 'Adjust your name and email',
            onTap: () {},
          ),
          SettingTile(
            leading: CircleIcon(color: const Color(0xFF7B61FF), icon: Icons.sports_esports),
            title: 'Personalisation',
            subtitle: 'Set your theme and logo',
            onTap: () => _showThemeSheet(context, controller),
          ),
          SettingTile(
            leading: CircleIcon(color: const Color(0xFF27AE60), icon: Icons.lock),
            title: 'Password',
            subtitle: 'Update your password',
            onTap: () {},
          ),
          SettingTile(
            leading: CircleIcon(color: const Color(0xFFF2994A), icon: Icons.star),
            title: 'Rate the app',
            subtitle: 'Let us know how you feel',
            onTap: () {},
          ),
          SettingTile(
            leading: CircleIcon(color: const Color(0xFFFF4D94), icon: Icons.logout),
            title: 'Sign out',
            subtitle: 'Sign out of the app',
            onTap: () {},
          ),

          const SizedBox(height: 8),
          DangerZoneDivider(),

          SettingTile(
            leading: CircleIcon(color: const Color(0xFFFF4D4D), icon: Icons.delete_forever),
            title: 'Delete account',
            subtitle: 'We hate to see you leave',
            titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.redAccent,
              fontWeight: FontWeight.w700,
            ),
            onTap: () {},
          ),

          const SizedBox(height: 64),
          LearnMore(isDark: isDark),
        ],
      ),
    );
  }

  void _showThemeSheet(BuildContext context, ThemeController controller) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        ThemeMode current = controller.mode;
        Widget radio(ThemeMode mode, String label, IconData icon) {
          return RadioListTile<ThemeMode>(
            value: mode,
            groupValue: current,
            onChanged: (v) {
              if (v != null) {
                controller.setMode(v);
                Navigator.of(context).pop();
              }
            },
            title: Text(label, style: theme.textTheme.titleMedium),
            subtitle: Text(
              mode == ThemeMode.system
                  ? 'Follow device setting'
                  : mode == ThemeMode.light
                  ? 'Always use light theme'
                  : 'Always use dark theme',
              style: theme.textTheme.bodyMedium,
            ),
            secondary: Icon(icon),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 4),
              ListTile(
                title: Text(
                  'Theme',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                trailing: Chip(
                  label: Text(
                    current == ThemeMode.system
                        ? 'System'
                        : current == ThemeMode.light
                        ? 'Light'
                        : 'Dark',
                  ),
                ),
              ),
              radio(ThemeMode.system, 'System default', Icons.settings_suggest),
              radio(ThemeMode.light, 'Light', Icons.light_mode),
              radio(ThemeMode.dark, 'Dark', Icons.dark_mode),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.06)
                        : Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: isDark ? Colors.white70 : Colors.black87),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'You can change this later from Settings → Personalisation.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}