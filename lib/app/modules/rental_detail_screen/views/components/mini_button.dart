import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget miniButton({required IconData icon, required VoidCallback? onTap}) {
  final bool disabled = onTap == null;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: disabled ? Colors.white10 : const Color(0xFF1D4ED8),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: Colors.white, size: 16.sp),
    ),
  );
}