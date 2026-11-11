import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/services/notification_service.dart';

class PreferenceSection extends StatelessWidget {
  PreferenceSection({super.key});

  final MainController mainController = Get.find<MainController>();

  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferences',
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
              SelectTimeFormat(),
              // Container(
              //   width: double.infinity,
              //   height: 1,
              //   margin: const EdgeInsets.symmetric(vertical: 16),
              //   color: AppColors.mutedText.withValues(alpha: 0.3),
              // ),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   spacing: 14,
              //   children: [
              //     const Icon(
              //       PhosphorIconsBold.bellRinging,
              //       color: AppColors.selectedColor,
              //       size: 30,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       spacing: 4,
              //       children: [
              //         Text(
              //           'Notifications',
              //           style: GoogleFonts.manrope(
              //             color: AppColors.primaryText,
              //             fontSize: 17,
              //             fontWeight: FontWeight.w700,
              //             height: 1,
              //           ),
              //         ),
              //         Text(
              //           'Prayer reminders',
              //           style: GoogleFonts.manrope(
              //             color: AppColors.mutedText,
              //             fontSize: 14,
              //             fontWeight: FontWeight.w500,
              //             height: 1,
              //           ),
              //         ),
              //       ],
              //     ),
              //     const Spacer(),
              //     Obx(
              //       () => Switch(
              //         value: controller.notificationsEnabled.value,
              //         activeThumbColor: AppColors.white,
              //         activeTrackColor: AppColors.selectedColor,
              //         inactiveThumbColor: AppColors.mutedText,
              //         inactiveTrackColor: AppColors.backgroundColor,
              //         onChanged: (value) =>
              //             controller.updateNotificationsPreference(value),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class SelectTimeFormat extends StatelessWidget {
  SelectTimeFormat({super.key});
  final MainController mainController = Get.find<MainController>();
  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          controller.showTimeFormatBottomSheet(TimeFormatBottomSheet()),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 14,
        children: [
          const Icon(
            PhosphorIconsBold.clockUser,
            color: AppColors.selectedColor,
            size: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Time Format',
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.timeFormat.value == TimeFormat.twelveHour
                        ? '12-hour'
                        : '24-hour',
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

class TimeFormatBottomSheet extends StatelessWidget {
  TimeFormatBottomSheet({super.key});
  final MainController mainController = Get.find<MainController>();
  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    bool isSelected(TimeFormat format) =>
        controller.timeFormat.value.name == format.name;
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
            'Select a Time Format',
            style: GoogleFonts.manrope(
              color: AppColors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.5,
            ),
          ),
          SizedBox(height: mainController.vh.value! * 4),
          Column(
            children: TimeFormat.values.map((format) {
              return InkWell(
                onTap: () => controller.updateTimeFormat(format),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  decoration: BoxDecoration(
                    border: format.name == '12-hour'
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
                          color: isSelected(format)
                              ? AppColors.selectedColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          border: !isSelected(format)
                              ? BoxBorder.all(
                                  color: AppColors.selectedColor,
                                  width: 1,
                                )
                              : null,
                        ),
                        child: isSelected(format)
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
                              format.name,
                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              format.description,
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
