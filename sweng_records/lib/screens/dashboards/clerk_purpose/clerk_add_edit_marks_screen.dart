import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/controllers/marks_controller.dart';

// class ClerkAddEditMarksScreen extends StatelessWidget {
//   final MarksController _controller = Get.find();
//   final Map<String, dynamic>? editMark;

//   ClerkAddEditMarksScreen({this.editMark});

//   final _formKey = GlobalKey<FormState>();
//   // final _rollCtrl = TextEditingController();
//   final _semCtrl = TextEditingController();
//   final _chairmanCtrl = TextEditingController();
//   final _supervisorCtrl = TextEditingController();
//   final _externalCtrl = TextEditingController();
//   final _internalCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     if (editMark != null) {
//       // _rollCtrl.text = editMark!['student_roll_no'];
//       _semCtrl.text = editMark!['semester'].toString();
//       _chairmanCtrl.text = editMark!['chairman_marks'].toString();
//       _supervisorCtrl.text = editMark!['supervisor_marks'].toString();
//       _externalCtrl.text = editMark!['external_marks'].toString();
//       _internalCtrl.text = editMark!['internal_marks'].toString();
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text(editMark == null ? "Add Marks" : "Edit Marks")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // TextFormField(controller: _rollCtrl, decoration: InputDecoration(labelText: "Roll No")),
//               TextFormField(controller: _semCtrl, decoration: InputDecoration(labelText: "Semester")),
//               TextFormField(controller: _chairmanCtrl, decoration: InputDecoration(labelText: "Chairman Marks")),
//               TextFormField(controller: _supervisorCtrl, decoration: InputDecoration(labelText: "Supervisor Marks")),
//               TextFormField(controller: _externalCtrl, decoration: InputDecoration(labelText: "External Marks")),
//               TextFormField(controller: _internalCtrl, decoration: InputDecoration(labelText: "Internal Marks")),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 child: Text(editMark == null ? "Add" : "Update"),
//                 onPressed: () {
//                   final data = {
//                     // "student_roll_no": _rollCtrl.text,
//                     "semester": _semCtrl.text,
//                     "chairman_marks": int.parse(_chairmanCtrl.text),
//                     "supervisor_marks": int.parse(_supervisorCtrl.text),
//                     "external_marks": int.parse(_externalCtrl.text),
//                     "internal_marks": int.parse(_internalCtrl.text),
//                   };
//                   if (editMark == null) {
//                     _controller.addMarks(data);
//                   } else {
//                     _controller.updateMarks(editMark!['id'], data);
//                   }
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ClerkAddEditMarksScreen extends StatelessWidget {
  final MarksController _controller = Get.find();
  final Map<String, dynamic>? editMark;

  ClerkAddEditMarksScreen({this.editMark});

  final _formKey = GlobalKey<FormState>();
  final _rollCtrl = TextEditingController();
  final _semCtrl = TextEditingController();
  final _chairmanCtrl = TextEditingController();
  final _supervisorCtrl = TextEditingController();
  final _externalCtrl = TextEditingController();
  final _internalCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (editMark != null) {
      _rollCtrl.text = editMark!['student_roll_no']; // ✅ added back
      _semCtrl.text = editMark!['semester'].toString();
      _chairmanCtrl.text = editMark!['chairman_marks'].toString();
      _supervisorCtrl.text = editMark!['supervisor_marks'].toString();
      _externalCtrl.text = editMark!['external_marks'].toString();
      _internalCtrl.text = editMark!['internal_marks'].toString();
    }

    return Scaffold(
      appBar: AppBar(title: Text(editMark == null ? "Add Marks" : "Edit Marks")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _rollCtrl,
                decoration: InputDecoration(labelText: "Roll No"),
                validator: (val) => val == null || val.isEmpty ? "Enter roll no" : null,
              ),
              TextFormField(
                controller: _semCtrl,
                decoration: InputDecoration(labelText: "Semester"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _chairmanCtrl,
                decoration: InputDecoration(labelText: "Chairman Marks"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _supervisorCtrl,
                decoration: InputDecoration(labelText: "Supervisor Marks"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _externalCtrl,
                decoration: InputDecoration(labelText: "External Marks"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _internalCtrl,
                decoration: InputDecoration(labelText: "Internal Marks"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(editMark == null ? "Add" : "Update"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final data = {
                      "student_roll_no": _rollCtrl.text, // ✅ required
                      "semester": int.parse(_semCtrl.text),
                      "chairman_marks": int.parse(_chairmanCtrl.text),
                      "supervisor_marks": int.parse(_supervisorCtrl.text),
                      "external_marks": int.parse(_externalCtrl.text),
                      "internal_marks": int.parse(_internalCtrl.text),
                    };

                    if (editMark == null) {
                      _controller.addMarks(data);
                    } else {
                      _controller.updateMarks(editMark!['id'], data);
                    }

                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
