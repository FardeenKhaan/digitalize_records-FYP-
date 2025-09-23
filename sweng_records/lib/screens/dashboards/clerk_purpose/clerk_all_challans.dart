// screens/clerk_all_challans.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/controllers/challanController.dart';

// class ClerkAllChallansScreen extends StatelessWidget {
//   final controller = Get.put(ChallanController());

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchAllChallans();

//     return Scaffold(
//       appBar: AppBar(title: Text("All Challans")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (controller.allChallans.isEmpty) {
//           return Center(child: Text("No challans in system."));
//         }

//         return ListView.builder(
//           itemCount: controller.allChallans.length,
//           itemBuilder: (context, index) {
//             final challan = controller.allChallans[index];
//             return Card(
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               child: ListTile(
//                 title: Text("${challan['name']} (${challan['roll_no']})"),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Challan #: ${challan['challan_no']}"),
//                     Text("Status: ${challan['status']}"),
//                     Text("Amount: ${challan['fees_amount']}"),
//                     Text("Date: ${challan['submission_date']}"),
//                     if (challan['remarks'] != null &&
//                         challan['remarks'].isNotEmpty)
//                       Text("Remarks: ${challan['remarks']}"),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// class ClerkAllChallansScreen extends StatelessWidget {
//   final controller = Get.put(ChallanController());

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchAllChallans();

//     return Scaffold(
//       appBar: AppBar(title: Text("All Challans")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (controller.allChallans.isEmpty) {
//           return Center(child: Text("No challans in system."));
//         }

//         return ListView.builder(
//           itemCount: controller.allChallans.length,
//           itemBuilder: (context, index) {
//             final challan = controller.allChallans[index];
//             return Card(
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               child: Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Text(
//                         "MEHRAN UNIVERSITY OF ENGINEERING & TECHNOLOGY, JAMSHORO",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Divider(),

//                     _buildRow("Challan #", challan['challan_no']),
//                     _buildRow("Student Name", challan['name']),
//                     _buildRow("Roll No", challan['roll_no']),
//                     _buildRow("Father Name", challan['father_name'] ?? "-"),
//                     _buildRow("Program", challan['program'] ?? "BE Program"),
//                     _buildRow(
//                       "Fee Description",
//                       challan['fee_description'] ?? "-",
//                     ),
//                     _buildRow("Date", challan['submission_date']),
//                     _buildRow("Amount (Rs)", challan['fees_amount']),
//                     _buildRow("Status", challan['status']),
//                     if (challan['remarks'] != null &&
//                         challan['remarks'].isNotEmpty)
//                       _buildRow("Remarks", challan['remarks']),

//                     Divider(),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Text("Signature: _______________"),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }

//   /// Helper widget to generate key-value style rows
//   Widget _buildRow(String title, dynamic value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4,
//             child: Text(
//               "$title:",
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//           Expanded(flex: 6, child: Text(value.toString())),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ClerkAllChallansScreen extends StatelessWidget {
//   final controller = Get.put(ChallanController());

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchAllChallans();

//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false, title: Text("All Challans Records")),

//       // floatingActionButton: Obx(() {
//       //   return controller.isExporting.value
//       //       ? FloatingActionButton(
//       //         onPressed: null,
//       //         // backgroundColor: Colors.grey[400],
//       //         child: CircularProgressIndicator(color: Colors.white),
//       //       )
//       //       : FloatingActionButton.extended(
//       //         onPressed: () => controller.exportToPDF(),
//       //         icon: Icon(Icons.picture_as_pdf),
//       //         label: Text("Export PDF"),
//       //       );
//       // }),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: TextField(
//                       onChanged: (val) => controller.searchRollNo.value = val,
//                       decoration: InputDecoration(
//                         labelText: "Search by Roll No",
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     flex: 1,
//                     child: Obx(
//                       () => DropdownButtonFormField<String>(
//                         value: controller.statusFilter.value.isEmpty ? null : controller.statusFilter.value,
//                         onChanged: (val) => controller.statusFilter.value = val ?? '',
//                         decoration: InputDecoration(labelText: "Filter by Status", border: OutlineInputBorder()),
//                         items: [
//                           DropdownMenuItem(child: Text("All"), value: ''),
//                           DropdownMenuItem(child: Text("Pending"), value: 'pending'),
//                           DropdownMenuItem(child: Text("Verified"), value: 'verified'),
//                           DropdownMenuItem(child: Text("Rejected"), value: 'rejected'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Obx(() {
//                 if (controller.filteredChallans.isEmpty) {
//                   return Center(child: Text("No challans found."));
//                 }

//                 return ListView.builder(
//                   itemCount: controller.filteredChallans.length,
//                   itemBuilder: (context, index) {
//                     final challan = controller.filteredChallans[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Text(
//                                 "MEHRAN UNIVERSITY OF ENGINEERING & TECHNOLOGY, JAMSHORO",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Divider(),
//                             _buildRow("Challan #", challan['challan_no']),
//                             _buildRow("Student Name", challan['challan_name']),
//                             _buildRow("Roll No", challan['roll_no']),
//                             _buildRow("Father Name", challan['father_name'] ?? "-"),
//                             _buildRow("Program", challan['program'] ?? "BE Program"),
//                             _buildRow("Fee Description", challan['fee_description'] ?? "Admission"),
//                             _buildRow("Date", challan['submission_date']),
//                             _buildRow("Amount (Rs)", challan['fees_amount']),
//                             _buildRow("Status", challan['status']),
//                             if (challan['remarks'] != null && challan['remarks'].isNotEmpty)
//                               _buildRow("Remarks", challan['remarks']),
//                             Divider(),
//                             Align(alignment: Alignment.centerRight, child: Text("Signature: _______________")),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   /// Helper widget to generate key-value style rows
//   Widget _buildRow(String title, dynamic value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(flex: 4, child: Text("$title:", style: TextStyle(fontWeight: FontWeight.w600))),
//           Expanded(flex: 6, child: Text(value.toString())),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/controllers/challanController.dart';

class ClerkAllChallansScreen extends StatefulWidget {
  const ClerkAllChallansScreen({super.key});

  @override
  State<ClerkAllChallansScreen> createState() => _ClerkAllChallansScreenState();
}

class _ClerkAllChallansScreenState extends State<ClerkAllChallansScreen> {
  // final ChallanController controller = Get.find<ChallanController>();
  final controller = Get.put(ChallanController());
  @override
  void initState() {
    super.initState();
    controller.fetchAllChallans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("All Challans Records"),
        actions: [
          Obx(() {
            return controller.isExporting.value
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    ),
                  ),
                )
                : IconButton(
                  icon: const Icon(Icons.picture_as_pdf),
                  tooltip: 'Export PDF',
                  onPressed: () => controller.exportToPDF(),
                );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Search & Filter row
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      onChanged: (val) => controller.searchRollNo.value = val,
                      decoration: const InputDecoration(
                        labelText: "Search by Roll No",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.statusFilter.value.isEmpty ? null : controller.statusFilter.value,
                        onChanged: (val) => controller.statusFilter.value = val ?? '',
                        decoration: const InputDecoration(labelText: "Filter by Status", border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(child: Text("All"), value: ''),
                          DropdownMenuItem(child: Text("Pending"), value: 'pending'),
                          DropdownMenuItem(child: Text("Verified"), value: 'verified'),
                          DropdownMenuItem(child: Text("Rejected"), value: 'rejected'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: Obx(() {
                final items = controller.filteredChallans;
                if (items.isEmpty) return const Center(child: Text("No challans found."));

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final c = items[index];

                    // pick names safely (backend uses student_name / challan_name / image_full_url)
                    final studentName = c['student_name'] ?? c['name'] ?? 'Unknown';
                    final challanTitle = c['challan_name'] ?? '';
                    final imageUrl = c['image_full_url'] ?? c['image_url'];
                    final status = c['status'] ?? '';
                    final rollNo = c['roll_no'] ?? '-';

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Thumbnail
                            if (imageUrl != null)
                              InkWell(
                                onTap: () => _showImageDialog(context, imageUrl),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    imageUrl,
                                    width: 120,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, __, ___) => Container(
                                          width: 120,
                                          height: 90,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.broken_image),
                                        ),
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: 120,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.receipt_long),
                              ),

                            const SizedBox(width: 12),

                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    challanTitle.isNotEmpty ? challanTitle : 'Challan',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Text('$studentName ($rollNo)', style: const TextStyle(fontSize: 13)),
                                  const SizedBox(height: 6),
                                  Text('Semester: ${c['semester_year'] ?? '-'}'),
                                  Text('Amount: ${c['fees_amount'] ?? '-'}'),
                                  Text('Date: ${c['submission_date'] ?? '-'}'),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Status: ${status.toString().toUpperCase()}',
                                    style: TextStyle(color: _statusColor(status), fontWeight: FontWeight.w600),
                                  ),
                                  if (c['remarks'] != null && (c['remarks'] as String).isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text('Remarks: ${c['remarks']}'),
                                    ),
                                ],
                              ),
                            ),

                            // Actions (only allow approve/reject for pending)
                            Column(
                              children: [
                                if (status == 'pending') ...[
                                  IconButton(
                                    icon: const Icon(Icons.check_circle, color: Colors.green),
                                    tooltip: 'Verify',
                                    onPressed: () => _openStatusDialog(c['id'], 'verified'),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.cancel, color: Colors.red),
                                    tooltip: 'Reject',
                                    onPressed: () => _openStatusDialog(c['id'], 'rejected'),
                                  ),
                                ] else
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(status.toString().toUpperCase(), style: const TextStyle(fontSize: 12)),
                                  ),
                              ],
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
        );
      }),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'verified':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    Get.dialog(
      Dialog(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 5.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
            ),
          ),
        ),
      ),
    );
  }

  void _openStatusDialog(int id, String status) {
    final remarksController = TextEditingController();
    Get.defaultDialog(
      title: "${status[0].toUpperCase()}${status.substring(1)} Challan",
      content: Column(
        children: [
          TextField(controller: remarksController, decoration: const InputDecoration(labelText: "Remarks (optional)")),
        ],
      ),
      textConfirm: "Submit",
      textCancel: "Cancel",
      onConfirm: () {
        controller.updateChallan(id, status, remarksController.text);
        Get.back();
      },
    );
  }
}
