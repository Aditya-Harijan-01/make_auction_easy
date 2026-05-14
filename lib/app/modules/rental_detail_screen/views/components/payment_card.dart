import 'package:dummy_app/app/modules/rental_detail_screen/controllers/rental_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'section_card.dart';

Widget buildPaymentCard(Color color, RentalDetailScreenController controller) {
    return sectionCard(
      color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _sectionSubtitle('Payment method'),
          // SizedBox(height: 10.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: controller.paymentMethods
                .map((method) {
                  final bool selected =
                      controller.selectedPaymentMethod.value == method;
                  return GestureDetector(
                    onTap: () => controller.setPaymentMethod(method),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.blue.withValues(alpha: 0.25)
                            : const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: selected ? Colors.blueAccent : Colors.white12,
                        ),
                      ),
                      child: Text(
                        method,
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    ),
                  );
                })
                .toList(growable: false),
          ),
        ],
      ),
    );
  }