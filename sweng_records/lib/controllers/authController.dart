import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sweng_records/routes/app_routes.dart';
import 'package:sweng_records/services/auth_services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sweng_records/utils/helper_functions.dart';
import 'package:video_player/video_player.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userName = ''.obs; // Add this at the top
  final userRole = ''.obs; // Optional: if you want to track user role
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  late VideoPlayerController videoController;
  var isInitialized = false.obs;

  @override
  void onInit() {
    ///assets\muet_video.mp4
    // videoController = VideoPlayerController.asset("assets/dept_video.mp4")
    videoController = VideoPlayerController.network("assets/muet_video.mp4")
      ..initialize().then((_) {
        videoController.setLooping(true);
        videoController.setVolume(0.0); // mute for autoplay
        videoController.play();
        isInitialized.value = true;
      });
    emailController.clear();
    passwordController.clear();
    isLoading.value = false;
    //  Load name from GetStorage
    userName.value = box.read('name') ?? '';
    userRole.value = box.read('role') ?? '';
    super.onInit();
  }

  final box = GetStorage();

  // Optional: For reactive validation
  var isLoading = false.obs;

  var isLoginSelected = true.obs;

  void selectLogin() {
    isLoginSelected.value = true;
  }

  void selectRegister() {
    isLoginSelected.value = false;
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Get.snackbar("Error", "Email and password required");
      // FkAlertMessage.flushBarErrorMessage('Email and password required', context);
      FkHelperFunctions.errorSnackBar(title: 'Error!', message: 'Email and password both required');

      return;
    }

    isLoading.value = true;

    try {
      final authService = AuthService();
      final result = await authService.login(email, password);

      isLoading.value = false;

      if (result['success']) {
        String role = result['role'];
        String token = result['token'];

        //  Save token & role
        box.write('token', token);
        box.write('role', role);
        box.write('email', email);
        String? name = result['name'];
        if (name != null) {
          box.write('name', name);
          userName.value = name;
        }

        emailController.clear();
        passwordController.clear();

        if (role == 'student') {
          Get.offAllNamed(Routes.studentDashboard);
        } else if (role == 'clerk') {
          Get.offAllNamed(Routes.clerkDashboard);
        }
      } else {
        Get.snackbar("Login Failed", result['message']);
      }
    } catch (e, stacktrace) {
      isLoading.value = false;
      print('Login Error: $e');
      print('StackTrace: $stacktrace');
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  void logout() {
    emailController.clear();
    passwordController.clear();
    isLoading.value = false;
    userName.value = '';
    userRole.value = '';

    box.erase(); // Clear stored token & role

    Get.offAllNamed(Routes.loginScreen);

    Future.delayed(const Duration(milliseconds: 100), () {
      Get.put(AuthController());
    });
  }

  ///
  // @override
  // void onClose() {
  //   videoController.dispose();
  //   super.onClose();
  // }
}
