import "dart:convert";

import "package:get/get.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "../../utils/validation_utils.dart";
import "../../http/http_service.dart";
import "../http/apis.dart";

class ApplyController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  final HttpService httpService = HttpService();

  final RxBool isLoading = false.obs;

  void onRequestButtonClicked() async {
    // We assume that all text fields don't allow white-space.
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String passwordConfirmation = passwordConfirmationController.text.trim();

    // Textfield validation
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordConfirmation.isEmpty) {
      Get.snackbar(
        "Error",
        "Please complete your personal information.",
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
      return;
    }

    if (!isValidEmail(email)) {
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
      return;
    }
    if (password != passwordConfirmation) {
      Get.snackbar(
        "Error",
        "The passwords you entered twice do not match.",
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
      return;
    }

    // Start to send network request
    isLoading.value = true;

    try {
      /**
       * User fields:
       * 1. username;
       * 2. password;
       * 3. email;
       * 4. password_confirmation(optional)
       * 
       */

      /**
       * Success: statusCode: 201(created);
       * Fail: statusCode: 400(Bad request);
      */
      http.Response response = await httpService.postRequest(Apis.register, {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      }).timeout(const Duration(seconds: 5));

      // Received JSON data from server successfully
      if (response.statusCode == 201) {
        // Get response body first
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey("message")) {
          Get.snackbar(
            "Success",
            "Registration completed successfully.",
            icon: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.check_circle, color: Colors.green, size: 30.0),
            ),
            padding: const EdgeInsets.all(15.0),
          );
          // Redirect to the login page
          Get.offNamed("login");
        }
      } else if (response.statusCode == 400) {
        dynamic responseData =
            response.body.isNotEmpty ? jsonDecode(response.body) : {};
        Get.snackbar(
          "Error",
          "The email has already been taken.",
          icon: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.error, color: Colors.orange, size: 30.0),
          ),
          padding: const EdgeInsets.all(15.0),
        );
      }
    } catch (e) {
      // Handle network or unexpected errors
      Get.snackbar(
        "Error",
        "$e",
        icon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.error, color: Colors.red, size: 30.0),
        ),
        padding: const EdgeInsets.all(15.0),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
