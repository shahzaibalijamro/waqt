import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/controllers/api_controller.dart';

enum Screen { home, calendar, settings, search }

class MainScreen extends StatefulWidget {
  const new({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ApiController controller = Get.find<ApiController>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = (screenWidth * 0.05).clamp(16.0, 24.0).toDouble();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: horizontalPadding),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return controller.screens[controller.currentIndex.value];
          }),
        ),
      ),
      bottomNavigationBar: Obx(
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(PhosphorIconsRegular.house),
              activeIcon: Icon(
                PhosphorIconsFill.house,
                color: AppColors.selectedColor,
              ),

              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIconsRegular.calendarBlank),
              activeIcon: Icon(PhosphorIconsFill.calendarBlank),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(PhosphorIconsRegular.gearFine),
              activeIcon: Icon(PhosphorIconsFill.gearFine),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
