import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBarsHelper {
  static void showError(String value) => Get.snackbar('Oops!', value,
      colorText: Colors.white,
      animationDuration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.startToEnd,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      forwardAnimationCurve: Curves.elasticInOut,
      backgroundColor: Colors.red.withOpacity(0.80));

  static void showRequired(String value) => Get.snackbar('Required*', value,
      colorText: Colors.white,
      animationDuration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.startToEnd,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      forwardAnimationCurve: Curves.elasticInOut,
      backgroundColor: Colors.red.withOpacity(0.80));

  static void showMessage(String value, {bool dark = false}) =>
      Get.snackbar('Message', value,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 2),
          dismissDirection: DismissDirection.startToEnd,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          forwardAnimationCurve: Curves.elasticInOut,
          backgroundColor: Colors.black.withOpacity(0.80));
}
