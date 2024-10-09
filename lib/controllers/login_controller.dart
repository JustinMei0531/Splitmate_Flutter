import "dart:async";
import "package:flutter/material.dart";
import "dart:convert";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "../../utils/validation_utils.dart";
import "../../http/http_service.dart";
import "../http/apis.dart";
import "../../services/user_service.dart"; // Import UserService

class LoginController extends GetxController {
  // Image list shown on the login page
  final List<String> images = [
    "./assets/images/login_image01.png",
    "./assets/images/login_image02.png",
    "./assets/images/login_image03.png",
    "./assets/images/login_image04.png",
  ];

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  // Http service
  final HttpService httpService = HttpService();

  // Loading state
  final RxBool isLoading = false.obs;

  // Error message
  RxString emailError = "".obs;
  RxString pwdError = "".obs;

  RxInt activationIndex = 0.obs;
  Timer? timer;

  // Inject UserService
  final UserService _userService = Get.find<UserService>();

  bool checkTextFormat() {
    if (emailController.text.isEmpty || !isValidEmail(emailController.text)) {
      emailError.value = "Invalid email!";
      Get.snackbar(
        "Error",
        "Please input a valid email.",
        icon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.warning,
            color: Colors.orange,
            size: 30.0,
          ),
        ),
        padding: const EdgeInsets.all(15.0),
      );
      return false;
    }
    if (pwdController.text.isEmpty) {
      pwdError.value = "Password is empty!";
      Get.snackbar(
        "Error",
        "Please input your password.",
        icon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.warning,
            color: Colors.orange,
            size: 30.0,
          ),
        ),
        padding: const EdgeInsets.all(15.0),
      );
    }
    return true;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      activationIndex.value = (activationIndex.value + 1) % images.length;
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer(); // Start the timer for image slideshow
  }

  @override
  void onClose() {
    timer?.cancel();
    emailController.dispose();
    pwdController.dispose();
    super.onClose();
  }

  // Use GetX router
  void onLoginButtonPressed() async {
    if (!checkTextFormat()) {
      return;
    }
    String email = emailController.text.trim();
    String password = pwdController.text.trim();

    try {
      isLoading.value = true; // Start loading
      http.Response response = await httpService.postRequest(Apis.login, {
        "email": email,
        "password": password
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Save the token using UserService
        _userService.saveToken(responseData["token"]);

        // Get user information from the server
        http.Response userResponse = await httpService.getRequest(
            Apis.userInfo, _userService.userToken!);

        if (userResponse.statusCode == 200) {
          // Save user information using UserService
          _userService.saveUserInfo(jsonDecode(userResponse.body));
        } else {
          print("Failed to fetch user info");
          return;
        }

        Get.snackbar("Success", "Login successful.",
            messageText: const Text(
              "Login successful",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            icon: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.verified,
                color: Colors.orange,
                size: 30.0,
              ),
            ),
            backgroundColor: Colors.green,
            colorText: Colors.white);

        // Navigate to the home page
        Get.toNamed("/user-home");
      } else {
        Get.snackbar("Failed", " ",
            messageText: const Text(
              "Login Failed",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            icon: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            backgroundColor: Colors.orange,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Network error: $e",
          backgroundColor: Colors.orange, colorText: Colors.white);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  void onApplyButtonPressed() {
    Get.offAllNamed("/apply");
  }

  void onForgetPasswordButtonPressed() {
    Get.offAllNamed("/input-email");
  }
}
