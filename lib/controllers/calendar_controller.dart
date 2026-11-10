import 'dart:convert';

import 'package:get/get.dart';
import 'package:waqt/constants/prefs_keys.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/models/api_response_model.dart';
import 'package:waqt/models/prayer_model.dart';
import 'package:waqt/utils/app_utils.dart';

class CalendarController extends GetxController {
  AppUtils appUtils = Get.find<AppUtils>();
  SettingsController settingsController = Get.find<SettingsController>();
  ApiController apiController = Get.find<ApiController>();
  Rxn<List<PrayerResponse>> calendarData = Rxn();
  RxBool isLoading = false.obs;
  RxnString errorMsg = RxnString();
  RxBool isOffline = false.obs;
  RxInt selectedMonth = DateTime.now().month.obs;
  RxInt selectedYear = DateTime.now().year.obs;

  @override
  void onInit() {
    super.onInit();
    checkCalendarData();
  }

  void nextMonth() {
    if ((selectedMonth.value + 1) == 13) {
      selectedMonth.value = 1;
      selectedYear.value++;
    } else {
      selectedMonth.value++;
    }
    checkCalendarData();
  }

  void prevMonth() {
    if ((selectedMonth.value - 1) == 0) {
      selectedMonth.value = 12;
      selectedYear.value--;
    } else {
      selectedMonth.value--;
    }
    checkCalendarData();
  }

  void checkCalendarData() {
    if (isLoading.value) return;

    final String? savedCalendarData = appUtils.getStringFromPrefs(
      key: AppKeys.calendarData,
    );

    if (savedCalendarData != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(savedCalendarData);

        if (isCalendarDataCacheValid(data)) {
          final List<Map<String, dynamic>> rawData = data['data'];
          calendarData.value = rawData
              .map((e) => PrayerResponse.fromJson(e))
              .toList();
          print(calendarData.value!.length);
          print("cache valid");

          isOffline.value = false;
          errorMsg.value = null;

          return;
        }
      } catch (e) {
        print('Invalid calendar cache: $e');
      }
    }

    fetchCalendarData();
  }

  Future<void> fetchCalendarData() async {
    isLoading.value = true;
    final ApiResponse response = await apiController.fetchCalendarData(
      selectedYear.value.toString(),
      selectedMonth.value.toString(),
      settingsController.location.value.latitude,
      settingsController.location.value.longitude,
      settingsController.selectedMethod.value.id,
      settingsController.selectedSchool.value.id,
    );
    // unsuccessfull request
    if (response.statusCode != 200) {
      // network error
      if (response.message == 'No internet!') {
        isOffline.value = true;
        isLoading.value = false;
        return;
      }
      // server error
      errorMsg.value = response.message;
      isLoading.value = false;
      return;
    }
    // successful response
    calendarData.value = response.data;
    final jsonData = calendarData.value!.map((e) => e.toJson()).toList();
    appUtils.storeStringInPrefs(
      key: AppKeys.calendarData,
      value: jsonEncode({
        'cacheKey': currentCacheKey,
        'data': jsonData,
        'savedAt': DateTime.now().toString(),
      }),
    );
    isLoading.value = false;
    isOffline.value = false;
    errorMsg.value = null;
  }

  bool isCalendarDataCacheValid(Map<String, dynamic> data) {
    return data['cacheKey'] == currentCacheKey;
  }

  String get currentCacheKey {
    final location = settingsController.location.value;
    print(location.toJson());

    return [
      selectedYear.value.toString(),
      selectedMonth.value.toString(),
      location.latitude,
      location.longitude,
      settingsController.selectedMethod.value.id,
      settingsController.selectedSchool.value.id,
    ].join('|');
  }
}
