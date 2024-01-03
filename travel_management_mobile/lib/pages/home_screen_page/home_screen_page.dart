import 'package:flutter/material.dart';
import 'package:travel_management_mobile/core/utils/size_utils.dart';
import 'package:travel_management_mobile/pages/home_screen_page/widgets/hotelslist_item_widget.dart';
import 'package:travel_management_mobile/pages/home_screen_page/widgets/martinezcannes_item_widget.dart';


import '../../../theme/custom_text_style.dart';
import '../../../theme/theme_helper.dart';
import '../../components/app_bar/appbar_leading_image.dart';
import '../../components/app_bar/appbar_title.dart';
import '../../components/app_bar/appbar_trailing_image.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../core/utils/image_constant.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  HomeScreenPageState createState() => HomeScreenPageState();
}

class HomeScreenPageState extends State<HomeScreenPage>
    with AutomaticKeepAliveClientMixin<HomeScreenPage> {
  @override
  bool get wantKeepAlive => true;

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
                title:
                AppbarTitle(text: "Home", margin: EdgeInsets.only(left: 16.h)),
                actions: [
                  AppbarTrailingImage(
                      imagePath: ImageConstant.imgIcons,
                      margin: EdgeInsets.only(left: 24.h, top: 11.v, right: 11.h),
                      onTap: () {
                       // onTapIcons(context);
                      }),
                  AppbarTrailingImage(
                      imagePath: ImageConstant.imgClock,
                      margin: EdgeInsets.only(left: 20.h, top: 11.v, right: 35.h))
                ]),

            body: SizedBox(
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(height: 30.v),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(left: 24.h),
                          child: Column(children: [
                            //_buildHotelsList(context),
                            SizedBox(height: 34.v),
                            _buildRecentlyBookedList(context)
                          ])))
                ]))));
  }

  /// Section Widget
  Widget _buildHotelsList(BuildContext context) {
    return SizedBox(
        height: 400.v,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 24.h);
            },
            itemCount: 2,
            itemBuilder: (context, index) {
              return HotelslistItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildRecentlyBookedList(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.only(right: 24.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Recent Operations", style: theme.textTheme.titleMedium),
            GestureDetector(
                onTap: () {
                  onTapTxtSeeAll(context);
                },
                child: Text("See All",
                    style: CustomTextStyles.titleMediumPrimary16))
          ])),
      SizedBox(height: 16.v),
      Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 24.v);
              },
              itemCount: 5,
              itemBuilder: (context, index) {
                return MartinezcannesItemWidget();
              }))
    ]);
  }

  /// Navigates to the recentlyBookedScreen when the action is triggered.
  onTapTxtSeeAll(BuildContext context) {
   // Navigator.pushNamed(context, AppRoutes.recentlyBookedScreen);
  }
}
