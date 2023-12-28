
import 'package:flutter/material.dart';
import 'package:travel_management_mobile/core/utils/size_utils.dart';
import 'package:travel_management_mobile/pages/operation_page/widgets/bookingongoing_item_widget.dart';

import '../../../theme/app_decoration.dart';
import '../../components/app_bar/appbar_leading_image.dart';
import '../../components/app_bar/appbar_title.dart';
import '../../components/app_bar/appbar_trailing_image.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../core/utils/image_constant.dart';
import '../../routes/app_routes.dart';


class BookingOngoingPage extends StatefulWidget {
  const BookingOngoingPage({Key? key}) : super(key: key);

  @override
  BookingOngoingPageState createState() => BookingOngoingPageState();
}

class BookingOngoingPageState extends State<BookingOngoingPage>
    with AutomaticKeepAliveClientMixin<BookingOngoingPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return  Scaffold(
        appBar: CustomAppBar(
            height: 50.v,
            leadingWidth: 56.h,
            leading: AppbarLeadingImage(
                imagePath: ImageConstant.logo,
                margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v)),
            title:
            AppbarTitle(text: "Operations", margin: EdgeInsets.only(left: 16.h)),
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
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnPrimary,
                child: Column(children: [
                  SizedBox(height: 30.v),
                  _buildBookingOngoing(context)
                ])));
  }

  /// Section Widget
  Widget _buildBookingOngoing(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20.v);
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return BookingongoingItemWidget(
                      onTapBookingActionCancelBooking: () {
                    onTapBookingActionCancelBooking(context);
                  }, onTapBookingActionViewTicket: () {
                    onTapBookingActionViewTicket(context);
                  });
                })));
  }

  onTapBookingActionCancelBooking(BuildContext context) {
    // TODO: implement Actions
  }

  /// Navigates to the viewTicketScreen when the action is triggered.
  onTapBookingActionViewTicket(BuildContext context) {
   // Navigator.pushNamed(context, AppRoutes.viewTicketScreen);
  }
}
