import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/rental_property.dart';
import '../../controllers/rental_detail_screen_controller.dart';

Widget buildAvailabilityBadge( RentalDetailScreenController controller) {
    final RentalProperty property = controller.property;
    final String availability = property.available
        ? 'Available from ${controller.formatDate(property.availableFrom)}'
        : 'Currently unavailable';

    return Positioned(
      left: 16.w,
      bottom: 20.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1E3A8A).withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, color: Colors.white, size: 14.sp),
            SizedBox(width: 6.w),
            Text(
              availability,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }