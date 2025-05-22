import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // Text Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  var isButtonEnabled = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isUsernameValid = true.obs;
  var isPasswordValid = true.obs;
  var doPasswordsMatch = true.obs;
  var hasStartedTypingUsername = false.obs;
  var usernameErrorMessage = ''.obs;

  final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  final _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(_onUsernameChanged);
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

    isPasswordValid.value = passwordController.text.length >= 6 &&
        _passwordRegex.hasMatch(passwordController.text);

    doPasswordsMatch.value =
        passwordController.text == confirmPasswordController.text;

    isButtonEnabled.value =
        isUsernameValid.value && isPasswordValid.value && doPasswordsMatch.value;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
