import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  // Reactive list of users from Firestore
  var users = <Map<String, dynamic>>[].obs;

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    super.onInit();
    // Listen to real-time changes on Firestore 'users' collection
    usersCollection.snapshots().listen((snapshot) {
      users.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // store doc id for updates/deletes if needed
        return data;
      }).toList();
    });
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> addUser(String name) async {
    try {
      await usersCollection.add({
        'name': name,
        'contact': '$name@example.com',
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}
