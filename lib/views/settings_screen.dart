import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/layout_screen.dart';
import 'package:waqt/views/search_screen.dart';
import 'package:waqt/widgets/appbar.dart';

class SettingsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

enum TimeFormat { twelveHour, twentyFourHour }

class _SettingsScreenState extends State<SettingsScreen> {
  bool areNotificationsOn = true;
  TimeFormat timeFormat = TimeFormat.twentyFourHour;
  String location = 'Karachi, Pakistan';
  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    return ListView(
      children: [
        MyAppBar(screen: Screen.settings, context: context),
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchLocation(currentLocation: location,)),
          ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      location,
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        height: 1,
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
                const Spacer(),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                spacing: 14,
                children: [
                  const Icon(
                    PhosphorIconsBold.calculator,
                    color: AppColors.selectedColor,
                    size: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
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
                        'University of Islamic Sciences, Karachi',
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
                    PhosphorIconsBold.clock,
                    color: AppColors.selectedColor,
                    size: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
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
                        'Hanafi',
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
              SelectFormatTile(selectedFormat: timeFormat),
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
                    spacing: 8,
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
                  Switch(
                    value: areNotificationsOn,
                    activeThumbColor: AppColors.white,
                    activeTrackColor: AppColors.selectedColor,
                    onChanged: (value) {
                      setState(() {
                        areNotificationsOn = !areNotificationsOn;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
      showModalBottomSheet(
        showDragHandle: true,
        backgroundColor: AppColors.backgroundColor,
        context: context,
        useSafeArea: true,
        builder: (context) {
          return Container(
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
                          spacing: 8,
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
                          Spacer(),
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
                          spacing: 8,
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
                          Spacer(),
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
          );
        },
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
            spacing: 8,
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
