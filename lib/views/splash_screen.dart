import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waqt/constants/routes.dart';
import 'package:waqt/controllers/api_controller.dart';

class SplashScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      await Get.find<ApiController>().isOnline();
      Get.offAllNamed(AppRoutes.main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.png'),
          alignment: AlignmentGeometry.center,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
