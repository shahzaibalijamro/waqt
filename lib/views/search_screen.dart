import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/constants/enums.dart';
import 'package:waqt/controllers/main_controller.dart';
import 'package:waqt/controllers/settings_controller.dart';
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
    // TODO: implement dispose
    super.dispose();
    searchInputController.dispose();
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
                enabled: true,
                style: GoogleFonts.manrope(
                  color: AppColors.mutedText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                textAlignVertical: const TextAlignVertical(y: -0.1),
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
              LocationTile(
                location:
                    '${controller.location.value.name}, ${controller.location.value.country}',
                icon: PhosphorIconsBold.checkCircle,
                bordered: true,
                selected: true,
              ),
              const LocationTile(
                location: 'Lahore, Pakistan',
                icon: PhosphorIconsBold.clockClockwise,
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
              Expanded(
                child: ListView(
                  physics: const ScrollPhysics(),
                  children: [
                    for (
                      int i = 0;
                      i < controller.popularLocations.value.locations.length;
                      i++
                    )
                      LocationTile(
                        location:
                            '${controller.popularLocations.value.locations[i].name}, ${controller.popularLocations.value.locations[i].country}',
                        icon: PhosphorIconsBold.mapPin,
                        bordered:
                            i !=
                            (controller
                                    .popularLocations
                                    .value
                                    .locations
                                    .length -
                                1),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  const new({
    super.key,
    required this.location,
    required this.icon,
    this.bordered = false,
    this.selected = false,
  });
  final String location;
  final IconData icon;
  final bool bordered;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Icon(icon, color: AppColors.selectedColor, size: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  location.split(', ')[0],
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  location,
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
          selected
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
