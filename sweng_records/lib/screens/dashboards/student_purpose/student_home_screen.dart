import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_dashboard/widgets/glass_card.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_dashboard/widgets/profile_section.dart';
import 'package:sweng_records/utils/constants/image_strings.dart';
import 'package:sweng_records/utils/constants/sizes.dart';
import 'package:sweng_records/widgets/clerk_dashboard_intro.dart';
import 'package:sweng_records/widgets/drawer.dart';
import 'package:sweng_records/widgets/student_dashboard_into.dart';

class StudentHomescreen extends StatelessWidget {
  const StudentHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        // title: Text(
        //   "Student Dashboard",
        //   // style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black54),
        //   style: TextTheme.of(context).headlineMedium!.copyWith(color: FkColors.white),
        // ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Iconsax.logout, color: Colors.white),
              onPressed: () {
                authController.logout();
              },
            ),
          ),
        ],
      ),
      drawer: DrawerforWebApp(),
      body: Stack(
        children: [
          /// Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(FkImages.muetImage), fit: BoxFit.cover),
            ),
          ),

          /// Dark overlay for readability
          Container(color: Colors.black.withValues(alpha: 0.4)),

          /// Content
          SingleChildScrollView(
            padding: EdgeInsets.only(top: kToolbarHeight + 40, bottom: 40),
            child: Column(
              children: [
                /// Reusable Profile Section
                ProfileSection(authController: authController, size: size),
                const SizedBox(height: FkSizes.spaceBtwSections),

                /// Reusable Glass Card
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: GlassCard(child: const StudentDashboardIntro()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Welcome + Profile
  Widget _buildProfileSection(AuthController authController, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _glassDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome 👋",
                    style: GoogleFonts.poppins(
                      fontSize: size.width < 600 ? 18 : 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    authController.userName.value,
                    style: GoogleFonts.poppins(
                      fontSize: size.width < 600 ? 26 : 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(authController.userRole.value, style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            CircleAvatar(
              radius: size.width < 600 ? 40 : 50,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: size.width < 600 ? 38 : 48,
                backgroundImage: const AssetImage(FkImages.userProfile),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Student Dashboard Intro inside Glass Card
  Widget _buildGlassDashboard(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      child: Container(
        decoration: _glassDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(padding: const EdgeInsets.all(20), child: const StudentDashboardIntro()),
          ),
        ),
      ),
    );
  }

  /// Glass Effect BoxDecoration
  BoxDecoration _glassDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: .15), Colors.white.withValues(alpha: 0.05)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 10, offset: const Offset(0, 4))],
    );
  }
}
