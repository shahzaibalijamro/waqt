import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/controllers/calendar_controller.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/widgets/appbar.dart';

class CalendarScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  SettingsController settingsController = Get.find<SettingsController>();
  MainController mainController = Get.find<MainController>();
  CalendarController controller = Get.put(CalendarController());
  final ScrollController _dateScrollController = ScrollController();

  String? _lastAutoScrolledPeriod;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  bool isToday(String date) {
    final now = DateTime.now();

    return date == '${now.day}' &&
        controller.selectedMonth.value == now.month &&
        controller.selectedYear.value == now.year;
  }

  @override
  void dispose() {
    super.dispose();
    _dateScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.fetchCalendarData(),
      color: AppColors.selectedColor,
      backgroundColor: AppColors.backgroundColor,
      child: ListView(
        children: [
          MyAppBar(screen: Screen.calendar),
          SizedBox(height: mainController.vh.value! * 16),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: mainController.vh.value! * 5,
            ),
            decoration: BoxDecoration(
              color: AppColors.highLightColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                spacing: 8,
                children: [
                  InkWell(
                    onTap: () => controller.prevMonth(),
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
                    '${months[controller.selectedMonth.value - 1]} ${controller.selectedYear.value}',
                    style: GoogleFonts.manrope(
                      color: AppColors.primaryText,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.nextMonth(),
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
          ),
          SizedBox(height: mainController.vh.value! * 16),
          Row(
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              const Icon(
                PhosphorIconsFill.mapPin,
                color: AppColors.selectedColor,
              ),
              Obx(
                () => Text(
                  '${settingsController.location.value.name}, ${settingsController.location.value.country}',
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mainController.vh.value! * 16),
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
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Date',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'الفجر',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'الظهر',
                          textAlign: TextAlign.center,

                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'العصر',
                          textAlign: TextAlign.center,

                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'المغرب',
                          textAlign: TextAlign.center,

                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,

                        child: Text(
                          'العشاء',
                          textAlign: TextAlign.end,

                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: mainController.screenHeight.value! / 2,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.selectedColor,
                        ),
                      ),
                    );
                  }
                  final calendarData = controller.calendarData.value;
                  if (calendarData == null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Text(
                            controller.errorMsg.value ??
                                (controller.isOffline.value
                                    ? 'No internet!'
                                    : 'Calendar data is unavailable.'),
                            style: GoogleFonts.manrope(
                              color: AppColors.primaryText,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(
                            onTap: controller.checkCalendarData,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.selectedColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: Text(
                                'Retry?',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (calendarData.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text('No calendar data available.'),
                    );
                  }
                  final todayIndex = calendarData.indexWhere(
                    (item) => isToday(item.date.gregorian.day),
                  );

                  final currentPeriod =
                      '${controller.selectedYear.value}-${controller.selectedMonth.value}';

                  if (todayIndex == -1) {
                    _lastAutoScrolledPeriod = null;
                  } else if (_lastAutoScrolledPeriod != currentPeriod) {
                    _lastAutoScrolledPeriod = currentPeriod;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted || !_dateScrollController.hasClients) return;

                      final position = _dateScrollController.position;

                      final targetOffset = (todayIndex * 80);

                      _dateScrollController.animateTo(
                        targetOffset
                            .clamp(0.0, position.maxScrollExtent)
                            .toDouble(),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                    });
                  }
                  return SizedBox(
                    height: mainController.screenHeight.value! * 0.4,
                    child: ListView.builder(
                      controller: _dateScrollController,
                      primary: false,
                      physics: const ClampingScrollPhysics(),
                      itemCount: calendarData.length,
                      itemExtent: 80,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                isToday(calendarData[index].date.gregorian.day)
                                ? AppColors.highLightColor
                                : Colors.transparent,
                            border: index != calendarData.length - 1
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text.rich(
                                  textAlign: TextAlign.start,
                                  TextSpan(
                                    text:
                                        calendarData[index].date.gregorian.day,
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
                                          fontSize: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: calendarData[index]
                                            .date
                                            .gregorian
                                            .weekday
                                            .en
                                            .substring(0, 3),

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
                              Expanded(
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    text:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? settingsController
                                              .formatPrayerTime(
                                                calendarData[index]
                                                    .timings
                                                    .fajr,
                                                true,
                                              )
                                              .split(' ')[0]
                                        : settingsController.formatPrayerTime(
                                            calendarData[index].timings.fajr,
                                            true,
                                          ),
                                    style: GoogleFonts.manrope(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w800,

                                      fontSize: 16,
                                    ),
                                    children:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? [
                                            TextSpan(
                                              text: '\n',

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: settingsController
                                                  .formatPrayerTime(
                                                    calendarData[index]
                                                        .timings
                                                        .fajr,
                                                    true,
                                                  )
                                                  .split(' ')[1],

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    text:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? settingsController
                                              .formatPrayerTime(
                                                calendarData[index]
                                                    .timings
                                                    .dhuhr,
                                                true,
                                              )
                                              .split(' ')[0]
                                        : settingsController.formatPrayerTime(
                                            calendarData[index].timings.dhuhr,
                                            true,
                                          ),
                                    style: GoogleFonts.manrope(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w800,

                                      fontSize: 16,
                                    ),
                                    children:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? [
                                            TextSpan(
                                              text: '\n',

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: settingsController
                                                  .formatPrayerTime(
                                                    calendarData[index]
                                                        .timings
                                                        .dhuhr,
                                                    true,
                                                  )
                                                  .split(' ')[1],

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    text:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? settingsController
                                              .formatPrayerTime(
                                                calendarData[index].timings.asr,
                                                true,
                                              )
                                              .split(' ')[0]
                                        : settingsController.formatPrayerTime(
                                            calendarData[index].timings.asr,
                                            true,
                                          ),
                                    style: GoogleFonts.manrope(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w800,

                                      fontSize: 16,
                                    ),
                                    children:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? [
                                            TextSpan(
                                              text: '\n',

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: settingsController
                                                  .formatPrayerTime(
                                                    calendarData[index]
                                                        .timings
                                                        .asr,
                                                    true,
                                                  )
                                                  .split(' ')[1],

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    text:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? settingsController
                                              .formatPrayerTime(
                                                calendarData[index]
                                                    .timings
                                                    .maghrib,
                                                true,
                                              )
                                              .split(' ')[0]
                                        : settingsController.formatPrayerTime(
                                            calendarData[index].timings.maghrib,
                                            true,
                                          ),
                                    style: GoogleFonts.manrope(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w800,

                                      fontSize: 16,
                                    ),
                                    children:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? [
                                            TextSpan(
                                              text: '\n',

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: settingsController
                                                  .formatPrayerTime(
                                                    calendarData[index]
                                                        .timings
                                                        .maghrib,
                                                    true,
                                                  )
                                                  .split(' ')[1],

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    text:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? settingsController
                                              .formatPrayerTime(
                                                calendarData[index]
                                                    .timings
                                                    .isha,
                                                true,
                                              )
                                              .split(' ')[0]
                                        : settingsController.formatPrayerTime(
                                            calendarData[index].timings.isha,
                                            true,
                                          ),
                                    style: GoogleFonts.manrope(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w800,

                                      fontSize: 16,
                                    ),
                                    children:
                                        settingsController
                                                .timeFormat
                                                .value
                                                .name ==
                                            TimeFormat.twelveHour.name
                                        ? [
                                            TextSpan(
                                              text: '\n',

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: settingsController
                                                  .formatPrayerTime(
                                                    calendarData[index]
                                                        .timings
                                                        .isha,
                                                    true,
                                                  )
                                                  .split(' ')[1],

                                              style: GoogleFonts.manrope(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: mainController.vh.value! * 16),

          Container(
            padding: EdgeInsets.symmetric(
              vertical: mainController.vh.value! * 5,
            ),
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
                  onTap: () => controller.prevMonth(),
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
                  onTap: () => controller.nextMonth(),
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
          SizedBox(height: mainController.vh.value! * 24),
        ],
      ),
    );
  }
}
