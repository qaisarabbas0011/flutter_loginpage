import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/login_model.dart';
import '../screens/home_screen.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isUsernameValid = true.obs;
  var usernameErrorMessage = ''.obs;
  var isPasswordValid = true.obs;
  var isButtonEnabled = false.obs;
  var hasStartedTypingUsername = false.obs;

  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(_validateUsername);
    passwordController.addListener(_validatePassword);
  }

  void _validateUsername() {
    if (!hasStartedTypingUsername.value && usernameController.text.isNotEmpty) {
      hasStartedTypingUsername.value = true;
    }

    if (hasStartedTypingUsername.value) {
      if (_emailRegex.hasMatch(usernameController.text.trim())) {
        isUsernameValid.value = true;
        usernameErrorMessage.value = '';
      } else {
        isUsernameValid.value = false;
        usernameErrorMessage.value = 'Enter a valid email!';
      }
    }

    _updateButtonStatus();
  }

  void _validatePassword() {
    final pass = passwordController.text;
    isPasswordValid.value = pass.length >= 6;
    _updateButtonStatus();
  }

  void _updateButtonStatus() {
    isButtonEnabled.value = isUsernameValid.value && isPasswordValid.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginWithFirebase() async {
    final email = usernameController.text.trim();
    final password = passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.off(() => HomeScreen());
    } catch (e) {
      Get.snackbar('Login Failed', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

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
