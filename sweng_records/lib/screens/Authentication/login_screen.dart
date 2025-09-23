import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/screens/Authentication/widgets/login_button.dart';
import 'package:sweng_records/screens/Authentication/widgets/reuse_textfields.dart';
import 'package:sweng_records/utils/constants/colors.dart';
import 'package:sweng_records/utils/constants/image_strings.dart';
import 'package:sweng_records/utils/constants/sizes.dart';
import 'package:sweng_records/utils/constants/text_strings.dart';
import 'package:sweng_records/utils/message_showing.dart';
import 'package:video_player/video_player.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            /// --- Background video
            if (authController.isInitialized.value)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: authController.videoController.value.size.width,
                  height: authController.videoController.value.size.height,
                  child: VideoPlayer(authController.videoController),
                ),
              )
            else
              Container(color: Colors.white),

            // Dark overlay
            Container(color: Colors.black.withValues(alpha: 0.5)),

            // Foreground content
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(FkSizes.borderRadiusLg * 2),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: size.width * .400,
                    padding: const EdgeInsets.all(60),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(FkSizes.borderRadiusLg * 2),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo + Title
                        Column(
                          children: [
                            Image.asset(
                              FkImages.muetLogo,
                              height: FkSizes.imageThumbSize * 2,
                              width: FkSizes.imageThumbSize * 3,
                              filterQuality: FilterQuality.high,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              FkTexts.webAppName,
                              textAlign: TextAlign.center,
                              style: TextTheme.of(
                                context,
                              ).headlineMedium!.copyWith(color: FkColors.white, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: FkSizes.defaultSpace),
                          ],
                        ),

                        // Title
                        Text(
                          FkTexts.welcome,
                          style: TextTheme.of(
                            context,
                          ).headlineSmall!.copyWith(color: FkColors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: FkSizes.defaultSpace),

                        // Email field
                        FkTextField(
                          controller: authController.emailController,
                          label: FkTexts.email,
                          icon: Iconsax.sms,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: FkSizes.spaceBtwItems),
                        Obx(
                          () => FkTextField(
                            controller: authController.passwordController,
                            label: "Password",
                            icon: Icons.lock,
                            obscureText: !authController.isPasswordVisible.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                authController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () => authController.isPasswordVisible.toggle(),
                            ),
                          ),
                        ),
                        const SizedBox(height: FkSizes.spaceBtwItems),

                        /// --- Remember me + Forgot password
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: authController.rememberMe.value,
                                onChanged: (val) => authController.rememberMe.value = val ?? false,
                                checkColor: Colors.black,
                                fillColor: WidgetStateProperty.all(Colors.white),
                              ),
                            ),
                            const Text(FkTexts.rememberMe, style: TextStyle(color: Colors.white)),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                FkFlushbar.info(context, "Feature coming soon!", title: "Forgot Password");
                              },
                              child: const Text("Forgot Password?", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: FkSizes.spaceBtwSections),

                        // Login Button
                        Obx(
                          () =>
                              authController.isLoading.value
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : SizedBox(
                                    width: size.width * 0.15,
                                    child: FkButton(
                                      label: "Login",
                                      onPressed: authController.login,
                                      gradient: const LinearGradient(
                                        colors: [Colors.blueGrey, Color.fromARGB(255, 45, 72, 70)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
