import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Qaisar Khan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('qaisar@example.com', style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  ProfileListItem(title: 'Account Settings', icon: Icons.settings),
                  ProfileListItem(title: 'Privacy', icon: Icons.lock),
                  ProfileListItem(title: 'Notifications', icon: Icons.notifications),
                  ProfileListItem(title: 'Help & Support', icon: Icons.help),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final String title;
  final IconData icon;

  ProfileListItem({required this.title, required this.icon});

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
