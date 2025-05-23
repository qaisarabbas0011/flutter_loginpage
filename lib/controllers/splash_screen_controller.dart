import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/login_screen.dart';
import '../models/splash_model.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  final SplashModel splashModel = SplashModel();

  late TickerProvider vsync;

  SplashController({required this.vsync});

  @override
  void onInit() {
    super.onInit();
    _startSplash();
  }

  Future<void> _startSplash() async {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward().whenComplete(() {
      splashModel.markAnimationCompleted();
    });

    // Wait for Firebase (in case not initialized yet)
    try {
      await Firebase.initializeApp(); // Safe to call again
    } catch (e) {
      print("Firebase already initialized or error: $e");
    }

    // Continue to next screen after delay
    await Future.delayed(const Duration(seconds: 4));
    splashModel.markNavigationDone();
    Get.off(() => LoginScreen());
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
