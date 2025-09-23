// // controllers/clerk_form_controller.dart
// import 'package:get/get.dart';
// import 'package:sweng_records/services/admissionForm_service.dart';

// class ClerkFormController extends GetxController {
//   final service = AdmissionFormService();

//   var isLoading = false.obs;
//   var forms = <Map<String, dynamic>>[].obs;

//   Future<void> loadAllForms() async {
//     try {
//       isLoading.value = true;
//       final data = await service.getAllForms();
//       forms.assignAll(data.cast<Map<String, dynamic>>());
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> updateForm(int formId, Map<String, dynamic> updatedData) async {
//     try {
//       await service.updateForm(formId, updatedData);
//       Get.snackbar("Success", "Form updated successfully");
//       await loadAllForms();
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }

//   Future<void> deleteForm(int formId) async {
//     try {
//       await service.deleteForm(formId);
//       Get.snackbar("Deleted", "Form deleted successfully");
//       forms.removeWhere((f) => f['id'] == formId);
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }
// }

// controllers/clerk_form_controller.dart
import 'package:get/get.dart';
import 'package:sweng_records/services/admissionForm_service.dart';

class ClerkFormController extends GetxController {
  final service = AdmissionFormService();

  var isLoading = false.obs;
  var forms = <Map<String, dynamic>>[].obs;
  var filteredForms = <Map<String, dynamic>>[].obs;
  var searchText = ''.obs;

  Future<void> loadAllForms() async {
    try {
      isLoading.value = true;
      final data = await service.getAllForms();
      forms.assignAll(data.cast<Map<String, dynamic>>());
      _applyFilter();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setSearchText(String text) {
    searchText.value = text;
    _applyFilter();
  }

  void _applyFilter() {
    if (searchText.value.isEmpty) {
      filteredForms.assignAll(forms);
    } else {
      filteredForms.assignAll(forms.where((form) => (form['roll_no'] ?? '').toString().contains(searchText.value)));
    }
  }

  Future<void> updateForm(int formId, Map<String, dynamic> updatedData) async {
    try {
      await service.updateForm(formId, updatedData);
      Get.snackbar("Success", "Form updated successfully");
      await loadAllForms();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteForm(int formId) async {
    try {
      await service.deleteForm(formId);
      Get.snackbar("Deleted", "Form deleted successfully");
      forms.removeWhere((f) => f['id'] == formId);
      _applyFilter();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
