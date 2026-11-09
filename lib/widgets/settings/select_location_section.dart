import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/routes.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';

class SelectLocation extends StatelessWidget {
  SelectLocation({super.key});

  final MainController controller = Get.find<MainController>();

  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: GoogleFonts.manrope(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 2,
          ),
        ),
        SizedBox(height: controller.vh.value! * 4),
        InkWell(
          onTap: () {
            settingsController.filterPopularCities();
            Get.toNamed(AppRoutes.search);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.listBg,
              borderRadius: BorderRadius.circular(18),
              border: BoxBorder.all(
                color: AppColors.mutedText.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              spacing: 14,
              children: [
                const Icon(
                  PhosphorIconsBold.mapPin,
                  color: AppColors.selectedColor,
                  size: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Obx(
                        () => Text(
                          '${settingsController.location.value.name}, ${settingsController.location.value.country}',
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      Text(
                        'Tap to change city',
                        style: GoogleFonts.manrope(
                          color: AppColors.mutedText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  PhosphorIconsBold.caretRight,
                  color: AppColors.selectedColor,
                  fontWeight: FontWeight.w700,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
