import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/layout_screen.dart';

class MyAppBar extends StatelessWidget {
  final Screen screen;
  const MyAppBar({super.key, required this.screen});

  Widget _homeAppBar(double vh) {
    return Padding(
      padding: EdgeInsets.only(top: vh * 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          SizedBox(
            width: 35,
            child: Image.asset('assets/icons/moon.png', fit: BoxFit.contain),
          ),
          Text(
            'Waqt',
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

  Widget _normalAppBar(double vh, Screen screen) {
    return Padding(
      padding: EdgeInsets.only(top: vh * 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          InkWell(
            onTap: () => print('back'),
            borderRadius: BorderRadius.circular(50),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                PhosphorIconsBold.arrowLeft,
                size: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            screen == Screen.calendar ? 'Prayer calendar' : 'Settings',
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
    switch (screen) {
      case Screen.home:
        return _homeAppBar(vh);
      default:
        return _normalAppBar(vh, screen);
    }
  }
}
