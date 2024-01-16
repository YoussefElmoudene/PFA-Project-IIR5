import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_management_mobile/core/utils/size_utils.dart';
import 'package:travel_management_mobile/pages/bottom_navigation/home_screen_container_screen.dart';
import 'package:travel_management_mobile/routes/app_routes.dart';
import 'package:travel_management_mobile/service/storage.service.dart';

import '../components/custom_image_view.dart';
import '../core/utils/image_constant.dart';
import '../theme/custom_text_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late MediaQueryData mediaQueryData;
  late ThemeData theme;

  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      await init();
    });
    super.initState();
  }

  Future<void> init() async {
    String? token = await StorageService().getToken();

    if (token == null || token.isEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeContainerScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.splashimg1,
                height: 420.v,
                width: 428.h,
              ),
              SizedBox(height: 76.v),
              _buildWelcomeSection(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to",
            style: theme.textTheme.displayMedium,
          ),
          SizedBox(height: 23.v),
          Text(
            "TravelClaim ",
            style: theme.textTheme.displayLarge,
          ),
          SizedBox(height: 40.v),
          Container(
            width: 319.h,
            margin: EdgeInsets.only(right: 44.h),
            child: Text(
              "Empower Your Journey, Reclaim Your Costs: Your Business Travels, Your Refunds",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleMediumSemiBold_1.copyWith(
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
