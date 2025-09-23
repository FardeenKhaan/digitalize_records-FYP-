// screens/student/admission_form_view_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sweng_records/controllers/admissionForm_controller.dart';

class AdmissionFormViewScreen extends StatelessWidget {
  final _controller = Get.put(AdmissionFormController());

  @override
  Widget build(BuildContext context) {
    _controller.loadMyForm();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Admission Form"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (_controller.myForm.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text("No form submitted yet.", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              ],
            ),
          );
        }

        final form = _controller.myForm;
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3)),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormHeader(form),
                  SizedBox(height: 20),
                  _buildStudentInfo(form),
                  SizedBox(height: 20),
                  _buildAcademicQualification(form),
                  SizedBox(height: 20),
                  _buildGuardianInfo(form),
                  SizedBox(height: 30),
                  _buildSignatureSection(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFormHeader(Map<String, dynamic> form) {
    return Column(
      children: [
        // University Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
          child: Text(
            "MEHRAN UNIVERSITY OF ENGINEERING AND TECHNOLOGY, JAMSHORO\nDEPARTMENT OF SOFTWARE ENGINEERING",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ),

        SizedBox(height: 16),

        // Discipline and Roll No Row
        Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text("Discipline ", style: _labelStyle()),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
                      child: Text(_getStringValue(form['discipline'] ?? 'BS - SE'), style: _valueStyle()),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Roll No.  ", style: _labelStyle()),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
                      child: Text(_getStringValue(form['roll_no'] ?? ''), style: _valueStyle()),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            // Photo placeholder
            Container(
              width: 110,
              height: 130,
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Attach four", style: TextStyle(fontSize: 10)),
                  Text("latest", style: TextStyle(fontSize: 10)),
                  Text("Photographs", style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStudentInfo(Map<String, dynamic> form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        _buildFormField(
          number: "1.",
          label: "Full Name of the student",
          value: _getStringValue(form['full_name']),
          // isMainField: true,
        ),

        SizedBox(height: 12),

        // CNIC, DOB, Religion, Nationality in rows
        Row(children: [Expanded(child: _buildInlineField("(a) C.N.I.C No.", _getStringValue(form['cnic'])))]),

        SizedBox(height: 8),

        Row(children: [Expanded(child: _buildInlineField("(b) Date of Birth", _getStringValue(form['dob'])))]),

        SizedBox(height: 8),

        Row(
          children: [
            Expanded(flex: 2, child: _buildInlineField("(c) Religion", _getStringValue(form['religion']))),
            SizedBox(width: 20),
            Expanded(flex: 2, child: _buildInlineField("Nationality", _getStringValue(form['nationality']))),
          ],
        ),

        SizedBox(height: 8),

        Row(
          children: [
            Expanded(flex: 2, child: _buildInlineField("(d) District", _getStringValue(form['district']))),
            SizedBox(width: 20),
            Expanded(flex: 2, child: _buildInlineField("Urban/Rural", _getStringValue(form['urban_rural']))),
          ],
        ),

        SizedBox(height: 12),

        // Address
        Row(
          children: [
            Expanded(child: _buildAddressField("(e) Address: (i) Present", _getStringValue(form['present_address']))),
          ],
        ),
        // _buildAddressField("(e) Address: (i) Present", _getStringValue(form['present_address'])),
        SizedBox(height: 8),
        Row(
          children: [Expanded(child: _buildAddressField("(ii) Permanent", _getStringValue(form['permanent_address'])))],
        ),

        SizedBox(height: 12),

        // Contact Info
        Row(
          children: [
            Expanded(child: _buildInlineField("(d) Telephone No.", _getStringValue(form['telephone']))),
            SizedBox(width: 20),
            Expanded(child: _buildInlineField("Student Cell No.", _getStringValue(form['student_cell']))),
          ],
        ),

        SizedBox(height: 8),

        _buildFormField(label: "(i) Email Address", value: _getStringValue(form['email'])),
      ],
    );
  }

  Widget _buildAcademicQualification(Map<String, dynamic> form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("(e) Academic Qualification", style: _labelStyle()),
        SizedBox(height: 12),

        // Table Header
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: {
              0: FixedColumnWidth(40),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(2),
              4: FixedColumnWidth(60),
              5: FixedColumnWidth(80),
            },
            children: [
              // Header Row
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: [
                  _buildTableCell("S.#", isHeader: true),
                  _buildTableCell("Name of\nExamination", isHeader: true),
                  _buildTableCell("Marks\nObtained", isHeader: true),
                  _buildTableCell("Board/University", isHeader: true),
                  _buildTableCell("Year", isHeader: true),
                  _buildTableCell("Grade/\nDivision", isHeader: true),
                ],
              ),
              // Matriculation Row
              TableRow(
                children: [
                  _buildTableCell("01"),
                  _buildTableCell("Matriculation"),
                  _buildTableCell(_getStringValue(form['matric_marks'])),
                  _buildTableCell(_getStringValue(form['matric_board'])),
                  _buildTableCell(_getStringValue(form['matric_year'])),
                  _buildTableCell(_getStringValue(form['matric_grade'])),
                ],
              ),
              // Intermediate Row
              TableRow(
                children: [
                  _buildTableCell("02"),
                  _buildTableCell("Intermediate"),
                  _buildTableCell(_getStringValue(form['inter_marks'])),
                  _buildTableCell(_getStringValue(form['inter_board'])),
                  _buildTableCell(_getStringValue(form['inter_year'])),
                  _buildTableCell(_getStringValue(form['inter_grade'])),
                ],
              ),
              // Empty Row
              TableRow(
                children: [
                  _buildTableCell("03"),
                  _buildTableCell(""),
                  _buildTableCell(""),
                  _buildTableCell(""),
                  _buildTableCell(""),
                  _buildTableCell(""),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuardianInfo(Map<String, dynamic> form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField(
          number: "2.",
          label: "Father/Guardian Name",
          value: _getStringValue(form['guardian_name']),
          isMainField: true,
        ),

        SizedBox(height: 12),

        _buildInlineField("(a) Guardian's Relation", _getStringValue(form['guardian_relation'])),

        SizedBox(height: 8),

        Row(
          children: [
            Expanded(flex: 2, child: _buildInlineField("(b) Occupation", _getStringValue(form['guardian_occupation']))),
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: _buildInlineField("Position/Designation", _getStringValue(form['guardian_designation'])),
            ),
          ],
        ),

        SizedBox(height: 8),

        _buildAddressField("(c) Organization Address", _getStringValue(form['guardian_org_address'])),

        SizedBox(height: 12),

        Row(
          children: [
            Expanded(child: _buildInlineField("(d) Telephone No.(Off)", _getStringValue(form['guardian_tel_off']))),
            SizedBox(width: 10),
            Expanded(child: _buildInlineField("Res:", _getStringValue(form['guardian_tel_res']))),
            SizedBox(width: 10),
            Expanded(child: _buildInlineField("Cell", _getStringValue(form['guardian_cell']))),
          ],
        ),

        SizedBox(height: 8),

        _buildInlineField("(e) Annual Income", _getStringValue(form['guardian_annual_income'])),
      ],
    );
  }

  Widget _buildSignatureSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(height: 1, color: Colors.black),
              SizedBox(height: 4),
              Text("Signature of the Student", style: _labelStyle()),
            ],
          ),
        ),
        SizedBox(width: 40),
        Expanded(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(height: 1, color: Colors.black),
              SizedBox(height: 4),
              Text("Chairman", style: _labelStyle()),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildFormField({String? number, required String label, required String value, bool isMainField = false}) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       if (number != null) ...[SizedBox(width: 20, child: Text(number, style: _labelStyle())), SizedBox(width: 8)],
  //       Text(label, style: _labelStyle()),
  //       SizedBox(width: 8),
  //       Expanded(
  //         child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 4),
  //           decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
  //           child: Text(value.isEmpty ? "" : value, style: _valueStyle()),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildFormField({String? number, required String label, required String value, bool isMainField = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Number OUTSIDE padding
        if (number != null) ...[
          SizedBox(
            width: 50, // reserves space so fields align properly
            child: Text(number, style: _labelStyle()),
          ),
        ],

        // Everything else INSIDE padding
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: _labelStyle()),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
                      child: Text(value.isEmpty ? "" : value, style: _valueStyle()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInlineField(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label + " ", style: _labelStyle()),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
            child: Text(value.isEmpty ? "" : value, style: _valueStyle()),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle()),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
          child: Text(value.isEmpty ? "" : value, style: _valueStyle(), maxLines: 2),
        ),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
  }

  TextStyle _valueStyle() {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87);
  }

  // Helper method to safely convert any value to string
  String _getStringValue(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}
