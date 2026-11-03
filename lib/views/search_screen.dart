import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/layout_screen.dart';
import 'package:waqt/widgets/appbar.dart';

class SearchLocation extends StatefulWidget {
  const new({super.key, this.currentLocation});
  final String? currentLocation;

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final TextEditingController searchInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = (screenWidth * 0.05).clamp(16.0, 24.0).toDouble();
    final vh = MediaQuery.of(context).size.height * 0.01725 / 16;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              MyAppBar(screen: Screen.search, context: context),
              SizedBox(height: vh * 24),
              TextField(
                style: GoogleFonts.manrope(
                  color: AppColors.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 2,
                ),
                controller: searchInputController,
                cursorColor: AppColors.primaryText,
                cursorHeight: 18,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  hoverColor: Colors.transparent,
                  fillColor: AppColors.white,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Icon(
                      PhosphorIconsBold.magnifyingGlass,
                      color: AppColors.primaryText,
                      size: 25,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

                  prefixIconColor: AppColors.primaryText,
                  filled: true,
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
                  hint: widget.currentLocation != null
                      ? Text(
                          widget.currentLocation!,
                          style: GoogleFonts.manrope(
                            color: AppColors.mutedText,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 2,
                          ),
                        )
                      : null,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 16,
                    children: [
                      Transform.rotate(
                        angle: 1.6,
                        child: const Icon(
                          PhosphorIconsFill.navigationArrow,
                          color: AppColors.selectedColor,
                        ),
                      ),
                      Text(
                        'Current Location',
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const LocationTile(
                location: 'Karachi, Pakistan',
                icon: PhosphorIconsBold.checkCircle,
                bordered: true,
              ),
              const LocationTile(
                location: 'Lahore, Pakistan',
                icon: PhosphorIconsBold.clockClockwise,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 16,
                  children: [
                    Text(
                      'Other Cities',
                      style: GoogleFonts.manrope(
                        color: AppColors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
                    ),
                    LocationTile(
                      location: 'Barcelona, Spain',
                      icon: PhosphorIconsBold.mapPin,
                      bordered: true,
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
  });
  final String location;
  final IconData icon;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Column(
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
        ],
      ),
    );
  }
}
