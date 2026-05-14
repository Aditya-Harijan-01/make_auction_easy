import 'package:dummy_app/app/modules/rental_detail_screen/controllers/rental_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'section_card.dart';
import 'section_subtitle.dart';

Widget buildMoveInCard(Color color, RentalDetailScreenController controller) {
    return sectionCard(
      color,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.event,
              color: Colors.lightBlueAccent,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionSubtitle('Move-in date'),
                SizedBox(height: 4.h),
                Text(
                  controller.moveInDateLabel,
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: controller.pickMoveInDate,
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }