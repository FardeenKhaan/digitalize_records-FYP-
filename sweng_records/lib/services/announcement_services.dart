import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

// class AnnouncementService {
//   final box = GetStorage();
//   final baseUrl = 'http://localhost:3000/api/announcements';

//   Map<String, String> get headers => {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer ${box.read('token')}',
//   };

//   Future<List<dynamic>> fetchAnnouncements() async {
//     final res = await http.get(Uri.parse(baseUrl), headers: headers);
//     if (res.statusCode == 200) {
//       return json.decode(res.body);
//     } else {
//       throw Exception('Failed to load announcements');
//     }
//   }

//   Future<Map<String, dynamic>> postAnnouncement(
//     String title,
//     String message,
//   ) async {
//     final res = await http.post(
//       Uri.parse('$baseUrl/create'),
//       headers: headers,
//       body: json.encode({'title': title, 'message': message}),
//     );

//     return json.decode(res.body);
//   }
// }

class AnnouncementService {
  final box = GetStorage();
  final baseUrl = 'http://localhost:3000/api/announcements';

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${box.read('token')}',
  };

  Future<List<dynamic>> fetchAnnouncements({String? date}) async {
    final uri =
        date != null ? Uri.parse("$baseUrl?date=$date") : Uri.parse(baseUrl);
    final res = await http.get(uri, headers: headers);
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Failed to load announcements");
  }

  Future<void> postAnnouncement(String title, String message) async {
    final res = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: headers,
      body: json.encode({'title': title, 'message': message}),
    );
    if (res.statusCode != 200) throw Exception("Failed to post");
  }

  Future<void> updateAnnouncement(int id, String title, String message) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
      body: json.encode({'title': title, 'message': message}),
    );
    if (res.statusCode != 200) throw Exception("Update failed");
  }

  Future<void> deleteAnnouncement(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'), headers: headers);
    if (res.statusCode != 200) throw Exception("Delete failed");
  }
}
