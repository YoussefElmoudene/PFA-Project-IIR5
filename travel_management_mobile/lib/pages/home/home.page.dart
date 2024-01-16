import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_management_mobile/components/app_bar/appbar_leading_image.dart';
import 'package:travel_management_mobile/components/app_bar/appbar_title.dart';
import 'package:travel_management_mobile/components/app_bar/appbar_trailing_image.dart';
import 'package:travel_management_mobile/components/app_bar/custom_app_bar.dart';
import 'package:travel_management_mobile/components/app_icons.dart';
import 'package:travel_management_mobile/components/custom_image_view.dart';
import 'package:travel_management_mobile/core/utils/image_constant.dart';
import 'package:travel_management_mobile/core/utils/size_utils.dart';
import 'package:travel_management_mobile/model/demande.model.dart';
import 'package:travel_management_mobile/model/user.model.dart';
import 'package:travel_management_mobile/service/demande.service.dart';
import 'package:travel_management_mobile/service/storage.service.dart';
import 'package:travel_management_mobile/service/user.service.dart';
import 'package:travel_management_mobile/theme/app_decoration.dart';
import 'package:travel_management_mobile/theme/custom_button_style.dart';
import 'package:travel_management_mobile/theme/custom_text_style.dart';
import 'package:travel_management_mobile/theme/theme_helper.dart';
import 'package:travel_management_mobile/toasts/toast_notifications.dart';
import 'package:travel_management_mobile/components/custom_elevated_button.dart';
import 'package:travel_management_mobile/components/custom_outlined_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final DemandeService _demandeService = DemandeService();
  final UserService _userService = UserService();
  TextEditingController dateStartController = TextEditingController();
  TextEditingController dateEndController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController MotifController = TextEditingController();
  List<Demande> demandes = [];
  int userId = 1;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    userId = await _userService.getUserId();
    demandes = await _demandeService.getDemandesByUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () {}),
          AppbarTrailingImage(
              imagePath: ImageConstant.imgClock,
              margin: EdgeInsets.only(left: 20.h, top: 11.v, right: 35.h))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Column(
                  children: [
                    _buildRecentlyBookedList(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomOutlinedButton(
        onPressed: () {
          _showAddDemandeModal(context);
        },
        height: 60.0,
        width: 60.0,
        text: "+",
        buttonTextStyle: CustomTextStyles.titleLargeSemiBold,
      ),
    );
  }

  Widget _buildRecentlyBookedList(BuildContext context) {
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
  }

  Widget _buildDemandeItem(BuildContext context, Demande demande) {
    String dateStart = _dateFormat.format(demande.dateDebut);
    String dateEnd = _dateFormat.format(demande.dateFin);
    String amount = demande.frais.toString();
    String city = demande.ville;
    String vehicle = demande.moyenTransport;

    return Container(
      padding: EdgeInsets.all(10.h),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: "Delete",
                  margin: EdgeInsets.only(right: 6.h),
                  onPressed: () {
                    _deleteDemande(demande);
                  },
                ),
              ),
              Expanded(
                child: CustomElevatedButton(
                  height: 78.v,
                  text: "Update",
                  margin: EdgeInsets.only(left: 6.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL19,
                  buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
                  onPressed: () {
                    _showUpdateDemandeModal(context, demande);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
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
                  decoration: InputDecoration(
                    labelText: 'Date Start',
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                TextFormField(
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
                  decoration: InputDecoration(labelText: 'Date End'),
                  style: TextStyle(color: Colors.black),
                ),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  style: TextStyle(color: Colors.black),
                ),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  style: TextStyle(color: Colors.black),
                ),
                TextFormField(
                  controller: vehicleController,
                  decoration: InputDecoration(labelText: 'Vehicle'),
                  style: TextStyle(color: Colors.black),
                ),
                TextFormField(
                  controller: MotifController,
                  decoration: InputDecoration(labelText: 'Motif'),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: CustomElevatedButton(
                    height: 38.0,
                    text: "Save",
                    onPressed: () async {
                      _addDemandeToService(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addDemandeToService(BuildContext context) async {
    try {
      print("user id $userId");
      UserModel us = new UserModel(id: userId);
      if (_validateInputs()) {
        Demande newDemande = Demande(
          id: 0,
          motif: MotifController.text,
          ville: cityController.text,
          etat: "En_COURS",
          frais: double.parse(amountController.text),
          dateDebut: DateTime.parse(dateStartController.text),
          dateFin: DateTime.parse(dateEndController.text),
          demandeur: us,
          moyenTransport: vehicleController.text,
        );

        await _demandeService.createDemandes(newDemande);
        init();
        Navigator.pop(context);
        ToastUtils.showSuccessToast(context, 'Done', 'Item Added Successfully');
        _clearInputs();
      } else {
        ToastUtils.showErrorToast(
          context,
          'Error',
          'Please fill in all required fields.',
        );
      }
    } catch (e) {
      print('Error adding demande: $e');
      ToastUtils.showErrorToast(
        context,
        'Error',
        'Failed to add item. Please try again.',
      );
    }
  }

  void _deleteDemande(Demande demande) async {
    try {
      await _demandeService.deleteDemandes(demande.id);
      init();
      ToastUtils.showErrorToast(context, 'Done', 'Item Deleted Successfully');
    } catch (e) {
      print('Error deleting demande: $e');
      ToastUtils.showErrorToast(
          context, 'Error', 'Failed to delete item. Please try again.');
    }
  }

  void _clearInputs() {
    dateStartController.clear();
  }

  bool _validateInputs() {
    return dateStartController.text.isNotEmpty && true;
  }

  void _showUpdateDemandeModal(BuildContext context, Demande demande) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildUpdateDemandeForm(context, demande);
      },
    );
  }

  Widget _buildUpdateDemandeForm(BuildContext context, Demande demande) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: demande.dateDebut,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateStartController.text = _dateFormat.format(pickedDate);
                  }
                },
                controller: dateStartController,
                decoration: InputDecoration(labelText: 'Date Start'),
              ),
              SizedBox(height: 16.0),
              Center(
                child: CustomElevatedButton(
                  height: 38.0,
                  text: "Update",
                  onPressed: () {
                    _updateDemandeInService(context, demande.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateDemandeInService(BuildContext context, int id) async {
    try {
      UserModel us = new UserModel(id: userId);
      if (_validateInputs()) {
        Demande updatedDemande = Demande(
          id: 0,
          motif: MotifController.text,
          ville: cityController.text,
          etat: "En_COURS",
          frais: double.parse(amountController.text),
          dateDebut: DateTime.parse(dateStartController.text),
          dateFin: DateTime.parse(dateEndController.text),
          demandeur: us,
          moyenTransport: vehicleController.text,
        );

        await _demandeService.updateDemandes(1, updatedDemande);
        init();
        Navigator.pop(context);
        ToastUtils.showUpdateToast(
          context,
          'Done',
          'Item updated Successfully',
        );
        _clearInputs();
      } else {
        ToastUtils.showErrorToast(
          context,
          'Error',
          'Please fill in all required fields.',
        );
      }
    } catch (e) {
      print('Error updating demande: $e');
      ToastUtils.showErrorToast(
        context,
        'Error',
        'Failed to update item. Please try again.',
      );
    }
  }
}
