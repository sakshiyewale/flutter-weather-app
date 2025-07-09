import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/firstpage.dart';

class LoginController extends GetxController {
  RxBool isPasswordHidden = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email and password must not be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(12),
        duration: Duration(seconds: 3),
        icon: Icon(Icons.warning, color: Colors.white),
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Sucess');
      Get.snackbar(
        "Success",
        "Logged in successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xff4DB6AC),
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(12),
        duration: Duration(seconds: 3),
        icon: Icon(Icons.check_circle, color: Colors.white),
      );

      Get.offAll(() => Firstpage()); // Clear login screen from stack
    } catch (e) {
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@faild');
      Get.snackbar(
        "Login Failed",
        e.toString().replaceAll(RegExp(r'\[.*?\]'), ''), // clean up Firebase error
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(12),
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error, color: Colors.white),
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
