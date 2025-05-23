// signup_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController extends GetxController {
  // Text Controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();  // Added email controller
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  var isButtonEnabled = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isUsernameValid = true.obs;
  var isEmailValid = true.obs; // New for email validation
  var isPasswordValid = true.obs;
  var doPasswordsMatch = true.obs;
  var hasStartedTypingUsername = false.obs;
  var usernameErrorMessage = ''.obs;
  var emailErrorMessage = ''.obs;

  final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  final _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(_onUsernameChanged);
    emailController.addListener(_validateFields);
    passwordController.addListener(_validateFields);
    confirmPasswordController.addListener(_validateFields);
  }

  void _onUsernameChanged() {
    if (!hasStartedTypingUsername.value && usernameController.text.isNotEmpty) {
      hasStartedTypingUsername.value = true;
    }
    _validateFields();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void _validateFields() {
    // Username validation
    if (hasStartedTypingUsername.value) {
      if (usernameController.text.isEmpty ||
          _usernameRegex.hasMatch(usernameController.text)) {
        isUsernameValid.value = true;
        usernameErrorMessage.value = '';
      } else {
        isUsernameValid.value = false;
        usernameErrorMessage.value = ' Special characters are not allowed!';
      }
    }

    // Email validation
    if (emailController.text.isEmpty || _emailRegex.hasMatch(emailController.text)) {
      isEmailValid.value = true;
      emailErrorMessage.value = '';
    } else {
      isEmailValid.value = false;
      emailErrorMessage.value = ' Invalid email format!';
    }

    // Password validation
    isPasswordValid.value = passwordController.text.length >= 6 &&
        _passwordRegex.hasMatch(passwordController.text);

    // Confirm password match
    doPasswordsMatch.value =
        passwordController.text == confirmPasswordController.text;

    // Enable button only if all valid
    isButtonEnabled.value = isUsernameValid.value &&
        isEmailValid.value &&
        isPasswordValid.value &&
        doPasswordsMatch.value;
  }

  Future<void> signUp() async {
    try {
      // Create user with email & password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      // Optionally update display name (username)
      await userCredential.user?.updateDisplayName(usernameController.text.trim());

      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Clear text fields
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Go back or navigate to another page
      Get.back();
    } on FirebaseAuthException catch (e) {
      String message = 'Sign up failed.';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already in use.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email.';
      } else if (e.code == 'weak-password') {
        message = 'Weak password.';
      }
      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
