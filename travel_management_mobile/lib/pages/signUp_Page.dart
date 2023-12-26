
import 'package:flutter/material.dart';

import '../components/custom_checkbox_button.dart';
import '../components/custom_elevated_button.dart';
import '../components/custom_image_view.dart';
import '../components/custom_text_form_field.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../routes/app_routes.dart';
import '../theme/app_decoration.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool rememberme = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return  Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.h, vertical: 11.v),
                    child: Column(children: [
                      SizedBox(height: 70.v),

                      CustomImageView(imagePath: ImageConstant.logo,
                          height: 120.adaptSize,
                          width: 120.adaptSize,
                          alignment: Alignment.center,
                          onTap: () {
                            onTapImgArrowLeft(context);
                          }),
                      SizedBox(height: 50.v),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              child: Text("Sign Up",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.displayMedium!
                                      .copyWith(height: 1.50)))),
                      SizedBox(height: 20.v),
                      _buildCreateAccountForm(context),
                      SizedBox(height: 30.v),
                      _buildOrDivider(context),
                      SizedBox(height: 10.v),
                      _buildSocial(context),
                      SizedBox(height: 20.v),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: CustomTextStyles.bodyMediumGray50_1),
                            GestureDetector(
                                onTap: () {
                                  onTapTxtSignIn(context);
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(left: 8.h),
                                    child: Text("Sign in",
                                        style: theme.textTheme.titleSmall)))
                          ]),
                      SizedBox(height: 5.v)
                    ]))));
  }

  /// Section Widget
  Widget _buildCreateAccountForm(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomTextFormField(
          controller: emailController,
          hintText: "First Name",
          textInputType: TextInputType.text,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgUser,
                  height: 20.adaptSize,
                  width: 20.adaptSize)),
          prefixConstraints: BoxConstraints(maxHeight: 60.v),
          contentPadding:
          EdgeInsets.only(top: 21.v, right: 30.h, bottom: 21.v)),
      SizedBox(height: 20.v),
      CustomTextFormField(
          controller: emailController,
          hintText: "Last Name",
          textInputType: TextInputType.text,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgCheckmark,
                  height: 20.adaptSize,
                  width: 20.adaptSize)),
          prefixConstraints: BoxConstraints(maxHeight: 60.v),
          contentPadding:
          EdgeInsets.only(top: 21.v, right: 30.h, bottom: 21.v)),
      SizedBox(height: 20.v),
      CustomTextFormField(
          controller: emailController,
          hintText: "Email",
          textInputType: TextInputType.emailAddress,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgCheckmark,
                  height: 20.adaptSize,
                  width: 20.adaptSize)),
          prefixConstraints: BoxConstraints(maxHeight: 60.v),
          contentPadding:
          EdgeInsets.only(top: 21.v, right: 30.h, bottom: 21.v)),
      SizedBox(height: 20.v),
      CustomTextFormField(
          controller: passwordController,
          hintText: "Password",
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLock,
                  height: 20.adaptSize,
                  width: 20.adaptSize)),
          prefixConstraints: BoxConstraints(maxHeight: 60.v),
          suffix: Container(
              margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgDashboard,
                  height: 20.adaptSize,
                  width: 20.adaptSize)),
          suffixConstraints: BoxConstraints(maxHeight: 60.v),
          obscureText: true,
          contentPadding: EdgeInsets.symmetric(vertical: 21.v)),
      SizedBox(height: 20.v),
      CustomCheckboxButton(
          text: "Remember me",
          value: rememberme,
          padding: EdgeInsets.symmetric(vertical: 3.v),
          onChange: (value) {
            rememberme = value;
          }),
      SizedBox(height: 20.v),
      CustomElevatedButton(
          text: "Sign Up",
          onPressed: () {
            onTapSignUp(context);
          })
    ]);
  }

  /// Section Widget
  Widget _buildOrDivider(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 11.v, bottom: 9.v),
                  child: SizedBox(width: 96.h, child: Divider())),
              Text("or continue with",
                  style: CustomTextStyles.titleMediumGray50),
              Padding(
                  padding: EdgeInsets.only(top: 11.v, bottom: 9.v),
                  child: SizedBox(width: 96.h, child: Divider()))
            ]));
  }

  /// Section Widget
  Widget _buildSocial(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 38.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 60.v,
              width: 88.h,
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 17.v),
              decoration: AppDecoration.outlineGray
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLogosfacebook,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  alignment: Alignment.center)),
          Container(
              height: 60.v,
              width: 87.h,
              margin: EdgeInsets.only(left: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 17.v),
              decoration: AppDecoration.outlineGray
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
              child: CustomImageView(
                  imagePath: ImageConstant.imgFrame,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  alignment: Alignment.center)),
          Container(
              height: 60.v,
              width: 88.h,
              margin: EdgeInsets.only(left: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 31.h, vertical: 17.v),
              decoration: AppDecoration.outlineGray
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
              child: CustomImageView(
                  imagePath: ImageConstant.imgFrameWhiteA700,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  alignment: Alignment.center))
        ]));
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the fillProfileScreen when the action is triggered.
  onTapSignUp(BuildContext context) {
  //  Navigator.pushNamed(context, AppRoutes.fillProfileScreen);
  }

  /// Navigates to the fillProfileScreen when the action is triggered.
  onTapTxtSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
