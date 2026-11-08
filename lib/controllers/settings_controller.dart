import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/constants/prefs_keys.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/models/api_response_model.dart';
import 'package:waqt/models/calc_method_model.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:waqt/widgets/bottom_sheet.dart';

class SettingsController extends GetxController {
  AppUtils utils = Get.find<AppUtils>();
  ApiController apiController = Get.find<ApiController>();
  RxString location = 'Karachi, Pakistan'.obs;
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
    print("here?");
    if (storedLocation != null) location.value = storedLocation;
    if (storedMethod != null) {
      selectedMethod.value = CalculationMethod.fromJson(
        jsonDecode(storedMethod),
      );
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
