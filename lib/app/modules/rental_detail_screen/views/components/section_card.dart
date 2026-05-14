import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sectionCard(Color cardBackground, {required Widget child}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: cardBackground,
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: Colors.white10),
    ),
    child: child,
  );
}