import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waqt/constants/prefs_keys.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/models/api_response_model.dart';
import 'package:waqt/models/prayer_model.dart';
import 'package:waqt/utils/app_utils.dart';

class HomeController extends GetxController {
  AppUtils appUtils = Get.find<AppUtils>();
  SettingsController settingsController = Get.find<SettingsController>();
  ApiController apiController = Get.find<ApiController>();
  Rxn<PrayerResponse> prayerData = Rxn();
  RxBool isLoading = false.obs;
  RxnString errorMsg = RxnString();
  RxBool isOffline = false.obs;
  Rxn<NextPrayer> nextPrayer = Rxn<NextPrayer>();

  @override
  void onInit() {
    super.onInit();
    checkPrayerData();
  }

  void checkPrayerData() {
    if (isLoading.value) return;

    final String? savedPrayerData = appUtils.getStringFromPrefs(
      key: AppKeys.prayerData,
    );

    if (savedPrayerData != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(savedPrayerData);

        if (isPrayerDataCacheValid(data)) {
          prayerData.value = PrayerResponse.fromJson(data['data']);
          print('cache valid');
          calculateNextPrayer();

          isOffline.value = false;
          errorMsg.value = null;

          return;
        }
      } catch (e) {
        print('Invalid prayer cache: $e');
      }
    }

    fetchPrayerData();
  }

  Future<void> fetchPrayerData() async {
    isLoading.value = true;
    final ApiResponse response = await apiController.fetchPrayerData(
      DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
    // first we order the list in a way that the selected method is first for user experience
    prayerData.value = response.data;
    final String value = jsonEncode({
      'cacheKey': currentCacheKey,
      'data': prayerData.value!.toJson(),
      'savedAt': '${DateTime.now()}',
    });
    appUtils.storeStringInPrefs(key: AppKeys.prayerData, value: value);
    print(value);
    calculateNextPrayer();
    isLoading.value = false;
    isOffline.value = false;
    errorMsg.value = null;
  }

  void calculateNextPrayer() {
    final data = prayerData.value;
    if (data == null) {
      nextPrayer.value = null;
      return;
    }

    final DateTime currentTime = DateTime.now();
    final timings = data.timings.toJson();
    final entries = timings.entries.toList();
    nextPrayer.value = null;

    for (final entry in entries) {
      final thisPrayer = entry.value;
      final DateTime thisPrayerDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        int.parse(thisPrayer.split(':')[0]),
        int.parse(thisPrayer.split(':')[1]),
      );
      if (thisPrayerDateTime.isAfter(currentTime)) {
        nextPrayer.value = NextPrayer(
          name: entry.key,
          time: thisPrayer,
          beginsIn: _countdownUntil(currentTime, thisPrayerDateTime),
        );
        break;
      }
    }

    if (nextPrayer.value == null) {
      final fajr = timings['Fajr'];
      if (fajr == null) return;

      final fajrTomorrow = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day + 1,
        int.parse(fajr.split(':')[0]),
        int.parse(fajr.split(':')[1]),
      );
      nextPrayer.value = NextPrayer(
        name: 'Fajr',
        time: fajr,
        beginsIn: _countdownUntil(currentTime, fajrTomorrow),
        isTomorrow: true,
      );
    }
  }

  String _countdownUntil(DateTime now, DateTime prayerTime) {
    final difference = prayerTime.difference(now);
    return 'Begins in ${difference.inHours}ʰ ${difference.inMinutes.remainder(60)}m';
  }

  bool isPrayerDataCacheValid(Map<String, dynamic> data) {
    return data['cacheKey'] == currentCacheKey;
  }

  String get currentCacheKey {
    final location = settingsController.location.value;

    return [
      DateFormat('yyyy-MM-dd').format(DateTime.now()),
      location.latitude,
      location.longitude,
      settingsController.selectedMethod.value.id,
      settingsController.selectedSchool.value.id,
    ].join('|');
  }
}
