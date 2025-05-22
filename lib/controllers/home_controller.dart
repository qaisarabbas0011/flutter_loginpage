import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int _currentIndex = 0;
  List<Map<String, String>> _users = [
    {'name': 'Qaisar Khan', 'contact': 'qaisar@example.com'},
    {'name': 'Ali Ahmed', 'contact': 'ali@example.com'},
  ];

  int get currentIndex => _currentIndex;
  List<Map<String, String>> get users => _users;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void addUser(String name) {
    _users.add({'name': name, 'contact': '$name@example.com'});
    notifyListeners();
  }
}
