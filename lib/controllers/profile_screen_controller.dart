import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  // User info as RxString if you want to update them dynamically
  var userName = 'Qaisar Khan'.obs;
  var userEmail = 'qaisar@example.com'.obs;

  // Profile menu items can remain as a normal getter since they are static
  List<Map<String, dynamic>> getProfileItems() {
    return [
      {'title': 'Account Settings', 'icon': Icons.settings},
      {'title': 'Privacy', 'icon': Icons.lock},
      {'title': 'Notifications', 'icon': Icons.notifications},
      {'title': 'Help & Support', 'icon': Icons.help},
    ];
  }
}
