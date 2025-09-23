// import 'package:another_flushbar/flushbar.dart';
// import 'package:another_flushbar/flushbar_route.dart';
// import 'package:flutter/material.dart';

// class FkAlertMessage {
//   /// --FlushBar -- Announce message
//   static void flushBarAnnounceMessage(String message, BuildContext context, IconData icon) {
//     final overlay = Overlay.of(context);

//     final entry = OverlayEntry(
//       builder:
//           (context) => Positioned(
//             top: 40, // distance from top
//             right: 20, // distance from right
//             child: Material(
//               color: Colors.transparent,
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: 280),
//                 child: Flushbar(
//                   forwardAnimationCurve: Curves.decelerate,
//                   reverseAnimationCurve: Curves.easeInOut,
//                   margin: EdgeInsets.zero,
//                   padding: EdgeInsets.all(15),
//                   borderRadius: BorderRadius.circular(8),
//                   message: message,
//                   duration: const Duration(seconds: 3),
//                   backgroundColor: Colors.blueGrey,
//                   icon: Icon(icon, size: 28, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//     );

//     overlay.insert(entry);

//     // auto remove after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () {
//       entry.remove();
//     });
//   }

//   /// -- FlushBar -- Error message
//   static void flushBarErrorMessage(String message, BuildContext context) {
//     // Implement your flush bar error message logic here

//     showFlushbar(
//       context: context,
//       flushbar: Flushbar(
//         flushbarPosition: FlushbarPosition.TOP,
//         forwardAnimationCurve: Curves.decelerate,
//         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         padding: EdgeInsets.all(15),
//         borderRadius: BorderRadius.circular(8),
//         message: message,
//         duration: Duration(seconds: 3),
//         backgroundColor: Colors.red,
//         reverseAnimationCurve: Curves.easeInOut,
//         positionOffset: 20,
//         icon: Icon(Icons.error, size: 28, color: Colors.white),
//       )..show(context),
//     );
//   }
// }

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FkFlushbar {
  static void show({
    required BuildContext context,
    required String message,
    required IconData icon,
    String? title,
    Color backgroundColor = Colors.blueGrey,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 40,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Flushbar(
                  forwardAnimationCurve: Curves.decelerate,
                  reverseAnimationCurve: Curves.easeInOut,
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(8),
                  title: title, // 🔹 New
                  message: message,
                  duration: duration,
                  backgroundColor: backgroundColor,
                  icon: Icon(icon, size: 28, color: Colors.white),
                ),
              ),
            ),
          ),
    );

    overlay.insert(entry);

    Future.delayed(duration, () {
      entry.remove();
    });
  }

  /// ✅ Success message
  static void success(BuildContext context, String message, {String? title}) {
    show(
      context: context,
      title: title ?? "Success",
      message: message,
      icon: Icons.check_circle,
      backgroundColor: Colors.green.shade600,
    );
  }

  /// ❌ Error message
  static void error(BuildContext context, String message, {String? title}) {
    show(
      context: context,
      title: title ?? "Error",
      message: message,
      icon: Icons.error,
      backgroundColor: Colors.red.shade700,
    );
  }

  /// ⚠️ Warning message
  static void warning(BuildContext context, String message, {String? title}) {
    show(
      context: context,
      title: title ?? "Warning",
      message: message,
      icon: Icons.warning,
      backgroundColor: Colors.orange.shade700,
    );
  }

  /// ℹ️ Info message
  static void info(BuildContext context, String message, {String? title}) {
    show(
      context: context,
      title: title ?? "Info",
      message: message,
      icon: Icons.info,
      backgroundColor: Colors.blueGrey,
    );
  }
}
