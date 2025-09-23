import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_dashboard/widgets/style/decoration.dart';
import 'package:sweng_records/utils/constants/image_strings.dart';
import 'package:sweng_records/utils/constants/text_strings.dart';

class ProfileSection extends StatelessWidget {
  final AuthController authController;
  final Size size;

  const ProfileSection({super.key, required this.authController, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: FkDecorations.glass(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FkTexts.welcome,
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
}
