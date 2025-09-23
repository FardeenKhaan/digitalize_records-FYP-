import 'package:get/get.dart';
import 'package:sweng_records/middleware/auth_middleware.dart';
import 'package:sweng_records/routes/app_routes.dart';
import 'package:sweng_records/screens/Authentication/login_screen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_add_edit_marks_screen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_all_challans.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_form_detail_screen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_dashboard/clerk_homeScreen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_marks_screen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_pending_challans.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/clerk_post_announcement_screen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/manage_student_screen.dart';
import 'package:sweng_records/screens/dashboards/clerk_purpose/view_admission_forms.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/stu_admission_form_view_screen.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/stu_admissionform_submit_screen.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/student_home_screen.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/student_announcements_screen.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/student_marks_screen.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/student_upload_challan.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/student_view_challans.dart';
import 'package:sweng_records/screens/dashboards/student_purpose/view_student_screen.dart';

final List<GetPage> appPages = [
  GetPage(
    name: Routes.loginScreen,
    page: () => LoginScreen(),
    // binding: LoginBinding()
  ),
  GetPage(
    name: Routes.studentDashboard,
    page: () => const StudentHomescreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.clerkDashboard,
    page: () => const ClerkHomescreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  GetPage(
    name: Routes.uploadChallan,
    page: () => StudentUploadChallanScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.pendingChallan,
    page: () => ClerkPendingChallansScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  GetPage(
    name: Routes.studentChallan,
    page: () => StudentViewChallansScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.clerkAllChallans,
    page: () => ClerkAllChallansScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  GetPage(
    name: Routes.studentAnnouncement,
    page: () => StudentAnnouncementsScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.clerkAnnouncement,
    page: () => ClerkAnnouncementScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  GetPage(
    name: Routes.studentViewRollnoList,
    page: () => StudentsViewScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.clerkAssingsRollno,
    page: () => ManageStudentsScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  GetPage(
    name: Routes.admissionFormSubmission,
    page: () => StudentAdmissionFormScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.admissionFormView,
    page: () => AdmissionFormViewScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.clerkAdmissionForm,
    page: () => ClerkAdmissionFormsScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  // GetPage(
  //   name: Routes.CLERK_FORM_DETAIL,
  //   page: () => ClerkFormDetailScreen(form: Get.arguments['form']),
  //   middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  // ),
  GetPage(
    name: Routes.clerkFormDetails,
    page: () {
      final args = Get.arguments as Map<String, dynamic>?;
      return ClerkFormDetailScreen(form: args?['form'] ?? {});
    },
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  GetPage(
    name: Routes.studentMarksScreen,
    page: () => StudentMarksScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'student')],
  ),
  GetPage(
    name: Routes.clerk_edit_marks_screen,
    page: () => ClerkAddEditMarksScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
  // GetPage(
  //   name: Routes.clerk_marks_detail_screen,
  //   page: () => ClerkMarksDetailScreen(),
  //   middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  // ),
  GetPage(
    name: Routes.clerkMarksScreen,
    page: () => ClerkMarksScreen(),
    middlewares: [AuthMiddleware(allowedRole: 'clerk')],
  ),
];
