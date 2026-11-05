import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils extends GetxController {
  SharedPreferences? prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      await initPrefs();
    });
    print("ON INIT");
  }

  String? getStringFromPrefs({required String key}) {
    return prefs!.getString(key);
  }
}
