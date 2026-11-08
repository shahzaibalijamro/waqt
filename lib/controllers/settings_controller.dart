import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/enums.dart';
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
  Rx<Locations> popularLocations = Locations(
    locations: [
      // Pakistan
      Location(
        id: 1174872,
        name: 'Karachi',
        latitude: 24.86080,
        longitude: 67.01040,
        country: 'Pakistan',
      ),
      Location(
        id: 1172451,
        name: 'Lahore',
        latitude: 31.55800,
        longitude: 74.35071,
        country: 'Pakistan',
      ),
      Location(
        id: 1176615,
        name: 'Islamabad',
        latitude: 33.72148,
        longitude: 73.04329,
        country: 'Pakistan',
      ),
      Location(
        id: 1168197,
        name: 'Peshawar',
        latitude: 34.00800,
        longitude: 71.57849,
        country: 'Pakistan',
      ),

      // Saudi Arabia
      Location(
        id: 104515,
        name: 'Makkah',
        latitude: 21.42664,
        longitude: 39.82563,
        country: 'Saudi Arabia',
      ),
      Location(
        id: 109223,
        name: 'Madinah',
        latitude: 24.46861,
        longitude: 39.61417,
        country: 'Saudi Arabia',
      ),

      // United Arab Emirates
      Location(
        id: 292223,
        name: 'Dubai',
        latitude: 25.07725,
        longitude: 55.30927,
        country: 'United Arab Emirates',
      ),

      // Türkiye
      Location(
        id: 745044,
        name: 'Istanbul',
        latitude: 41.01384,
        longitude: 28.94966,
        country: 'Türkiye',
      ),

      // Malaysia
      Location(
        id: 1733046,
        name: 'Kuala Lumpur',
        latitude: 3.14309,
        longitude: 101.68653,
        country: 'Malaysia',
      ),

      // Singapore
      Location(
        id: 1880252,
        name: 'Singapore',
        latitude: 1.28967,
        longitude: 103.85007,
        country: 'Singapore',
      ),

      // Egypt
      Location(
        id: 360630,
        name: 'Cairo',
        latitude: 30.06263,
        longitude: 31.24967,
        country: 'Egypt',
      ),

      // United Kingdom
      Location(
        id: 2643743,
        name: 'London',
        latitude: 51.50853,
        longitude: -0.12574,
        country: 'United Kingdom',
      ),

      // Canada
      Location(
        id: 6167865,
        name: 'Toronto',
        latitude: 43.65333,
        longitude: -79.38389,
        country: 'Canada',
      ),

      // United States
      Location(
        id: 5128581,
        name: 'New York',
        latitude: 40.71427,
        longitude: -74.00597,
        country: 'United States',
      ),
    ],
  ).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(AppKeys.notifications);

    fetchStoredSettings();
  }

  void fetchStoredSettings() {
    print(AppKeys.notifications);
    final String? storedLocation = utils.getStringFromPrefs(
      key: AppKeys.location,
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
    print("here?");
    // if (storedLocation != null) location.value = storedLocation;
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
      print(storedSchool);
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
      print(storedNotificationPreference);
      notificationsEnabled.value = storedNotificationPreference;
    }
  }

  Future<void> fetchCalculationMethods() async {
    isLoading.value = true;
    final ApiResponse response = await apiController.fetchCalculationMethods();
    // unsuccessfull request
    if (response.statusCode != 200) {
      // network error
      if (response.message == "No internet!") {
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
}

bool isCalculationMethodsCacheValid(DateTime savedAt) {
  final age = DateTime.now().difference(savedAt);

  return !age.isNegative && age <= const Duration(days: 1);
}
