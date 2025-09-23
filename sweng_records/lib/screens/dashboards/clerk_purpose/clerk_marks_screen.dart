import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/controllers/marks_controller.dart';
import 'package:sweng_records/routes/app_routes.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_add_edit_marks_screen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_marks_detail_screen.dart';

// class ClerkMarksScreen extends StatelessWidget {
//   final MarksController _controller = Get.put(MarksController());
//   final _searchCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     _controller.loadAllMarks();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Manage Marks"),
//         actions: [IconButton(icon: Icon(Icons.add), onPressed: () => Get.to(() => ClerkAddEditMarksScreen()))],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: TextField(
//               controller: _searchCtrl,
//               decoration: InputDecoration(
//                 hintText: "Search by Roll No",
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () => _controller.searchByRollNo(_searchCtrl.text),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (_controller.isLoading.value) return Center(child: CircularProgressIndicator());
//               if (_controller.marksList.isEmpty) return Center(child: Text("No marks available"));

//               return ListView.builder(
//                 itemCount: _controller.marksList.length,
//                 itemBuilder: (_, i) {
//                   final mark = _controller.marksList[i];
//                   return Card(
//                     child: ListTile(
//                       title: Text("Roll No: ${mark['student_roll_no']} | Sem: ${mark['semester']}"),
//                       subtitle: Text("Chairman: ${mark['chairman_marks']} | Supervisor: ${mark['supervisor_marks']}"),

//                       trailing: PopupMenuButton<String>(
//                         onSelected: (value) {
//                           if (value == 'view') {
//                             Get.toNamed(
//                               Routes.clerk_marks_detail_screen,
//                               arguments: mark, // 👈 pass the full map here
//                             );
//                           } else if (value == 'edit') {
//                             Get.to(() => ClerkAddEditMarksScreen(editMark: mark));
//                           } else if (value == 'delete') {
//                             _controller.deleteMarks(mark['id']);
//                           }
//                         },
//                         itemBuilder:
//                             (context) => [
//                               PopupMenuItem(value: 'view', child: Text("View")),
//                               PopupMenuItem(value: 'edit', child: Text("Edit")),
//                               PopupMenuItem(value: 'delete', child: Text("Delete")),
//                             ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ClerkMarksScreen extends StatelessWidget {
  final MarksController _controller = Get.put(MarksController());
  final AuthController authController = Get.put(AuthController());
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.loadAllMarks();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueGrey.shade700,
        elevation: 0,
        title: Obx(
          () => Row(
            children: [
              const Icon(Iconsax.document_upload, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Manage FYP Evaluation - ${authController.userName.value}',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // 🔍 Search + Add button row
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Search
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
                    ),
                    child: TextField(
                      controller: _searchCtrl,
                      decoration: const InputDecoration(
                        hintText: "Search by Roll No",
                        prefixIcon: Icon(Iconsax.search_favorite, color: Colors.blueGrey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      onSubmitted: (value) => _controller.searchByRollNo(value),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // ➕ Add button
                ElevatedButton.icon(
                  onPressed: () => Get.to(() => ClerkAddEditMarksScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 22),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add Student Marks", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // 📋 Marks List
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_controller.marksList.isEmpty) {
                return const Center(child: Text("No marks available"));
              }

              return ListView.builder(
                itemCount: _controller.marksList.length,
                itemBuilder: (_, i) {
                  final mark = _controller.marksList[i];

                  // calculate total
                  final total =
                      (mark['chairman_marks'] ?? 0) +
                      (mark['supervisor_marks'] ?? 0) +
                      (mark['external_marks'] ?? 0) +
                      (mark['internal_marks'] ?? 0);

                  final status = total >= 50 ? "Pass" : "Fail"; // example condition

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Roll No + Semester
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Roll No: ${mark['student_roll_no']}",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Sem ${mark['semester']}",
                                  style: TextStyle(color: Colors.blueGrey.shade700),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Marks (chips style)
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              _buildMarksChip("Chairman", mark['chairman_marks'], Colors.teal),
                              _buildMarksChip("Supervisor", mark['supervisor_marks'], Colors.indigo),
                              _buildMarksChip("External", mark['external_marks'], Colors.deepOrange),
                              _buildMarksChip("Internal", mark['internal_marks'], Colors.purple),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Total + Status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total: $total", style: const TextStyle(fontWeight: FontWeight.bold)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: status == "Pass" ? Colors.green.shade100 : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: status == "Pass" ? Colors.green.shade800 : Colors.red.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Actions (edit/delete)
                          Align(
                            alignment: Alignment.centerRight,
                            child: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  Get.to(() => ClerkAddEditMarksScreen(editMark: mark));
                                } else if (value == 'delete') {
                                  _controller.deleteMarks(mark['id']);
                                }
                              },
                              itemBuilder:
                                  (context) => [
                                    const PopupMenuItem(value: 'edit', child: Text("Edit")),
                                    const PopupMenuItem(value: 'delete', child: Text("Delete")),
                                  ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // 🔹 Marks chip widget
  Widget _buildMarksChip(String label, dynamic value, Color color) {
    return Chip(
      label: Text("$label: $value"),
      backgroundColor: color.withValues(alpha: 0.1),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}
