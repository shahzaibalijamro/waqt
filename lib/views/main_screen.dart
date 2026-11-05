import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainController controller = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = (screenWidth * 0.05).clamp(16.0, 24.0).toDouble();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: horizontalPadding),
          child: Obx(() => controller.screens[controller.currentIndex.value]),
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: controller),
    );
  }
}
