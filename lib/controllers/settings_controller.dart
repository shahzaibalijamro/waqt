import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/constants/prefs_keys.dart';
import 'package:waqt/controllers/api_controller.dart';
import 'package:waqt/models/api_response.dart';
import 'package:waqt/models/calc_method_model.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:waqt/widgets/bottom_sheet.dart';

class SettingsController extends GetxController {
  AppUtils utils = Get.find<AppUtils>();
  ApiController apiController = Get.find<ApiController>();
  RxnString location = RxnString();
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
  Rx<School> selectedSchool = School.hanafi.obs;

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
    calcMethods.value = response.data;
    isLoading.value = false;
    errorMsg.value = null;
  }

  void showCalculationMethodBottomSheet(Widget child) async {
    MyBottomSheet(child: child);
    print(calcMethods.value);
    if (calcMethods.value.isNotEmpty) return;
    await fetchCalculationMethods();
  }

  void showAsrCalculationSchoolBottomSheet(Widget child) {
    MyBottomSheet(child: child);
  }
}
