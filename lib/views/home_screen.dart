import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/constants/routes.dart';
import 'package:waqt/controllers/home_controller.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';

import 'dart:ui' as ui;

import '../widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SettingsController settingsController = Get.find<SettingsController>();
  MainController mainController = Get.find<MainController>();
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MyAppBar(screen: Screen.home),
        SizedBox(height: mainController.vh.value! * 6),
        Obx(
          () => InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              if (settingsController.isLoading.value) return;
              settingsController.filterPopularCities();

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
                enabled: settingsController.isLoading.value,
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
                        '${settingsController.location.value.name}, ${settingsController.location.value.country}',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const Skeleton.shade(
                      child: Icon(
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
        SizedBox(height: mainController.vh.value! * 2),
        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            const Icon(
              PhosphorIconsRegular.calendarBlank,
              color: AppColors.selectedColor,
            ),
            Text(
              // 'Tuesday, 27 October',
              DateFormat('EEEE, d MMMM').format(DateTime.now()),
              style: GoogleFonts.manrope(
                color: AppColors.primaryText,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return SizedBox(
              height: mainController.screenHeight.value! / 2,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.selectedColor,
                ),
              ),
            );
          }
          bool isNext(int index) =>
              controller.prayerData.value!.timings
                  .toJson()
                  .keys
                  .toList()[index] ==
              controller.nextPrayer.value!.name;
          bool isLast(int index) =>
              index ==
              controller.prayerData.value!.timings.toJson().values.length - 1;
          return Column(
            children: [
              SizedBox(height: mainController.vh.value! * 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: ui.TextDirection.ltr,
                    spacing: 5,
                    children: [
                      Text(
                        controller.prayerData.value!.date.hijri.year,
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Directionality(
                        textDirection: ui.TextDirection.rtl,
                        child: Text(
                          controller.prayerData.value!.date.hijri.month.ar,
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        controller.prayerData.value!.date.hijri.day,
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    PhosphorIconsRegular.calendarBlank,
                    color: AppColors.selectedColor,
                  ),
                ],
              ),
              SizedBox(height: mainController.vh.value! * 16),
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
                    SizedBox(height: mainController.vh.value! * 9),
                    Text(
                      controller.nextPrayer.value!.name,
                      style: GoogleFonts.manrope(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: mainController.vh.value! * 9),

                    Text(
                      settingsController.formatPrayerTime(
                        controller.nextPrayer.value!.time,
                      ),
                      style: GoogleFonts.manrope(
                        color: AppColors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: mainController.vh.value! * 12),

                    Text(
                      controller.nextPrayer.value!.beginsIn,
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
              SizedBox(height: mainController.vh.value! * 16),
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
              SizedBox(height: mainController.vh.value! * 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: BoxBorder.all(
                    color: AppColors.mutedText.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    for (
                      int i = 0;
                      i <
                          controller.prayerData.value!.timings
                              .toJson()
                              .values
                              .length;
                      i++
                    )
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,

                        decoration: BoxDecoration(
                          borderRadius: i == 0 && isNext(i)
                              ? const BorderRadius.vertical(
                                  top: Radius.circular(18),
                                )
                              : isLast(i) && isNext(i)
                              ? const BorderRadius.vertical(
                                  bottom: Radius.circular(18),
                                )
                              : null,
                          color: isNext(i) ? AppColors.highLightColor : null,
                          border: !isLast(i)
                              ? BoxBorder.fromLTRB(
                                  bottom: BorderSide(
                                    color: AppColors.mutedText.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                )
                              : null,
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
                              controller.prayerData.value!.timings
                                  .toJson()
                                  .keys
                                  .toList()[i],
                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              settingsController.formatPrayerTime(
                                controller.prayerData.value!.timings
                                    .toJson()
                                    .values
                                    .toList()[i],
                              ),
                              style: GoogleFonts.manrope(
                                color: AppColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            isNext(i)
                                ? Container(
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
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: mainController.vh.value! * 16),
            ],
          );
        }),
      ],
    );
  }
}
