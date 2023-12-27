
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

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool rememberme = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(key: _formKey,
            child: Container(width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 11.v),
                child: Column(
                    children: [
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
                          //width: 320.h,
                          child: Text("Sign In",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.displayMedium!
                                  .copyWith(height: 1.50)))),
                  SizedBox(height: 21.v),
                  _buildLoginForm(context),
                  SizedBox(height: 57.v),
                  _buildOrDivider(context),
                  SizedBox(height: 33.v),
                  _buildSocialMediaLogin(context),
                  SizedBox(height: 20.v),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 1.v),
                            child: Text("Don’t have an account?",
                                style: CustomTextStyles.bodyMediumGray50_1)),
                        GestureDetector(onTap: () {
                          onTapTxtSignUp(context);
                        },
                            child: Padding(padding: EdgeInsets.only(left: 8.h),
                                child: Text("Sign up",
                                    style: theme.textTheme.titleSmall)))
                      ]),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  Widget _buildLoginForm(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(controller: emailController,
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
                  child: CustomImageView(imagePath: ImageConstant.imgCheckmark,
                      height: 20.adaptSize,
                      width: 20.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              contentPadding: EdgeInsets.only(
                  top: 21.v, right: 30.h, bottom: 21.v)),
          SizedBox(height: 24.v),
          CustomTextFormField(controller: passwordController,
              hintText: "Password",
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              prefix: Container(
                  margin: EdgeInsets.fromLTRB(20.h, 20.v, 12.h, 20.v),
                  child: CustomImageView(imagePath: ImageConstant.imgLock,
                      height: 20.adaptSize,
                      width: 20.adaptSize)),
              prefixConstraints: BoxConstraints(maxHeight: 60.v),
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgDashboardBlueGray100,
                      height: 20.adaptSize,
                      width: 20.adaptSize)),
              suffixConstraints: BoxConstraints(maxHeight: 60.v),
              obscureText: true,
              contentPadding: EdgeInsets.symmetric(vertical: 21.v)),
          SizedBox(height: 24.v),
          CustomCheckboxButton(text: "Remember me",
              value: rememberme,
              padding: EdgeInsets.symmetric(vertical: 2.v),
              onChange: (value) {
                rememberme = value;
              }),
          SizedBox(height: 24.v),
          CustomElevatedButton(text: "Sign In"),
          SizedBox(height: 28.v),
          Align(alignment: Alignment.center, child: GestureDetector(onTap: () {
            onTapTxtForgotThePassword(context);
          },
              child: Text("Forgot the password?",
                  style: CustomTextStyles.titleMediumPrimarySemiBold)))
        ]);
  }

  /// Section Widget
  Widget _buildOrDivider(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.only(top: 11.v, bottom: 9.v),
                  child: SizedBox(width: 96.h, child: Divider())),
              Text("or continue with",
                  style: CustomTextStyles.titleMediumGray50),
              Padding(padding: EdgeInsets.only(top: 11.v, bottom: 9.v),
                  child: SizedBox(width: 96.h, child: Divider()))
            ]));
  }

  /// Section Widget
  Widget _buildSocialMediaLogin(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 38.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 60.v,
                  width: 88.h,
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.h, vertical: 17.v),
                  decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder16),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgLogosfacebook,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.center)),
              Container(height: 60.v,
                  width: 87.h,
                  margin: EdgeInsets.only(left: 20.h),
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.h, vertical: 17.v),
                  decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder16),
                  child: CustomImageView(imagePath: ImageConstant.imgFrame,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.center)),
              Container(height: 60.v,
                  width: 88.h,
                  margin: EdgeInsets.only(left: 20.h),
                  padding: EdgeInsets.symmetric(
                      horizontal: 31.h, vertical: 17.v),
                  decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder16),
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

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotThePassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  /// Navigates to the signUpBlankScreen when the action is triggered.
  onTapTxtSignUp(BuildContext context) {
   Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}
