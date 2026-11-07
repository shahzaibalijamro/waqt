import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/models/calc_method_model.dart';

class SelectCalculationMethod extends StatelessWidget {
  SelectCalculationMethod({super.key});
  final SettingsController controller = Get.find<SettingsController>();
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.showCalculationMethodBottomSheet(
        const SelectCalMethodBottomSheet(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 14,
        children: [
          const Icon(
            PhosphorIconsBold.calculator,
            color: AppColors.selectedColor,
            size: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Calculation Method',
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  controller.selectedMethod.value.name,
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
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
    );
  }
}

class SelectCalMethodBottomSheet extends StatefulWidget {
  const new({super.key});

  @override
  State<SelectCalMethodBottomSheet> createState() =>
      _SelectCalMethodBottomSheetState();
}

class _SelectCalMethodBottomSheetState
    extends State<SelectCalMethodBottomSheet> {
  final SettingsController controller = Get.find<SettingsController>();
  final MainController mainController = Get.find<MainController>();
  final TextEditingController searchInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: mainController.horizontalPadding.value!,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calculation Method',
            style: GoogleFonts.manrope(
              color: AppColors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.5,
            ),
          ),
          Text(
            'Choose how your prayer times are calculated.',
            style: GoogleFonts.manrope(
              color: AppColors.mutedText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            enabled: controller.isLoading.value,
            style: GoogleFonts.manrope(
              color: AppColors.mutedText,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            textAlignVertical: const TextAlignVertical(y: -0.1),

            controller: searchInputController,
            cursorColor: AppColors.primaryText,
            cursorHeight: 15,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              isCollapsed: true,
              isDense: true,
              hoverColor: Colors.transparent,
              fillColor: AppColors.white,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Icon(
                  PhosphorIconsBold.magnifyingGlass,
                  color: AppColors.primaryText,
                  size: 25,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                // vertical: 15,
              ),

              prefixIconColor: AppColors.primaryText,
              filled: true,

              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mutedText.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mutedText.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mutedText.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              hint: Text(
                'University of Islamic Sciences, Karachi',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  color: AppColors.mutedText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: mainController.vh.value! * 20),
          Obx(
            () => controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.selectedColor,
                      ),
                    ),
                  )
                : controller.isOffline.value
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                CupertinoIcons.wifi_exclamationmark,
                                color: Colors.red,
                                size: 25,
                              ),
                              Text(
                                'No Internet',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: controller.fetchCalculationMethods,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.selectedColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                'Retry?',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : controller.errorMsg.value != null
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.errorMsg.value!,
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: controller.fetchCalculationMethods,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.selectedColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                'Retry?',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: controller.calcMethods
                        .map(
                          (element) => CalculationMethodListTile(
                            selectedMethod: controller.selectedMethod.value.id,
                            method: element,
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget CalculationMethodListTile({
    required CalculationMethod method,
    required int selectedMethod,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(
            color: AppColors.mutedText.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 14,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: AppColors.selectedColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: selectedMethod == method.id
                ? const Icon(
                    PhosphorIconsBold.check,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    size: 20,
                  )
                : null,
          ),
          Expanded(
            child: Text(
              method.name,
              style: GoogleFonts.manrope(
                color: AppColors.primaryText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                // height: 1,
              ),
            ),
          ),
          if (selectedMethod == method.id) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.selectedColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'SELECTED',
                style: GoogleFonts.manrope(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
