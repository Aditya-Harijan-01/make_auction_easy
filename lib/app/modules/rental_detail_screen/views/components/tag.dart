import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/rental_property.dart';

Widget buildTags(RentalProperty property) {
  return Row(
    children: [
      tagChip(
        text: property.available ? 'Available' : 'Unavailable',
        background: property.available ? Colors.green : Colors.red,
      ),
      SizedBox(width: 10.w),
      tagChip(text: property.type, background: const Color(0xFF1D4ED8)),
    ],
  );
}

Widget tagChip({required String text, required Color background}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: background.withValues(alpha: 0.24),
      borderRadius: BorderRadius.circular(14.r),
      border: Border.all(color: background.withValues(alpha: 0.65)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}