import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/routes/app_routes.dart';

// class DrawerforWebApp extends StatelessWidget {
//   const DrawerforWebApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final box = GetStorage();
//     final role = box.read('role');
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   const Color.fromARGB(255, 3, 41, 105),
//                   const Color.fromARGB(255, 0, 77, 153),
//                   const Color.fromARGB(255, 21, 143, 243),
//                   const Color.fromARGB(255, 111, 176, 206),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 7,
//                     offset: Offset(3, 7), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image(
//                   image: AssetImage("assets/dept_cover.jpg"),
//                   fit: BoxFit.fill,
//                   // color: Color.fromARGB(255, 3, 41, 105),
//                 ),
//               ),
//             ),
//           ),

//           ListTile(
//             leading: Icon(Iconsax.home),
//             title: Text('Dashboard'),
//             onTap: () {
//               // final box = GetStorage();
//               // final role = box.read('role');

//               if (role == 'clerk') {
//                 Get.offAllNamed(Routes.CLERK_DASHBOARD);
//               } else if (role == 'student') {
//                 Get.offAllNamed(Routes.STUDENT_DASHBOARD);
//               } else {
//                 Get.snackbar("Error", "Unknown user role");
//               }
//             },
//           ),

//           // ListTile(
//           //   leading: Icon(Icons.document_scanner),
//           //   title: Text('Challan'),
//           //   onTap: () {
//           //     final box = GetStorage();
//           //     final role = box.read('role');

//           //     if (role == 'clerk') {
//           //       Get.toNamed(Routes.PENDING_CHALLANS);
//           //     } else if (role == 'student') {
//           //       Get.toNamed(Routes.UPLOAD_CHALLAN);
//           //     } else {
//           //       Get.snackbar("Error", "Unknown user role");
//           //     }
//           //   },
//           // ),
//           // Show Challan only if role is student
//           if (role == 'student')
//             ListTile(
//               leading: Icon(Iconsax.document),
//               title: Text('Challan'),
//               onTap: () {
//                 Get.toNamed(Routes.UPLOAD_CHALLAN);
//               },
//             ),
//           ListTile(
//             leading: Icon(Icons.view_list),
//             title: Text('Challans View'),
//             onTap: () {
//               // final box = GetStorage();
//               // final role = box.read('role');

//               if (role == 'clerk') {
//                 Get.toNamed(Routes.CLERK_ALL_CHALLANS);
//               } else if (role == 'student') {
//                 Get.toNamed(Routes.STUDENT_CHALLANS);
//               } else {
//                 Get.snackbar("Error", "Unknown user role");
//               }
//             },
//           ),
//           // if (role == 'clerk')
//           //   ListTile(
//           //     leading: Icon(Iconsax.document),
//           //     title: Text('Challan'),
//           //     onTap: () {
//           //       Get.toNamed(Routes.CLERK_ALL_CHALLANS);
//           //     },
//           //   ),
//           ListTile(
//             leading: Icon(Icons.folder_special),
//             title: Text('Admission Form'),
//             onTap: () {
//               if (role == 'clerk') {
//                 Get.toNamed(Routes.CLERK_ADMISSION_FORMS);
//               } else if (role == 'student') {
//                 Get.toNamed(Routes.ADMISSION_FORM_SUBMISSION);
//               } else {
//                 Get.snackbar("Error", "Unknown user role");
//               }
//             },
//           ),
//           if (role == 'student')
//             ListTile(
//               leading: Icon(Icons.document_scanner),
//               title: Text('Admission Form View'),
//               onTap: () {
//                 Get.toNamed(Routes.ADMISSION_FORM_VIEW);
//               },
//             ),

//           if (role == 'clerk')
//             ListTile(
//               leading: Icon(Iconsax.eye_slash),
//               title: Text('Marks View'),
//               onTap: () {
//                 Get.toNamed(Routes.clerk_marks_screen);
//               },
//             ),
//           if (role == 'clerk')
//             ListTile(
//               leading: Icon(Iconsax.document_favorite),
//               title: Text('FYP Marks Details'),
//               onTap: () {
//                 Get.toNamed(Routes.clerk_marks_detail_screen);
//               },
//             ),
//           if (role == 'clerk')
//             ListTile(
//               leading: Icon(Iconsax.edit),
//               title: Text('Edit FYP Marks'),
//               onTap: () {
//                 Get.toNamed(Routes.clerk_edit_marks_screen);
//               },
//             ),
//           if (role == 'student')
//             ListTile(
//               leading: Icon(Iconsax.mirror),
//               title: Text('FYP Marks'),
//               onTap: () {
//                 Get.toNamed(Routes.student_marks_screen);
//               },
//             ),

//           ListTile(
//             leading: Icon(Icons.campaign),
//             title: Text('Announcements'),
//             onTap: () {
//               // final box = GetStorage();
//               // final role = box.read('role');

//               if (role == 'clerk') {
//                 Get.toNamed(Routes.CLERK_ANNOUNCMENT);
//               } else if (role == 'student') {
//                 Get.toNamed(Routes.STUDENT_ANNOUNCEMENT);
//               } else {
//                 Get.snackbar("Error", "Unknown user role");
//               }
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.assignment_sharp),
//             title: Text('viewing Roll numbers'),
//             onTap: () {
//               // final box = GetStorage();
//               // final role = box.read('role');

//               if (role == 'clerk') {
//                 Get.toNamed(Routes.CLERK_Assigns_ROLLNO);
//               } else if (role == 'student') {
//                 Get.toNamed(Routes.STUDENTS_VIEW_ROLLNOLIST);
//               } else {
//                 Get.snackbar("Error", "Unknown user role");
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class DrawerforWebApp extends StatelessWidget {
  const DrawerforWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final role = box.read('role');

    return Drawer(
      child: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            // --- Drawer Header with profile ---
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 46, 57, 75),
                    const Color.fromARGB(255, 73, 99, 125),
                    const Color.fromARGB(255, 70, 94, 113),
                    const Color.fromARGB(255, 29, 45, 53),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(3, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage("assets/dept_cover.jpg"),
                    fit: BoxFit.fill,
                    // color: Color.fromARGB(255, 3, 41, 105),
                  ),
                ),
              ),
            ),

            // --- Drawer Content ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildTile(
                    icon: Iconsax.home,
                    title: "Dashboard",
                    onTap: () {
                      if (role == 'clerk') {
                        Get.offAllNamed(Routes.clerkDashboard);
                      } else if (role == 'student') {
                        Get.offAllNamed(Routes.studentDashboard);
                      }
                    },
                  ),

                  const Divider(),

                  // --- Challans Section ---
                  if (role == 'student')
                    _buildTile(
                      icon: Iconsax.document,
                      title: "Upload Challan",
                      onTap: () => Get.toNamed(Routes.uploadChallan),
                    ),
                  _buildTile(
                    icon: Icons.view_list,
                    title: "Challans View",
                    onTap: () {
                      if (role == 'clerk') {
                        Get.toNamed(Routes.clerkAllChallans);
                      } else {
                        Get.toNamed(Routes.studentChallan);
                      }
                    },
                  ),

                  const Divider(),

                  // --- Admission Section ---
                  _buildTile(
                    icon: Icons.edit_document,
                    title: "BioData Form",
                    onTap: () {
                      if (role == 'clerk') {
                        Get.toNamed(Routes.clerkAdmissionForm);
                      } else {
                        Get.toNamed(Routes.admissionFormSubmission);
                      }
                    },
                  ),
                  if (role == 'student')
                    _buildTile(
                      icon: Iconsax.note_text,
                      title: "BioData Form View",
                      onTap: () => Get.toNamed(Routes.admissionFormView),
                    ),

                  const Divider(),

                  // --- Marks Section ---
                  if (role == 'clerk') ...[
                    _buildTile(
                      icon: Iconsax.eye,
                      title: "Marks View",
                      onTap: () => Get.toNamed(Routes.clerkMarksScreen),
                    ),
                    _buildTile(
                      icon: Iconsax.document_favorite,
                      title: "FYP Marks Details",
                      onTap: () => Get.toNamed(Routes.clerk_marks_detail_screen),
                    ),
                    _buildTile(
                      icon: Iconsax.edit,
                      title: "Edit FYP Marks",
                      onTap: () => Get.toNamed(Routes.clerk_edit_marks_screen),
                    ),
                  ],
                  if (role == 'student')
                    _buildTile(
                      icon: Iconsax.medal_star,
                      title: "FYP Marks",
                      onTap: () => Get.toNamed(Routes.studentMarksScreen),
                    ),

                  const Divider(),

                  // --- Announcements & Roll Numbers ---
                  _buildTile(
                    icon: Icons.campaign,
                    title: "Announcements",
                    onTap: () {
                      if (role == 'clerk') {
                        Get.toNamed(Routes.clerkAnnouncement);
                      } else {
                        Get.toNamed(Routes.studentAnnouncement);
                      }
                    },
                  ),
                  const Divider(),
                  _buildTile(
                    icon: Iconsax.archive_book,
                    title: "Roll Numbers",
                    onTap: () {
                      if (role == 'clerk') {
                        Get.toNamed(Routes.clerkAssingsRollno);
                      } else {
                        Get.toNamed(Routes.studentViewRollnoList);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable styled ListTile
  Widget _buildTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[600]),
      title: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      dense: true,
      onTap: onTap,
      hoverColor: Colors.blue.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
