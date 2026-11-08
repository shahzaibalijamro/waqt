import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:waqt/constants/endpoints.dart';
import 'package:waqt/models/api_response_model.dart';
import 'package:waqt/models/calc_method_model.dart';
import 'package:waqt/models/location_model.dart';
import 'package:waqt/utils/app_utils.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  AppUtils utils = Get.find<AppUtils>();

  RxBool isLoading = false.obs;
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

  Future<ApiResponse> fetchCalculationMethods() async {
    await isOnline();
    if (isOffline.value) return ApiResponse(message: 'No internet!');
    try {
      final response = await http.get(AppEndpoints.methods);
      final Map<String, dynamic> rawMethods = jsonDecode(response.body)['data'];
      final methods = rawMethods.values
          .where(
            (method) =>
                method['id'].runtimeType == int &&
                method['name']?.runtimeType == String,
          )
          .map((method) => CalculationMethod.fromJson(method))
          .toList();
      return ApiResponse(message: 'Success', statusCode: 200, data: methods);
    } catch (e) {
      print(e);
      return ApiResponse(message: 'Something went wrong!', statusCode: 500);
    }
  }

  Future<ApiResponse> fetchLocationsViaApi(String query) async {
    await isOnline();
    if (isOffline.value) return ApiResponse(message: 'No internet!');
    try {
      final response = await http.get(
        Uri.parse('${AppEndpoints.locations}?name=$query&count=10'),
      );
      final Locations locations = Locations.fromJson(jsonDecode(response.body));
      return ApiResponse(message: 'Success', statusCode: 200, data: locations);
    } catch (e) {
      print(e);
      return ApiResponse(message: 'Something went wrong!', statusCode: 500);
    }
  }
}
