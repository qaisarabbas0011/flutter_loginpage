import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeContent extends StatelessWidget {
  late final HomeController controller;

  HomeContent({super.key}) {
    controller = Get.find();
  }

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
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              child: Text(user['name'][0].toUpperCase()),
            ),
            title: Text(user['name']),
            subtitle: Text(user['contact']),
          );
        },
      );
    });
  }
}
