import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_management_mobile/core/utils/size_utils.dart';

import '../../../theme/app_decoration.dart';
import '../../components/app_bar/appbar_leading_image.dart';
import '../../components/app_bar/appbar_title.dart';
import '../../components/app_bar/appbar_trailing_image.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../components/app_icons.dart';
import '../../components/custom_elevated_button.dart';
import '../../components/custom_image_view.dart';
import '../../components/custom_outlined_button.dart';
import '../../components/custom_search_view.dart';
import '../../core/utils/image_constant.dart';
import '../../service/firebaseService.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

class BookingOngoingPage extends StatefulWidget {
  const BookingOngoingPage({Key? key}) : super(key: key);

  @override
  BookingOngoingPageState createState() => BookingOngoingPageState();
}

class BookingOngoingPageState extends State<BookingOngoingPage>
    with AutomaticKeepAliveClientMixin<BookingOngoingPage> {
  @override
  bool get wantKeepAlive => true;
  final FirebaseService _firebaseService = FirebaseService();
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        height: 50.v,
        leadingWidth: 56.h,
        leading: AppbarLeadingImage(
          imagePath: ImageConstant.logo,
          margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v),
        ),
        title: AppbarTitle(
          text: "Operations",
          margin: EdgeInsets.only(left: 16.h),
        ),
        actions: [
          AppbarTrailingImage(
            imagePath: ImageConstant.imgIcons,
            margin: EdgeInsets.only(left: 24.h, top: 11.v, right: 11.h),
            onTap: () {
              // onTapIcons(context);
            },
          ),
          AppbarTrailingImage(
            imagePath: ImageConstant.imgClock,
            margin: EdgeInsets.only(left: 20.h, top: 11.v, right: 35.h),
          )
        ],
      ),
      body: SizedBox(
        width: mediaQueryData.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchView(
                controller: searchController,
                hintText: "Search",
                onChanged: (String searchTerm) {
                  Future.delayed(Duration(milliseconds: 300), () {
                    _firebaseService.searchDemandes(searchTerm);
                  });
                },
              ),


              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.h),
                  child: Column(
                    children: [_buildRecentlyBookedList(context)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentlyBookedList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.v),
        SizedBox(height: 16.v),
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService.getDemandesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text("No demands available.");
              }

              List<QueryDocumentSnapshot> demandes = snapshot.data!.docs;

              String searchTerm = searchController.text.toLowerCase();
              List<QueryDocumentSnapshot> filteredDemandes = demandes
                  .where((demande) =>
                  demande['city']!.toLowerCase().contains(searchTerm))
                  .toList();

              return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24.v);
                },
                itemCount: filteredDemandes.length,
                itemBuilder: (context, index) {
                  return _buildDemandeItem(context, filteredDemandes[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildDemandeItem(
      BuildContext context, QueryDocumentSnapshot demande) {
    String dateStart = demande['dateStart'] ?? '';
    String dateEnd = demande['dateEnd'] ?? '';
    String amount = demande['amount'] ?? '';
    String city = demande['city'] ?? '';
    String vehicle = demande['vehicle'] ?? '';
    String searchTerm = searchController.text.toLowerCase();
    if (!city.toLowerCase().contains(searchTerm)) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " $dateStart - $dateEnd",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 12.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: AppIcons.imgMoney,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      margin: EdgeInsets.symmetric(vertical: 2.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "$amount Dh",
                        style: CustomTextStyles.headlineSmallPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "City : $city",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Align children at the start and end
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    // Add left padding to the vehicle section
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: AppIcons.imgCar,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                          margin: EdgeInsets.symmetric(vertical: 2.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text(
                            " : $vehicle",
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: CustomElevatedButton(
                  height: 24.v,
                  width: 60.h,
                  text: "Status",
                  buttonStyle: CustomButtonStyles.fillTeal,
                  buttonTextStyle: CustomTextStyles.labelMediumCyan300,
                ),
              )
            ],
          ),
          SizedBox(height: 19.v),
          Divider(),
          SizedBox(height: 19.v),
        ],
      ),
    );
  }
}
