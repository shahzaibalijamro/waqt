import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/widgets/appbar.dart';
import 'package:waqt/widgets/settings/prayer_calc_section.dart';
import 'package:waqt/widgets/settings/preference_section.dart';
import 'package:waqt/widgets/settings/select_location_section.dart';

class SettingsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController controller = Get.find<SettingsController>();
  MainController mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        spacing: mainController.vh.value! * 16,
        children: [
          MyAppBar(screen: Screen.settings),
          SelectLocation(),
          const PrayerCalcSection(),
          PreferenceSection(),
        ],
      ),
    );
  }
}
