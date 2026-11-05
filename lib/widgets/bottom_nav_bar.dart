import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/controllers/main_controller.dart';

class BottomNavBar extends StatelessWidget {
  const new({super.key, required this.controller});

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        currentIndex: controller.currentIndex.value,
        onTap: (value) => controller.switchScreens(value),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.manrope(
          fontWeight: const FontWeight(600),
          fontSize: 14,
          height: 1.5,
        ),
        selectedItemColor: AppColors.selectedColor,
        unselectedItemColor: AppColors.mutedText,
        unselectedLabelStyle: GoogleFonts.manrope(
          fontWeight: const FontWeight(600),
          fontSize: 14,
          height: 1.5,
        ),
        items: controller.navItems
            .map(
              (e) => BottomNavigationBarItem(
                icon: e['icon'],
                activeIcon: e['activeIcon'],
                label: e['label'],
              ),
            )
            .toList(),
      ),
    );
  }
}
