import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/rental_detail_screen_controller.dart';

class RentalDetailScreenView extends GetView<RentalDetailScreenController> {
  const RentalDetailScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1C),

      /// ✅ Bottom Button
      bottomNavigationBar: _buildBottomButton(),

      body: Column(
        children: [
          /// 🔹 Image + TopBar
          Stack(
            children: [
              _buildImage(),
              _buildTopBar(),
            ],
          ),

          /// 🔹 Content
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  /// 🔹 Image Section
  Widget _buildImage() {
    return Container(
      height: 260.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/house.webp"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.live_tv, color: Colors.red, size: 15.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "Auction ends in: 3d 4h 20m",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// 🔹 Top Bar
  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: _circle(Icons.arrow_back_ios_new),
            ),
            const Spacer(),
            _circle(Icons.favorite_border),
          ],
        ),
      ),
    );
  }

  /// 🔹 Circle Button
  Widget _circle(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(icon, color: Colors.white, size: 18.sp),
    );
  }

  /// 🔹 Content
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: const BoxDecoration(
          color: Color(0xFF0A0F1C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tags
            Row(
              children: [
                _tag("Available", Colors.greenAccent, Colors.black54),
                SizedBox(width: 10.w),
                _tag("Round 2", Colors.blue, Colors.white),
              ],
            ),

            SizedBox(height: 12.h),

            /// Title
            Text(
              "Modern Family House",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "New York, USA",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14.sp,
              ),
            ),

            SizedBox(height: 16.h),

            /// Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _Info(Icons.bed, "3 Beds"),
                _Info(Icons.bathtub, "2 Bath"),
                _Info(Icons.square_foot, "1200 sqft"),
              ],
            ),

            SizedBox(height: 20.h),

            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(14.r),
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(child: _bidBox(false)),
            //       SizedBox(width: 10.w),
            //       Expanded(child: _bidBox(false)),
            //     ],
            //   ),
            // ),

            /// Bid Section
            Row(
              children: [
                Expanded(child: _bidBox(true, "Current Bid")),
                SizedBox(width: 10.w),
                Expanded(child: _bidBox(true, "Your Bid")),
              ],
            ),

            SizedBox(height: 20.h),

            /// Description
            Text(
              "Description",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "Beautiful modern house with spacious rooms, private garden and great location.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13.sp,
              ),
            ),

            SizedBox(height: 20.h),

            /// Amenities
            Text(
              "Amenities",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),

            SizedBox(height: 10.h),

            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: const [
                _Chip("WiFi"),
                _Chip("Parking"),
                _Chip("Pool"),
                _Chip("AC"),
              ],
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  /// 🔹 Tag Widget
  Widget _tag(String text, Color bg, Color textColor) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  /// 🔹 Bid Box
  Widget _bidBox(bool isAuction, String title) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: !isAuction ? Colors.transparent : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white70, size: 35.sp),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "\$1200/month",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Bottom Button
  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0F1C),
      ),
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            "Rent Now - \$1200/month",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

/// 🔹 Info Widget
class _Info extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Info(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20.sp),
        SizedBox(height: 6.h),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ],
    );
  }
}

/// 🔹 Chip Widget
class _Chip extends StatelessWidget {
  final String text;
  const _Chip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 12.sp),
      ),
    );
  }
}