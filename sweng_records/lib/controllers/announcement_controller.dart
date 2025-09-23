import 'package:get/get.dart';
import 'package:sweng_records/services/announcement_services.dart';
import '../models/announcement_model.dart';

class AnnouncementController extends GetxController {
  final AnnouncementService _service = AnnouncementService();

  var announcements = <Announcement>[].obs;
  var isLoading = false.obs;
  var selectedDate = Rxn<DateTime>();

  Future<void> loadAnnouncements() async {
    isLoading.value = true;
    try {
      final data = await _service.fetchAnnouncements(
        date: selectedDate.value?.toIso8601String().split("T")[0],
      );
      announcements.value =
          data.map((json) => Announcement.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch announcements");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postAnnouncement(String title, String message) async {
    await _service.postAnnouncement(title, message);
    await loadAnnouncements();
  }

  Future<void> updateAnnouncement(int id, String title, String message) async {
    await _service.updateAnnouncement(id, title, message);
    await loadAnnouncements();
  }

  Future<void> deleteAnnouncement(int id) async {
    await _service.deleteAnnouncement(id);
    await loadAnnouncements();
  }
}
