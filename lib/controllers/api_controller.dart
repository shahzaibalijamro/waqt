import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/prefs_keys.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:waqt/views/calendar_screen.dart';
import 'package:waqt/views/home_screen.dart';
import 'package:waqt/views/settings_screen.dart';

class ApiController extends GetxController {
  AppUtils utils = Get.find<AppUtils>();
  RxBool isLoading = true.obs;
  RxnString location = RxnString();
  RxInt currentIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const SettingsScreen(),
  ];

  void switchScreens(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    location.value =
        (utils.getStringFromPrefs(key: AppKeys.location) ??
        'Karachi, Pakistan');
    isLoading.value = false;
  }
}
