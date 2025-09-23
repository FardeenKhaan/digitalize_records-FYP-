// // import 'package:flutter/material.dart';

// // class ClerkMarksDetailScreen extends StatelessWidget {
// //   final Map<String, dynamic> mark;
// //   ClerkMarksDetailScreen({required this.mark});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Marks Detail - Roll No: ${mark['student_roll_no']}")),
// //       body: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("Semester: ${mark['semester']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //             Divider(),
// //             Text("Chairman Marks: ${mark['chairman_marks']}"),
// //             Text("Supervisor Marks: ${mark['supervisor_marks']}"),
// //             Text("External Marks: ${mark['external_marks']}"),
// //             Text("Internal Marks: ${mark['internal_marks']}"),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ClerkMarksDetailScreen extends StatelessWidget {
//   ClerkMarksDetailScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> mark = Get.arguments;

//     return Scaffold(
//       appBar: AppBar(title: Text("Marks Detail - Roll No: ${mark['student_roll_no']}")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Semester: ${mark['semester']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Divider(),
//             Text("Chairman Marks: ${mark['chairman_marks']}"),
//             Text("Supervisor Marks: ${mark['supervisor_marks']}"),
//             Text("External Marks: ${mark['external_marks']}"),
//             Text("Internal Marks: ${mark['internal_marks']}"),
//           ],
//         ),
//       ),
//     );
//   }
// }
