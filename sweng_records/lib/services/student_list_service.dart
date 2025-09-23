import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sweng_records/models/student_model.dart';

class StudentListService {
  final box = GetStorage();
  final String baseUrl = 'http://localhost:3000/api/rollnumbers';

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${box.read('token')}',
  };

  Future<List<Student>> fetchStudents() async {
    final res = await http.get(Uri.parse(baseUrl), headers: headers);
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((json) => Student.fromJson(json)).toList();
    }
    throw Exception('Failed to load students');
  }

  Future<void> createStudent(
    String name,
    String fatherName,
    String rollNumber,
    String section,
  ) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode({
        'name': name,
        'father_name': fatherName,
        'roll_number': rollNumber,
        'section': section,
      }),
    );
    if (res.statusCode != 200) throw Exception('Failed to create student');
  }

  Future<void> updateStudent(
    int id,
    String name,
    String fatherName,
    String rollNumber,
    String section,
  ) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
      body: json.encode({
        'name': name,
        'father_name': fatherName,
        'roll_number': rollNumber,
        'section': section,
      }),
    );
    if (res.statusCode != 200) throw Exception('Failed to update student');
  }

  Future<void> deleteStudent(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'), headers: headers);
    if (res.statusCode != 200) throw Exception('Failed to delete student');
  }
}
