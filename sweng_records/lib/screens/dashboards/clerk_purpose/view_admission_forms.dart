// screens/clerk/clerk_forms_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/controllers/clerkForm_controller.dart';
import 'package:sweng_records/routes/app_routes.dart';

class ClerkAdmissionFormsScreen extends StatelessWidget {
  final _controller = Get.put(ClerkFormController());

  @override
  Widget build(BuildContext context) {
    _controller.loadAllForms();

    return Scaffold(
      appBar: AppBar(title: Text("All Admission Forms")),
      body: Column(
        children: [
          // 🔎 Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Roll No",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) => _controller.setSearchText(value),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (_controller.filteredForms.isEmpty) {
                return Center(child: Text("No forms found."));
              }

              return ListView.builder(
                itemCount: _controller.filteredForms.length,
                itemBuilder: (context, index) {
                  final form = _controller.filteredForms[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(form['full_name'] ?? 'Unnamed'),
                      subtitle: Text("Roll No: ${form['roll_no']} | Email: ${form['user_email']}"),
                      // trailing: PopupMenuButton<String>(
                      //   onSelected: (value) {
                      //     if (value == 'edit') {
                      //       _showEditDialog(context, form);
                      //     } else if (value == 'delete') {
                      //       _controller.deleteForm(form['id']);
                      //     }
                      //   },
                      //   itemBuilder:
                      //       (context) => [
                      //         PopupMenuItem(value: 'edit', child: Text("Edit")),
                      //         PopupMenuItem(value: 'delete', child: Text("Delete")),
                      //       ],
                      // ),
                      // trailing: PopupMenuButton<String>(
                      //   onSelected: (value) {
                      //     if (value == 'view') {
                      //       Get.to(() => ClerkFormDetailScreen(form: form));
                      //       // Get.toNamed('/clerk-form-detail', arguments: {form});
                      //       // Get.toNamed(Routes.CLERK_FORM_DETAIL, arguments: {'form': form});
                      //     } else if (value == 'edit') {
                      //       _showEditDialog(context, form);
                      //     } else if (value == 'delete') {
                      //       _controller.deleteForm(form['id']);
                      //     }
                      //   },
                      //   itemBuilder:
                      //       (context) => [
                      //         PopupMenuItem(value: 'view', child: Text("View")),
                      //         PopupMenuItem(value: 'edit', child: Text("Edit")),
                      //         PopupMenuItem(value: 'delete', child: Text("Delete")),
                      //       ],
                      // ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'view') {
                            Get.toNamed(Routes.clerkFormDetails, arguments: {'form': form});
                          } else if (value == 'edit') {
                            _showEditDialog(context, form);
                          } else if (value == 'delete') {
                            _controller.deleteForm(form['id']);
                          }
                        },
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(value: 'view', child: Text("View")),
                              PopupMenuItem(value: 'edit', child: Text("Edit")),
                              PopupMenuItem(value: 'delete', child: Text("Delete")),
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

  void _showEditDialog(BuildContext context, Map<String, dynamic> form) {
    final fullNameCtrl = TextEditingController(text: form['full_name']);
    final rollNoCtrl = TextEditingController(text: form['roll_no']);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Edit Form"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: fullNameCtrl, decoration: InputDecoration(labelText: "Full Name")),
                TextField(controller: rollNoCtrl, decoration: InputDecoration(labelText: "Roll No")),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  _controller.updateForm(form['id'], {"full_name": fullNameCtrl.text, "roll_no": rollNoCtrl.text});
                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
            ],
          ),
    );
  }
}
