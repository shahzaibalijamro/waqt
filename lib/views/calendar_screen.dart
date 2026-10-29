import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/layout_screen.dart';
import 'package:waqt/widgets/appbar.dart';

class CalendarScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    return ListView(
      children: [
        const MyAppBar(screen: Screen.calendar),
        SizedBox(height: vh * 16),
        Container(
          padding: EdgeInsets.symmetric(vertical: vh * 5),
          decoration: BoxDecoration(
            color: AppColors.highLightColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              InkWell(
                onTap: () => print('Month back'),
                borderRadius: BorderRadius.circular(50),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    PhosphorIconsBold.caretLeft,
                    color: AppColors.selectedColor,
                  ),
                ),
              ),
              Text(
                'October 2026',
                style: GoogleFonts.manrope(
                  color: AppColors.primaryText,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              InkWell(
                onTap: () => print('Month forward'),
                borderRadius: BorderRadius.circular(50),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(
                    PhosphorIconsBold.caretRight,
                    color: AppColors.selectedColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: vh * 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            const Icon(
              PhosphorIconsFill.mapPin,
              color: AppColors.selectedColor,
            ),
            Text(
              'Karachi, Pakistan',
              style: GoogleFonts.manrope(
                color: AppColors.primaryText,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                height: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: vh * 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: BoxBorder.all(
              color: AppColors.mutedText.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.highLightColor,
                  // borderRadius: BorderRadius.circular(18),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),

                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    Text(
                      'Date',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.highLightColor,
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: '27',
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: '\n',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Tue',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: '27',
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: '\n',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Tue',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF4F1EB),
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: '27',
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: '\n',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Tue',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: '27',
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: '\n',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Tue',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF4F1EB),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(18),
                  ),
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: '27',
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: '\n',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Tue',

                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: '5:12',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w800,

                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'AM',

                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: vh * 16),

        Container(
          padding: EdgeInsets.symmetric(vertical: vh * 5),
          decoration: BoxDecoration(
            color: AppColors.highLightColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              InkWell(
                onTap: () => print('Month back'),
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        PhosphorIconsBold.caretLeft,
                        color: AppColors.selectedColor,
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                      Text(
                        'Previous',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => print('Month forward'),
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    spacing: 6,
                    children: [
                      Text(
                        'Next',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      const Icon(
                        PhosphorIconsBold.caretRight,
                        color: AppColors.selectedColor,
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
