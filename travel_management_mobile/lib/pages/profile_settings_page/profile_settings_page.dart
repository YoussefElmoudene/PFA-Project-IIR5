import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:travel_management_mobile/pages/login_Page.dart';
import 'package:travel_management_mobile/service/storage.service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/app_bar/appbar_leading_image.dart';
import '../../components/app_bar/appbar_title.dart';
import '../../components/app_bar/appbar_trailing_image.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../components/custom_bottom_bar.dart';
import '../../components/custom_elevated_button.dart';
import '../../components/custom_image_view.dart';
import '../../components/custom_outlined_button.dart';
import '../../components/custom_switch.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../model/user.model.dart';
import '../../routes/app_routes.dart';
import '../../service/user.service.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSelectedSwitch = false;
  late Future<UserModel> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = UserService().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: FutureBuilder(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User data not available'));
          } else {
            final userData = snapshot.data as UserModel;
            return Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 30.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 120.adaptSize,
                        width: 120.adaptSize,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Center(
                              child: Initicon(
                                text:
                                    "${userData.firstName} ${userData.lastName}",
                                backgroundColor: Colors.teal,
                                size: 80.0, // Adjust the size as needed
                                elevation: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.v),
                      // Text("${userData['firstName']} ${userData['lastName']}", style: theme.textTheme.headlineSmall),
                      Text("${userData.firstName}",
                          style: theme.textTheme.headlineSmall),
                      SizedBox(height: 11.v),
                      Text("${userData.lastName}",
                          style: CustomTextStyles.titleSmallWhiteA700),
                      SizedBox(height: 11.v),
                      Text("${userData.tel}",
                          style: CustomTextStyles.titleSmallWhiteA700),
                    ],
                  ),
                  SizedBox(height: 60.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomOutlinedButton(
                        height: 40.v,
                        width: 148.h,
                        text: "Update",
                        leftIcon: Container(
                          margin: EdgeInsets.only(right: 20.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgEdit,
                            height: 28.adaptSize,
                            width: 28.adaptSize,
                          ),
                        ),
                        buttonStyle: CustomButtonStyles.none,
                        buttonTextStyle: CustomTextStyles.titleMediumSemiBold_1,
                        onPressed: () {
                          _showUpdateProfileDialog(context);
                        },
                      ),
                      SizedBox(width: 20.h),
                      // Adjust the spacing between buttons
                      CustomOutlinedButton(
                        height: 40.v,
                        width: 148.h,
                        text: "Logout",
                        leftIcon: Container(
                          margin: EdgeInsets.only(right: 20.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgRefresh,
                            height: 28.adaptSize,
                            width: 28.adaptSize,
                          ),
                        ),
                        buttonStyle: CustomButtonStyles.none,
                        buttonTextStyle: CustomTextStyles.titleMediumSemiBold_1,
                        onPressed: () async {
                          onTapSignOut(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.v),
                  SizedBox(height: 5.v),
                ],
              ),
            );
          }
        },
      ),
    );
  }





  void _showUpdateProfileDialog(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Update Profile",
            style: TextStyle(color: Colors.black),
          ),
          content: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            CustomElevatedButton(
              height: 28.v,
              width: 114.h,
              text: 'update',
              onPressed: () async {
                await UserService().updateProfile(
                  firstNameController.text,
                  lastNameController.text,
                  phoneController.text,
                );
                Navigator.pop(context);
              },
            ),
            CustomElevatedButton(
              height: 28.v,
              width: 114.h,
              text: "cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 50.v,
        leadingWidth: 56.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.logo,
            margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v),
            ),
        title:
            AppbarTitle(text: "Profile", margin: EdgeInsets.only(left: 16.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgClock,
              margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 11.v))
        ]);
  }
  onTapSignOut(BuildContext context) async {
    try {
      await StorageService().deleteAll();

      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print('Error during sign out: $e');
      // Handle errors as needed
    }
  }
}
