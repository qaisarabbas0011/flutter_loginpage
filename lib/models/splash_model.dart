import 'package:get/get.dart';

class SplashModel {
  final RxBool isAnimationCompleted = false.obs;
  final RxBool isNavigated = false.obs;

  void markAnimationCompleted() {
    isAnimationCompleted.value = true;
  }

  void markNavigationDone() {
    isNavigated.value = true;
  }
}
