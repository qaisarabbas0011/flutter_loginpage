import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/profile_screen_controller.dart';
import 'package:get/get.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final menuItems = controller.getProfileItems();

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
            Obx(() => Text(
                  controller.userName.value.isEmpty
                      ? 'Loading...'
                      : controller.userName.value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10),
            Obx(() => Text(
                  controller.userEmail.value.isEmpty
                      ? ''
                      : controller.userEmail.value,
                  style: TextStyle(color: Colors.grey[700]),
                )),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(item['icon'], color: Colors.teal),
                      title: Text(item['title']),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () {
                        // Implement navigation/actions here
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
