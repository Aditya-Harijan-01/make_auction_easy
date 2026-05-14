import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/rental_detail_screen_controller.dart';
import 'section_card.dart';
import 'section_subtitle.dart';
import 'step_badge.dart';

Widget buildStepTimeline() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: const [
        StepBadge(order: 1, text: 'Lease'),
        StepBadge(order: 2, text: 'Move-in'),
        StepBadge(order: 3, text: 'Payment'),
        StepBadge(order: 4, text: 'Confirm'),
      ],
    );
  }

Widget buildLeaseDurationCard(Color color, RentalDetailScreenController controller) {
  return sectionCard(
    color,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionSubtitle('Lease duration'),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: controller.leaseOptions
              .map((months) {
                final bool selected =
                    controller.selectedLeaseMonths.value == months;
                return GestureDetector(
                  onTap: () => controller.selectLeaseMonths(months),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: selected
                            ? Colors.lightBlueAccent
                            : Colors.white12,
                      ),
                    ),
                    child: Text(
                      '$months months',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              })
              .toList(growable: false),
        ),
        SizedBox(height: 10.h),
        Text(
          controller.selectedLeaseMonths.value >= 12
              ? 'Long lease benefit applied: ${controller.formatMoney(controller.leaseDiscount)} off due-now amount.'
              : 'Choose 12+ months to unlock due-now discount.',
          style: TextStyle(color: Colors.white60, fontSize: 12.sp),
        ),
      ],
    ),
  );
}