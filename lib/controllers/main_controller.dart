import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/views/calendar_screen.dart';
import 'package:waqt/views/home_screen.dart';
import 'package:waqt/views/settings_screen.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const SettingsScreen(),
  ];

  final List<Map<String, dynamic>> navItems = const [
    {
      'icon': Icon(PhosphorIconsRegular.house),
      'activeIcon': Icon(PhosphorIconsFill.house, color: AppColors.primaryText),

      'label': 'Home',
      'index': 0,
    },
    {
      'icon': Icon(PhosphorIconsRegular.calendarBlank),
      'activeIcon': Icon(
        PhosphorIconsFill.calendarBlank,
        color: AppColors.primaryText,
      ),
      'label': 'Calendar',
      'index': 1,
    },
    {
      'icon': Icon(PhosphorIconsRegular.gearFine),
      'activeIcon': Icon(
        PhosphorIconsFill.gearFine,
        color: AppColors.primaryText,
      ),
      'label': 'Settings',
      'index': 2,
    },
  ];

  void switchScreens(int index) {
    currentIndex.value = index;
  }
}
