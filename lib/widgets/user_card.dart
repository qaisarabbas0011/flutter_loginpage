import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String contact;
  final String number;

  const UserCard({super.key, required this.name, required this.contact, required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/insta2.png'),
          backgroundColor: Colors.indigo,
          child: Text(name[0], style: TextStyle(color: Colors.white)),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Contact: $contact\nNumber: $number'),
      ),
    );
  }
}
