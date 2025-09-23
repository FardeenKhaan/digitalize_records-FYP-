import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_dashboard/widgets/glass_card.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_dashboard/widgets/profile_section.dart';
import 'package:sweng_records/utils/constants/image_strings.dart';
import 'package:sweng_records/utils/constants/sizes.dart';
import 'package:sweng_records/widgets/clerk_dashboard_intro.dart';
import 'package:sweng_records/widgets/drawer.dart';

class ClerkHomescreen extends StatelessWidget {
  const ClerkHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Iconsax.logout, color: Colors.white),
              onPressed: () => authController.logout(),
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
                  child: GlassCard(child: const ClerkDashboardIntro()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
