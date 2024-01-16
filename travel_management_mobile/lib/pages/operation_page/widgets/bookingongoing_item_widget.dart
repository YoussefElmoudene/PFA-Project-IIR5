//
// import 'package:flutter/material.dart';
// import 'package:travel_management_mobile/core/utils/size_utils.dart';
//
// import '../../../components/custom_elevated_button.dart';
// import '../../../components/custom_image_view.dart';
// import '../../../components/custom_outlined_button.dart';
// import '../../../components/custom_search_view.dart';
// import '../../../core/utils/image_constant.dart';
// import '../../../theme/app_decoration.dart';
// import '../../../theme/custom_button_style.dart';
// import '../../../theme/custom_text_style.dart';
// import '../../../theme/theme_helper.dart';
//
// // ignore: must_be_immutable
// class BookingongoingItemWidget extends StatelessWidget {BookingongoingItemWidget({
//     Key? key,
//     this.onTapBookingActionCancelBooking,
//     this.onTapBookingActionViewTicket,
//   }) : super(
//           key: key,
//         );
//
//   VoidCallback? onTapBookingActionCancelBooking;
//
//   VoidCallback? onTapBookingActionViewTicket;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(
//       children: [
//         // CustomSearchView(
//         //   //controller: searchController,
//         //   hintText: "Search",
//         // ),
//         Container(
//           padding: EdgeInsets.all(20.h),
//           decoration: AppDecoration.outlineBlackC.copyWith(
//             borderRadius: BorderRadiusStyle.roundedBorder16,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(right: 8.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // CustomImageView(
//                     //   imagePath: ImageConstant.imgRectangle4100x100,
//                     //   height: 100.adaptSize,
//                     //   width: 100.adaptSize,
//                     //   radius: BorderRadius.circular(
//                     //     16.h,
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: 5.v,
//                         bottom: 6.v,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Royale Ops",
//                             style: CustomTextStyles.titleLargeSemiBold,
//                           ),
//                           SizedBox(height: 9.v),
//                           Text(
//                             "Paris, France",
//                             style: theme.textTheme.bodyMedium,
//                           ),
//                           SizedBox(height: 11.v),
//                           CustomElevatedButton(
//                             height: 24.v,
//                             width: 60.h,
//                             text: "Paid",
//                             buttonStyle: CustomButtonStyles.fillTeal,
//                             buttonTextStyle: CustomTextStyles.labelMediumCyan300,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.v),
//               Divider(),
//               SizedBox(height: 19.v),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: CustomOutlinedButton(
//                       text: "Cancel ",
//                       margin: EdgeInsets.only(right: 6.h),
//                       onPressed: () {
//                         onTapBookingActionCancelBooking!.call();
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomElevatedButton(
//                       height: 38.v,
//                       text: "View ",
//                       margin: EdgeInsets.only(left: 6.h),
//                       buttonStyle: CustomButtonStyles.fillPrimaryTL19,
//                       buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
//                       onPressed: () {
//                         onTapBookingActionViewTicket!.call();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }