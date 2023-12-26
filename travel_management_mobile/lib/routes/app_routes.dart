import 'package:flutter/material.dart';
import 'package:travel_management_mobile/pages/home_screen_container_screen/home_screen_container_screen.dart';
import 'package:travel_management_mobile/pages/home_screen_page/home_screen_page.dart';
import 'package:travel_management_mobile/pages/profile_settings_page/profile_settings_page.dart';

import '../pages/login_Page.dart';
import '../pages/operation_page/booking_ongoing_page.dart';
import '../pages/signUp_Page.dart';
import '../pages/splash_Page.dart';


class AppRoutes {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String dashboard = '/dashboard';
  static const String operations = '/operations';
  static const String homeScreen = '/home';
  static const String profileScreen = '/profile';
  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashPage(),
    loginScreen: (context) => LoginPage(),
    signUpScreen: (context) => SignUpPage(),
    profileScreen: (context) => ProfilePage(),
    homeScreen: (context) => HomeContainerScreen(),
    operations: (context) => BookingOngoingPage(),
    // dashboard: (context) => DashboardPage(),
    // homeScreen: (context) => HomeContainerScreen(),
    // profileScreen: (context) => ProfilePage()
  };
}
