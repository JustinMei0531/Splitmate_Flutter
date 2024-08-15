import "dart:async";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:get/get.dart";
import "../../utils/validation_utils.dart";

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

  // Error message
  RxString emailError = "".obs;
  RxString pwdError = "".obs;

  // RxString

  RxInt activationIndex = 0.obs;

  Timer? timer;

  bool checkTextFormat() {
    bool isValid = true;
    if (emailController.text.isEmpty || !isValidEmail(emailController.text)) {
      emailError.value = "Invalid email!";
      Fluttertoast.showToast(
          msg: "Please input a valid email address!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white);
      isValid = false;
    }
    if (pwdController.text.isEmpty) {
      pwdError.value = "Password is empty!";
      Fluttertoast.showToast(
        msg: "Please enter your password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
      isValid = false;
    }
    return isValid;
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
    if (checkTextFormat()) {
      Get.offAllNamed("/login");
      return;
    }
  }

  void onApplyButtonPressed() {
    Get.offAllNamed("/apply");
    return;
  }
}
