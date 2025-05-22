import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  var users = <Map<String, String>>[
    {'name': 'Qaisar Khan', 'contact': 'qaisar@example.com'},
    {'name': 'Ali Ahmed', 'contact': 'ali@example.com'},
  ].obs;

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void addUser(String name) {
    users.add({'name': name, 'contact': '$name@example.com'});
  }
}
