import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_sense/view/widgets/settings_widges/setting_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Get.toNamed('/skinTypeInfo');
                },
              ),
              _buildSettingsTile(
                context,
                title: 'Privacy',
                icon: Icons.lock_outline,
                onTap: () {
                  Get.toNamed('/privacy');
                },
              ),
            ],
          ),
          // const SettingsSection(
          //   title: 'FEEDBACK',
          //   tiles: [
          //     ListTile(
          //       leading:
          //           Icon(Icons.report_problem_outlined, color: Colors.grey),
          //       title: Text('Report a bug',
          //           style: TextStyle(color: Colors.grey)),
          //       subtitle: Text('Building in progress',
          //           style: TextStyle(color: Colors.red)),
          //       enabled: false, // Disables the tile
          //     ),
          //     ListTile(
          //       leading:
          //           Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
          //       title: Text('Send feedback',
          //           style: TextStyle(color: Colors.grey)),
          //       subtitle: Text('Building in progress',
          //           style: TextStyle(color: Colors.red)),
          //       enabled: false, // Disables the tile
          //     ),
          //   ],
          // ),
        ],
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
