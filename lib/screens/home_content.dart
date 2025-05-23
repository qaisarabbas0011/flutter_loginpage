import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeContent extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.users.isEmpty) {
        return Center(
          child: Text('No users found', style: TextStyle(fontSize: 18)),
        );
      }
      return ListView.builder(
        itemCount: controller.users.length,
        itemBuilder: (context, index) {
          final user = controller.users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user['name'][0].toUpperCase()),
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            title: Text(user['name']),
            subtitle: Text(user['contact']),
          );
        },
      );
    });
  }
}
