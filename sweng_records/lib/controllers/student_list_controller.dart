import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweng_records/models/student_model.dart';
import 'package:sweng_records/services/student_list_service.dart';

class StudentListController extends GetxController {
  final StudentListService _service = StudentListService();

  var students = <Student>[].obs;
  var isLoading = false.obs;

  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final rollNumberController = TextEditingController();
  final sectionController = TextEditingController();

  Future<void> loadStudents() async {
    isLoading.value = true;
    try {
      students.value = await _service.fetchStudents();
    } catch (_) {
      Get.snackbar('Error', 'Could not load student list');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createStudent() async {
    await _service.createStudent(
      nameController.text,
      fatherNameController.text,
      rollNumberController.text,
      sectionController.text,
    );
    clearForm();
    await loadStudents();
  }

  Future<void> updateStudent(int id) async {
    await _service.updateStudent(
      id,
      nameController.text,
      fatherNameController.text,
      rollNumberController.text,
      sectionController.text,
    );
    clearForm();
    await loadStudents();
  }

  Future<void> deleteStudent(int id) async {
    await _service.deleteStudent(id);
    await loadStudents();
  }

  void fillForm(Student student) {
    nameController.text = student.name;
    fatherNameController.text = student.fatherName;
    rollNumberController.text = student.rollNumber;
    sectionController.text = student.section;
  }

  void clearForm() {
    nameController.clear();
    fatherNameController.clear();
    rollNumberController.clear();
    sectionController.clear();
  }
}
