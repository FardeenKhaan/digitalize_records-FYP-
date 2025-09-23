// controllers/admission_form_controller.dart
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sweng_records/services/admissionForm_service.dart';

class AdmissionFormController extends GetxController {
  final service = AdmissionFormService();

  var isLoading = false.obs;
  var myForm = <String, dynamic>{}.obs;

  Future<void> loadMyForm() async {
    try {
      isLoading.value = true;
      final data = await service.getMyForm();
      myForm.assignAll(data);
    } catch (e) {
      myForm.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitForm(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      await service.submitForm(data);
      Get.snackbar("Success", "Form submitted successfully");
      await loadMyForm(); // refresh
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
