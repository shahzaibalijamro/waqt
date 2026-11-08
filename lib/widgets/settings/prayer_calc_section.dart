import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/widgets/settings/select_asr_calc.dart';
import 'package:waqt/widgets/settings/select_cal_method.dart';

class PrayerCalcSection extends StatefulWidget {
  const new({super.key});

  @override
  State<PrayerCalcSection> createState() => _PrayerCalcSectionState();
}

class _PrayerCalcSectionState extends State<PrayerCalcSection> {
  MainController mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prayer Calculation',
          style: GoogleFonts.manrope(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 2,
          ),
        ),
        SizedBox(height: mainController.vh.value! * 4),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.listBg,
            borderRadius: BorderRadius.circular(18),
            border: BoxBorder.all(
              color: AppColors.mutedText.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              SelectCalculationMethod(),
              Container(
                width: double.infinity,
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 16),
                color: AppColors.mutedText.withValues(alpha: 0.3),
              ),
              SelectAsrCalculationSchool(),
            ],
          ),
        ),
      ],
    );
  }
}
