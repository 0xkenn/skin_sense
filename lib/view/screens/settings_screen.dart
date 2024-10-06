import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_sense/view/widgets/settings_widges/setting_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        body: ListView(
          children: [
            SettingsSection(
              title: 'GENERAL',
              tiles: [
                _buildSettingsTile(
                  context,
                  title: 'About',
                  icon: Icons.info_outline,
                  onTap: () {
                    Get.toNamed('/about');
                  },
                ),
                _buildSettingsTile(
                  context,
                  title: 'Learn more about skin types',
                  icon: Icons.person_outline,
                  onTap: () {
                    // Handle Learn more tap
                    Get.toNamed('/skinTypeInfo');
                  },
                ),
                _buildSettingsTile(
                  context,
                  title: 'Privacy',
                  icon: Icons.lock_outline,
                  onTap: () {
                    // Handle Privacy tap
                    Get.toNamed('/privacy');
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'FEEDBACK',
              tiles: [
                _buildSettingsTile(
                  context,
                  title: 'Report a bug',
                  icon: Icons.report_problem_outlined,
                  onTap: () {
                    // Handle Report a bug tap
                  },
                ),
                _buildSettingsTile(
                  context,
                  title: 'Send feedback',
                  icon: Icons.thumb_up_alt_outlined,
                  onTap: () {
                    // Handle Send feedback tap
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSettingsTile(
  BuildContext context, {
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: onTap,
  );
}
