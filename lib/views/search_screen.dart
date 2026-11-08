import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
import 'package:waqt/models/location_model.dart';
import 'package:waqt/widgets/appbar.dart';

class SearchLocation extends StatefulWidget {
  const new({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final TextEditingController searchInputController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SettingsController controller = Get.find<SettingsController>();
  final MainController mainController = Get.find<MainController>();

  @override
  void dispose() {
    super.dispose();
    searchInputController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mainController.horizontalPadding.value!,
          ),
          child: Column(
            children: [
              MyAppBar(screen: Screen.search),
              SizedBox(height: mainController.vh.value! * 16),
              TextField(
                onChanged: (value) => controller.searchLocations(value),
                enabled: true,
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
                // onChanged: (value) => controller.searchMethods(value),
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
                    'Search for city or country...',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      color: AppColors.mutedText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mainController.vh.value! * 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                spacing: 16,
                children: [
                  Expanded(
                    child: Text(
                      'Recent Locations',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => LocationTile(
                  location: controller.location.value,
                  icon: PhosphorIconsBold.checkCircle,
                  bordered: controller.recentLocation.value != null,
                ),
              ),
              Obx(
                () => controller.recentLocation.value != null
                    ? LocationTile(
                        location: controller.recentLocation.value!,
                        icon: PhosphorIconsBold.clockClockwise,
                      )
                    : const SizedBox.shrink(),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                spacing: 16,
                children: [
                  Expanded(
                    child: Text(
                      'Popular Cities',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                final List<Location> currentList =
                    controller.searchQuery.value.isNotEmpty
                    ? controller.searchedLocations.value.locations
                    : controller.popularLocations.value.locations;
                // final isSearchList = controller.searchQuery.value.isNotEmpty;
                if (controller.isLoading.value) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.selectedColor,
                      ),
                    ),
                  );
                }
                if (controller.isOffline.value) {
                  return Expanded(
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
                  );
                }
                if (controller.errorMsg.value != null) {
                  return Expanded(
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
                  );
                }
                if (currentList.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.searchQuery.value.length < 3
                                      ? 'Keep typing to search'
                                      : 'No locations found',
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
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView(
                    physics: const ScrollPhysics(),
                    children: [
                      for (int i = 0; i < currentList.length; i++)
                        LocationTile(
                          location: currentList[i],
                          icon: PhosphorIconsBold.mapPin,
                          bordered: i != (currentList.length - 1),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  LocationTile({
    super.key,
    required this.location,
    required this.icon,
    this.bordered = false,
  });
  final Location location;
  final IconData icon;
  final bool bordered;
  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(location.name);
        print(controller.location.value.name);
        controller.updateLocation(location);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: bordered
              ? BoxBorder.fromLTRB(
                  bottom: BorderSide(
                    color: AppColors.mutedText.withValues(alpha: 0.3),
                  ),
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 14,
          children: [
            Icon(icon, color: AppColors.selectedColor, size: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    location.name,
                    style: GoogleFonts.manrope(
                      color: AppColors.primaryText,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  Text(
                    '${location.name}, ${location.country}',
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
            location.id == controller.location.value.id
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: AppColors.primaryText,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Selected',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
