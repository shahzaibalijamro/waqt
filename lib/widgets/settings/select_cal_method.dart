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
                Obx(
                  () => Text(
                    controller.selectedMethod.value.name,
                    style: GoogleFonts.manrope(
                      color: AppColors.mutedText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
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
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchInputController = TextEditingController();

  List<CalculationMethod> searchList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: mainController.horizontalPadding.value!,
        right: mainController.horizontalPadding.value!,
        bottom: focusNode.hasFocus
            ? MediaQuery.of(context).viewInsets.bottom
            : 0,
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
            enabled: !controller.isLoading.value,
            style: GoogleFonts.manrope(
              color: AppColors.mutedText,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            textAlignVertical: const TextAlignVertical(y: 0),
            focusNode: focusNode,
            onTapOutside: (event) => focusNode.unfocus(),
            controller: searchInputController,
            onChanged: (value) => controller.searchMethods(value),
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
          SizedBox(height: mainController.vh.value! * 4),
          Obx(() {
            final List<CalculationMethod> currentList =
                controller.searchQuery.value.isEmpty
                ? controller.calcMethods.value
                : controller.searchResults.value;
            final isSearchList = controller.searchQuery.value.isNotEmpty;
            return controller.isLoading.value
                ? SizedBox(
                    height: mainController.screenHeight.value! / 3,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.selectedColor,
                      ),
                    ),
                  )
                : controller.isOffline.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Column(
                        spacing: 20,
                        children: [
                          Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
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
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Column(
                        spacing: 20,
                        children: [
                          Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.errorMsg.value!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.primaryText,
                                  ),
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
                              padding: const EdgeInsets.symmetric(
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
                : currentList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Column(
                        spacing: 20,
                        children: [
                          Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSearchList
                                    ? 'No methods found'
                                    : "Couldn't load calculation methods",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                          !isSearchList
                              ? InkWell(
                                  onTap: controller.fetchCalculationMethods,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.selectedColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
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
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  )
                : CalculationMethodsList();
          }),
        ],
      ),
    );
  }
}

class CalculationMethodsList extends StatelessWidget {
  CalculationMethodsList({super.key});
  final SettingsController controller = Get.find<SettingsController>();
  final MainController mainController = Get.find<MainController>();

  bool isSelected(CalculationMethod method) =>
      method.id == controller.selectedMethod.value.id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mainController.vh.value! * 4),
        SizedBox(
          height: mainController.screenHeight.value! / 3,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(() {
              final List<CalculationMethod> currentList =
                  controller.searchQuery.value.isEmpty
                  ? controller.calcMethods.value
                  : controller.searchResults.value;
              return Column(
                children: [
                  if (currentList.isNotEmpty)
                    for (int i = 0; i < currentList.length; i++)
                      InkWell(
                        onTap: () =>
                            controller.updateCalculationMethod(currentList[i]),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 16, top: 16),
                          decoration: BoxDecoration(
                            border: i != (currentList.length - 1)
                                ? BoxBorder.fromLTRB(
                                    bottom: BorderSide(
                                      color: AppColors.mutedText.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 1,
                                    ),
                                  )
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            spacing: 14,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: isSelected(currentList[i])
                                      ? AppColors.selectedColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  border: !isSelected(currentList[i])
                                      ? BoxBorder.all(
                                          color: AppColors.selectedColor,
                                          width: 1,
                                        )
                                      : null,
                                ),
                                child: isSelected(currentList[i])
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
                                  currentList[i].name,
                                  style: GoogleFonts.manrope(
                                    color: AppColors.primaryText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              );
            }),
          ),
        ),
        SizedBox(height: mainController.vh.value! * 10),
      ],
    );
  }
}
