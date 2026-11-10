import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/constants/popular_locations.dart';
import 'package:waqt/constants/prefs_keys.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/models/api_response_model.dart';
import 'package:waqt/models/calc_method_model.dart';
import 'package:waqt/models/location_model.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:waqt/widgets/bottom_sheet.dart';

class SettingsController extends GetxController {
  AppUtils utils = Get.find<AppUtils>();
  ApiController apiController = Get.find<ApiController>();
  Rx<Location> location = Location(
    id: 1174872,
    name: 'Karachi',
    latitude: 24.86080,
    longitude: 67.01040,
    country: 'Pakistan',
  ).obs;
  Rxn<Location> recentLocation = Rxn();
  RxBool isLoading = false.obs;
  RxList<CalculationMethod> calcMethods = <CalculationMethod>[].obs;
  RxBool isOffline = false.obs;
  RxnString errorMsg = RxnString();
  RxBool notificationsEnabled = true.obs;
  Rx<TimeFormat> timeFormat = TimeFormat.twentyFourHour.obs;
  Rx<CalculationMethod> selectedMethod = const CalculationMethod(
    id: 1,
    name: 'University of Islamic Sciences, Karachi',
  ).obs;
  Rx<AsrSchool> selectedSchool = AsrSchool.hanafi.obs;
  Rx<String> searchQuery = ''.obs;
  RxList<CalculationMethod> searchResults = <CalculationMethod>[].obs;
  Rx<Locations> popularLocations = popularLocationsList.obs;
  Rx<Locations> searchedLocations = Locations(locations: []).obs;

  @override
  void onInit() {
    super.onInit();
    fetchStoredSettings();
  }

  void fetchStoredSettings() {
    final String? storedLocation = utils.getStringFromPrefs(
      key: AppKeys.location,
    );
    final String? lastLocation = utils.getStringFromPrefs(
      key: AppKeys.recentCalcMethod,
    );
    final String? storedMethod = utils.getStringFromPrefs(
      key: AppKeys.calcMethod,
    );
    final int? storedSchool = utils.getIntFromPrefs(key: AppKeys.asrCalc);
    final String? storedTimeFormat = utils.getStringFromPrefs(
      key: AppKeys.timeFormat,
    );
    final bool? storedNotificationPreference = utils.getBoolFromPrefs(
      key: AppKeys.notifications,
    );
    final String? cachedMethods = utils.getStringFromPrefs(
      key: AppKeys.cachedMethods,
    );
    if (storedLocation != null) {
      location.value = Location.fromJson(jsonDecode(storedLocation));
    }
    if (lastLocation != null) {
      recentLocation.value = Location.fromJson(jsonDecode(lastLocation));
    }
    if (storedMethod != null) {
      selectedMethod.value = CalculationMethod.fromJson(
        jsonDecode(storedMethod),
      );
    }
    if (cachedMethods != null) {
      final Map<String, dynamic> storedMethods = jsonDecode(cachedMethods);
      if (isCalculationMethodsCacheValid(
        DateTime.parse(storedMethods['savedAt']),
      )) {
        for (final String method in storedMethods['methods']) {
          calcMethods.value.add(CalculationMethod.fromJson(jsonDecode(method)));
        }
      }
    }
    if (storedSchool != null) {
      selectedSchool.value = storedSchool == AsrSchool.hanafi.id
          ? AsrSchool.hanafi
          : AsrSchool.shafi;
    }
    if (storedTimeFormat != null) {
      timeFormat.value = storedTimeFormat == TimeFormat.twentyFourHour.name
          ? TimeFormat.twentyFourHour
          : TimeFormat.twelveHour;
    }
    if (storedTimeFormat != null) {
      timeFormat.value = storedTimeFormat == TimeFormat.twentyFourHour.name
          ? TimeFormat.twentyFourHour
          : TimeFormat.twelveHour;
    }
    if (storedNotificationPreference != null) {
      notificationsEnabled.value = storedNotificationPreference;
    }
  }

  void filterPopularCities() {
    searchQuery.value = '';
    // if popular cities has the selected city, we remove it since it would already be present in the recent location section of the UI
    if (popularLocations.value.locations.any(
      (element) => element.id == location.value.id,
    )) {
      final List<Location> filteredLocations = [];
      for (final element in popularLocations.value.locations) {
        if (element.id != location.value.id) {
          print('this is ok');
          filteredLocations.add(element);
        } else {
          print('this one is already selected');
        }
      }
      popularLocations.value = Locations(locations: filteredLocations);
    }
  }

  Future<void> fetchCalculationMethods() async {
    isLoading.value = true;
    final ApiResponse response = await apiController.fetchCalculationMethods();
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
    final List<CalculationMethod> orderedCalcMethods = [];
    for (final method in response.data) {
      if (method.id == selectedMethod.value.id) {
        orderedCalcMethods.insert(0, method);
      } else {
        orderedCalcMethods.add(method);
      }
    }
    calcMethods.value = orderedCalcMethods;
    isLoading.value = false;
    errorMsg.value = null;
  }

  void showCalculationMethodBottomSheet(Widget child) async {
    searchQuery.value = '';
    MyBottomSheet(child: child, scroll: true);
    if (calcMethods.value.isNotEmpty) return;
    await fetchCalculationMethods();
    // storing fetched methods in prefs (caching)
    final List<String> methods = calcMethods.value
        .map((e) => e.toJson(e))
        .toList();
    utils.storeStringInPrefs(
      key: AppKeys.cachedMethods,
      value: jsonEncode({'savedAt': '${DateTime.now()}', 'methods': methods}),
    );
  }

  void showAsrCalculationSchoolBottomSheet(Widget child) {
    MyBottomSheet(child: child);
  }

  void showTimeFormatBottomSheet(Widget child) {
    MyBottomSheet(child: child);
  }

  void updateLocation(Location loc) {
    print(loc.name);
    recentLocation.value = location.value;
    utils.storeStringInPrefs(
      key: AppKeys.recentCalcMethod,
      value: recentLocation.value!.toJson(),
    );
    location.value = loc;
    print(location.value.toJson());
    utils.storeStringInPrefs(key: AppKeys.location, value: loc.toJson());
    Get.back();
  }

  void updateCalculationMethod(CalculationMethod method) {
    selectedMethod.value = method;
    utils.storeStringInPrefs(
      key: AppKeys.calcMethod,
      value: method.toJson(method),
    );
    Get.closeBottomSheet();
    final List<CalculationMethod> orderedCalcMethods = [];
    for (final method in calcMethods.value) {
      if (method.id == selectedMethod.value.id) {
        orderedCalcMethods.insert(0, method);
      } else {
        orderedCalcMethods.add(method);
      }
    }
    calcMethods.value = orderedCalcMethods;
  }

  void updateNotificationsPreference(bool value) {
    notificationsEnabled.value = value;
    utils.storeBoolInPrefs(key: AppKeys.notifications, value: value);
  }

  void updateTimeFormat(TimeFormat value) {
    timeFormat.value = value;
    utils.storeStringInPrefs(key: AppKeys.timeFormat, value: value.name);
    Get.closeBottomSheet();
  }

  void updateAsrSchool(AsrSchool value) {
    selectedSchool.value = value;
    utils.storeIntInPrefs(key: AppKeys.asrCalc, value: value.id);
    Get.closeBottomSheet();
  }

  void searchMethods(String query) {
    searchQuery.value = query;
    searchResults.value = calcMethods.value
        .where(
          (element) =>
              element.name.toLowerCase().contains(query.trim().toLowerCase()),
        )
        .toList();
  }

  void searchLocations(String query) async {
    searchQuery.value = query;
    if (searchQuery.value.length < 3) {
      searchedLocations.value = Locations(
        locations: popularLocations.value.locations
            .where(
              (element) =>
                  element.name.toLowerCase().contains(
                    query.trim().toLowerCase(),
                  ) ||
                  element.country.toLowerCase().contains(
                    query.trim().toLowerCase(),
                  ),
            )
            .toList(),
      );
    } else {
      isLoading.value = true;
      final ApiResponse response = await apiController.fetchLocationsViaApi(
        query,
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
      searchedLocations.value = response.data;
      isLoading.value = false;
      errorMsg.value = null;
    }
  }

  String formatPrayerTime(String time, [bool? singleDigitHour = false]) {
    final int hours = int.parse(time.split(':')[0]);
    if (hours > 12) {
      if (timeFormat.value.name == TimeFormat.twelveHour.name) {
        String formattedPrayerTime = '';
        // 13:55 example
        if (hours - 12 < 10) {
          // 01:55 PM
          formattedPrayerTime =
              '${singleDigitHour != null && singleDigitHour ? '' : '0'}${hours - 12}:${time.split(':')[1].substring(0, 2)} PM';
        } else {
          // 11:55 PM
          formattedPrayerTime =
              '${hours - 12}:${time.split(':')[1].substring(0, 2)} PM';
        }
        return formattedPrayerTime;
      } else {
        return time.substring(0, 5);
      }
    }
    if (hours < 12 && hours > 0) {
      // 11:55 or 05:45
      if (TimeFormat.twelveHour.name == timeFormat.value.name) {
        if (hours < 10 && singleDigitHour != null && singleDigitHour) {
          // 05:45 AM
          return '${time.substring(1, 5)} AM';
        }
        // 11:45
        return '${time.substring(0, 5)} AM';
      }
      // 05:45
      if (hours < 10 && singleDigitHour != null && singleDigitHour) {
        return time.substring(1, 5);
      }
      return time.substring(0, 5);
    }
    if (hours == 12) {
      if (TimeFormat.twelveHour.name == timeFormat.value.name) {
        return '${time.substring(0, 5)} PM';
      }
      return time.substring(0, 5);
    }
    if (TimeFormat.twelveHour.name == timeFormat.value.name) {
      if (singleDigitHour != null && singleDigitHour) {
        return '${time.substring(1, 5)} AM';
      }
      return '${time.substring(0, 5)} AM';
    }
    if (singleDigitHour != null && singleDigitHour) return time.substring(1, 5);
    return time.substring(0, 5);
  }
}

bool isCalculationMethodsCacheValid(DateTime savedAt) {
  final age = DateTime.now().difference(savedAt);

  return !age.isNegative && age <= const Duration(days: 1);
}
