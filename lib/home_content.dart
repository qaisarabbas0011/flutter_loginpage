// home_content.dart
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> users = [
    {'name': 'Qaisar Khan', 'contact': 'qaisar@example.com'},
    {'name': 'Ali Ahmed', 'contact': 'ali@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 12),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(users[index]['name']![0]),
              ),
              title: Text(
                users[index]['name']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(users[index]['contact']!),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
