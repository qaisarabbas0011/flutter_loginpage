import 'package:get/get.dart';
import 'package:flutter/material.dart';
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

    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: vsync,
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward().whenComplete(() {
      splashModel.markAnimationCompleted();
    });

    Future.delayed(Duration(seconds: 4), () {
      splashModel.markNavigationDone();
      Get.off(() => LoginScreen());
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
