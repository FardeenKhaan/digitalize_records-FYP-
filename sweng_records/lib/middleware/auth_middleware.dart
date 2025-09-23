import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sweng_records/routes/app_routes.dart';

// class AuthMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     final box = GetStorage();
//     final token = box.read('token');

//     if (token == null || token.isEmpty) {
//       return const RouteSettings(name: Routes.LOGIN);
//     }

//     return null; // allow access
//   }
// }
class AuthMiddleware extends GetMiddleware {
  final String allowedRole; // 👈 NEW

  AuthMiddleware({required this.allowedRole});

  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final token = box.read('token');
    final role = box.read('role');

    // ✅ If no token, redirect to login
    if (token == null || token.isEmpty) {
      return const RouteSettings(name: Routes.loginScreen);
    }

    // ✅ If role doesn't match, redirect to their own dashboard
    if (role != allowedRole) {
      if (role == 'student') {
        return const RouteSettings(name: Routes.studentDashboard);
      } else if (role == 'clerk') {
        return const RouteSettings(name: Routes.clerkDashboard);
      } else {
        return const RouteSettings(name: Routes.loginScreen); // fallback
      }
    }

    return null; // ✅ Allow access
  }
}
