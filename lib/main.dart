import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/layout_screen.dart';
import 'package:waqt/views/search_screen.dart';

import './views/splash_screen.dart';

void main() {
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
          page: () {
            final arguments = Get.arguments;
            return SearchLocation(currentLocation: arguments['location']);
          },
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
