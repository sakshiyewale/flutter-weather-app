import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

errorSnackBar({String title = 'Failure', String? message}) {
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.TOP,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 700),
    ),
  );
}

successSnackBar({String title = 'Success', String? message}) {
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.TOP,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 700),
    ),
  );
}
// Show progress indicator
showProgressIndicator() {
  return EasyLoading.show(
    maskType: EasyLoadingMaskType.black,
    status: 'Loading',
    dismissOnTap: false,
  );
}

// Dismiss progress indicator
dismissProgressIndicator() {
  return EasyLoading.dismiss();
}