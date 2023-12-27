
import 'package:flutter/material.dart';
import 'package:travel_management_mobile/pages/profile_settings_page/profile_settings_page.dart';

import '../../components/custom_bottom_bar.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../home_screen_page/home_screen_page.dart';
import '../operation_page/booking_ongoing_page.dart';

// ignore_for_file: must_be_immutable
class HomeContainerScreen extends StatelessWidget {
  HomeContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return  Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.homeScreen,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildBottomBar(context));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreen;
      case BottomBarEnum.Booking:
        return AppRoutes.operations;
      case BottomBarEnum.Profile:
        return AppRoutes.profileScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeScreen:
        return HomeScreenPage();
      case AppRoutes.operations:
        return BookingOngoingPage();
      case AppRoutes.profileScreen:
        return ProfilePage();
      default:
        return DefaultWidget();
    }
  }
}
