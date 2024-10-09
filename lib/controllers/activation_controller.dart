import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ActivationController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Rx<XFile?> imageFile = Rx<XFile?>(null);

  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile.value = pickedFile;

        // Show success message
        Get.snackbar(
          "Success",
          "Avatar uploaded successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick an image: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onActivateButtonPressed() {
    Get.offNamed("/home");
  }
}
