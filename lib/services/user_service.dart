import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

class UserService extends GetxService {
  // Local storage instance
  final GetStorage _userStorage = GetStorage();

  // Getter for user token
  String? get userToken => _userStorage.read("token");

  // Getter for user information
  Map<String, dynamic>? get userInfo => _userStorage.read("userInfo");

  // Save token to local storage
  void saveToken(String token) {
    _userStorage.write("token", token);
  }

  // Save user information to local storage
  void saveUserInfo(Map<String, dynamic> userInfo) {
    _userStorage.write("userInfo", userInfo);
  }

  // Remove user data on logout
  void clearUserData() {
    _userStorage.remove("token");
    _userStorage.remove("userInfo");
  }

  @override
  void onInit() {
    super.onInit();
    print("UserService initialized");
  }
}
