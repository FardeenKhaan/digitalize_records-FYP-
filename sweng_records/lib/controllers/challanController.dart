// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:sweng_records/services/challan_services.dart';
// import 'package:sweng_records/utils/pdf_generator.dart';

// class ChallanController extends GetxController {
//   final ChallanService _challanService = ChallanService();
//   var isExporting = false.obs;

//   var isLoading = false.obs;

//   // Raw data for clerk
//   var allChallans = [].obs;

//   // Filtered view (search + filter)
//   var filteredChallans = [].obs;

//   // Student data
//   var studentChallans = [].obs;

//   // State for filtering/searching
//   var statusFilter = ''.obs; // '', 'pending', 'verified', 'rejected'
//   var searchRollNo = ''.obs;

//   // var selectedSemester = RxnInt(); // nullable int
//   // var selectedDate = Rxn<DateTime>(); // date

//   @override
//   void onInit() {
//     super.onInit();
//     ever(statusFilter, (_) => applyFilters());
//     ever(searchRollNo, (_) => applyFilters());
//   }

//   // Upload Challan
//   Future<void> uploadChallan(Map<String, dynamic> data) async {
//     isLoading.value = true;
//     try {
//       final response = await _challanService.uploadChallan(data);
//       Get.snackbar('Status', response['message']);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to upload challan');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Student Challans
//   Future<void> fetchStudentChallans() async {
//     isLoading.value = true;
//     try {
//       studentChallans.value = await _challanService.getStudentChallans();
//     } catch (_) {
//       Get.snackbar('Error', 'Failed to load your challans');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Clerk: All Challans
//   Future<void> fetchAllChallans() async {
//     isLoading.value = true;
//     try {
//       // allChallans.clear(); // Clear list before fetch
//       final data = await _challanService.getAllChallans();
//       allChallans.value = data;
//       applyFilters();
//     } catch (_) {
//       Get.snackbar('Error', 'Failed to load all challans');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Clerk: Pending Challans (only)
//   Future<void> fetchPendingChallans() async {
//     isLoading.value = true;
//     try {
//       final data = await _challanService.getPendingChallans();
//       allChallans.value = data;
//       // allChallans.clear(); // Clear list before fetch
//       applyFilters();
//     } catch (e) {
//       Get.snackbar('Error', 'Could not load challans');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Update Challan Status
//   Future<void> updateChallan(int id, String status, String remarks) async {
//     try {
//       final response = await _challanService.updateChallanStatus(id, status, remarks);
//       Get.snackbar('Status', response['message']);
//       // await fetchAllChallans(); // Refresh full list
//       await fetchPendingChallans(); // Only reload pending
//     } catch (e) {
//       Get.snackbar('Error', 'Update failed');
//     }
//   }

//   // 🧠 Apply search + filter
//   void applyFilters() {
//     final status = statusFilter.value.trim();
//     final roll = searchRollNo.value.trim().toLowerCase();

//     // filteredChallans.clear(); // Clear before applying filters

//     filteredChallans.value =
//         allChallans.where((challan) {
//           final matchesStatus = status.isEmpty || challan['status'] == status;
//           final matchesRoll = roll.isEmpty || challan['roll_no'].toString().toLowerCase().contains(roll);
//           return matchesStatus && matchesRoll;
//         }).toList();
//   }

//   Future<void> exportToPDF() async {
//     isExporting.value = true;
//     try {
//       await PdfGenerator.generateChallanPDF(filteredChallans);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to generate PDF');
//     } finally {
//       isExporting.value = false;
//     }
//   }
// }

// controllers/challanController.dart
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sweng_records/services/challan_services.dart';
import 'package:sweng_records/utils/pdf_generator.dart';

class ChallanController extends GetxController {
  final ChallanService _challanService = ChallanService();
  var isExporting = false.obs;
  var isLoading = false.obs;

  // clerk lists
  var allChallans = [].obs;
  var filteredChallans = [].obs;

  // student
  var studentChallans = [].obs;

  // filters
  var statusFilter = ''.obs;
  var searchRollNo = ''.obs;

  // picked image for upload
  final pickedImage = Rxn<PlatformFile>();

  @override
  void onInit() {
    super.onInit();
    ever(statusFilter, (_) => applyFilters());
    ever(searchRollNo, (_) => applyFilters());
  }

  // ---------- Image pick/clear ----------
  Future<void> pickImage() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // works on web + mobile
      allowMultiple: false,
    );
    if (res != null && res.files.isNotEmpty) {
      pickedImage.value = res.files.single;
    }
  }

  void clearPickedImage() => pickedImage.value = null;

  // ---------- Upload (multipart) ----------
  Future<void> uploadChallan(Map<String, dynamic> data) async {
    if (pickedImage.value == null) {
      Get.snackbar('Image required', 'Please attach a challan image.');
      return;
    }

    isLoading.value = true;
    try {
      // Convert to Map<String, String> for fields
      final fields = data.map((k, v) => MapEntry(k, v.toString()));
      final resp = await _challanService.uploadChallanMultipart(fields, pickedImage.value!);
      Get.snackbar('Status', resp['message'] ?? 'Uploaded');
      clearPickedImage();
      await fetchStudentChallans(); // refresh student's list
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload challan');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------- Student ----------
  Future<void> fetchStudentChallans() async {
    isLoading.value = true;
    try {
      studentChallans.value = await _challanService.getStudentChallans();
    } catch (_) {
      Get.snackbar('Error', 'Failed to load your challans');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------- Clerk ----------
  Future<void> fetchAllChallans() async {
    isLoading.value = true;
    try {
      final data = await _challanService.getAllChallans();
      allChallans.value = data;
      applyFilters();
    } catch (_) {
      Get.snackbar('Error', 'Failed to load all challans');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPendingChallans() async {
    isLoading.value = true;
    try {
      final data = await _challanService.getPendingChallans();
      allChallans.value = data;
      applyFilters();
    } catch (e) {
      Get.snackbar('Error', 'Could not load challans');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateChallan(int id, String status, String remarks) async {
    try {
      final response = await _challanService.updateChallanStatus(id, status, remarks);
      Get.snackbar('Status', response['message']);
      await fetchPendingChallans(); // keep this screen in sync
    } catch (e) {
      Get.snackbar('Error', 'Update failed');
    }
  }

  // ---------- Filter/Search ----------
  void applyFilters() {
    final status = statusFilter.value.trim();
    final roll = searchRollNo.value.trim().toLowerCase();

    filteredChallans.value =
        allChallans.where((c) {
          final matchesStatus = status.isEmpty || c['status'] == status;
          final matchesRoll = roll.isEmpty || (c['roll_no'] ?? '').toString().toLowerCase().contains(roll);
          return matchesStatus && matchesRoll;
        }).toList();
  }

  // ---------- Export ----------
  Future<void> exportToPDF() async {
    isExporting.value = true;
    try {
      await PdfGenerator.generateChallanPDF(filteredChallans);
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate PDF');
    } finally {
      isExporting.value = false;
    }
  }
}
