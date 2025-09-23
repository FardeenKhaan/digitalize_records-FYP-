import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClerkDashboardIntro extends StatelessWidget {
  const ClerkDashboardIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        double fontSize =
            maxWidth > 900
                ? 18
                : maxWidth > 600
                ? 16
                : 14;

        double headingSize =
            maxWidth > 900
                ? 24
                : maxWidth > 600
                ? 20
                : 18;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 3, color: Colors.black),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Clerk Dashboard",
                  style: GoogleFonts.lato(
                    fontSize: headingSize,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black87,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Welcome to the Clerk Dashboard of our Software Department Records system. This powerful platform is designed to streamline administrative tasks and enhance the efficiency of our department's operations.",
                  style: GoogleFonts.lato(
                    fontSize: fontSize,
                    // color: Colors.black87,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "As a clerk, you play a crucial role in maintaining the smooth functioning of our academic processes, and this dashboard is your central hub for managing various aspects of student records and departmental communications.",
                  style: GoogleFonts.lato(
                    fontSize: fontSize,
                    // color: Colors.black87,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Key Features Available:",
                  style: GoogleFonts.lato(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,

                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _buildBulletPoint(
                  "Challan Management",
                  "Efficiently process and manage student fee challans.",
                  fontSize,
                ),
                _buildBulletPoint(
                  "Marksheet Handling",
                  "Upload and manage student marksheets.",
                  fontSize,
                ),
                _buildBulletPoint(
                  "Roll Number Assignment",
                  "Easily assign and manage roll numbers for students.",
                  fontSize,
                ),
                _buildBulletPoint(
                  "Announcement Creation",
                  "Craft and publish important announcements for students.",
                  fontSize,
                ),
                const SizedBox(height: 20),
                Text(
                  "Your role as a clerk is vital to the functioning of our software department. By providing you with this advanced dashboard, we aim to empower you to perform your duties more effectively.",
                  style: GoogleFonts.lato(
                    fontSize: fontSize,
                    // color: Colors.black87,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBulletPoint(String title, String description, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize + 2,
              height: 1.5,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$title: ",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  // color: Colors.black87,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: description,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: fontSize,
                      // color: Colors.black87,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
