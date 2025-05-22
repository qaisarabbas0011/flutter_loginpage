import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';  // Adjust the path based on your structure

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();

    // Setup animation
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();

    // Navigate after delay
    Future.delayed(Duration(seconds: 4), () {
      Get.off(() => LoginScreen()); // PushReplacement
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
