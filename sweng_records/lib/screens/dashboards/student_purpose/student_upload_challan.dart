// screens/student_upload_challan.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sweng_records/controllers/authController.dart';
import 'package:sweng_records/controllers/challanController.dart';

// screens/student_upload_challan.dart

// class StudentUploadChallanScreen extends StatelessWidget {
//   StudentUploadChallanScreen({super.key});

//   final AuthController authController = Get.put(AuthController());
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, dynamic> challanData = {};
//   final controller = Get.put(ChallanController()); // avoid duplicate controllers

//   final List<String> semesterOptions = const [
//     '1st sem, 1st year',
//     '2nd sem, 1st year',
//     '3rd sem, 2nd year',
//     '4th sem, 2nd year',
//     '5th sem, 3rd year',
//     '6th sem, 3rd year',
//     '7th sem, 4th year',
//     '8th sem, 4th year',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.blueGrey.shade700,
//         elevation: 0,
//         title: Obx(
//           () => Row(
//             children: [
//               const Icon(Iconsax.document_upload, color: Colors.white),
//               const SizedBox(width: 8),
//               Text(
//                 'Upload Challan - ${authController.userName.value}',
//                 style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Center(
//         child: SizedBox(
//           height: 760,
//           width: 640,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Obx(
//               () => Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     Text('Challan Upload', style: TextStyle(color: Colors.blue.shade700, fontSize: 28)),
//                     const SizedBox(height: 8),

//                     _inputField('roll_no', 'Roll No'),
//                     _inputField('name', 'Name'),
//                     _inputField('father_name', 'Father Name'),
//                     _dropdownField('semester_year', 'Semester Year'),
//                     _inputField('challan_no', 'Challan No'),
//                     _datePickerField('submission_date', 'Submission Date (YYYY-MM-DD)'),
//                     _inputField('fees_amount', 'Fees Amount', isNumber: true),

//                     const SizedBox(height: 12),

//                     // ---- Image picker & preview ----
//                     _imagePickerCard(),

//                     const SizedBox(height: 16),

//                     controller.isLoading.value
//                         ? const Center(child: CircularProgressIndicator())
//                         : Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 50),
//                           child: TextButton(
//                             style: TextButton.styleFrom(
//                               backgroundColor: const Color.fromARGB(255, 3, 41, 105),
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//                               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _formKey.currentState!.save();
//                                 controller.uploadChallan(challanData);
//                               }
//                             },
//                             child: const Text("Upload"),
//                           ),
//                         ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // --------- widgets ---------

//   Widget _imagePickerCard() {
//     return Obx(() {
//       final file = controller.pickedImage.value;

//       return Card(
//         elevation: 1,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Attach Challan Image (PNG/JPG/WEBP, max 5MB)', style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   ElevatedButton.icon(
//                     icon: const Icon(Icons.image),
//                     onPressed: controller.pickImage,
//                     label: Text(file == null ? 'Pick Image' : 'Change Image'),
//                   ),
//                   const SizedBox(width: 8),
//                   if (file != null)
//                     TextButton.icon(
//                       icon: const Icon(Icons.delete_outline),
//                       onPressed: controller.clearPickedImage,
//                       label: const Text('Remove'),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               if (file != null && file.bytes != null)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(6),
//                   child: Image.memory(file.bytes!, height: 180, fit: BoxFit.cover),
//                 ),
//               if (file != null) ...[
//                 const SizedBox(height: 6),
//                 Text('Selected: ${file.name}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
//               ],
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget _inputField(String key, String label, {bool isNumber = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: TextFormField(
//         decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         onSaved: (value) => challanData[key] = value!.trim(),
//         validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
//       ),
//     );
//   }

//   Widget _dropdownField(String key, String label) {
//     String? selectedValue;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: StatefulBuilder(
//         builder: (context, setState) {
//           return DropdownButtonFormField<String>(
//             decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
//             items: semesterOptions.map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt))).toList(),
//             value: selectedValue,
//             onChanged: (value) => setState(() => selectedValue = value),
//             onSaved: (value) => challanData[key] = value!,
//             validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
//           );
//         },
//       ),
//     );
//   }

//   Widget _datePickerField(String key, String label) {
//     final tController = TextEditingController();
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: GestureDetector(
//         onTap: () async {
//           DateTime? picked = await showDatePicker(
//             context: Get.context!,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(2000),
//             lastDate: DateTime.now(),
//           );
//           if (picked != null) {
//             final formatted = DateFormat('yyyy-MM-dd').format(picked);
//             tController.text = formatted;
//             challanData[key] = formatted;
//           }
//         },
//         child: AbsorbPointer(
//           child: TextFormField(
//             controller: tController,
//             decoration: InputDecoration(
//               labelText: label,
//               border: const OutlineInputBorder(),
//               suffixIcon: const Icon(Icons.calendar_today),
//             ),
//             validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
//           ),
//         ),
//       ),
//     );
//   }
// }

class StudentUploadChallanScreen extends StatelessWidget {
  StudentUploadChallanScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> challanData = {};
  final controller = Get.put(ChallanController());

  final List<String> semesterOptions = const [
    '1st sem, 1st year',
    '2nd sem, 1st year',
    '3rd sem, 2nd year',
    '4th sem, 2nd year',
    '5th sem, 3rd year',
    '6th sem, 3rd year',
    '7th sem, 4th year',
    '8th sem, 4th year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                'Upload Challan - ${authController.userName.value}',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),

      // ---- Scroll only form ----
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 640,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Text(
                    "Challan Submission Form",
                    style: GoogleFonts.poppins(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Fill in your details and upload a scanned copy of your challan.",
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey.shade500),
                  ),
                  const SizedBox(height: 20),

                  // Student Info
                  _sectionTitle("Student Information", Iconsax.user_edit),
                  const Divider(height: 16),
                  _inputField('roll_no', 'Roll Number', Iconsax.card),
                  _inputField('name', 'Name', Iconsax.user),
                  _inputField('father_name', 'Father Name', Iconsax.profile_2user),
                  _dropdownField('semester_year', 'Semester Year', Iconsax.book),

                  const SizedBox(height: 16),

                  // Challan Details
                  _sectionTitle("Challan Details", Iconsax.document_text),
                  const Divider(height: 16),
                  _inputField('challan_no', 'Challan No', Iconsax.hashtag),
                  _datePickerField('submission_date', 'Submission Date', Iconsax.calendar),
                  _inputField('fees_amount', 'Fees Amount', Iconsax.money, isNumber: true),

                  const SizedBox(height: 16),

                  // Image Picker
                  _imagePickerCard(),
                ],
              ),
            ),
          ),
        ),
      ),

      // ---- Fixed Submit Button ----
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 650),
          color: Colors.transparent,
          child:
              controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                    icon: const Icon(Iconsax.document_upload),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        controller.uploadChallan(challanData);
                      }
                    },
                    label: const Text("Submit", style: TextStyle(fontSize: 16)),
                  ),
        ),
      ),
    );
  }

  // Section Title
  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey.shade700, size: 20),
        const SizedBox(width: 6),
        Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.blueGrey.shade700)),
      ],
    );
  }

  // Input Field
  Widget _inputField(String key, String label, IconData icon, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        onSaved: (value) => challanData[key] = value!.trim(),
        validator: (value) => (value == null || value.trim().isEmpty) ? 'Required' : null,
      ),
    );
  }

  // Dropdown Field
  Widget _dropdownField(String key, String label, IconData icon) {
    String? selectedValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: StatefulBuilder(
        builder: (context, setState) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon, size: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            items: semesterOptions.map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt))).toList(),
            value: selectedValue,
            onChanged: (value) => setState(() => selectedValue = value),
            onSaved: (value) => challanData[key] = value!,
            validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
          );
        },
      ),
    );
  }

  // Date Picker Field
  Widget _datePickerField(String key, String label, IconData icon) {
    final tController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            final formatted = DateFormat('yyyy-MM-dd').format(picked);
            tController.text = formatted;
            challanData[key] = formatted;
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: tController,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon, size: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
          ),
        ),
      ),
    );
  }

  // Image Picker Card
  Widget _imagePickerCard() {
    return Obx(() {
      final file = controller.pickedImage.value;

      return Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Attach Challan Image (PNG/JPG/WEBP, max 5MB)', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: controller.pickImage,
                    label: Text(file == null ? 'Pick Image' : 'Change Image'),
                  ),
                  const SizedBox(width: 8),
                  if (file != null)
                    TextButton.icon(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: controller.clearPickedImage,
                      label: const Text('Remove'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (file != null && file.bytes != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(file.bytes!, height: 180, fit: BoxFit.cover),
                ),
              if (file != null) ...[
                const SizedBox(height: 6),
                Text('Selected: ${file.name}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ],
          ),
        ),
      );
    });
  }
}
