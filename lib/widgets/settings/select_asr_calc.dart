import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';

class SelectAsrCalculationSchool extends StatelessWidget {
  SelectAsrCalculationSchool({super.key});
  final MainController mainController = Get.find<MainController>();
  final SettingsController controller = Get.find<SettingsController>();

  String capitalize(String string) =>
      string[0].toUpperCase() + string.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.showAsrCalculationSchoolBottomSheet(
        SelectAsrCalcSchoolBottomSheet(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 14,
        children: [
          const Icon(
            PhosphorIconsBold.clock,
            color: AppColors.selectedColor,
            size: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Asr Calculation',
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  capitalize(
                    controller.selectedSchool.toString().split('.')[1],
                  ),
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            PhosphorIconsBold.caretRight,
            color: AppColors.selectedColor,
            fontWeight: FontWeight.w700,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class SelectAsrCalcSchoolBottomSheet extends StatelessWidget {
  SelectAsrCalcSchoolBottomSheet({super.key});
  final SettingsController controller = Get.find<SettingsController>();
  final MainController mainController = Get.find<MainController>();
  bool isSelected(School school) =>
      controller.selectedSchool.toString() == school.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: mainController.horizontalPadding.value!,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Asr calculation',
            style: GoogleFonts.manrope(
              color: AppColors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.5,
            ),
          ),
          Text(
            'Choose the juristic school used to calculate Asr time. This affects Asr only.',
            style: GoogleFonts.manrope(
              color: AppColors.mutedText,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          SizedBox(height: mainController.vh.value! * 20),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                spacing: 14,
                children: [
                  Text(
                    '1.',
                    style: GoogleFonts.manrope(
                      color: AppColors.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        'Hanafi',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      Text(
                        'Example: 05:30 PM',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  if (isSelected(School.hanafi)) ...[
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.selectedColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'SELECTED',
                        style: GoogleFonts.manrope(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 16),
                color: AppColors.mutedText.withValues(alpha: 0.3),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                spacing: 14,
                children: [
                  Text(
                    '2.',
                    style: GoogleFonts.manrope(
                      color: AppColors.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        '24-hour',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      Text(
                        'Example: 17:30 PM',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  if (isSelected(School.shafi)) ...[
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.selectedColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'SELECTED',
                        style: GoogleFonts.manrope(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: mainController.vh.value! * 30),
        ],
      ),
    );
  }
}
