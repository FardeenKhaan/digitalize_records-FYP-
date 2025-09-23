import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sweng_records/routes/app_pages.dart';
import 'package:sweng_records/routes/app_routes.dart';

void main() async {
  // Get.lazyPut(() => ChallanController());

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // initialize storage
  final box = GetStorage();

  final role = box.read('role');
  final token = box.read('token');

  String initialRoute;

  if (token != null && role != null) {
    if (role == 'student') {
      initialRoute = Routes.studentDashboard;
    } else {
      initialRoute = Routes.clerkDashboard;
    }
  } else {
    initialRoute = Routes.loginScreen;
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String? initialRoute;
  const MyApp({super.key, this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digitalize Records',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 248, 248, 249))),
      initialRoute: initialRoute,
      getPages: appPages,
    );
  }
}
