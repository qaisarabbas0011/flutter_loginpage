import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isUsernameValid = true;
  bool isPasswordValid = true;
  bool doPasswordsMatch = true;
  bool hasStartedTypingUsername = false;
  String usernameErrorMessage = '';

  final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  final _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');

  SignUpController() {
    usernameController.addListener(_onUsernameChanged);
    passwordController.addListener(_validateFields);
    confirmPasswordController.addListener(_validateFields);
  }

  void _onUsernameChanged() {
    if (!hasStartedTypingUsername && usernameController.text.isNotEmpty) {
      hasStartedTypingUsername = true;
    }
    _validateFields();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  void _validateFields() {
    if (hasStartedTypingUsername) {
      if (usernameController.text.isEmpty ||
          _usernameRegex.hasMatch(usernameController.text)) {
        isUsernameValid = true;
        usernameErrorMessage = '';
      } else {
        isUsernameValid = false;
        usernameErrorMessage = ' Special characters are not allowed!';
      }
    }

    isPasswordValid = passwordController.text.length >= 6 &&
        _passwordRegex.hasMatch(passwordController.text);

    doPasswordsMatch =
        passwordController.text == confirmPasswordController.text;

    isButtonEnabled = isUsernameValid && isPasswordValid && doPasswordsMatch;

    notifyListeners();
  }

  void disposeControllers() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
