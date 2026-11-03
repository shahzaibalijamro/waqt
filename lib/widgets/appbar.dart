import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/layout_screen.dart';

class MyAppBar extends StatelessWidget {
  final Screen screen;
  final BuildContext context;
  const MyAppBar({super.key, required this.screen, required this.context});

  Widget _homeAppBar(double vh) {
    return Padding(
      padding: EdgeInsets.only(top: vh * 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          if (screen == Screen.home) ...[
            SizedBox(
              width: 35,
              child: Image.asset('assets/icons/moon.png', fit: BoxFit.contain),
            ),
          ],
          if (screen == Screen.search) ...[
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  PhosphorIconsBold.arrowLeft,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
          Text(
            screen == Screen.calendar
                ? 'Prayer calendar'
                : screen == Screen.search
                ? 'Choose your city'
                : screen == Screen.settings
                ? 'Settings'
                : 'Waqt',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    return _homeAppBar(vh);
  }
}
