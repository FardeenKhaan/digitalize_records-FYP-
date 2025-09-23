import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class StudentDashboardIntro extends StatelessWidget {
//   const StudentDashboardIntro({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double maxWidth = constraints.maxWidth;

//         double fontSize =
//             maxWidth > 900
//                 ? 18
//                 : maxWidth > 600
//                 ? 16
//                 : 14;

//         double headingSize =
//             maxWidth > 900
//                 ? 24
//                 : maxWidth > 600
//                 ? 20
//                 : 18;

//         return Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Container(
//             constraints: BoxConstraints(maxWidth: 1000),
//             padding: const EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(12),

//               border: Border.all(width: 3, color: Colors.black),

//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.8),
//                   spreadRadius: 2,
//                   blurRadius: 8,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Welcome to the Student Dashboard of our Software Department Records system.",
//                   style: GoogleFonts.lato(
//                     fontSize: headingSize,
//                     fontWeight: FontWeight.bold,
//                     // color: Colors.black87,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "This platform is designed to streamline your academic journey and provide you with easy access to essential information and services. As a student in our esteemed software department, you have access to a range of features that will enhance your educational experience and keep you informed about your academic progress.",
//                   style: GoogleFonts.lato(
//                     fontSize: fontSize,
//                     // color: Colors.black87,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Our dashboard is your central hub for managing various aspects of your academic life. Here's an overview of what you can do:",
//                   style: GoogleFonts.lato(
//                     fontSize: fontSize,
//                     fontWeight: FontWeight.w600,
//                     // color: Colors.black,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 _buildBulletPoint(
//                   "Profile Management",
//                   "Keep your personal information up-to-date, including contact details and emergency information.",
//                   fontSize,
//                 ),
//                 _buildBulletPoint(
//                   "Challan Upload",
//                   "Easily upload your fee challans directly through the dashboard.",
//                   fontSize,
//                 ),
//                 _buildBulletPoint(
//                   "Marksheet Access",
//                   "View and download your academic marksheets.",
//                   fontSize,
//                 ),
//                 _buildBulletPoint(
//                   "Announcements",
//                   "Stay informed about important department news, events, and deadlines.",
//                   fontSize,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "As you navigate through your academic career, this dashboard will be an invaluable tool. It's designed to be intuitive and user-friendly, ensuring that you can easily find the information you need when you need it.",
//                   style: GoogleFonts.lato(
//                     fontSize: fontSize,
//                     // color: Colors.black87,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBulletPoint(String title, String description, double fontSize) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 12.0, bottom: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "• ",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: fontSize + 2,
//               height: 1.5,
//             ),
//           ),
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 text: "$title: ",
//                 style: GoogleFonts.lato(
//                   fontWeight: FontWeight.bold,
//                   fontSize: fontSize,
//                   // color: Colors.black87,
//                   color: Colors.white,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: description,
//                     style: GoogleFonts.lato(
//                       fontWeight: FontWeight.normal,
//                       fontSize: fontSize,
//                       // color: Colors.black87,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class StudentDashboardIntro extends StatelessWidget {
  const StudentDashboardIntro({Key? key}) : super(key: key);

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
            constraints: const BoxConstraints(maxWidth: 1000),
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
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to your Student Dashboard!",
                  style: GoogleFonts.lato(fontSize: headingSize, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  "This portal is built to manage all your academic records in one place. "
                  "Here you can submit forms, upload challans, and view announcements and much more with ease.",
                  style: GoogleFonts.lato(fontSize: fontSize, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  "What you can do here:",
                  style: GoogleFonts.lato(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                const SizedBox(height: 10),
                _buildBulletPoint(
                  "Admission Form",
                  "Submit your admission form once. After submission, you can only view your form (no edits allowed).",
                  fontSize,
                ),
                _buildBulletPoint(
                  "Challan Upload",
                  "Upload your semester fee challans with an image. You can also track the verification status (pending, verified, or rejected).",
                  fontSize,
                ),
                _buildBulletPoint(
                  "FYP Marks",
                  "View your Final Year Project marks semester-wise. Only you can see your marks, while clerks manage them.",
                  fontSize,
                ),
                _buildBulletPoint(
                  "Profile & Announcements",
                  "Keep your profile updated and stay informed with the latest departmental notices.",
                  fontSize,
                ),
                const SizedBox(height: 20),
                Text(
                  "Tip: Always check portal regularly to avoid missing deadlines for forms or fee submissions.",
                  style: GoogleFonts.lato(fontSize: fontSize, fontStyle: FontStyle.italic, color: Colors.white),
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
          Text("• ", style: TextStyle(color: Colors.white, fontSize: fontSize + 2, height: 1.5)),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$title: ",
                style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.white),
                children: [
                  TextSpan(
                    text: description,
                    style: GoogleFonts.lato(fontWeight: FontWeight.normal, fontSize: fontSize, color: Colors.white),
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
