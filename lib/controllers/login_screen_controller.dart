import 'package:flutter/material.dart';

class LoginScreenController extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;
  bool isPasswordVisible = false;
  bool isUsernameValid = true;
  bool isPasswordValid = true;
  String usernameErrorMessage = '';
  bool hasStartedTypingUsername = false;

  final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  final RegExp _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');

  LoginScreenController() {
    usernameController.addListener(_checkFields);
    passwordController.addListener(_checkFields);
  }

  void _checkFields() {
    if (!hasStartedTypingUsername && usernameController.text.isNotEmpty) {
      hasStartedTypingUsername = true;
    }

    if (hasStartedTypingUsername) {
      if (usernameController.text.isEmpty || _usernameRegex.hasMatch(usernameController.text)) {
        isUsernameValid = true;
        usernameErrorMessage = '';
      } else {
        isUsernameValid = false;
        usernameErrorMessage = ' Special characters are not allowed!';
      }
    }

    isPasswordValid = passwordController.text.length >= 6 &&
        _passwordRegex.hasMatch(passwordController.text);

    isButtonEnabled = isUsernameValid && isPasswordValid;

    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void disposeControllers() {
    usernameController.dispose();
    passwordController.dispose();
  }
}
