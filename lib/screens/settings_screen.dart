import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SettingsListItem(title: 'Account', icon: Icons.person),
            SettingsListItem(title: 'Notifications', icon: Icons.notifications),
            SettingsListItem(title: 'Security', icon: Icons.security),
            SettingsListItem(title: 'Language', icon: Icons.language),
            SettingsListItem(title: 'About', icon: Icons.info),
          ],
        ),
      ),
    );
  }
}

class SettingsListItem extends StatelessWidget {
  final String title;
  final IconData icon;

  SettingsListItem({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
