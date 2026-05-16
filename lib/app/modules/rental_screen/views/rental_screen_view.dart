import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/models/rental_property.dart';
import '../../../routes/app_pages.dart';
import '../controllers/rental_screen_controller.dart';

class RentalScreenView extends GetView<RentalScreenController> {
  const RentalScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1C),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _buildHeader(),
            SizedBox(height: 15.h),
            _buildSearch(),
            SizedBox(height: 15.h),
            Obx(_buildFilters),
            SizedBox(height: 15.h),

            Expanded(child: Obx(_buildRentalList)),
          ],
        ),
      ),
    );
  }

  // 🔹 Header
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _circleButton(
            Icons.arrow_back_ios_new,
            onTap: () {
              if (Get.key.currentState?.canPop() ?? false) {
                Get.back();
              }
            },
          ),
          const Spacer(),
          Text(
            'Rentals',
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
          const Spacer(),
          _circleButton(Icons.tune),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Icon(icon, color: Colors.white, size: 18.sp),
      ),
    );
  }

  // 🔹 Search
  Widget _buildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: TextField(
          onChanged: controller.updateQuery,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.white54),
            hintText: 'Search property...',
            hintStyle: TextStyle(color: Colors.white54, fontSize: 14.sp),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // 🔹 Filters
  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.categories
            .map((category) {
              final bool selected =
                controller.selectedCategory.value == category;
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () => controller.setCategory(category),
                  child: FilterChipWidget(
                    title: category,
                    isSelected: selected,
                  ),
                ),
              );
            })
            .toList(growable: false),
        ),
      ),
    );
  }

  Widget _buildRentalList() {
    final List<RentalProperty> listings = controller.filteredProperties;
    if (listings.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Text(
            'No rentals found for this filter. Try another search.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (_, index) {
        final RentalProperty listing = listings[index];
        return RentalCard(
          property: listing,
          isFavorite: controller.isFavorite(listing.id),
          onFavoriteTap: () => controller.toggleFavorite(listing.id),
        );
      },
      separatorBuilder: (_, _) => SizedBox(height: 20.h),
      itemCount: listings.length,
    );
  }
}

// 🔹 Rental Card
class RentalCard extends StatelessWidget {
  const RentalCard({
    super.key,
    required this.property,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  final RentalProperty property;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.RENTAL_DETAIL_SCREEN, arguments: property.toMap());
      },
      child: Container(
        height: 160.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 154, 153, 153).withValues(alpha: 0.28),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 10),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(property.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.black.withValues(alpha: 0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.redAccent : Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    property.location,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.sp,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        '\$${property.monthlyRent}/month',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.bed, color: Colors.white70, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${property.beds}',
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.bathtub, color: Colors.white70, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '${property.baths}',
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.star, color: Colors.amber, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        property.rating.toStringAsFixed(1),
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 Filter Chip
class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 13.sp),
      ),
    );
  }
}
