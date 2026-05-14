import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'mini_button.dart';

Widget counterRow({
    required String label,
    required int value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
    required bool disableMinus,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 13.sp),
          ),
        ),
        miniButton(icon: Icons.remove, onTap: disableMinus ? null : onMinus),
        SizedBox(width: 10.w),
        Text(
          '$value',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10.w),
        miniButton(icon: Icons.add, onTap: onPlus),
      ],
    );
  }