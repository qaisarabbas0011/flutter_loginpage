import 'package:flutter/material.dart';

class ForgotPasswordController {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool emailSent = false;

  bool validateAndSend() {
    if (formKey.currentState?.validate() ?? false) {
      emailSent = true;
      // You can integrate Firebase or API logic here
      // e.g., FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      return true;
    }
    return false;
  }

  void resetState() {
    emailSent = false;
    emailController.clear();
  }

  void dispose() {
    emailController.dispose();
  }
}
