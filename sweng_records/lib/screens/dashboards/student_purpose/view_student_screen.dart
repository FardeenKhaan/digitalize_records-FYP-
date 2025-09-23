import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/controllers/student_list_controller.dart';

class StudentsViewScreen extends StatelessWidget {
  final controller = Get.put(StudentListController());

  @override
  Widget build(BuildContext context) {
    controller.loadStudents();

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Student Roll no: List of 2025"))),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.students.isEmpty) {
          return Center(child: Text("No data available"));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Horizontal scroll for responsiveness
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(color: Colors.grey),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FixedColumnWidth(60), // Serial No
                  1: FixedColumnWidth(100), // Roll No
                  2: FixedColumnWidth(150), // Name
                  3: FixedColumnWidth(150), // Father's Name
                  4: FixedColumnWidth(100), // Section
                },
                children: [
                  // Table Header Row
                  TableRow(
                    decoration: BoxDecoration(color: Color.fromARGB(255, 17, 68, 157)),
                    children: [
                      tableHeader("S.No"),
                      tableHeader("Roll No"),
                      tableHeader("Name"),
                      tableHeader("Father's Name"),
                      tableHeader("Section"),
                    ],
                  ),

                  // Data Rows
                  for (int index = 0; index < controller.students.length; index++)
                    TableRow(
                      children: [
                        tableCell("${index + 1}"),
                        tableCell(controller.students[index].rollNumber),
                        tableCell(controller.students[index].name),
                        tableCell(controller.students[index].fatherName),
                        tableCell(controller.students[index].section),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Helper for table headers
  Widget tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
    );
  }

  // Helper for table cells
  Widget tableCell(String text) {
    return Padding(padding: const EdgeInsets.all(8.0), child: Text(text));
  }
}
