import 'package:get/get.dart';
import '../services/marks_service.dart';

class MarksController extends GetxController {
  final service = MarksService();

  var isLoading = false.obs;
  var marksList = <dynamic>[].obs;

  // ---------- Student ----------
  Future<void> loadMyMarks() async {
    try {
      isLoading.value = true;
      marksList.assignAll(await service.getMyMarks());
    } catch (e) {
      marksList.clear();
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ---------- Clerk ----------
  Future<void> loadAllMarks() async {
    try {
      isLoading.value = true;
      marksList.assignAll(await service.getAllMarks());
    } catch (e) {
      marksList.clear();
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchByRollNo(String rollNo) async {
    try {
      isLoading.value = true;
      marksList.assignAll(await service.getMarksByRollNo(rollNo));
    } catch (e) {
      marksList.clear();
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addMarks(Map<String, dynamic> data) async {
    try {
      await service.addMarks(data);
      Get.snackbar("Success", "Marks added successfully");
      await loadAllMarks();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateMarks(int marksId, Map<String, dynamic> data) async {
    try {
      await service.updateMarks(marksId, data);
      Get.snackbar("Success", "Marks updated successfully");
      await loadAllMarks();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteMarks(int marksId) async {
    try {
      await service.deleteMarks(marksId);
      Get.snackbar("Deleted", "Marks deleted successfully");
      await loadAllMarks();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
