import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/bindings/main_binding.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:waqt/views/main_screen.dart';
import 'package:waqt/views/search_screen.dart';

// import 'services/notification_service.dart';

import './views/splash_screen.dart';

Future<void> main() async {
  final AppUtils utils = Get.put(AppUtils(), permanent: true);
  await utils.initPrefs();
  // final notificationService = NotificationService();
  // await notificationService.initialize();

  // Get.put(notificationService);
  Get.put(ApiController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(
          name: '/main',
          page: () => const MainScreen(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/search',
          page: () => const SearchLocation(),
          transition: Transition.rightToLeftWithFade,
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
