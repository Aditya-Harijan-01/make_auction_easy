import 'package:dummy_app/app/modules/rental_detail_screen/controllers/rental_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'counter_row.dart';
import 'section_card.dart';
import 'section_subtitle.dart';

Widget buildTenantCard(Color cardBackground, RentalDetailScreenController controller) {
    return sectionCard(
      cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionSubtitle('Tenants'),
          SizedBox(height: 10.h),
          counterRow(
            label: 'Adults',
            value: controller.adults.value,
            onMinus: controller.decrementAdults,
            onPlus: controller.incrementAdults,
            disableMinus: controller.adults.value <= 1,
          ),
          SizedBox(height: 10.h),
          counterRow(
            label: 'Children',
            value: controller.children.value,
            onMinus: controller.decrementChildren,
            onPlus: controller.incrementChildren,
            disableMinus: controller.children.value <= 0,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Include pets (+${controller.formatMoney(controller.petFee)}/month)',
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
              ),
              Switch.adaptive(
                value: controller.includePets.value,
                activeThumbColor: Colors.blue,
                activeTrackColor: Colors.blue.withValues(alpha: 0.45),
                onChanged: controller.togglePets,
              ),
            ],
          ),
        ],
      ),
    );
  }