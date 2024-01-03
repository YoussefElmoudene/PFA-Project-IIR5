import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/app_bar/appbar_leading_image.dart';
import '../../components/app_bar/appbar_title.dart';
import '../../components/app_bar/appbar_trailing_image.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../components/custom_bottom_bar.dart';
import '../../components/custom_elevated_button.dart';
import '../../components/custom_image_view.dart';
import '../../components/custom_switch.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

// ignore_for_file: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  bool isSelectedSwitch = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        appBar: CustomAppBar(
            height: 50.v,
            leadingWidth: 56.h,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.logo,
                margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v)),
            title: AppbarTitle(
                text: "Profile", margin: EdgeInsets.only(left: 16.h)),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgIcons,
                margin: EdgeInsets.only(left: 24.h, top: 11.v, right: 11.h),
              ),
              AppbarTrailingImage(
                  imagePath: ImageConstant.imgClock,
                  margin: EdgeInsets.only(left: 20.h, top: 11.v, right: 35.h))
            ]),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 30.v),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              _buildProfile(context),
              SizedBox(height: 60.v),
              CustomElevatedButton(
                  height: 28.v,
                  width: 134.h,
                  text: "Edit Profile",
                  leftIcon: Container(
                      margin: EdgeInsets.only(right: 20.h),
                      child: CustomImageView(
                          imagePath: ImageConstant.imgUser,
                          height: 28.adaptSize,
                          width: 28.adaptSize)),
                  buttonStyle: CustomButtonStyles.none,
                  buttonTextStyle: CustomTextStyles.titleMediumSemiBold_1,
                  onPressed: () {
                    onTapEditProfile(context);
                  }),
              SizedBox(height: 30.v),
              Row(children: [
                CustomImageView(
                    imagePath: ImageConstant.imgUser,
                    height: 28.adaptSize,
                    width: 28.adaptSize),
                Padding(
                    padding: EdgeInsets.only(left: 20.h, top: 5.v),
                    child: Text("First Name",
                        style: CustomTextStyles.titleMediumSemiBold_1))
              ]),
              SizedBox(height: 15.v),
                  Row(children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgUser,
                        height: 28.adaptSize,
                        width: 28.adaptSize),
                    Padding(
                        padding: EdgeInsets.only(left: 20.h, top: 5.v),
                        child: Text("Last Name",
                            style: CustomTextStyles.titleMediumSemiBold_1))
                  ]),
              SizedBox(height: 15.v),
                  Row(children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgUser,
                        height: 28.adaptSize,
                        width: 28.adaptSize),
                    Padding(
                        padding: EdgeInsets.only(left: 20.h, top: 5.v),
                        child: Text("Email",
                            style: CustomTextStyles.titleMediumSemiBold_1))
                  ]),
                  SizedBox(height: 15.v),

                  Row(children: [
                CustomImageView(
                    imagePath: ImageConstant.imgRefresh,
                    height: 28.adaptSize,
                    width: 28.adaptSize),
                Padding(
                    padding: EdgeInsets.only(left: 20.h, top: 5.v),
                    child: Text("Logout",
                        style: CustomTextStyles.titleMediumRed400))
              ]),
              SizedBox(height: 5.v)
            ])));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 50.v,
        leadingWidth: 56.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.logo,
            margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v),
            onTap: () {
              onTapGoogle(context);
            }),
        title:
            AppbarTitle(text: "Profile", margin: EdgeInsets.only(left: 16.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgClock,
              margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 11.v))
        ]);
  }

  Widget _buildProfile(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 120.adaptSize,
          width: 120.adaptSize,
          child: Stack(alignment: Alignment.bottomRight, children: [
            CustomImageView(
                imagePath: ImageConstant.imgEllipse120x120,
                height: 120.adaptSize,
                width: 120.adaptSize,
                radius: BorderRadius.circular(60.h),
                alignment: Alignment.center),
            CustomImageView(
                imagePath: ImageConstant.imgEdit,
                height: 30.adaptSize,
                width: 30.adaptSize,
                alignment: Alignment.bottomRight)
          ])),
      SizedBox(height: 10.v),
      Text("Daniel Austin", style: theme.textTheme.headlineSmall),
      SizedBox(height: 11.v),
      Text("uder@domain.com", style: CustomTextStyles.titleSmallWhiteA700)
    ]);
  }



  /// Opens a URL in the device's default web browser.
  ///
  /// The [context] parameter is the `BuildContext` of the widget that invoked the function.
  ///
  /// Throws an exception if the URL could not be launched.
  onTapGoogle(BuildContext context) async {
    var url = 'https://accounts.google.com/';
    if (!await launch(url)) {
      throw 'Could not launch https://accounts.google.com/';
    }
  }

  /// Navigates to the editProfileScreen when the action is triggered.
  onTapEditProfile(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.editProfileScreen);
  }

  /// Navigates to the notificationSettingsScreen when the action is triggered.
  onTapNotifications(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.notificationSettingsScreen);
  }

  /// Navigates to the securityScreen when the action is triggered.
  onTapSecurity(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.securityScreen);
  }
}
