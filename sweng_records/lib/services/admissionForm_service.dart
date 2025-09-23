import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// class AdmissionFormService {
//   final String baseUrl = 'http://localhost:3000/api/forms';
//   final _storage = GetStorage();

//   Map<String, String> get _authHeaders => {
//     'Authorization': 'Bearer ${_storage.read('token')}',
//     'Content-Type': 'application/json',
//   };

//   // Student: Submit form
//   Future<Map<String, dynamic>> submitForm(Map<String, dynamic> data) async {
//     final response = await http.post(Uri.parse('$baseUrl/submit'), headers: _authHeaders, body: jsonEncode(data));
//     final body = jsonDecode(response.body);
//     if (response.statusCode == 201) return body;
//     throw Exception(body['message'] ?? 'Failed to submit form');
//   }

//   // Student: View own form
//   Future<Map<String, dynamic>> getMyForm() async {
//     final response = await http.get(Uri.parse('$baseUrl/my'), headers: _authHeaders);
//     final body = jsonDecode(response.body);
//     if (response.statusCode == 200) return body;
//     throw Exception(body['message'] ?? 'Failed to fetch form');
//   }
// }

class AdmissionFormService {
  final String baseUrl = 'http://localhost:3000/api/forms';
  final _storage = GetStorage();

  Map<String, String> get _authHeaders => {
    'Authorization': 'Bearer ${_storage.read('token')}',
    'Content-Type': 'application/json',
  };

  // ---------- Student APIs ----------
  Future<Map<String, dynamic>> submitForm(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse('$baseUrl/submit'), headers: _authHeaders, body: jsonEncode(data));
    final body = jsonDecode(response.body);
    if (response.statusCode == 201) return body;
    throw Exception(body['message'] ?? 'Failed to submit form');
  }

  Future<Map<String, dynamic>> getMyForm() async {
    final response = await http.get(Uri.parse('$baseUrl/my'), headers: _authHeaders);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) return body;
    throw Exception(body['message'] ?? 'Failed to fetch form');
  }

  // ---------- Clerk APIs ----------
  Future<List<dynamic>> getAllForms() async {
    final response = await http.get(Uri.parse('$baseUrl/all'), headers: _authHeaders);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) return body;
    throw Exception(body['message'] ?? 'Failed to fetch forms');
  }

  Future<void> updateForm(int formId, Map<String, dynamic> data) async {
    final response = await http.put(Uri.parse('$baseUrl/$formId'), headers: _authHeaders, body: jsonEncode(data));
    final body = jsonDecode(response.body);
    if (response.statusCode != 200) throw Exception(body['message'] ?? 'Update failed');
  }

  Future<void> deleteForm(int formId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$formId'), headers: _authHeaders);
    final body = jsonDecode(response.body);
    if (response.statusCode != 200) throw Exception(body['message'] ?? 'Delete failed');
  }
}
