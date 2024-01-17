import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_management_mobile/core/utils/size_utils.dart';

import '../../../theme/app_decoration.dart';
import '../../components/app_bar/appbar_leading_image.dart';
import '../../components/app_bar/appbar_title.dart';
import '../../components/app_bar/appbar_trailing_image.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../components/app_icons.dart';
import '../../components/custom_image_view.dart';
import '../../components/custom_search_view.dart';
import '../../core/utils/image_constant.dart';
import '../../model/demande.model.dart';
import '../../model/user.model.dart';
import '../../service/demande.service.dart';
import '../../service/firebaseService.dart';
import '../../service/user.service.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../home/components/status_icon.dart';

class BookingOngoingPage extends StatefulWidget {
  const BookingOngoingPage({Key? key}) : super(key: key);

  @override
  BookingOngoingPageState createState() => BookingOngoingPageState();
}

class BookingOngoingPageState extends State<BookingOngoingPage>
    with AutomaticKeepAliveClientMixin<BookingOngoingPage> {
  @override
  bool get wantKeepAlive => true;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  List<Demande> demandes = [];

  TextEditingController searchController = TextEditingController();
  final DemandeService _demandeService = DemandeService();
  final UserService _userService = UserService();
  int userId = 1;
  String selectedEtat = '';
  String role = '';

  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    userId = await _userService.getUserId();
    role = await _userService.getUserRole();
    print("role user $role");
    if (role == 'ADMIN') {
      demandes = await _demandeService.getAllDemandes();
    } else {
      if (selectedEtat.isEmpty) {
        demandes = await _demandeService.getDemandesByUser();
      } else {
        demandes = await _demandeService
            .filterDemandesByEtatAndCurrentUser(selectedEtat);
      }
    }
    setState(() {});
  }

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
            text: "Demands",
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
                  onChanged: (text) {
                    print("Search text changed: $text");
                    onSearchTextChanged(text);
                  },                ),
                SizedBox(height: 20.v),
                // Use the filtered demands list for the ListView
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20.v);
                  },
                  itemCount: demandes.length,
                  itemBuilder: (context, index) {
                    return _buildRecentlyBookedList(context, demandes[index]);
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildRecentlyBookedList(BuildContext context, Demande demande) {
    String dateStart = _dateFormat.format(demande.dateDebut);
    String dateEnd = _dateFormat.format(demande.dateFin);
    String amount = demande.frais.toString();
    String city = demande.ville;
    String vehicle = demande.moyenTransport;
    return Center(
        child: Container(
      margin: EdgeInsets.only(right: 20.0, left: 20.0),
      padding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 5.v),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " $dateStart -> $dateEnd",
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
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
                child: Row(
                  children: [
                    StatusIcons(status: demande.etat),
                    SizedBox(width: 8.0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }


  void onSearchTextChanged(String text) {
    demandes = List.from(demandes);

    if (text.isNotEmpty) {
      demandes = demandes.where((demande) {
        return
          demande.frais.toString().toLowerCase().contains(text.toLowerCase()) ||
              demande.ville.toLowerCase().contains(text.toLowerCase()) ||
              demande.etat.toLowerCase().contains(text.toLowerCase()) ||
              demande.moyenTransport.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    setState(() {});
  }


}
