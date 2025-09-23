import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// class MarksService {
//   final String baseUrl = 'http://localhost:3000/api/marks';
//   final _storage = GetStorage();

//   Map<String, String> get _authHeaders => {
//         'Authorization': 'Bearer ${_storage.read('token')}',
//         'Content-Type': 'application/json',
//       };

//   // ---------- Student ----------
//   Future<List<dynamic>> getMyMarks() async {
//     final response = await http.get(Uri.parse('$baseUrl/my'), headers: _authHeaders);
//     if (response.statusCode == 200) return jsonDecode(response.body);
//     throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to fetch marks');
//   }

//   // ---------- Clerk ----------
//   Future<List<dynamic>> getAllMarks() async {
//     final response = await http.get(Uri.parse('$baseUrl/all'), headers: _authHeaders);
//     if (response.statusCode == 200) return jsonDecode(response.body);
//     throw Exception('Failed to fetch all marks');
//   }

//   Future<List<dynamic>> getMarksByRollNo(String rollNo) async {
//     final response = await http.get(Uri.parse('$baseUrl/roll/$rollNo'), headers: _authHeaders);
//     if (response.statusCode == 200) return jsonDecode(response.body);
//     throw Exception('No marks found for roll number $rollNo');
//   }

//   Future<void> addMarks(Map<String, dynamic> data) async {
//     final response = await http.post(Uri.parse('$baseUrl/add'), headers: _authHeaders, body: jsonEncode(data));
//     if (response.statusCode != 201) throw Exception(jsonDecode(response.body)['message']);
//   }

//   Future<void> updateMarks(int marksId, Map<String, dynamic> data) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/update/$marksId'),
//       headers: _authHeaders,
//       body: jsonEncode(data),
//     );
//     if (response.statusCode != 200) throw Exception(jsonDecode(response.body)['message']);
//   }

//   Future<void> deleteMarks(int marksId) async {
//     final response = await http.delete(Uri.parse('$baseUrl/delete/$marksId'), headers: _authHeaders);
//     if (response.statusCode != 200) throw Exception(jsonDecode(response.body)['message']);
//   }
// }

class MarksService {
  final String baseUrl = 'http://localhost:3000/api/marks';
  final _storage = GetStorage();

  Map<String, String> get _authHeaders => {
    'Authorization': 'Bearer ${_storage.read('token')}',
    'Content-Type': 'application/json',
  };

  // ---------- Student ----------
  Future<List<dynamic>> getMyMarks() async {
    final response = await http.get(Uri.parse('$baseUrl/my'), headers: _authHeaders);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to fetch marks');
  }

  // ---------- Clerk ----------
  Future<List<dynamic>> getAllMarks() async {
    final response = await http.get(Uri.parse('$baseUrl/all'), headers: _authHeaders);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to fetch all marks');
  }

  Future<List<dynamic>> getMarksByRollNo(String rollNo) async {
    final response = await http.get(Uri.parse('$baseUrl/roll/$rollNo'), headers: _authHeaders);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('No marks found for roll number $rollNo');
  }

  Future<void> addMarks(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse('$baseUrl/add'), headers: _authHeaders, body: jsonEncode(data));
    if (response.statusCode != 201) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> updateMarks(int marksId, Map<String, dynamic> data) async {
    final response = await http.put(Uri.parse('$baseUrl/$marksId'), headers: _authHeaders, body: jsonEncode(data));

    if (response.statusCode == 200) {
      // optional: parse message if needed
      return;
    }

    // ✅ protect against non-JSON errors
    try {
      final decoded = jsonDecode(response.body);
      throw Exception(decoded['message'] ?? 'Failed to update marks');
    } catch (_) {
      throw Exception('Failed to update marks: ${response.body}');
    }
  }

  Future<void> deleteMarks(int marksId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$marksId'), headers: _authHeaders);

    if (response.statusCode == 200) {
      return;
    }

    // ✅ protect against non-JSON errors
    try {
      final decoded = jsonDecode(response.body);
      throw Exception(decoded['message'] ?? 'Failed to delete marks');
    } catch (_) {
      throw Exception('Failed to delete marks: ${response.body}');
    }
  }
}
