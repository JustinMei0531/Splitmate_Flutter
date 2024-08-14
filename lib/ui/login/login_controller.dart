import "dart:async";
import "package:flutter/material.dart";
import "package:get/get.dart";

class LoginController extends GetxController {
  // This list contains images that shown on the login page
  final List<String> images = [
    "./assets/images/login_image01.png",
    "./assets/images/login_image02.png",
    "./assets/images/login_image03.png",
    "./assets/images/login_image04.png",
  ];

  // Controllers
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  // RxString

  RxInt activationIndex = 0.obs;

  Timer? timer;

  bool checkTextFormat() {
    return false;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      activationIndex.value = (activationIndex.value + 1) % images.length;
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer(); // Start to show images
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  // Use GetX router()
  void onLoginButtonPressed() {
    Get.offAllNamed("/login");
  }
}
