import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:waqt/constants/colors.dart';
import 'package:waqt/layout_screen.dart';
import 'package:waqt/widgets/appbar.dart';

class SearchLocation extends StatefulWidget {
  const new({super.key, required this.currentLocation});
  final String currentLocation;

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
      body: Padding(
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
                contentPadding: EdgeInsets.symmetric(
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
                hint: Text(
                  widget.currentLocation,
                  style: GoogleFonts.manrope(
                    color: AppColors.mutedText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
