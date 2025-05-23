import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'home_content.dart';

// Dummy placeholders for these screens:
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text('Profile Screen'));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text('Settings Screen'));
}

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Widget> _screens = [
    HomeContent(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  HomeScreen({super.key});

  void _onAddUser(BuildContext context) {
    TextEditingController userController = TextEditingController();

    Get.defaultDialog(
      title: 'Add New User',
      content: TextField(
        controller: userController,
        decoration: InputDecoration(hintText: 'Enter User Name'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
      confirm: TextButton(
        onPressed: () {
          if (userController.text.trim().isNotEmpty) {
            controller.addUser(userController.text.trim());
            Get.back();
          }
        },
        child: Text('Add'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insta',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Obx(() => AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _screens[controller.currentIndex.value],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.setCurrentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
            backgroundColor: Colors.white,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddUser(context),
        backgroundColor: Colors.teal,
        elevation: 0,
        tooltip: 'Add User',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
