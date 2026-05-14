import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/rental_detail_screen_controller.dart';
import 'section_card.dart';
import 'section_subtitle.dart';

Widget buildPriceSummaryCard(Color cardBackground, RentalDetailScreenController controller) {
    return sectionCard(
      cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionSubtitle('Price summary'),
          SizedBox(height: 10.h),
          amountRow(
            'Monthly rent',
            controller.formatMoney(controller.monthlyBaseRent),
          ),
          amountRow(
            'Maintenance',
            controller.formatMoney(controller.maintenanceFee),
          ),
          amountRow('Pets fee', controller.formatMoney(controller.petFee)),
          amountRow(
            'Security deposit',
            controller.formatMoney(controller.securityDeposit),
          ),
          amountRow(
            'Processing fee',
            controller.formatMoney(controller.processingFee),
          ),
          amountRow(
            'Lease discount',
            '-${controller.formatMoney(controller.leaseDiscount)}',
            valueColor: Colors.greenAccent,
          ),
          Divider(color: Colors.white24, height: 24.h),
          amountRow(
            'Due now',
            controller.formatMoney(controller.dueNow),
            valueColor: Colors.lightBlueAccent,
            isBold: true,
          ),
          SizedBox(height: 6.h),
          Text(
            'Monthly recurring amount: ${controller.formatMoney(controller.monthlyPayable)}',
            style: TextStyle(color: Colors.white60, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget amountRow(
    String label,
    String value, {
    Color valueColor = Colors.white,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTermsRow(RentalDetailScreenController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: controller.acceptedTerms.value,
          onChanged: controller.toggleTerms,
          activeColor: Colors.blue,
          checkColor: Colors.white,
        ),
        Expanded(
          child: Text(
            'I agree to the rental agreement terms and refund policy.',
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }