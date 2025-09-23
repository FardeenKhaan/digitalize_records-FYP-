import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweng_records/controllers/announcement_controller.dart';
import 'package:sweng_records/controllers/authController.dart';

// class StudentAnnouncementsScreen extends StatelessWidget {
//   final AuthController authController = Get.put(AuthController());
//   final controller = Get.put(AnnouncementController());

//   @override
//   Widget build(BuildContext context) {
//     controller.loadAnnouncements();

//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(
//           () => Text(
//             'Welcome! ${authController.userName.value} to Announcement\'s screen',
//             style: GoogleFonts.playfair(color: Colors.grey.shade700, fontSize: 25, fontWeight: FontWeight.bold),
//           ),
//         ),
//         actions: [
//           IconButton(
//             tooltip: 'See Calendar Events',
//             icon: Icon(Icons.calendar_month),
//             onPressed: () async {
//               final selected = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2024, 1),
//                 lastDate: DateTime(2026),
//               );

//               if (selected != null) {
//                 controller.selectedDate.value = selected;
//                 controller.loadAnnouncements();
//               }
//             },
//           ),
//           IconButton(
//             tooltip: 'clear',
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               controller.selectedDate.value = null;
//               controller.loadAnnouncements();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black, width: 3),
//               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
//               color: const Color.fromARGB(255, 9, 71, 121),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(30),
//                 child: Image(image: AssetImage('assets/attention.jfif'), width: double.infinity, height: 300),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               if (controller.announcements.isEmpty) {
//                 return Center(child: Text("No announcements found."));
//               }

//               return ListView.builder(
//                 padding: EdgeInsets.all(12),
//                 itemCount: controller.announcements.length,
//                 itemBuilder: (context, index) {
//                   final a = controller.announcements[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(a.title, style: TextStyle(fontWeight: FontWeight.bold)),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(a.message),
//                           SizedBox(height: 6),
//                           Text("By ${a.postedBy} on ${a.createdAt}", style: TextStyle(fontSize: 12)),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

class StudentAnnouncementsScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final controller = Get.put(AnnouncementController());

  @override
  Widget build(BuildContext context) {
    controller.loadAnnouncements();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [_buildSliverAppBar(context), _buildDateFilterSection(), _buildAnnouncementsSection()],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.blueGrey[700],
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey[700]!, Colors.blueGrey[900]!],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10), // Space for app bar
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Welcome Message
                        Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                            ),
                            child: Text(
                              'Welcome, ${authController.userName.value}!',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Announcement Icon and Title
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.campaign, size: 48, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                'Announcements',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Stay updated with latest news',
                                style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9), fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // title: Text('Announcements', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      actions: [
        IconButton(
          tooltip: 'Filter by Date',
          icon: Icon(Icons.calendar_today, color: Colors.white),
          onPressed: () => _showDateFilterDialog(context),
        ),
        Obx(
          () =>
              controller.selectedDate.value != null
                  ? IconButton(
                    tooltip: 'Clear Filter',
                    icon: Icon(Icons.filter_list_off, color: Colors.white),
                    onPressed: () {
                      controller.selectedDate.value = null;
                      controller.loadAnnouncements();
                      Get.snackbar(
                        'Filter Cleared',
                        'Showing all announcements',
                        backgroundColor: Colors.green[100],
                        colorText: Colors.green[700],
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        duration: Duration(seconds: 2),
                      );
                    },
                  )
                  : SizedBox(),
        ),
      ],
    );
  }

  Widget _buildDateFilterSection() {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (controller.selectedDate.value == null) return SizedBox.shrink();

        return Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.filter_list, color: Colors.blue[700]),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filtered by Date', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue[700])),
                    Text(
                      _formatDate(controller.selectedDate.value!),
                      style: TextStyle(color: Colors.blue[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.blue[700]),
                onPressed: () {
                  controller.selectedDate.value = null;
                  controller.loadAnnouncements();
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAnnouncementsSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return _buildLoadingState();
          }

          if (controller.announcements.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Header
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.announcement, color: Colors.blue[700]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.announcements.length} Announcements',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            controller.selectedDate.value != null
                                ? 'For ${_formatDate(controller.selectedDate.value!)}'
                                : 'All announcements',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Announcements List
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.announcements.length,
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final announcement = controller.announcements[index];
                  return _buildAnnouncementCard(announcement, index);
                },
              ),

              SizedBox(height: 80), // Space for FAB
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!)),
            SizedBox(height: 16),
            Text('Loading announcements...', style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.announcement_outlined, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No Announcements Found',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              controller.selectedDate.value != null
                  ? 'No announcements for the selected date.\nTry clearing the filter or selecting a different date.'
                  : 'There are no announcements to display at the moment.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            if (controller.selectedDate.value != null) ...[
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  controller.selectedDate.value = null;
                  controller.loadAnnouncements();
                },
                icon: Icon(Icons.clear_all),
                label: Text('Clear Filter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(dynamic announcement, int index) {
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.red, Colors.teal];
    final color = colors[index % colors.length];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        // child: InkWell(
        //   borderRadius: BorderRadius.circular(16),
        //   onTap: () => _showAnnouncementDetails(announcement),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with priority indicator
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.person, size: 14, color: Colors.grey[500]),
                            SizedBox(width: 4),
                            Text(
                              'By ${announcement.postedBy}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      _getTimeAgo(announcement.createdAt),
                      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Message content
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
                child: Text(
                  announcement.message,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.4),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 12),

              // Footer with date and actions
              Row(
                children: [
                  Icon(Icons.schedule, size: 14, color: Colors.grey[500]),
                  SizedBox(width: 4),
                  Text(
                    _formatDateTime(announcement.createdAt),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Spacer(),
                  TextButton.icon(
                    onPressed: () => _showAnnouncementDetails(announcement),
                    icon: Icon(Icons.visibility, size: 16),
                    label: Text('View Details'),
                    style: TextButton.styleFrom(
                      foregroundColor: color,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Obx(
      () => AnimatedScale(
        scale: controller.announcements.isEmpty ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: FloatingActionButton.extended(
          onPressed: () {
            controller.loadAnnouncements();
            Get.snackbar(
              'Refreshed',
              'Announcements updated successfully',
              // backgroundColor: Colors.green[100],
              // colorText: Colors.green[700],
              icon: Icon(Icons.refresh),
              duration: Duration(seconds: 2),
            );
          },
          icon: Icon(Icons.refresh),
          label: Text('Refresh'),
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  void _showDateFilterDialog(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: Colors.blue[700]!, onSurface: Colors.grey[800]!)),
          child: child!,
        );
      },
    );

    if (selected != null) {
      controller.selectedDate.value = selected;
      controller.loadAnnouncements();
      Get.snackbar(
        'Date Filter Applied',
        'Showing announcements for ${_formatDate(selected)}',
        backgroundColor: Colors.blue[100],
        colorText: Colors.blue[700],
        icon: Icon(Icons.filter_list, color: Colors.blue),
        duration: Duration(seconds: 3),
      );
    }
  }

  void _showAnnouncementDetails(dynamic announcement) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            SizedBox(height: 20),

            // Title
            Text(
              announcement.title,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            SizedBox(height: 12),

            // Author and date info
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.blue[700], size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Posted by ${announcement.postedBy}',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue[700]),
                        ),
                        Text(
                          _formatDateTime(announcement.createdAt),
                          style: TextStyle(color: Colors.blue[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Message content
            Text('Message', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700])),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(announcement.message, style: TextStyle(color: Colors.grey[700], fontSize: 15, height: 1.5)),
            ),

            SizedBox(height: 20),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: Text('Close'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(Get.context!).viewInsets.bottom),
          ],
        ),
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatDateTime(String dateTimeStr) {
    try {
      final date = DateTime.parse(dateTimeStr);
      return _formatDate(date);
    } catch (e) {
      return dateTimeStr;
    }
  }

  String _getTimeAgo(String dateTimeStr) {
    try {
      final date = DateTime.parse(dateTimeStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Recent';
    }
  }
}
