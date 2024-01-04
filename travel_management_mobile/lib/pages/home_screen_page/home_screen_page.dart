import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_management_mobile/core/utils/size_utils.dart';
import '../../../theme/custom_text_style.dart';
import '../../../theme/theme_helper.dart';
import '../../components/app_bar/appbar_leading_image.dart';
import '../../components/app_bar/appbar_title.dart';
import '../../components/app_bar/appbar_trailing_image.dart';
import '../../components/app_bar/custom_app_bar.dart';
import '../../components/custom_elevated_button.dart';
import '../../components/custom_image_view.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_button_style.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  HomeScreenPageState createState() => HomeScreenPageState();
}

class HomeScreenPageState extends State<HomeScreenPage>
    with AutomaticKeepAliveClientMixin<HomeScreenPage> {
  @override
  bool get wantKeepAlive => true;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController dateStartController = TextEditingController();
  TextEditingController dateEndController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController motifController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v)),
        title: AppbarTitle(text: "Home", margin: EdgeInsets.only(left: 16.h)),
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
        ],
      ),
      body: SizedBox(
        width: mediaQueryData.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.v),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.h),
                  child: Column(
                    children: [
                      //_buildHotelsList(context),
                      SizedBox(height: 34.v),
                      _buildRecentlyBookedList(context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDemandeModal(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }



  Widget _buildRecentlyBookedList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('demandes').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(); // Loading indicator
              }

              List<QueryDocumentSnapshot> demandes = snapshot.data!.docs;

              return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24.v);
                },
                itemCount: demandes.length,
                itemBuilder: (context, index) {
                  return _buildDemandeItem(context, demandes[index]);
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

    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.v, horizontal: 18.v),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 11.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " $dateStart - $dateEnd",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 18.v),
                Text(
                  "city :$city",
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 12.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgCalendar,
                      height: 12.adaptSize,
                      width: 12.adaptSize,
                      margin: EdgeInsets.symmetric(vertical: 2.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "Vehicle: $vehicle",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        top: 1.v,
                      ),
                      child: Text(
                        "",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.v,
              bottom: 8.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$amount Dh",
                  style: CustomTextStyles.headlineSmallPrimary,
                ),
                SizedBox(height: 2.v),
                Text(
                  "",
                  style: theme.textTheme.labelMedium,
                ),
                SizedBox(height: 16.v),
                Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      _deleteDemande(demande);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteDemande(QueryDocumentSnapshot demande) async {
    await _firestore.collection('demandes').doc(demande.id).delete();
  }

  onTapTxtSeeAll(BuildContext context) {}

  void _showAddDemandeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildAddDemandeForm(context);
      },
    );
  }

  Widget _buildAddDemandeForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateStartController.text = _dateFormat.format(pickedDate);
                  }
                },
                controller: dateStartController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(labelText: 'Date Start'),
              ),
              TextFormField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateEndController.text = _dateFormat.format(pickedDate);
                  }
                },
                controller: dateEndController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(labelText: 'Date End'),
              ),
              TextFormField(
                controller: amountController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: cityController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: vehicleController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(labelText: 'Vehicle'),
              ),
              SizedBox(height: 16.0),
              Center(
                child: CustomElevatedButton(
                  height: 38.v,
                  text: "Save ",
                  margin: EdgeInsets.only(left: 6.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL19,
                  buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
                  onPressed: () {
                    _addDemandeToFirestore(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addDemandeToFirestore(BuildContext context) async {
    try {
      await _firestore.collection('demandes').add({
        'dateStart': dateStartController.text,
        'dateEnd': dateEndController.text,
        'amount': amountController.text,
        'city': cityController.text,
        'vehicle': vehicleController.text,
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error adding demande: $e');
    }
  }
}
