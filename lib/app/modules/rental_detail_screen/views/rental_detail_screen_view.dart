import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/models/rental_property.dart';
import '../controllers/rental_detail_screen_controller.dart';
import 'components/duration_details_card.dart';
import 'components/move_in_widget.dart';
import 'components/section_card.dart';
import 'components/section_subtitle.dart';
import 'components/tag.dart';
import 'components/tenent_detail.dart';

class RentalDetailScreenView extends GetView<RentalDetailScreenController> {
  const RentalDetailScreenView({super.key});

  static const Color _background = Color(0xFF0A0F1C);
  static const Color _cardBackground = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    final RentalProperty property = controller.property;

    return Scaffold(
      backgroundColor: _background,
      bottomNavigationBar: Obx(_buildBottomButton),
      body: Column(
        children: [
          Stack(
            children: [
              _buildHeaderImage(property),
              _buildTopBar(),
              // _buildAvailabilityBadge(),
            ],
          ),
          Expanded(child: Obx(() => _buildContent(property))),
        ],
      ),
    );
  }

  Widget _buildHeaderImage(RentalProperty property) {
    return SizedBox(
      height: 280.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(property.imagePath, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.15),
                  Colors.black.withValues(alpha: 0.72),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Positioned(
          //   right: 16.w,
          //   bottom: 20.h,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          //     decoration: BoxDecoration(
          //       color: Colors.black54,
          //       borderRadius: BorderRadius.circular(14.r),
          //     ),
          //     child: Text(
          //       '${controller.formatMoney(property.monthlyRent)}/month',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 13.sp,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back<void>(),
              child: _circleIcon(Icons.arrow_back_ios_new),
            ),
            const Spacer(),
            Obx(
              () => GestureDetector(
                onTap: controller.toggleFavorite,
                child: _circleIcon(
                  controller.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: controller.isFavorite.value
                      ? Colors.redAccent
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  Widget _circleIcon(IconData icon, {Color color = Colors.white}) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(icon, color: color, size: 18.sp),
    );
  }

  Widget _buildContent(RentalProperty property) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTags(property),
            SizedBox(height: 12.h),
            Text(
              property.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    property.location,
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                ),
                Icon(Icons.star, color: Colors.amber, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  property.rating.toStringAsFixed(1),
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoCard(icon: Icons.bed, text: '${property.beds} Beds'),
                _InfoCard(icon: Icons.bathtub, text: '${property.baths} Baths'),
                _InfoCard(
                  icon: Icons.square_foot,
                  text: '${property.areaSqft} sqft',
                ),
                _InfoCard(
                  icon: Icons.groups,
                  text: 'Up to ${property.maxTenants}',
                ),
              ],
            ),
            // SizedBox(height: 20.h),
            // _sectionTitle('Rental Process'),
            // SizedBox(height: 10.h),
            // _buildStepTimeline(),
            // SizedBox(height: 20.h),
            // buildLeaseDurationCard(_cardBackground, controller),
            SizedBox(height: 14.h),
            buildMoveInCard(_cardBackground, controller),
            SizedBox(height: 14.h),
            buildTenantCard(_cardBackground, controller),
            SizedBox(height: 14.h),
            // _buildPaymentCard(_cardBackground, controller),
            // SizedBox(height: 14.h),
            buildNoteCard(),
            SizedBox(height: 14.h),
            _buildDescriptionCard(property),
            SizedBox(height: 14.h),
            _buildAmenitiesCard(property),
            // SizedBox(height: 14.h),
            // _buildPriceSummaryCard(),
            // SizedBox(height: 10.h),
            // _buildTermsRow(),
            SizedBox(height: 14.h),
          ],
        ),
      ),
    );
  }

  Widget buildNoteCard() {
    return sectionCard(
      _cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionSubtitle('Special requests'),
          SizedBox(height: 10.h),
          TextField(
            controller: controller.noteController,
            minLines: 3,
            maxLines: 4,
            style: TextStyle(color: Colors.white, fontSize: 13.sp),
            decoration: InputDecoration(
              hintText: 'Any move-in or furnishing requests?',
              hintStyle: TextStyle(color: Colors.white38, fontSize: 12.sp),
              filled: true,
              fillColor: const Color(0xFF0B1220),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: Colors.white12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: Colors.white12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: const BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(RentalProperty property) {
    return sectionCard(
      _cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionSubtitle('Description'),
          SizedBox(height: 8.h),
          Text(
            property.description,
            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesCard(RentalProperty property) {
    return sectionCard(
      _cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionSubtitle('Amenities'),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: property.amenities
                .map(
                  (amenity) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B1220),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Text(
                      amenity,
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }

  

  Widget _buildBottomButton() {
    final bool enabled = controller.canSubmit;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
      decoration: const BoxDecoration(color: _background),
      child: GestureDetector(
        onTap: enabled ? controller.submitRentalRequest : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: 56.h,
          decoration: BoxDecoration(
            gradient: enabled
                ? const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                  )
                : const LinearGradient(
                    colors: [Color(0xFF374151), Color(0xFF374151)],
                  ),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Center(
            child: controller.isSubmitting.value
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Confirm Rental - ${controller.formatMoney(controller.dueNow)} due now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  

  // Widget _sectionTitle(String text) {
  //   return Text(
  //     text,
  //     style: TextStyle(
  //       color: Colors.white,
  //       fontSize: 17.sp,
  //       fontWeight: FontWeight.w700,
  //     ),
  //   );
  // }

  
}



class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _RentalDetailScreenViewColors.infoCard,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 18.sp),
          SizedBox(height: 4.h),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}

class _RentalDetailScreenViewColors {
  static const Color infoCard = Color(0xFF111827);
}
