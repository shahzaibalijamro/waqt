import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/constants/routes.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/main.dart';

import '../widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SettingsController controller = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    return ListView(
      children: [
        MyAppBar(screen: Screen.home),
        SizedBox(height: vh * 6),
        Obx(
          () => InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              if (controller.isLoading.value) return;
              Get.toNamed(AppRoutes.search);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Skeletonizer(
                effect: ShimmerEffect(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  duration: const Duration(seconds: 1),
                ),
                enabled: controller.isLoading.value,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 8,
                  children: [
                    const Icon(
                      PhosphorIconsFill.mapPin,
                      color: AppColors.selectedColor,
                    ),
                    Expanded(
                      child: Text(
                        controller.location.value!,
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Skeleton.shade(
                      child: const Icon(
                        PhosphorIconsRegular.caretDown,
                        color: AppColors.selectedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: vh * 2),
        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            const Icon(
              PhosphorIconsRegular.calendarBlank,
              color: AppColors.selectedColor,
            ),
            Text(
              'Tuesday, 27 October',
              style: GoogleFonts.manrope(
                color: AppColors.primaryText,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: vh * 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: const DecorationImage(
              image: AssetImage('assets/images/card_bg_home.png'),

              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NEXT PRAYER',
                style: GoogleFonts.manrope(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
              SizedBox(height: vh * 9),
              Text(
                'Maghrib',
                style: GoogleFonts.manrope(
                  color: AppColors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              SizedBox(height: vh * 9),

              Text(
                '5:48 PM',
                style: GoogleFonts.manrope(
                  color: AppColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
              SizedBox(height: vh * 12),

              Text(
                'Begins in 01ʰ 24m',
                style: GoogleFonts.manrope(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1,
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
            Expanded(
              child: Text(
                "Today's Prayers",
                style: GoogleFonts.manrope(
                  color: AppColors.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.find<MainController>().switchScreens(1),
              child: Row(
                spacing: 5,
                children: [
                  Text(
                    'View month',
                    style: GoogleFonts.manrope(
                      color: AppColors.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Icon(
                      PhosphorIconsRegular.arrowRight,
                      color: AppColors.selectedColor,
                      size: 18,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: vh * 12),
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
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 12,
                  children: [
                    const Icon(
                      PhosphorIconsRegular.sunHorizon,
                      color: AppColors.selectedColor,
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '5:12 AM',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 12,
                  children: [
                    const Icon(
                      PhosphorIconsRegular.sunHorizon,
                      color: AppColors.selectedColor,
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '5:12 AM',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 12,
                  children: [
                    const Icon(
                      PhosphorIconsRegular.sunHorizon,
                      color: AppColors.selectedColor,
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '5:12 AM',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(
                    bottom: BorderSide(
                      color: AppColors.mutedText.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 12,
                  children: [
                    const Icon(
                      PhosphorIconsRegular.sunHorizon,
                      color: AppColors.selectedColor,
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '5:12 AM',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                  spacing: 12,
                  children: [
                    const Icon(
                      PhosphorIconsFill.sunHorizon,
                      color: AppColors.selectedColor,
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '5:12 AM',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                        'NEXT',
                        style: GoogleFonts.manrope(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                // decoration: BoxDecoration(
                //   border: BoxBorder.fromLTRB(
                //     bottom: BorderSide(
                //       color: AppColors.mutedText.withValues(alpha: 0.3),
                //     ),
                //   ),
                // ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 12,
                  children: [
                    const Icon(
                      PhosphorIconsRegular.sunHorizon,
                      color: AppColors.selectedColor,
                    ),
                    Text(
                      'Fajr',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '5:12 AM',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
