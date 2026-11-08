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
                Obx(
                  () => Text(
                    capitalize(
                      controller.selectedSchool.toString().split('.')[1],
                    ),
                    style: GoogleFonts.manrope(
                      color: AppColors.mutedText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
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
  bool isSelected(AsrSchool school) =>
      controller.selectedSchool.value.id == school.id;

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
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: mainController.vh.value! * 4),
          Column(
            children: AsrSchool.values.map((school) {
              return InkWell(
                onTap: () => controller.updateAsrSchool(school),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  decoration: BoxDecoration(
                    border: school.id == 0
                        ? BoxBorder.fromLTRB(
                            bottom: BorderSide(
                              color: AppColors.mutedText.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 14,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: isSelected(school)
                              ? AppColors.selectedColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          border: !isSelected(school)
                              ? BoxBorder.all(
                                  color: AppColors.selectedColor,
                                  width: 1,
                                )
                              : null,
                        ),
                        child: isSelected(school)
                            ? const Icon(
                                PhosphorIconsBold.check,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                                size: 20,
                              )
                            : null,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              school.displayName,
                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              school.description,
                              style: GoogleFonts.manrope(
                                color: AppColors.mutedText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: mainController.vh.value! * 10),
        ],
      ),
    );
  }
}

// [

//               Container(
//                 width: double.infinity,
//                 height: 1,
//                 margin: const EdgeInsets.symmetric(vertical: 16),
//                 color: ,
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 spacing: 14,
//                 children: [
//                   Container(
//                     height: 30,
//                     width: 30,
//                     decoration: BoxDecoration(
//                       color: AppColors.selectedColor,
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: isSelected(AsrSchool.hanafi)
//                         ? const Icon(
//                             PhosphorIconsBold.check,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.white,
//                             size: 20,
//                           )
//                         : null,
//                   ),

//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       spacing: 2,
//                       children: [
//                         Text(
//                           AsrSchool.hanafi.displayName,
//                           style: GoogleFonts.manrope(
//                             color: AppColors.primaryText,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             height: 1,
//                           ),
//                         ),
//                         Text(
//                           ,
//                           style: GoogleFonts.manrope(
//                             color: AppColors.mutedText,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
