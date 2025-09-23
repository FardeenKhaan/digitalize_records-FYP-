import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/controllers/announcement_controller.dart';

import 'package:sweng_records/models/announcement_model.dart';

class ClerkAnnouncementScreen extends StatelessWidget {
  final controller = Get.put(AnnouncementController());
  final titleController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.loadAnnouncements();

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Announcements"),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: controller.loadAnnouncements)],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _showPostDialog(context), child: Icon(Icons.add)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.announcements.isEmpty) {
          return Center(child: Text("No announcements yet."));
        }

        return
        // ListView.builder(
        //   padding: EdgeInsets.all(12),
        //   itemCount: controller.announcements.length,
        //   itemBuilder: (context, index) {
        //     final a = controller.announcements[index];
        //     return Card(
        //       elevation: 2,
        //       margin: EdgeInsets.symmetric(vertical: 6),
        //       child: ListTile(
        //         title: Text(a.title, style: TextStyle(fontWeight: FontWeight.bold)),
        //         subtitle: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(a.message),
        //             SizedBox(height: 4),
        //             Text("Posted by: ${a.postedBy}", style: TextStyle(fontSize: 12)),
        //             Text("Date: ${a.createdAt}", style: TextStyle(fontSize: 12)),
        //           ],
        //         ),
        //         trailing: PopupMenuButton<String>(
        //           onSelected: (value) {
        //             if (value == 'edit') _showEditDialog(context, a);
        //             if (value == 'delete') controller.deleteAnnouncement(a.id);
        //           },
        //           itemBuilder:
        //               (_) => [
        //                 PopupMenuItem(value: 'edit', child: Text('Edit')),
        //                 PopupMenuItem(value: 'delete', child: Text('Delete')),
        //               ],
        //         ),
        //       ),
        //     );
        //   },
        // );
        ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.announcements.length,
          itemBuilder: (context, index) {
            final a = controller.announcements[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Title Row with PopupMenu
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              a.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade800,
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onSelected: (value) {
                              if (value == 'edit') _showEditDialog(context, a);
                              if (value == 'delete') controller.deleteAnnouncement(a.id);
                            },
                            itemBuilder:
                                (_) => [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 18, color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, size: 18, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // 🔹 Message Body
                      Text(a.message, style: TextStyle(fontSize: 15, color: Colors.grey.shade800)),
                      SizedBox(height: 12),

                      // 🔹 Meta Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "By ${a.postedBy}",
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                          ),
                          Text(a.createdAt, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showPostDialog(BuildContext context) {
    titleController.clear();
    messageController.clear();

    Get.defaultDialog(
      title: "Post New Announcement",
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Announcement', style: TextTheme.of(context).headlineSmall),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                // ),
              ),
            ),
            Text('Announcement Description', style: TextTheme.of(context).headlineSmall),
            TextFormField(
              controller: messageController,
              decoration: InputDecoration(labelText: "Message", focusedBorder: OutlineInputBorder()),
              maxLines: 4,
            ),
          ],
        ),
      ),
      textConfirm: "Post",
      textCancel: "Cancel",
      onConfirm: () {
        controller.postAnnouncement(titleController.text, messageController.text);
        Get.back();
      },
    );
  }

  void _showEditDialog(BuildContext context, Announcement a) {
    titleController.text = a.title;
    messageController.text = a.message;

    Get.defaultDialog(
      title: "Edit Announcement",
      content: Column(
        children: [
          Text("Editing announcement posted by ${a.postedBy} on ${a.createdAt}"),
          TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
          TextField(controller: messageController, decoration: InputDecoration(labelText: "Message"), maxLines: 4),
        ],
      ),
      textConfirm: "Update",
      textCancel: "Cancel",
      onConfirm: () {
        controller.updateAnnouncement(a.id, titleController.text, messageController.text);
        Get.back();
      },
    );
  }
}
