import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:splitmate_flutter/services/user_service.dart';

class UpdateProfileController extends GetxController {
  // Inject UserService
  final UserService userService = Get.find<UserService>();

  // Controllers for text fields
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  // Reactive loading state and image file
  final RxBool isLoading = false.obs;
  final Rx<File?> imageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize text controllers with existing user data
    nameController =
        TextEditingController(text: userService.userInfo?['name'] ?? '');
    emailController =
        TextEditingController(text: userService.userInfo?['email'] ?? '');
    phoneController =
        TextEditingController(text: userService.userInfo?['phone'] ?? '');
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is destroyed
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Pick image using ImagePicker
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // Save profile information and avatar
  void saveProfileInfo() async {
    // Update loading state
    isLoading.value = true;

    // Update user information in UserService
    userService.saveUserInfo({
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      // Optionally, you can store the avatar path or handle uploading here
      'avatar': imageFile.value?.path,
    });

    // Show success message
    Get.snackbar(
      "Success",
      "Profile updated successfully.",
      icon: const Icon(Icons.check_circle, color: Colors.white),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Stop loading
    isLoading.value = false;
  }

  // Back to previous page
  void onBackButtonClicked() {
    Get.back();
    return;
  }
}
