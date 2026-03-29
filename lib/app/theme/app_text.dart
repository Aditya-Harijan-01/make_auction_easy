import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  // 🔹 Heading
  static TextStyle heading = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // 🔹 Sub Heading
  static TextStyle subHeading = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // 🔹 Body
  static TextStyle body = TextStyle(
    fontSize: 14.sp,
    color: AppColors.white70,
  );

  // 🔹 Small Text
  static TextStyle small = TextStyle(
    fontSize: 12.sp,
    color: AppColors.white60,
  );

  // 🔹 Button Text
  static TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // 🔹 Highlight / Link
  static TextStyle link = TextStyle(
    fontSize: 14.sp,
    color: Colors.blueAccent,
    fontWeight: FontWeight.w500,
  );
}