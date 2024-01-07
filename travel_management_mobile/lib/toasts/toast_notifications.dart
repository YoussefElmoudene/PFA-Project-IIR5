
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void showSuccessToast(BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: title,
      description: description,
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(12.0),
      showProgressBar: true,
    );
  }

  static void showErrorToast(BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: title,
      description: description,
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(12.0),
      showProgressBar: true,
    );
  }
  static void showUpdateToast(BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      title: title,
      description: description,
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(12.0),
      showProgressBar: true,
    );
  }
}
