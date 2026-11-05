import 'package:get/get.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';

class MainBinding extends Binding {
  @override
  List<Bind<dynamic>> dependencies() => [
    // TODO: implement dependencies
    Bind.lazyPut<MainController>(() => MainController()),
    Bind.lazyPut<SettingsController>(() => SettingsController()),
  ];
}
