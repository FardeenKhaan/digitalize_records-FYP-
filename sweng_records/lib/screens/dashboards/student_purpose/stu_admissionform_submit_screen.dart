import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/controllers/admissionForm_controller.dart';
import 'package:sweng_records/controllers/authController.dart';

// class StudentAdmissionFormScreen extends StatelessWidget {
//   final _controller = Get.put(AdmissionFormController());

//   final _formKey = GlobalKey<FormState>();

//   // Example minimal fields
//   final _discipline = TextEditingController();
//   final _rollNo = TextEditingController();
//   final _fullName = TextEditingController();
//   final _cnic = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admission Form")),
//       body: Obx(() {
//         if (_controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (_controller.myForm.isNotEmpty) {
//           // Student already submitted → show read-only form
//           final form = _controller.myForm;
//           return ListView(
//             padding: EdgeInsets.all(16),
//             children: [
//               Text("My Admission Form", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 16),
//               Text("Discipline: ${form['discipline']}"),
//               Text("Roll No: ${form['roll_no']}"),
//               Text("Full Name: ${form['full_name']}"),
//               Text("CNIC: ${form['cnic']}"),
//               SizedBox(height: 20),
//               Text("You cannot edit this form after submission.", style: TextStyle(color: Colors.red)),
//             ],
//           );
//         }

//         // Otherwise → show form for submission
//         return Padding(
//           padding: EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 TextFormField(
//                   controller: _discipline,
//                   decoration: InputDecoration(labelText: "Discipline"),
//                   validator: (v) => v!.isEmpty ? "Required" : null,
//                 ),
//                 TextFormField(
//                   controller: _rollNo,
//                   decoration: InputDecoration(labelText: "Roll No"),
//                   validator: (v) => v!.isEmpty ? "Required" : null,
//                 ),
//                 TextFormField(
//                   controller: _fullName,
//                   decoration: InputDecoration(labelText: "Full Name"),
//                   validator: (v) => v!.isEmpty ? "Required" : null,
//                 ),
//                 TextFormField(
//                   controller: _cnic,
//                   decoration: InputDecoration(labelText: "CNIC"),
//                   validator: (v) => v!.isEmpty ? "Required" : null,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       final data = {
//                         "discipline": _discipline.text,
//                         "roll_no": _rollNo.text,
//                         "full_name": _fullName.text,
//                         "cnic": _cnic.text,
//                       };
//                       _controller.submitForm(data);
//                     }
//                   },
//                   child: Text("Submit Form"),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// class StudentAdmissionFormScreen extends StatelessWidget {
//   final _controller = Get.put(AdmissionFormController());
//   final _formKey = GlobalKey<FormState>();

//   // Controllers (grouped for readability)
//   final _discipline = TextEditingController();
//   final _rollNo = TextEditingController();
//   final _fullName = TextEditingController();
//   final _cnic = TextEditingController();
//   final _dob = TextEditingController();
//   final _religion = TextEditingController();
//   final _nationality = TextEditingController();
//   final _district = TextEditingController();
//   final _urbanRural = TextEditingController();
//   final _presentAddress = TextEditingController();
//   final _permanentAddress = TextEditingController();
//   final _telephone = TextEditingController();
//   final _studentCell = TextEditingController();
//   final _email = TextEditingController();

//   // Academic Info
//   final _matricMarks = TextEditingController();
//   final _matricBoard = TextEditingController();
//   final _matricYear = TextEditingController();
//   final _matricGrade = TextEditingController();

//   final _interMarks = TextEditingController();
//   final _interBoard = TextEditingController();
//   final _interYear = TextEditingController();
//   final _interGrade = TextEditingController();

//   // Guardian Info
//   final _guardianName = TextEditingController();
//   final _guardianRelation = TextEditingController();
//   final _guardianOccupation = TextEditingController();
//   final _guardianDesignation = TextEditingController();
//   final _guardianOrgAddress = TextEditingController();
//   final _guardianTelOff = TextEditingController();
//   final _guardianTelRes = TextEditingController();
//   final _guardianCell = TextEditingController();
//   final _guardianIncome = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Admission Form")),
//       body: Obx(() {
//         if (_controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (_controller.myForm.isNotEmpty) {
//           final form = _controller.myForm;
//           return ListView(
//             padding: EdgeInsets.all(16),
//             children: [
//               Text("My Admission Form", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 16),
//               ...form.entries.map((e) => Text("${e.key}: ${e.value}")),
//               SizedBox(height: 20),
//               Text("You cannot edit this form after submission.", style: TextStyle(color: Colors.red)),
//             ],
//           );
//         }

//         // Otherwise → show admission form
//         return Padding(
//           padding: EdgeInsets.all(12),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 _buildSection(
//                   title: "Personal Information",
//                   children: [
//                     _buildTextField("Discipline", _discipline),
//                     _buildTextField("Roll No", _rollNo),
//                     _buildTextField("Full Name", _fullName),
//                     _buildTextField("CNIC", _cnic),
//                     _buildTextField("Date of Birth (YYYY-MM-DD)", _dob),
//                     _buildTextField("Religion", _religion),
//                     _buildTextField("Nationality", _nationality),
//                     _buildTextField("District", _district),
//                     _buildDropdown("Urban/Rural", _urbanRural, ["Urban", "Rural"]),
//                   ],
//                 ),
//                 _buildSection(
//                   title: "Contact Information",
//                   children: [
//                     _buildTextField("Present Address", _presentAddress),
//                     _buildTextField("Permanent Address", _permanentAddress),
//                     _buildTextField("Telephone", _telephone),
//                     _buildTextField("Student Cell", _studentCell),
//                     _buildTextField("Email", _email, keyboardType: TextInputType.emailAddress),
//                   ],
//                 ),
//                 _buildSection(
//                   title: "Matriculation",
//                   children: [
//                     _buildTextField("Marks", _matricMarks, keyboardType: TextInputType.number),
//                     _buildTextField("Board", _matricBoard),
//                     _buildTextField("Year", _matricYear, keyboardType: TextInputType.number),
//                     _buildTextField("Grade", _matricGrade),
//                   ],
//                 ),
//                 _buildSection(
//                   title: "Intermediate",
//                   children: [
//                     _buildTextField("Marks", _interMarks, keyboardType: TextInputType.number),
//                     _buildTextField("Board", _interBoard),
//                     _buildTextField("Year", _interYear, keyboardType: TextInputType.number),
//                     _buildTextField("Grade", _interGrade),
//                   ],
//                 ),
//                 _buildSection(
//                   title: "Guardian Information",
//                   children: [
//                     _buildTextField("Guardian Name", _guardianName),
//                     _buildTextField("Relation", _guardianRelation),
//                     _buildTextField("Occupation", _guardianOccupation),
//                     _buildTextField("Designation", _guardianDesignation),
//                     _buildTextField("Org Address", _guardianOrgAddress),
//                     _buildTextField("Telephone (Office)", _guardianTelOff),
//                     _buildTextField("Telephone (Res)", _guardianTelRes),
//                     _buildTextField("Guardian Cell", _guardianCell),
//                     _buildTextField("Annual Income", _guardianIncome, keyboardType: TextInputType.number),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       final data = {
//                         "discipline": _discipline.text,
//                         "roll_no": _rollNo.text,
//                         "full_name": _fullName.text,
//                         "cnic": _cnic.text,
//                         "dob": _dob.text,
//                         "religion": _religion.text,
//                         "nationality": _nationality.text,
//                         "district": _district.text,
//                         "urban_rural": _urbanRural.text,
//                         "present_address": _presentAddress.text,
//                         "permanent_address": _permanentAddress.text,
//                         "telephone": _telephone.text,
//                         "student_cell": _studentCell.text,
//                         "email": _email.text,
//                         "matric_marks": _matricMarks.text,
//                         "matric_board": _matricBoard.text,
//                         "matric_year": _matricYear.text,
//                         "matric_grade": _matricGrade.text,
//                         "inter_marks": _interMarks.text,
//                         "inter_board": _interBoard.text,
//                         "inter_year": _interYear.text,
//                         "inter_grade": _interGrade.text,
//                         "guardian_name": _guardianName.text,
//                         "guardian_relation": _guardianRelation.text,
//                         "guardian_occupation": _guardianOccupation.text,
//                         "guardian_designation": _guardianDesignation.text,
//                         "guardian_org_address": _guardianOrgAddress.text,
//                         "guardian_tel_off": _guardianTelOff.text,
//                         "guardian_tel_res": _guardianTelRes.text,
//                         "guardian_cell": _guardianCell.text,
//                         "guardian_annual_income": _guardianIncome.text,
//                       };
//                       _controller.submitForm(data);
//                     }
//                   },
//                   child: Text("Submit Form"),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildSection({required String title, required List<Widget> children}) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String label,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
//         validator: (v) => v!.isEmpty ? "Required" : null,
//       ),
//     );
//   }

//   Widget _buildDropdown(String label, TextEditingController controller, List<String> options) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6),
//       child: DropdownButtonFormField<String>(
//         value: controller.text.isEmpty ? null : controller.text,
//         items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//         decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
//         onChanged: (val) => controller.text = val!,
//         validator: (v) => v == null ? "Required" : null,
//       ),
//     );
//   }
// }

// class StudentAdmissionFormScreen extends StatelessWidget {
//   final _controller = Get.put(AdmissionFormController());
//   final _formKey = GlobalKey<FormState>();

//   // Controllers (same as before)
//   final _discipline = TextEditingController();
//   final _rollNo = TextEditingController();
//   final _fullName = TextEditingController();
//   final _cnic = TextEditingController();
//   final _dob = TextEditingController();
//   final _religion = TextEditingController();
//   final _nationality = TextEditingController();
//   final _district = TextEditingController();
//   final _urbanRural = TextEditingController();
//   final _presentAddress = TextEditingController();
//   final _permanentAddress = TextEditingController();
//   final _telephone = TextEditingController();
//   final _studentCell = TextEditingController();
//   final _email = TextEditingController();

//   // Academic Info
//   final _matricMarks = TextEditingController();
//   final _matricBoard = TextEditingController();
//   final _matricYear = TextEditingController();
//   final _matricGrade = TextEditingController();

//   final _interMarks = TextEditingController();
//   final _interBoard = TextEditingController();
//   final _interYear = TextEditingController();
//   final _interGrade = TextEditingController();

//   // Guardian Info
//   final _guardianName = TextEditingController();
//   final _guardianRelation = TextEditingController();
//   final _guardianOccupation = TextEditingController();
//   final _guardianDesignation = TextEditingController();
//   final _guardianOrgAddress = TextEditingController();
//   final _guardianTelOff = TextEditingController();
//   final _guardianTelRes = TextEditingController();
//   final _guardianCell = TextEditingController();
//   final _guardianIncome = TextEditingController();

//   StudentAdmissionFormScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Student Admission Form"), backgroundColor: Colors.blueGrey.shade700),
//       body: Obx(() {
//         if (_controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // If already submitted, show a read-only summary (unchanged logic)
//         if (_controller.myForm.isNotEmpty) {
//           final form = _controller.myForm;
//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 const Text("My Admission Form", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: ListView(
//                     children:
//                         form.entries
//                             .map(
//                               (e) => Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 6),
//                                 child: Text("${e.key}: ${e.value}"),
//                               ),
//                             )
//                             .toList(),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 const Text("You cannot edit this form after submission.", style: TextStyle(color: Colors.red)),
//               ],
//             ),
//           );
//         }

//         // Main form: constrained width container, responsive field layout
//         return Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Center(
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(maxWidth: 760),
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         // decide field width: two columns when wide enough
//                         final double max = constraints.maxWidth;
//                         final bool twoColumn = max >= 640;
//                         final double fieldWidth = twoColumn ? (max - 20) / 2 : max;

//                         Widget field(
//                           String label,
//                           TextEditingController ctrl, {
//                           TextInputType keyboardType = TextInputType.text,
//                           bool fullWidth = false,
//                         }) {
//                           final w = fullWidth ? max : fieldWidth;
//                           return SizedBox(
//                             width: w,
//                             child: TextFormField(
//                               controller: ctrl,
//                               keyboardType: keyboardType,
//                               decoration: InputDecoration(
//                                 labelText: label,
//                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                               ),
//                               validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
//                             ),
//                           );
//                         }

//                         Widget dropdownField(
//                           String label,
//                           TextEditingController ctrl,
//                           List<String> options, {
//                           bool fullWidth = false,
//                         }) {
//                           final w = fullWidth ? max : fieldWidth;
//                           return SizedBox(
//                             width: w,
//                             child: DropdownButtonFormField<String>(
//                               value: ctrl.text.isEmpty ? null : ctrl.text,
//                               items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                               decoration: InputDecoration(
//                                 labelText: label,
//                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                               ),
//                               onChanged: (val) => ctrl.text = val ?? '',
//                               validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
//                             ),
//                           );
//                         }

//                         Widget section(String title, List<Widget> children) {
//                           return Card(
//                             elevation: 2,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             child: Padding(
//                               padding: const EdgeInsets.all(14),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                   const SizedBox(height: 12),
//                                   Wrap(spacing: 12, runSpacing: 12, children: children),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }

//                         // Build the form using the helpers above
//                         return Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               section("Personal Information", [
//                                 field("Discipline", _discipline),
//                                 field("Roll No", _rollNo),
//                                 field("Full Name", _fullName),
//                                 field("CNIC", _cnic),
//                                 field("Date of Birth (YYYY-MM-DD)", _dob),
//                                 field("Religion", _religion),
//                                 field("Nationality", _nationality),
//                                 field("District", _district),
//                                 dropdownField("Urban/Rural", _urbanRural, ["Urban", "Rural"]),
//                               ]),

//                               section("Contact Information", [
//                                 field("Present Address", _presentAddress, fullWidth: true),
//                                 field("Permanent Address", _permanentAddress, fullWidth: true),
//                                 field("Telephone", _telephone),
//                                 field("Student Cell", _studentCell),
//                                 field("Email", _email, keyboardType: TextInputType.emailAddress),
//                               ]),

//                               section("Matriculation", [
//                                 field("Marks", _matricMarks, keyboardType: TextInputType.number),
//                                 field("Board", _matricBoard),
//                                 field("Year", _matricYear, keyboardType: TextInputType.number),
//                                 field("Grade", _matricGrade),
//                               ]),

//                               section("Intermediate", [
//                                 field("Marks", _interMarks, keyboardType: TextInputType.number),
//                                 field("Board", _interBoard),
//                                 field("Year", _interYear, keyboardType: TextInputType.number),
//                                 field("Grade", _interGrade),
//                               ]),

//                               section("Guardian Information", [
//                                 field("Guardian Name", _guardianName),
//                                 field("Relation", _guardianRelation),
//                                 field("Occupation", _guardianOccupation),
//                                 field("Designation", _guardianDesignation),
//                                 field("Org Address", _guardianOrgAddress, fullWidth: true),
//                                 field("Telephone (Office)", _guardianTelOff),
//                                 field("Telephone (Res)", _guardianTelRes),
//                                 field("Guardian Cell", _guardianCell),
//                                 field("Annual Income", _guardianIncome, keyboardType: TextInputType.number),
//                               ]),

//                               const SizedBox(height: 96), // space to make sure bottom button doesn't overlap content
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // Fixed submit area (outside scrollable form)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               color: Colors.white, // subtle separation; change to match your app
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 760),
//                 child: Row(
//                   children: [
//                     Expanded(child: Container()), // left spacer so button sits to right — change layout as needed
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.check),
//                       label: const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                         child: Text("Submit Form", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueGrey.shade800,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           final data = {
//                             "discipline": _discipline.text,
//                             "roll_no": _rollNo.text,
//                             "full_name": _fullName.text,
//                             "cnic": _cnic.text,
//                             "dob": _dob.text,
//                             "religion": _religion.text,
//                             "nationality": _nationality.text,
//                             "district": _district.text,
//                             "urban_rural": _urbanRural.text,
//                             "present_address": _presentAddress.text,
//                             "permanent_address": _permanentAddress.text,
//                             "telephone": _telephone.text,
//                             "student_cell": _studentCell.text,
//                             "email": _email.text,
//                             "matric_marks": _matricMarks.text,
//                             "matric_board": _matricBoard.text,
//                             "matric_year": _matricYear.text,
//                             "matric_grade": _matricGrade.text,
//                             "inter_marks": _interMarks.text,
//                             "inter_board": _interBoard.text,
//                             "inter_year": _interYear.text,
//                             "inter_grade": _interGrade.text,
//                             "guardian_name": _guardianName.text,
//                             "guardian_relation": _guardianRelation.text,
//                             "guardian_occupation": _guardianOccupation.text,
//                             "guardian_designation": _guardianDesignation.text,
//                             "guardian_org_address": _guardianOrgAddress.text,
//                             "guardian_tel_off": _guardianTelOff.text,
//                             "guardian_tel_res": _guardianTelRes.text,
//                             "guardian_cell": _guardianCell.text,
//                             "guardian_annual_income": _guardianIncome.text,
//                           };
//                           // backend call unchanged:
//                           _controller.submitForm(data);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

class StudentAdmissionFormScreen extends StatelessWidget {
  final _controller = Get.put(AdmissionFormController());
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  // Controllers (grouped for readability)
  final _discipline = TextEditingController();
  final _rollNo = TextEditingController();
  final _fullName = TextEditingController();
  final _cnic = TextEditingController();
  final _dob = TextEditingController();
  final _religion = TextEditingController();
  final _nationality = TextEditingController();
  final _district = TextEditingController();
  final _urbanRural = TextEditingController();
  final _presentAddress = TextEditingController();
  final _permanentAddress = TextEditingController();
  final _telephone = TextEditingController();
  final _studentCell = TextEditingController();
  final _email = TextEditingController();

  // Academic Info
  final _matricMarks = TextEditingController();
  final _matricBoard = TextEditingController();
  final _matricYear = TextEditingController();
  final _matricGrade = TextEditingController();

  final _interMarks = TextEditingController();
  final _interBoard = TextEditingController();
  final _interYear = TextEditingController();
  final _interGrade = TextEditingController();

  // Guardian Info
  final _guardianName = TextEditingController();
  final _guardianRelation = TextEditingController();
  final _guardianOccupation = TextEditingController();
  final _guardianDesignation = TextEditingController();
  final _guardianOrgAddress = TextEditingController();
  final _guardianTelOff = TextEditingController();
  final _guardianTelRes = TextEditingController();
  final _guardianCell = TextEditingController();
  final _guardianIncome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueGrey.shade700,
        elevation: 0,
        title: Obx(
          () => Row(
            children: [
              const Icon(Iconsax.document_upload, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'BioData Form Submission - ${authController.userName.value}',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.myForm.isNotEmpty) {
          final form = _controller.myForm;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text("My Admission Form", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...form.entries.map((e) => Text("${e.key}: ${e.value}")),
              const SizedBox(height: 20),
              const Text("You cannot edit this form after submission.", style: TextStyle(color: Colors.red)),
            ],
          );
        }

        // Otherwise → show admission form
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                section(
                  step: 1,
                  title: "Personal Information",
                  icon: Icons.person,
                  children: [
                    _buildTextField("Discipline", _discipline),
                    _buildTextField("Roll No", _rollNo),
                    _buildTextField("Full Name", _fullName),
                    _buildTextField("CNIC", _cnic),
                    _buildTextField("Date of Birth (YYYY-MM-DD)", _dob),
                    _buildTextField("Religion", _religion),
                    _buildTextField("Nationality", _nationality),
                    _buildTextField("District", _district),
                    _buildDropdown("Urban/Rural", _urbanRural, ["Urban", "Rural"]),
                  ],
                ),
                section(
                  step: 2,
                  title: "Contact Information",
                  icon: Icons.contact_phone,
                  children: [
                    _buildTextField("Present Address", _presentAddress),
                    _buildTextField("Permanent Address", _permanentAddress),
                    _buildTextField("Telephone", _telephone),
                    _buildTextField("Student Cell", _studentCell),
                    _buildTextField("Email", _email, keyboardType: TextInputType.emailAddress),
                  ],
                ),
                section(
                  step: 3,
                  title: "Matriculation",
                  icon: Icons.school,
                  children: [
                    _buildTextField("Marks", _matricMarks, keyboardType: TextInputType.number),
                    _buildTextField("Board", _matricBoard),
                    _buildTextField("Year", _matricYear, keyboardType: TextInputType.number),
                    _buildTextField("Grade", _matricGrade),
                  ],
                ),
                section(
                  step: 4,
                  title: "Intermediate",
                  icon: Icons.school_outlined,
                  children: [
                    _buildTextField("Marks", _interMarks, keyboardType: TextInputType.number),
                    _buildTextField("Board", _interBoard),
                    _buildTextField("Year", _interYear, keyboardType: TextInputType.number),
                    _buildTextField("Grade", _interGrade),
                  ],
                ),
                section(
                  step: 5,
                  title: "Guardian Information",
                  icon: Icons.family_restroom,
                  children: [
                    _buildTextField("Guardian Name", _guardianName),
                    _buildTextField("Relation", _guardianRelation),
                    _buildTextField("Occupation", _guardianOccupation),
                    _buildTextField("Designation", _guardianDesignation),
                    _buildTextField("Org Address", _guardianOrgAddress),
                    _buildTextField("Telephone (Office)", _guardianTelOff),
                    _buildTextField("Telephone (Res)", _guardianTelRes),
                    _buildTextField("Guardian Cell", _guardianCell),
                    _buildTextField("Annual Income", _guardianIncome, keyboardType: TextInputType.number),
                  ],
                ),
                const SizedBox(height: 80), // leave space for FAB
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final data = {
              "discipline": _discipline.text,
              "roll_no": _rollNo.text,
              "full_name": _fullName.text,
              "cnic": _cnic.text,
              "dob": _dob.text,
              "religion": _religion.text,
              "nationality": _nationality.text,
              "district": _district.text,
              "urban_rural": _urbanRural.text,
              "present_address": _presentAddress.text,
              "permanent_address": _permanentAddress.text,
              "telephone": _telephone.text,
              "student_cell": _studentCell.text,
              "email": _email.text,
              "matric_marks": _matricMarks.text,
              "matric_board": _matricBoard.text,
              "matric_year": _matricYear.text,
              "matric_grade": _matricGrade.text,
              "inter_marks": _interMarks.text,
              "inter_board": _interBoard.text,
              "inter_year": _interYear.text,
              "inter_grade": _interGrade.text,
              "guardian_name": _guardianName.text,
              "guardian_relation": _guardianRelation.text,
              "guardian_occupation": _guardianOccupation.text,
              "guardian_designation": _guardianDesignation.text,
              "guardian_org_address": _guardianOrgAddress.text,
              "guardian_tel_off": _guardianTelOff.text,
              "guardian_tel_res": _guardianTelRes.text,
              "guardian_cell": _guardianCell.text,
              "guardian_annual_income": _guardianIncome.text,
            };
            _controller.submitForm(data);
          }
        },
        label: const Text("Submit Form", style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.check_circle, color: Colors.white),
        backgroundColor: Colors.blueGrey.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget section({required int step, required String title, required IconData icon, required List<Widget> children}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blueGrey.shade700,
                  child: Text(
                    step.toString(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: Colors.blueGrey.shade600),
                const SizedBox(width: 6),
                Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(thickness: 1, height: 20),
            Wrap(spacing: 12, runSpacing: 12, children: children),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (v) => v!.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget _buildDropdown(String label, TextEditingController controller, List<String> options) {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<String>(
        value: controller.text.isEmpty ? null : controller.text,
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (val) => controller.text = val!,
        validator: (v) => v == null ? "Required" : null,
      ),
    );
  }
}
