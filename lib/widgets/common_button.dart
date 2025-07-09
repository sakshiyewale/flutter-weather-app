import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/common_textstyles.dart';

class CommonButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Function() onpressed;
  final String lable;
  final TextStyle? style;
  final BorderRadius? borderRadius; // New property for border radius

  const CommonButton({
    super.key,
    this.height,
    this.width,
    this.color,
    required this.onpressed,
    required this.lable,
    this.style,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: height ?? 5.6.h,
        width: width ?? 100.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            color:Color(0xff4DB6AC),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color:Colors.white,
                blurRadius: 4,
                spreadRadius: 2,
              )
            ]
        ),
        child: Center(
          child: Text(
            lable ?? "Login",
            style: style ?? TextHelper.size16.copyWith(color: Colors.white,fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}