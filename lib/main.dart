import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:waqt/views/main_screen.dart';
import 'package:waqt/views/search_screen.dart';

import './views/splash_screen.dart';

void main() async {
  final AppUtils utils = Get.put(AppUtils());
  await utils.initPrefs();
  Get.put(ApiController());
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
        GetPage(name: '/main', page: () => const MainScreen()),
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
