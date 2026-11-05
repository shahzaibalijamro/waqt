import 'dart:io';

import 'package:get/get.dart';
import 'package:waqt/utils/app_utils.dart';

class ApiController extends GetxController {
  AppUtils utils = Get.find<AppUtils>();

  RxBool isLoading = true.obs;
  RxBool isOffline = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> isOnline() async {
    try {
      await InternetAddress.lookup('google.com');
      isOffline.value = false;
    } catch (e) {
      isOffline.value = true;
    }
  }
}
