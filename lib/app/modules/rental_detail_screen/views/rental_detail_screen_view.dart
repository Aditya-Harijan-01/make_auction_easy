import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/rental_property.dart';
import '../controllers/rental_detail_screen_controller.dart';

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
              _buildAvailabilityBadge(),
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
          Positioned(
            right: 16.w,
            bottom: 20.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Text(
                '${controller.formatMoney(property.monthlyRent)}/month',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
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

  Widget _buildAvailabilityBadge() {
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
            _buildTags(property),
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
            SizedBox(height: 20.h),
            _sectionTitle('Rental Process'),
            SizedBox(height: 10.h),
            _buildStepTimeline(),
            SizedBox(height: 20.h),
            _buildLeaseDurationCard(),
            SizedBox(height: 14.h),
            _buildMoveInCard(),
            SizedBox(height: 14.h),
            _buildTenantCard(),
            SizedBox(height: 14.h),
            // _buildPaymentCard(),
            // SizedBox(height: 14.h),
            _buildNoteCard(),
            SizedBox(height: 14.h),
            _buildDescriptionCard(property),
            SizedBox(height: 14.h),
            _buildAmenitiesCard(property),
            SizedBox(height: 14.h),
            _buildPriceSummaryCard(),
            SizedBox(height: 10.h),
            _buildTermsRow(),
            SizedBox(height: 14.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTags(RentalProperty property) {
    return Row(
      children: [
        _tagChip(
          text: property.available ? 'Available' : 'Unavailable',
          background: property.available ? Colors.green : Colors.red,
        ),
        SizedBox(width: 10.w),
        _tagChip(text: property.type, background: const Color(0xFF1D4ED8)),
      ],
    );
  }

  Widget _tagChip({required String text, required Color background}) {
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

  Widget _buildStepTimeline() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: const [
        _StepBadge(order: 1, text: 'Lease'),
        _StepBadge(order: 2, text: 'Move-in'),
        _StepBadge(order: 3, text: 'Payment'),
        _StepBadge(order: 4, text: 'Confirm'),
      ],
    );
  }

  Widget _buildLeaseDurationCard() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionSubtitle('Lease duration'),
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

  Widget _buildMoveInCard() {
    return _sectionCard(
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
                _sectionSubtitle('Move-in date'),
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

  Widget _buildTenantCard() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionSubtitle('Tenants'),
          SizedBox(height: 10.h),
          _counterRow(
            label: 'Adults',
            value: controller.adults.value,
            onMinus: controller.decrementAdults,
            onPlus: controller.incrementAdults,
            disableMinus: controller.adults.value <= 1,
          ),
          SizedBox(height: 10.h),
          _counterRow(
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

  Widget _counterRow({
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
        _miniButton(icon: Icons.remove, onTap: disableMinus ? null : onMinus),
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
        _miniButton(icon: Icons.add, onTap: onPlus),
      ],
    );
  }

  Widget _miniButton({required IconData icon, required VoidCallback? onTap}) {
    final bool disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          color: disabled ? Colors.white10 : const Color(0xFF1D4ED8),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: Colors.white, size: 16.sp),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return _sectionCard(
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

  Widget _buildNoteCard() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionSubtitle('Special requests'),
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
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionSubtitle('Description'),
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
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionSubtitle('Amenities'),
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

  Widget _buildPriceSummaryCard() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionSubtitle('Price summary'),
          SizedBox(height: 10.h),
          _amountRow(
            'Monthly rent',
            controller.formatMoney(controller.monthlyBaseRent),
          ),
          _amountRow(
            'Maintenance',
            controller.formatMoney(controller.maintenanceFee),
          ),
          _amountRow('Pets fee', controller.formatMoney(controller.petFee)),
          _amountRow(
            'Security deposit',
            controller.formatMoney(controller.securityDeposit),
          ),
          _amountRow(
            'Processing fee',
            controller.formatMoney(controller.processingFee),
          ),
          _amountRow(
            'Lease discount',
            '-${controller.formatMoney(controller.leaseDiscount)}',
            valueColor: Colors.greenAccent,
          ),
          Divider(color: Colors.white24, height: 24.h),
          _amountRow(
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

  Widget _amountRow(
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

  Widget _buildTermsRow() {
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

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _sectionSubtitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _StepBadge extends StatelessWidget {
  const _StepBadge({required this.order, required this.text});

  final int order;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF1D4ED8),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$order',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 7.w),
          Text(
            text,
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
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
