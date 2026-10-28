import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waqt/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/icons/moon.png"),
        titleSpacing: 0,
        centerTitle: false,
        title: Text(
          "Waqt",
          style: GoogleFonts.manrope(
            fontWeight: FontWeight(700),
            fontSize: 24,
            color: AppColors.primaryText,
          ),
        ),
      ),
      body: ListView(),
    );
  }
}
