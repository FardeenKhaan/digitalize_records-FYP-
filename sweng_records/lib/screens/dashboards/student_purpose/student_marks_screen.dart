import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/controllers/marks_controller.dart';

// class StudentMarksScreen extends StatelessWidget {
//   final MarksController _controller = Get.put(MarksController());

//   @override
//   Widget build(BuildContext context) {
//     _controller.loadMyMarks();

//     return Scaffold(
//       appBar: AppBar(title: Text("My Marks")),
//       body: Obx(() {
//         if (_controller.isLoading.value) return Center(child: CircularProgressIndicator());
//         if (_controller.marksList.isEmpty) return Center(child: Text("No marks found"));

//         return ListView.builder(
//           itemCount: _controller.marksList.length,
//           itemBuilder: (_, i) {
//             final mark = _controller.marksList[i];
//             return Card(
//               child: ListTile(
//                 title: Text("Semester: ${mark['semester']}"),
//                 subtitle: Text(
//                   "Chairman: ${mark['chairman_marks']} | Supervisor: ${mark['supervisor_marks']} "
//                   "\nExternal: ${mark['external_marks']} | Internal: ${mark['internal_marks']}",
//                 ),
//                 trailing: Text(
//                   "\nTotal: ${(mark['chairman_marks'] ?? 0) + (mark['supervisor_marks'] ?? 0) + (mark['external_marks'] ?? 0) + (mark['internal_marks'] ?? 0)}",
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

class StudentMarksScreen extends StatelessWidget {
  final MarksController _controller = Get.put(MarksController());
  final AuthController authController = Get.put(AuthController());

  StudentMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.loadMyMarks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        elevation: 0,
        title: Obx(
          () => Row(
            children: [
              const Icon(Iconsax.eye, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'See FYP Marks - ${authController.userName.value}',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.marksList.isEmpty) {
          return const Center(child: Text("No marks found", style: TextStyle(fontSize: 16, color: Colors.grey)));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _controller.marksList.length,
          itemBuilder: (_, i) {
            final mark = _controller.marksList[i];
            final chairman = mark['chairman_marks'] ?? 0;
            final supervisor = mark['supervisor_marks'] ?? 0;
            final external = mark['external_marks'] ?? 0;
            final internal = mark['internal_marks'] ?? 0;
            final total = chairman + supervisor + external + internal;

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade500,
                  child: Text(
                    mark['semester'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                title: Text("Semester ${mark['semester']}", style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: LinearProgressIndicator(
                  value: total / 75, // assuming each is out of 100
                  backgroundColor: Colors.grey.shade200,
                  color: total >= 75 ? Colors.green : Colors.orange,
                  minHeight: 6,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$total / 100", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(
                      _getGrade(total),
                      style: TextStyle(color: total >= 75 ? Colors.green : Colors.red, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMarkRow("Chairman", chairman),
                        _buildMarkRow("Supervisor", supervisor),
                        _buildMarkRow("External", external),
                        _buildMarkRow("Internal", internal),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildMarkRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text("$value / 25", style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _getGrade(int total) {
    if (total >= 91) return "A+";
    if (total >= 83) return "A";
    if (total >= 75) return "B+";
    if (total >= 65) return "B";
    if (total >= 60) return "C+";
    if (total >= 50) return "C";
    return "F";
  }
}
