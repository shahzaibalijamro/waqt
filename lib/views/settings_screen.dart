import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/models/calc_method_model.dart';
import 'package:waqt/widgets/appbar.dart';
import 'package:waqt/widgets/bottom_sheet.dart';
import 'package:waqt/widgets/settings/prayer_calc_section.dart';
import 'package:waqt/widgets/settings/select_location_section.dart';

class SettingsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController controller = Get.find<SettingsController>();
  MainController mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MyAppBar(screen: Screen.settings),
        SizedBox(height: mainController.vh.value! * 16),
        const SelectLocation(),
        SizedBox(height: mainController.vh.value! * 16),
        const PrayerCalcSection(),
        SizedBox(height: mainController.vh.value! * 16),
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
              Obx(
                () => SelectFormatTile(
                  selectedFormat: controller.timeFormat.value,
                ),
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
                  const Icon(
                    PhosphorIconsBold.bellRinging,
                    color: AppColors.selectedColor,
                    size: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        'Notifications',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                      Text(
                        'Prayer reminders',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Obx(
                    () => Switch(
                      value: controller.notificationsEnabled.value,
                      activeThumbColor: AppColors.white,
                      activeTrackColor: AppColors.selectedColor,
                      inactiveThumbColor: AppColors.mutedText,
                      inactiveTrackColor: AppColors.backgroundColor,
                      onChanged: (value) => controller.toggleNotifications(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: mainController.vh.value! * 24),
      ],
    );
  }
}

class SelectFormatTile extends StatelessWidget {
  SelectFormatTile({super.key, required this.selectedFormat});
  final TimeFormat selectedFormat;
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    bool isSelected(TimeFormat format) =>
        selectedFormat.toString() == format.toString();

    void showBottomSheet() {
      MyBottomSheet(
        child: Container(
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
                  height: 2,
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
                            '12-hour',
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
                      if (isSelected(TimeFormat.twelveHour)) ...[
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
                      if (isSelected(TimeFormat.twentyFourHour)) ...[
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
                  SizedBox(height: mainController.vh.value! * 30),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: showBottomSheet,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 14,
        children: [
          const Icon(
            PhosphorIconsBold.clockUser,
            color: AppColors.selectedColor,
            size: 30,
          ),
          Column(
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
              Text(
                selectedFormat == TimeFormat.twelveHour ? '12-hour' : '24-hour',
                style: GoogleFonts.manrope(
                  color: AppColors.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
          const Spacer(),
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
