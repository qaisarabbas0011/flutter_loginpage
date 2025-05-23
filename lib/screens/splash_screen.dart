import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late SplashController splashController;

  @override
  void initState() {
    super.initState();
    splashController = SplashController(vsync: this);
    Get.put(splashController); // Register with GetX
    splashController.onInit();
  }

  @override
  void dispose() {
    splashController.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => splashController.splashModel.isAnimationCompleted.value
          ? buildAnimatedSplash()
          : buildInitialSplash()),
    );
  }

  Widget buildInitialSplash() => Center(
        child: CircularProgressIndicator(color: Colors.tealAccent),
      );

  Widget buildAnimatedSplash() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: splashController.fadeAnimation,
                child: Image.asset('images/insta1.png', width: 150, height: 150),
              ),
              SizedBox(height: 20),
              FadeTransition(
                opacity: splashController.fadeAnimation,
                child: Text(
                  'Welcome to App',
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      );
}
