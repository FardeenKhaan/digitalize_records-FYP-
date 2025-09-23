import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sweng_records/controllers/student_list_controller.dart';
import 'package:sweng_records/utils/rollno_pdf.dart';

class ManageStudentsScreen extends StatelessWidget {
  final controller = Get.put(StudentListController());

  @override
  Widget build(BuildContext context) {
    controller.loadStudents();

    return Scaffold(
      // Inside AppBar
      appBar: AppBar(
        title: Center(child: Text("Manage list of Student of New Batch")),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            tooltip: 'Export PDF',
            onPressed: () {
              RollNumberPdfGenerator.generate(controller.students);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add student',
        onPressed: () => _showFormDialog(context),
        child: Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoading.value)
          return Center(child: CircularProgressIndicator());

        if (controller.students.isEmpty)
          return Center(child: Text("No students found."));

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return Card(
              child: ListTile(
                title: Text(student.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Father: ${student.fatherName}"),
                    Text("Roll #: ${student.rollNumber}"),
                    Text("Section: ${student.section}"),
                    Text("Added: ${student.createdAt}"),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      controller.fillForm(student);
                      _showFormDialog(context, isEdit: true, id: student.id);
                    }
                    if (value == 'delete') {
                      controller.deleteStudent(student.id);
                    }
                  },
                  itemBuilder:
                      (_) => [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showFormDialog(BuildContext context, {bool isEdit = false, int? id}) {
    final title = isEdit ? "Edit Student" : "Add Student";
    final confirmText = isEdit ? "Update" : "Create";

    Get.defaultDialog(
      title: title,
      content: Column(
        children: [
          TextField(
            controller: controller.nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: controller.fatherNameController,
            decoration: InputDecoration(labelText: "Father Name"),
          ),
          TextField(
            controller: controller.rollNumberController,
            decoration: InputDecoration(labelText: "Roll Number"),
          ),
          TextField(
            controller: controller.sectionController,
            decoration: InputDecoration(labelText: "Section"),
          ),
        ],
      ),
      textConfirm: confirmText,
      textCancel: "Cancel",
      onConfirm: () {
        isEdit ? controller.updateStudent(id!) : controller.createStudent();
        Get.back();
      },
    );
  }
}
