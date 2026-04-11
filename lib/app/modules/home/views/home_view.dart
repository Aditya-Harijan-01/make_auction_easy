import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart' show AnimatedNotchBottomBar, BottomBarItem;
import 'package:dummy_app/app/modules/auction_screen/views/auction_screen_view.dart';
import 'package:dummy_app/app/modules/rental_screen/views/rental_screen_view.dart';
import 'package:dummy_app/app/modules/setting_screen/views/setting_screen_view.dart';
import 'package:dummy_app/app/theme/app_colors.dart';
import 'package:dummy_app/app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: Obx(() => _buildCurrentTab(controller.selectedIndex.value)),
      ),
    );
  }

  Widget _buildCurrentTab(int index) {
    switch (index) {
      case 0:
        return _buildHomeTab();
      case 1:
        return AuctionScreenView();
      case 2:
        return RentalScreenView();
      case 3:
        return SettingScreenView();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 20.h),
          _buildBanner(),
          SizedBox(height: 20.h),
          _buildCoinsRow(),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("On-going auctions"),
                  SizedBox(height: 12.h),
                  _buildAuctionList(),
                  SizedBox(height: 20.h),
                  _buildSectionTitle("Featured auctions"),
                  SizedBox(height: 12.h),
                  _buildAuctionList(),
                  SizedBox(height: 20.h),
                  _buildSectionTitle("Premium auctions"),
                  SizedBox(height: 12.h),
                  _buildAuctionList(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Header
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome,", style: AppTextStyles.body),
                SizedBox(height: 4.h),
                Text("Alex Jorda", style: AppTextStyles.heading),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.notifications_active_outlined,
              color: Colors.white),
        ),
      ],
    );
  }

  // 🔹 Banner
  Widget _buildBanner() {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          colors: [AppColors.secondary, AppColors.primary],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "One Tap to Your\nNext Home.",
            style: AppTextStyles.subHeading.copyWith(fontSize: 18.sp),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
            ),
            child: Image.asset(
              'assets/images/home_text.png',
              width: 150.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Coins Row
  Widget _buildCoinsRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("00", style: AppTextStyles.heading),
              SizedBox(width: 3.w),
              Text("/Sweep coins", style: AppTextStyles.body),
            ],
          ),
          Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: AppColors.primaryBg,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Text("Get more coins", style: AppTextStyles.body),
                SizedBox(width: 4.w),
                const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white70),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Section Title
  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.subHeading),
        Text("See all", style: AppTextStyles.link),
      ],
    );
  }

  // 🔹 Auction List
  Widget _buildAuctionList() {
    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, _) => _auctionCard(),
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemCount: 6,
      ),
    );
  }

  // 🔹 Auction Card
  Widget _auctionCard() {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.cardBg,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            left: 12.w,
            right: 12.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lord Villa", style: AppTextStyles.subHeading),
                SizedBox(height: 4.h),
                Text(
                  "1580 Garden Rd, Australia",
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Bottom Navigation
  Widget _buildBottomNav() {
    return AnimatedNotchBottomBar(
      notchBottomBarController: controller.notchBottomBarController,
      kIconSize: 20.sp,
      kBottomRadius: 8.r,
      notchColor: AppColors.primary,
      color: AppColors.secondaryBg,
      showLabel: false,
      itemLabelStyle: AppTextStyles.small,
      bottomBarItems: const [
        BottomBarItem(
          inActiveItem: Icon(Icons.home_rounded, color: Colors.white54),
          activeItem: Icon(Icons.home_rounded, color: Colors.white),
          itemLabel: 'Home',
        ),
        BottomBarItem(
          inActiveItem:
              Icon(Icons.bar_chart_rounded, color: Colors.white54),
          activeItem:
              Icon(Icons.bar_chart_rounded, color: Colors.white),
          itemLabel: 'Auction',
        ),
        BottomBarItem(
          inActiveItem:
              Icon(Icons.menu_book_rounded, color: Colors.white54),
          activeItem:
              Icon(Icons.menu_book_rounded, color: Colors.white),
          itemLabel: 'Rental',
        ),
        BottomBarItem(
          inActiveItem:
              Icon(Icons.settings, color: Colors.white54),
          activeItem:
              Icon(Icons.settings, color: Colors.white),
          itemLabel: 'Settings',
        ),
      ],
      onTap: controller.onBottomNavTap,
    );
  }
}