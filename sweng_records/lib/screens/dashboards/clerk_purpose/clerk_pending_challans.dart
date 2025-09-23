// // screens/clerk_pending_challans.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sweng_records/controllers/challanController.dart';
// import 'package:sweng_records/routes/app_routes.dart';

// class ClerkPendingChallansScreen extends StatelessWidget {
//   final controller = Get.put(ChallanController());
//   // final controller = Get.find<ChallanController>();

//   bool _loaded = false;

//   @override
//   Widget build(BuildContext context) {
//     if (!_loaded) {
//       controller.fetchPendingChallans();
//       _loaded = true;
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text("Pending Challans")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView.builder(
//           itemCount: controller.allChallans.length,
//           // itemCount: controller.filteredChallans.length,
//           itemBuilder: (context, index) {
//             final challan = controller.allChallans[index];
//             // final challan = controller.filteredChallans[index];
//             return Card(
//               margin: EdgeInsets.all(8),
//               child: ListTile(
//                 title: Text('${challan['name']} (${challan['roll_no']})'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Semester: ${challan['semester_year']}'),
//                     Text('Amount: ${challan['fees_amount']}'),
//                     Text('Date: ${challan['submission_date']}'),
//                   ],
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.check, color: Colors.green),
//                       tooltip: 'Verified',
//                       onPressed:
//                           () => _openStatusDialog(challan['id'], 'verified'),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.close, color: Colors.red),
//                       tooltip: 'Rejected',
//                       onPressed:
//                           () => _openStatusDialog(challan['id'], 'rejected'),
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

//   void _openStatusDialog(int id, String status) {
//     final remarksController = TextEditingController();

//     Get.defaultDialog(
//       title: "$status Challan",
//       content: Column(
//         children: [
//           TextField(
//             controller: remarksController,
//             decoration: InputDecoration(labelText: "Remarks"),
//           ),
//         ],
//       ),
//       confirm: ElevatedButton(
//         onPressed: () {
//           controller.updateChallan(id, status, remarksController.text);
//           Get.back();
//         },
//         child: Text("Submit"),
//       ),
//       cancel: TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/controllers/challanController.dart';

class ClerkPendingChallansScreen extends StatefulWidget {
  const ClerkPendingChallansScreen({super.key});

  @override
  State<ClerkPendingChallansScreen> createState() => _ClerkPendingChallansScreenState();
}

class _ClerkPendingChallansScreenState extends State<ClerkPendingChallansScreen> {
  // final ChallanController controller = Get.find<ChallanController>();
  final controller = Get.put(ChallanController());

  @override
  void initState() {
    super.initState();
    controller.fetchPendingChallans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Challans")),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());

        final items = controller.filteredChallans; // filtered view
        if (items.isEmpty) return const Center(child: Text("No pending challans."));

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 6),
          itemBuilder: (context, index) {
            final c = items[index];
            final studentName = c['student_name'] ?? c['name'] ?? 'Unknown';
            // final imageUrl = c['image_full_url'] ?? c['image_url'];
            final imageUrl = c['image_full_url'] ?? c['image_url'];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 1,
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading:
                    imageUrl != null
                        ? InkWell(
                          onTap: () => _showImageDialog(context, imageUrl),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              imageUrl,
                              width: 84,
                              height: 84,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                            ),
                          ),
                        )
                        : const Icon(Icons.receipt_long, size: 40),
                title: Text(
                  '$studentName (${c['roll_no'] ?? '-'})',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text('Semester: ${c['semester_year'] ?? '-'}'),
                    Text('Amount: ${c['fees_amount'] ?? '-'}'),
                    Text('Date: ${c['submission_date'] ?? '-'}'),
                  ],
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () => _openStatusDialog(c['id'], 'verified'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => _openStatusDialog(c['id'], 'rejected'),
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
