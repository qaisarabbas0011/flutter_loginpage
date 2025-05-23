import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;

  final String userId = 'your_user_id_here'; // Replace with actual user id or method to get current user id

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    usersCollection.doc(userId).snapshots().listen((doc) {
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        userName.value = data['name'] ?? '';
        userEmail.value = data['contact'] ?? '';
      }
    });
  }

  List<Map<String, dynamic>> getProfileItems() {
    return [
      {'title': 'Account Settings', 'icon': Icons.settings},
      {'title': 'Privacy', 'icon': Icons.lock},
      {'title': 'Notifications', 'icon': Icons.notifications},
      {'title': 'Help & Support', 'icon': Icons.help},
    ];
  }
}
