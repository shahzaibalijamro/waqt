import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/constants/routes.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/main.dart';
import 'package:waqt/widgets/appbar.dart';
import 'package:waqt/widgets/bottom_sheet.dart';

class SettingsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController controller = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    return ListView(
      children: [
        MyAppBar(screen: Screen.settings),
        SizedBox(height: vh * 16),
        Text(
          'Location',
          style: GoogleFonts.manrope(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 2,
          ),
        ),
        SizedBox(height: vh * 4),
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.search),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.listBg,
              borderRadius: BorderRadius.circular(18),
              border: BoxBorder.all(
                color: AppColors.mutedText.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              spacing: 14,
              children: [
                const Icon(
                  PhosphorIconsBold.mapPin,
                  color: AppColors.selectedColor,
                  size: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Obx(
                        () => Text(
                          controller.location.value!,
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      Text(
                        'Tap to change city',
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
          ),
        ),
        SizedBox(height: vh * 24),
        Text(
          'Prayer Calculation',
          style: GoogleFonts.manrope(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 2,
          ),
        ),
        SizedBox(height: vh * 4),
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
              CalculationMethodTile(
                selectedMethod: 'University of Islamic Sciences, Karachi',
                controller: controller,
              ),
              Container(
                width: double.infinity,
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 16),
                color: AppColors.mutedText.withValues(alpha: 0.3),
              ),
              const AsrCalculationTile(selectedSchool: School.hanafi),
            ],
          ),
        ),
        SizedBox(height: vh * 24),
        Text(
          'Preferences',
          style: GoogleFonts.manrope(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 2,
          ),
        ),
        SizedBox(height: vh * 4),
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
        SizedBox(height: vh * 24),
      ],
    );
  }
}

class CalculationMethodTile extends StatefulWidget {
  const CalculationMethodTile({
    super.key,
    required this.selectedMethod,
    required this.controller,
  });
  final String selectedMethod;
  final SettingsController controller;

  @override
  State<CalculationMethodTile> createState() => _CalculationMethodTileState();
}

class _CalculationMethodTileState extends State<CalculationMethodTile> {
  final TextEditingController searchInputController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    final vw = MediaQuery.of(context).size.width;
    final horizontalPadding = (vw * 0.05).clamp(16.0, 24.0).toDouble();
    bool isSelected() => true;

    final Widget bottomSheet = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calculation Method',
            style: GoogleFonts.manrope(
              color: AppColors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.5,
            ),
          ),
          Text(
            'Choose how your prayer times are calculated.',
            style: GoogleFonts.manrope(
              color: AppColors.mutedText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            style: GoogleFonts.manrope(
              color: AppColors.mutedText,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            textAlignVertical: const TextAlignVertical(y: -0.1),

            controller: searchInputController,
            cursorColor: AppColors.primaryText,
            cursorHeight: 15,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              isCollapsed: true,
              isDense: true,
              hoverColor: Colors.transparent,
              fillColor: AppColors.white,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Icon(
                  PhosphorIconsBold.magnifyingGlass,
                  color: AppColors.primaryText,
                  size: 25,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                // vertical: 15,
              ),

              prefixIconColor: AppColors.primaryText,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mutedText.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mutedText.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              hint: Text(
                widget.selectedMethod,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  color: AppColors.mutedText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: vh * 20),
          Obx(
            () => widget.controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        spacing: 14,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.selectedColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: isSelected()
                                ? const Icon(
                                    PhosphorIconsBold.check,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                    size: 20,
                                  )
                                : null,
                          ),
                          Expanded(
                            child: Text(
                              'University of Islamic Sciences, Karachi',
                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                // height: 1,
                              ),
                            ),
                          ),
                          if (isSelected()) ...[
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
                      SizedBox(height: vh * 30),
                    ],
                  ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: () =>
          widget.controller.showCalculationMethodBottomSheet(bottomSheet),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 14,
        children: [
          const Icon(
            PhosphorIconsBold.calculator,
            color: AppColors.selectedColor,
            size: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Calculation Method',
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  widget.selectedMethod,
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

class AsrCalculationTile extends StatelessWidget {
  const new({super.key, required this.selectedSchool});
  final School selectedSchool;

  String capitalize(String string) =>
      string[0].toUpperCase() + string.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    final vw = MediaQuery.of(context).size.width;
    final horizontalPadding = (vw * 0.05).clamp(16.0, 24.0).toDouble();
    bool isSelected(School school) =>
        selectedSchool.toString() == school.toString();
    void showBottomSheet() {
      MyBottomSheet(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
              SizedBox(height: vh * 20),
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
              SizedBox(height: vh * 30),
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
                  capitalize(selectedSchool.toString().split('.')[1]),
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

class SelectFormatTile extends StatelessWidget {
  const new({super.key, required this.selectedFormat});
  final TimeFormat selectedFormat;

  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    final vw = MediaQuery.of(context).size.width;
    final horizontalPadding = (vw * 0.05).clamp(16.0, 24.0).toDouble();
    bool isSelected(TimeFormat format) =>
        selectedFormat.toString() == format.toString();

    void showBottomSheet() {
      MyBottomSheet(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
              SizedBox(height: vh * 20),
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
                  SizedBox(height: vh * 30),
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
