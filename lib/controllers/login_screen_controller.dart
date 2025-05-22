import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/login_model.dart';

class LoginController extends GetxController {
  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Reactive variables for UI state
  var isPasswordVisible = false.obs;
  var isUsernameValid = true.obs;
  var usernameErrorMessage = ''.obs;
  var isPasswordValid = true.obs;
  var isButtonEnabled = false.obs;
  var hasStartedTypingUsername = false.obs;

  final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  final RegExp _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');

  @override
  void onInit() {
    super.onInit();

    // Listen for text changes
    usernameController.addListener(_validateUsername);
    passwordController.addListener(_validatePassword);
  }

  void _validateUsername() {
    if (!hasStartedTypingUsername.value && usernameController.text.isNotEmpty) {
      hasStartedTypingUsername.value = true;
    }

    if (hasStartedTypingUsername.value) {
      if (usernameController.text.isEmpty || _usernameRegex.hasMatch(usernameController.text)) {
        isUsernameValid.value = true;
        usernameErrorMessage.value = '';
      } else {
        isUsernameValid.value = false;
        usernameErrorMessage.value = 'Special characters are not allowed!';
      }
    }

    _updateButtonStatus();
  }

  void _validatePassword() {
    final pass = passwordController.text;
    if (pass.length >= 6 && _passwordRegex.hasMatch(pass)) {
      isPasswordValid.value = true;
    } else {
      isPasswordValid.value = false;
    }

    _updateButtonStatus();
  }

  void _updateButtonStatus() {
    isButtonEnabled.value = isUsernameValid.value && isPasswordValid.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Optionally, you can create a method to get the LoginModel from inputs
  LoginModel getLoginModel() {
    return LoginModel(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
