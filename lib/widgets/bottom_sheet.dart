import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/colors.dart';

Future<dynamic> MyBottomSheet({required Widget child}) {
  return Get.bottomSheet(
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Manual drag handle
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            color: AppColors.mutedText,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Your content below
        const SizedBox(height: 16),
        child,
      ],
    ),
    enableDrag: true,
    ignoreSafeArea: false,
    backgroundColor: AppColors.backgroundColor,
  );
}
