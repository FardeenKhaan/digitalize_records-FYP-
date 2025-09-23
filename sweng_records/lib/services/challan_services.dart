// // services/challan_service.dart
// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// class ChallanService {
//   final String baseUrl = 'http://localhost:3000/api/challans';
//   final _storage = GetStorage();

//   Map<String, String> get headers => {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer ${_storage.read('token')}',
//   };

//   Future<Map<String, dynamic>> uploadChallan(Map<String, dynamic> data) async {
//     final response = await http.post(Uri.parse('$baseUrl/upload'), headers: headers, body: jsonEncode(data));
//     return jsonDecode(response.body);
//   }

//   Future<List<dynamic>> getPendingChallans() async {
//     final response = await http.get(Uri.parse('$baseUrl/pending'), headers: headers);
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch pending challans');
//     }
//   }

//   Future<Map<String, dynamic>> updateChallanStatus(int challanId, String status, String remarks) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/status/$challanId'),
//       headers: headers,
//       body: jsonEncode({'status': status, 'remarks': remarks}),
//     );
//     return jsonDecode(response.body);
//   }

//   Future<List<dynamic>> getStudentChallans() async {
//     final response = await http.get(Uri.parse('$baseUrl/my'), headers: headers);
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load student challans');
//     }
//   }

//   Future<List<dynamic>> getAllChallans() async {
//     final response = await http.get(Uri.parse('$baseUrl/all'), headers: headers);
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load all challans');
//     }
//   }
// }

// services/challan_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';

class ChallanService {
  final String baseUrl = 'http://localhost:3000/api/challans';
  final _storage = GetStorage();

  Map<String, String> get _authOnlyHeaders => {
    // DO NOT set Content-Type here for multipart; http sets boundary automatically
    'Authorization': 'Bearer ${_storage.read('token')}',
  };

  /// Upload challan with required image (works on web & mobile)
  Future<Map<String, dynamic>> uploadChallanMultipart(Map<String, String> fields, PlatformFile imageFile) async {
    final uri = Uri.parse('$baseUrl/upload');
    final request = http.MultipartRequest('POST', uri);

    // headers
    request.headers.addAll(_authOnlyHeaders);

    // fields
    fields.forEach((k, v) => request.fields[k] = v);

    // file
    http.MultipartFile filePart;

    // Always prefer bytes so it works on web too
    final Uint8List? bytes = imageFile.bytes;
    final String fileName = imageFile.name;
    final String? path = imageFile.path;

    if (bytes != null) {
      filePart = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: fileName,
        contentType: _guessMediaType(fileName),
      );
    } else if (!kIsWeb && path != null) {
      filePart = await http.MultipartFile.fromPath('image', path, contentType: _guessMediaType(fileName));
    } else {
      throw Exception('No image bytes/path found for upload.');
    }

    request.files.add(filePart);

    final streamed = await request.send();
    final bodyStr = await streamed.stream.bytesToString();

    // 201 from your API on success
    final body = jsonDecode(bodyStr.isEmpty ? '{}' : bodyStr);
    if (streamed.statusCode == 201 || streamed.statusCode == 200) {
      return body;
    }
    throw Exception(body['message'] ?? 'Upload failed (${streamed.statusCode})');
  }

  // ------- READ endpoints (unchanged) -------

  Future<List<dynamic>> getPendingChallans() async {
    final response = await http.get(Uri.parse('$baseUrl/pending'), headers: _authOnlyHeaders);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to fetch pending challans');
  }

  Future<Map<String, dynamic>> updateChallanStatus(int challanId, String status, String remarks) async {
    final response = await http.put(
      Uri.parse('$baseUrl/status/$challanId'),
      headers: {..._authOnlyHeaders, 'Content-Type': 'application/json'},
      body: jsonEncode({'status': status, 'remarks': remarks}),
    );
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getStudentChallans() async {
    final response = await http.get(Uri.parse('$baseUrl/my'), headers: _authOnlyHeaders);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load student challans');
  }

  Future<List<dynamic>> getAllChallans() async {
    final response = await http.get(Uri.parse('$baseUrl/all'), headers: _authOnlyHeaders);
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to load all challans');
  }

  // ------------ helpers ------------
  MediaType _guessMediaType(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return MediaType('image', 'png');
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) {
      return MediaType('image', 'jpeg');
    }
    if (lower.endsWith('.webp')) return MediaType('image', 'webp');
    // default
    return MediaType('application', 'octet-stream');
  }
}
