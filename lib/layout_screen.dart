import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/views/calendar_screen.dart';
import 'package:waqt/views/home_screen.dart';
import 'package:waqt/views/settings_screen.dart';

class LayoutScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const SettingsScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
          child: screens[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.manrope(
          fontWeight: FontWeight(600),
          fontSize: 14,
          height: 1.5,
        ),
        selectedItemColor: AppColors.selectedColor,
        unselectedItemColor: AppColors.mutedText,
        unselectedLabelStyle: GoogleFonts.manrope(
          fontWeight: FontWeight(600),
          fontSize: 14,
          height: 1.5,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.house),
            activeIcon: Icon(
              PhosphorIconsFill.house,
              color: AppColors.selectedColor,
            ),

            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.calendarBlank),
            activeIcon: Icon(PhosphorIconsFill.calendarBlank),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIconsRegular.gearFine),
            activeIcon: Icon(PhosphorIconsFill.gearFine),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
