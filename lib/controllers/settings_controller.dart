import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/constants/prefs_keys.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:waqt/widgets/bottom_sheet.dart';

class SettingsController extends GetxController {
  AppUtils utils = Get.find<AppUtils>();
  RxnString location = RxnString();
  RxBool isLoading = false.obs;
  RxList calcMethods = [].obs;

  RxBool notificationsEnabled = true.obs;
  Rx<TimeFormat> timeFormat = TimeFormat.twentyFourHour.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    location.value =
        (utils.getStringFromPrefs(key: AppKeys.location) ??
        'Karachi, Pakistan');
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void showCalculationMethodBottomSheet(Widget child) {
    MyBottomSheet(child: child);
    if (calcMethods.value.isNotEmpty) {
      isLoading.value = true;
    }
  }
}
