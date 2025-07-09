import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whetherapp/widgets/common_button.dart';
import 'package:whetherapp/widgets/text_field.dart';
import '../controller/login_screen_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.sp, horizontal: 13.sp),
          child: SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Lottie.asset(
                        'assets/animation/login.json',
                        height: 38.h,
                      ),
                      SizedBox(height: 3.h),

                      /// Email Field
                      Container(
                        height: 6.h,
                        child: CustomTextField(
                          controller: loginController.emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "Enter Your Email",
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(Icons.person, color: Colors.black),
                          ),
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter Email Address' : null,
                        ),
                      ),
                      SizedBox(height: 5.h),

                      /// Password Field
                      Obx(() => Container(
                        height: 6.h,
                        child: CustomTextField(
                          controller: loginController.passwordController,
                          obscureText: loginController.isPasswordHidden.value,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginController.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                loginController.isPasswordHidden.toggle();
                              },
                            ),
                          ),
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter Password' : null,
                        ),
                      )),

                      SizedBox(height: 1.5.h),

                      /// Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            // Handle forgot password
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),

                      /// Login Button
                      CommonButton(
                        height: 6.5.h,
                        lable: " Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                        onpressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginController.login();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
