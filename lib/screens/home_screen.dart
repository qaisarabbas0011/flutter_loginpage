import 'package:flutter/material.dart';
import '../../widgets/user_card.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> userData = [
    {"name": "Qaisar Khan", "contact": "qaisar1@gmail.com", "number": "123-456-7890"},
    {"name": "Ahmed Ali", "contact": "ahmed.ali@gmail.com", "number": "234-567-8901"},
    {"name": "Fatima Noor", "contact": "fatima.noor@gmail.com", "number": "345-678-9012"},
    {"name": "Aisha Khan", "contact": "aisha.khan@gmail.com", "number": "456-789-0123"},
    {"name": "Zain Malik", "contact": "zain.malik@gmail.com", "number": "567-890-1234"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/user.png'), // Replace with your asset image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Qaisar Khan',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context); // Close Drawer
                Navigator.pop(context); // Simulate logout
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return UserCard(
              name: userData[index]["name"]!,
              contact: userData[index]["contact"]!,
              number: userData[index]["number"]!,
            );
          },
        ),
      ),
    );
  }
}
