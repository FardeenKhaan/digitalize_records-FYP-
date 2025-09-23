// screens/clerk/clerk_form_detail_screen.dart

import 'package:flutter/material.dart';

// class ClerkFormDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> form;

//   ClerkFormDetailScreen({required this.form});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Form Details - Roll No: ${form['roll_no']}")),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           _buildSection("Personal Information", {
//             "Full Name": form['full_name'],
//             "Roll No": form['roll_no'],
//             "CNIC": form['cnic'],
//             "DOB": form['dob'],
//             "Religion": form['religion'],
//             "Nationality": form['nationality'],
//             "District": form['district'],
//             "Urban/Rural": form['urban_rural'],
//           }),
//           _buildSection("Contact Information", {
//             "Present Address": form['present_address'],
//             "Permanent Address": form['permanent_address'],
//             "Telephone": form['telephone'],
//             "Student Cell": form['student_cell'],
//             "Email": form['email'],
//           }),
//           _buildSection("Matriculation", {
//             "Marks": form['matric_marks'],
//             "Board": form['matric_board'],
//             "Year": form['matric_year'],
//             "Grade": form['matric_grade'],
//           }),
//           _buildSection("Intermediate", {
//             "Marks": form['inter_marks'],
//             "Board": form['inter_board'],
//             "Year": form['inter_year'],
//             "Grade": form['inter_grade'],
//           }),
//           _buildSection("Guardian Information", {
//             "Name": form['guardian_name'],
//             "Relation": form['guardian_relation'],
//             "Occupation": form['guardian_occupation'],
//             "Designation": form['guardian_designation'],
//             "Org Address": form['guardian_org_address'],
//             "Tel (Office)": form['guardian_tel_off'],
//             "Tel (Res)": form['guardian_tel_res'],
//             "Cell": form['guardian_cell'],
//             "Annual Income": form['guardian_annual_income'],
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildSection(String title, Map<String, dynamic> fields) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             ...fields.entries.map(
//               (e) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Text("${e.key}: ${e.value ?? 'N/A'}"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ClerkFormDetailScreen extends StatelessWidget {
  final Map<String, dynamic> form;

  ClerkFormDetailScreen({required this.form});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Details"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              // final pdf = await _generatePdf();
              // await Printing.sharePdf(bytes: pdf, filename: 'form_${form['roll_no']}.pdf');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildFormHeader(),
              SizedBox(height: 20),

              // Main form content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Form fields
                  Expanded(flex: 7, child: _buildFormFields()),

                  // Right side - Photo box
                  Container(width: 120, child: _buildPhotoSection()),
                ],
              ),

              SizedBox(height: 25),

              // Academic Qualification table
              _buildAcademicTable(),

              SizedBox(height: 25),

              // Guardian information
              _buildGuardianInfo(),

              SizedBox(height: 30),

              // Signature section
              _buildSignatureSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormHeader() {
    return Column(
      children: [
        // University header
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "MEHRAN UNIVERSITY OF ENGINEERING AND TECHNOLOGY, JAMSHORO",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2),
              Text(
                "DEPARTMENT OF SOFTWARE ENGINEERING",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(height: 15),

        // Discipline and Roll No line
        Row(
          children: [
            Text("Discipline ", style: TextStyle(fontSize: 12)),
            Container(
              width: 60,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['discipline'] ?? 'BE - SE', style: TextStyle(fontSize: 12)),
            ),
            Spacer(),
            Text("Roll No. ", style: TextStyle(fontSize: 12)),
            Container(
              width: 100,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['roll_no']?.toString() ?? '', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),

        // 1. Full Name
        _buildFieldRow("1.", "Full Name of the student", form['full_name']),
        SizedBox(height: 12),

        // (a) CNIC
        _buildSubFieldRow("(a)", "C.N.I.C. No.", form['cnic']),
        SizedBox(height: 10),

        // (b) Date of Birth
        _buildSubFieldRow("(b)", "Date of Birth", form['dob']),
        SizedBox(height: 10),

        // (c) Religion and Nationality
        Row(
          children: [
            Text("(c) ", style: TextStyle(fontSize: 12)),
            Text("Religion ", style: TextStyle(fontSize: 12)),
            Container(
              width: 80,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['religion']?.toString() ?? '', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(width: 20),
            Text("Nationality ", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Text(form['nationality']?.toString() ?? '', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        // (d) District and Urban/Rural
        Row(
          children: [
            Text("(d) ", style: TextStyle(fontSize: 12)),
            Text("District ", style: TextStyle(fontSize: 12)),
            Container(
              width: 100,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['district']?.toString() ?? '', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(width: 20),
            Text("Urban/Rural ", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Text(form['urban_rural']?.toString() ?? '', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // (e) Address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("(e) Address:", style: TextStyle(fontSize: 12)),
            SizedBox(height: 8),

            // Present address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30),
                Text("(i) Present ", style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                        child: Text(
                          form['present_address']?.toString() ?? '',
                          style: TextStyle(fontSize: 12),
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                        child: Text("", style: TextStyle(fontSize: 12, height: 1.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Permanent address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30),
                Text("(ii) Permanent ", style: TextStyle(fontSize: 12)),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                        child: Text(
                          form['permanent_address']?.toString() ?? '',
                          style: TextStyle(fontSize: 12),
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                        child: Text("", style: TextStyle(fontSize: 12, height: 1.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),

        // Telephone and Student Cell
        Row(
          children: [
            Text("(d) ", style: TextStyle(fontSize: 12)),
            Text("Telephone No. ", style: TextStyle(fontSize: 12)),
            Container(
              width: 100,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['telephone']?.toString() ?? '', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(width: 15),
            Text("Student Cell No. ", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Text(form['student_cell']?.toString() ?? '', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        // Email
        _buildSubFieldRow("(i)", "Email Address", form['email']),
      ],
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child:
              form['photo_url'] != null
                  ? Image.network(form['photo_url'], fit: BoxFit.cover)
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Attach four", style: TextStyle(fontSize: 9), textAlign: TextAlign.center),
                      Text("latest", style: TextStyle(fontSize: 9), textAlign: TextAlign.center),
                      Text("Photographs", style: TextStyle(fontSize: 9), textAlign: TextAlign.center),
                    ],
                  ),
        ),
      ],
    );
  }

  Widget _buildAcademicTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("(e) Academic Qualification", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),

        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: Column(
            children: [
              // Header row
              Container(
                height: 40,
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Row(
                  children: [
                    _buildTableHeader("S.#", 35),
                    _buildTableHeader("Name of\nExamination", 90),
                    _buildTableHeader("Marks\nObtained", 70),
                    _buildTableHeader("Board/University", 120),
                    _buildTableHeader("Year", 50),
                    _buildTableHeader("Grade/\nDivision", 70),
                  ],
                ),
              ),

              // Matriculation row
              Container(
                height: 35,
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Row(
                  children: [
                    _buildTableCell("01", 35),
                    _buildTableCell("Matriculation", 90),
                    _buildTableCell(form['matric_marks']?.toString() ?? '', 70),
                    _buildTableCell(form['matric_board']?.toString() ?? '', 120),
                    _buildTableCell(form['matric_year']?.toString() ?? '', 50),
                    _buildTableCell(form['matric_grade']?.toString() ?? '', 70),
                  ],
                ),
              ),

              // Intermediate row
              Container(
                height: 35,
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Row(
                  children: [
                    _buildTableCell("02", 35),
                    _buildTableCell("Intermediate", 90),
                    _buildTableCell(form['inter_marks']?.toString() ?? '', 70),
                    _buildTableCell(form['inter_board']?.toString() ?? '', 120),
                    _buildTableCell(form['inter_year']?.toString() ?? '', 50),
                    _buildTableCell(form['inter_grade']?.toString() ?? '', 70),
                  ],
                ),
              ),

              // Empty row
              Container(
                height: 35,
                child: Row(
                  children: [
                    _buildTableCell("03", 35),
                    _buildTableCell("", 90),
                    _buildTableCell("", 70),
                    _buildTableCell("", 120),
                    _buildTableCell("", 50),
                    _buildTableCell("", 70),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuardianInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Father/Guardian Name
        _buildFieldRow("2.", "Father/Guardian Name", form['guardian_name']),
        SizedBox(height: 12),

        // Guardian's Relation
        _buildSubFieldRow("(a)", "Guardian's Relation", form['guardian_relation']),
        SizedBox(height: 10),

        // Occupation and Position
        Row(
          children: [
            Text("(b) ", style: TextStyle(fontSize: 12)),
            Text("Occupation ", style: TextStyle(fontSize: 12)),
            Container(
              width: 100,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['guardian_occupation']?.toString() ?? '', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(width: 15),
            Text("Position/Designation ", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Text(form['guardian_designation']?.toString() ?? '', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        // Organization Address
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("(c) ", style: TextStyle(fontSize: 12)),
            Text("Organization Address ", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                    child: Text(form['guardian_org_address']?.toString() ?? '', style: TextStyle(fontSize: 12)),
                  ),
                  SizedBox(height: 3),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                    child: Text("", style: TextStyle(fontSize: 12, height: 1.5)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Phone numbers
        Row(
          children: [
            Text("(d) ", style: TextStyle(fontSize: 12)),
            Text("Telephone No.(Off.) ", style: TextStyle(fontSize: 12)),
            Container(
              width: 90,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['guardian_tel_off']?.toString() ?? '', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(width: 10),
            Text("Res: ", style: TextStyle(fontSize: 12)),
            Container(
              width: 90,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(form['guardian_tel_res']?.toString() ?? '', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(width: 10),
            Text("Cell ", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: Text(form['guardian_cell']?.toString() ?? '', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        // Annual Income
        _buildSubFieldRow("(e)", "Annual Income", form['guardian_annual_income']?.toString()),
      ],
    );
  }

  Widget _buildSignatureSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                child:
                    form['signature_url'] != null
                        ? Image.network(form['signature_url'], height: 40, fit: BoxFit.contain)
                        : Container(),
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: SizedBox(height: 1),
              ),
              SizedBox(height: 5),
              Text("Signature of the Student", style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
        SizedBox(width: 80),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 60),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
                child: SizedBox(height: 1),
              ),
              SizedBox(height: 5),
              Text("Chairman", style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldRow(String number, String label, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 20, child: Text(number, style: TextStyle(fontSize: 12))),
        Text("$label ", style: TextStyle(fontSize: 12)),
        Expanded(
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
            child: Text(value?.toString() ?? '', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _buildSubFieldRow(String letter, String label, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        Text("$letter ", style: TextStyle(fontSize: 12)),
        Text("$label ", style: TextStyle(fontSize: 12)),
        Expanded(
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
            child: Text(value?.toString() ?? '', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black, width: 1))),
      child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }

  Widget _buildTableCell(String text, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.black, width: 1))),
      child: Text(text, style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
    );
  }

  /// ✅ Generate PDF from form data
  // Future<Uint8List> _generatePdf() async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.MultiPage(
  //       build: (context) => [
  //         pw.Center(
  //           child: pw.Text(
  //             "MEHRAN UNIVERSITY OF ENGINEERING AND TECHNOLOGY, JAMSHORO\nDEPARTMENT OF SOFTWARE ENGINEERING",
  //             textAlign: pw.TextAlign.center,
  //             style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
  //           ),
  //         ),
  //         pw.SizedBox(height: 20),

  //         pw.Text("Roll No: ${form['roll_no'] ?? ''}", style: pw.TextStyle(fontSize: 12)),
  //         pw.Text("Full Name: ${form['full_name'] ?? ''}", style: pw.TextStyle(fontSize: 12)),
  //         pw.Text("CNIC: ${form['cnic'] ?? ''}", style: pw.TextStyle(fontSize: 12)),
  //         pw.Text("DOB: ${form['dob'] ?? ''}", style: pw.TextStyle(fontSize: 12)),
  //         pw.SizedBox(height: 10),

  //         pw.Text("Academic Qualification:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         pw.Table(
  //           border: pw.TableBorder.all(),
  //           children: [
  //             pw.TableRow(
  //               children: [
  //                 pw.Text("Exam"),
  //                 pw.Text("Marks"),
  //                 pw.Text("Board"),
  //                 pw.Text("Year"),
  //                 pw.Text("Grade"),
  //               ],
  //             ),
  //             pw.TableRow(
  //               children: [
  //                 pw.Text("Matriculation"),
  //                 pw.Text(form['matric_marks']?.toString() ?? ''),
  //                 pw.Text(form['matric_board']?.toString() ?? ''),
  //                 pw.Text(form['matric_year']?.toString() ?? ''),
  //                 pw.Text(form['matric_grade']?.toString() ?? ''),
  //               ],
  //             ),
  //             pw.TableRow(
  //               children: [
  //                 pw.Text("Intermediate"),
  //                 pw.Text(form['inter_marks']?.toString() ?? ''),
  //                 pw.Text(form['inter_board']?.toString() ?? ''),
  //                 pw.Text(form['inter_year']?.toString() ?? ''),
  //                 pw.Text(form['inter_grade']?.toString() ?? ''),
  //               ],
  //             ),
  //           ],
  //         ),

  //         pw.SizedBox(height: 20),
  //         pw.Row(
  //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //           children: [
  //             pw.Column(children: [pw.Text("_________________"), pw.Text("Signature of Student")]),
  //             pw.Column(children: [pw.Text("_________________"), pw.Text("Chairman")]),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );

  //   return pdf.save();
  // }
}
