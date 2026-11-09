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
    final String? savedPrayerData = appUtils.getStringFromPrefs(
      key: AppKeys.prayerData,
    );
    if (savedPrayerData != null) {
      final Map<String, dynamic> data = jsonDecode(savedPrayerData);
      if (isPrayerDataCacheValid(
        DateTime.parse(data['savedAt']),
        data['location'],
      )) {
        print('cache valid');
        prayerData.value = PrayerResponse.fromJson(data['data']);
        calculateNextPrayer();
      } else {
        print('cache invalid, fetching data');
        Future.delayed(Duration.zero, fetchPrayerData);
        return;
      }
    } else {
      Future.delayed(Duration.zero, fetchPrayerData);
    }
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
    appUtils.storeStringInPrefs(
      key: AppKeys.prayerData,
      value: jsonEncode({
        'data': prayerData.value!.toJson(),
        'savedAt': '${DateTime.now()}',
        'location':
            '${settingsController.location.value.name}, ${settingsController.location.value.country}',
      }),
    );
    calculateNextPrayer();
    isLoading.value = false;
    errorMsg.value = null;
  }

  void calculateNextPrayer() {
    final DateTime currentTime = DateTime.now();
    for (var i = 0; i < prayerData.value!.timings.toJson().values.length; i++) {
      String thisPrayer = prayerData.value!.timings.toJson().values.toList()[i];
      final DateTime thisPrayerDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        int.parse(thisPrayer.split(':')[0]),
        int.parse(thisPrayer.split(':')[1]),
      );
      if (thisPrayerDateTime.isAfter(currentTime)) {
        nextPrayer.value = NextPrayer(
          name: prayerData.value!.timings.toJson().keys.toList()[i],
          time: thisPrayer,
          beginsIn:
              'Begins in ${thisPrayerDateTime.difference(currentTime).toString().split(':')[0]}ʰ ${thisPrayerDateTime.difference(currentTime).toString().split(':')[1]}m',
        );
        break;
      }
    }
    // print(closestNextPrayer.toString());
  }

  bool isPrayerDataCacheValid(DateTime savedAt, String location) {
    final DateTime today = DateTime.now();
    return ('${today.day}${today.month}' == '${savedAt.day}${savedAt.month}') &&
        (location ==
            '${settingsController.location.value.name}, ${settingsController.location.value.country}');
  }
}
