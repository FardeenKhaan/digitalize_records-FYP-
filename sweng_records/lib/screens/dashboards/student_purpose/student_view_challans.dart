// // screens/student_view_challans.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sweng_records/controllers/challanController.dart';

// class StudentViewChallansScreen extends StatelessWidget {
//   final controller = Get.put(ChallanController());

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchStudentChallans();

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("My Challans"),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (controller.studentChallans.isEmpty) {
//           return Center(child: Text("No challans found."));
//         }

//         return ListView.builder(
//           itemCount: controller.studentChallans.length,
//           itemBuilder: (context, index) {
//             final challan = controller.studentChallans[index];
//             return ListTile(
//               title: Text("Challan #: ${challan['challan_no']}"),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Date: ${challan['submission_date']}"),
//                   Text("Amount: ${challan['fees_amount']}"),
//                   Text("Status: ${challan['status']}"),
//                   if (challan['remarks'] != null &&
//                       challan['remarks'].isNotEmpty)
//                     Text("Remarks: ${challan['remarks']}"),
//                 ],
//               ),
//               isThreeLine: true,
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// screens/student_view_challans.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sweng_records/controllers/challanController.dart';

// class StudentViewChallansScreen extends StatelessWidget {
//   StudentViewChallansScreen({super.key});
//   final controller = Get.put(ChallanController());
//   // final ChallanController controller = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     controller.fetchStudentChallans();

//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false, title: const Text("My Challans")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (controller.studentChallans.isEmpty) {
//           return const Center(child: Text("No challans found."));
//         }

//         return ListView.separated(
//           itemCount: controller.studentChallans.length,
//           separatorBuilder: (_, __) => const Divider(height: 0),
//           itemBuilder: (context, index) {
//             final c = controller.studentChallans[index];
//             final imageUrl = c['image_full_url'] ?? c['image_url'];

//             return ListTile(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               leading:
//                   (imageUrl != null)
//                       ? ClipRRect(
//                         borderRadius: BorderRadius.circular(6),
//                         child: Image.network(
//                           imageUrl,
//                           width: 64,
//                           height: 64,
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
//                         ),
//                       )
//                       : const Icon(Icons.receipt_long),
//               title: Text("Challan #: ${c['challan_no']}"),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Date: ${c['submission_date']}"),
//                   Text("Amount: ${c['fees_amount']}"),
//                   Text("Status: ${c['status']}"),
//                   if (c['remarks'] != null && (c['remarks'] as String).isNotEmpty) Text("Remarks: ${c['remarks']}"),
//                 ],
//               ),
//               onTap: () {
//                 if (imageUrl == null) return;
//                 Get.dialog(
//                   Dialog(
//                     child: InteractiveViewer(
//                       minScale: 0.5,
//                       maxScale: 5,
//                       child: Image.network(imageUrl, fit: BoxFit.contain),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/controllers/challanController.dart';

// class StudentViewChallansScreen extends StatelessWidget {
//   StudentViewChallansScreen({super.key});
//   final controller = Get.put(ChallanController());

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'approved':
//         return Colors.green;
//       case 'rejected':
//         return Colors.red;
//       case 'pending':
//       default:
//         return Colors.orange;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchStudentChallans();

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(title: const Text("My Challans"), centerTitle: true, elevation: 1),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (controller.studentChallans.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Iconsax.document, size: 80, color: Colors.grey),
//                 const SizedBox(height: 12),
//                 Text("No challans found", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.studentChallans.length,
//           itemBuilder: (context, index) {
//             final c = controller.studentChallans[index];
//             final imageUrl = c['image_full_url'] ?? c['image_url'];
//             final status = (c['status'] ?? "Pending").toString();

//             return Card(
//               margin: const EdgeInsets.only(bottom: 16),
//               elevation: 2,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(12),
//                 onTap: () {
//                   if (imageUrl == null) return;
//                   Get.dialog(
//                     Dialog(
//                       child: InteractiveViewer(
//                         minScale: 0.5,
//                         maxScale: 5,
//                         child: Image.network(imageUrl, fit: BoxFit.contain),
//                       ),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // ---- Image Preview ----
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child:
//                             imageUrl != null
//                                 ? Image.network(
//                                   imageUrl,
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 40),
//                                 )
//                                 : Container(
//                                   width: 80,
//                                   height: 80,
//                                   color: Colors.grey[200],
//                                   child: const Icon(Iconsax.receipt, size: 36, color: Colors.grey),
//                                 ),
//                       ),
//                       const SizedBox(width: 16),

//                       // ---- Details ----
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Header Row
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Challan #${c['challan_no']}",
//                                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: _getStatusColor(status).withOpacity(0.15),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Text(
//                                     status,
//                                     style: TextStyle(
//                                       color: _getStatusColor(status),
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),

//                             // Info Rows
//                             Row(
//                               children: [
//                                 const Icon(Iconsax.calendar_1, size: 16, color: Colors.grey),
//                                 const SizedBox(width: 6),
//                                 Text("Date: ${c['submission_date']}"),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 const Icon(Iconsax.money, size: 16, color: Colors.grey),
//                                 const SizedBox(width: 6),
//                                 Text("Amount: ${c['fees_amount']}"),
//                               ],
//                             ),
//                             if (c['remarks'] != null && (c['remarks'] as String).isNotEmpty) ...[
//                               const SizedBox(height: 4),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Icon(Iconsax.message, size: 16, color: Colors.grey),
//                                   const SizedBox(width: 6),
//                                   Expanded(child: Text("Remarks: ${c['remarks']}")),
//                                 ],
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

class StudentViewChallansScreen extends StatelessWidget {
  StudentViewChallansScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final controller = Get.put(ChallanController());

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  String _formatDate(String dateStr) {
    try {
      final parsed = DateTime.parse(dateStr);
      return DateFormat("dd MMM yyyy").format(parsed); // e.g., 14 Sep 2025
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchStudentChallans();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        elevation: 0,
        title: Obx(
          () => Row(
            children: [
              const Icon(Iconsax.eye, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'View Challan Records - ${authController.userName.value}',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.studentChallans.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.document, size: 80, color: Colors.grey),
                const SizedBox(height: 12),
                Text("No challans found", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.studentChallans.length,
          itemBuilder: (context, index) {
            final c = controller.studentChallans[index];
            final imageUrl = c['image_full_url'] ?? c['image_url'];
            final status = (c['status'] ?? "Pending").toString();

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---- Image Preview with Hover Overlay ----
                    if (imageUrl != null)
                      _ImageWithHover(
                        imageUrl: imageUrl,
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              child: InteractiveViewer(
                                minScale: 0.5,
                                maxScale: 5,
                                child: Image.network(imageUrl, fit: BoxFit.contain),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
                        child: const Icon(Iconsax.receipt, size: 36, color: Colors.grey),
                      ),

                    const SizedBox(width: 16),

                    // ---- Details ----
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Challan #${c['challan_no']}",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Info Rows
                          Row(
                            children: [
                              const Icon(Iconsax.calendar_1, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text("Date: ${_formatDate(c['submission_date'])}"),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Iconsax.money, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text("Amount: ${c['fees_amount']}"),
                            ],
                          ),
                          if (c['remarks'] != null && (c['remarks'] as String).isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Iconsax.message, size: 16, color: Colors.grey),
                                const SizedBox(width: 6),
                                Expanded(child: Text("Remarks: ${c['remarks']}")),
                              ],
                            ),
                          ],
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
    );
  }
}

/// Custom widget for image preview with hover effect
class _ImageWithHover extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const _ImageWithHover({required this.imageUrl, required this.onTap});

  @override
  State<_ImageWithHover> createState() => _ImageWithHoverState();
}

class _ImageWithHoverState extends State<_ImageWithHover> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 40),
              ),
            ),
            if (_hovering)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Iconsax.eye, color: Colors.white, size: 28),
              ),
          ],
        ),
      ),
    );
  }
}
