import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Reactive boolean to track if email is sent
  var emailSent = false.obs;

  bool validateAndSend() {
    if (formKey.currentState?.validate() ?? false) {
      emailSent.value = true;
      // Add your password reset logic here
      // e.g., FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      return true;
    }
    return false;
  }

  void resetState() {
    emailSent.value = false;
    emailController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
