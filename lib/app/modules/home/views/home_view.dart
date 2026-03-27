import 'package:dummy_app/app/modules/auction_screen/views/auction_screen_view.dart';
import 'package:dummy_app/app/modules/rental_screen/views/rental_screen_view.dart';
import 'package:dummy_app/app/modules/setting_screen/views/setting_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1F),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildBanner(),
          const SizedBox(height: 20),
          _buildCoinsRow(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("On-going auctions"),
                  const SizedBox(height: 12),
                  _buildAuctionList(),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Featured auctions"),
                  const SizedBox(height: 12),
                  _buildAuctionList(),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Premium auctions"),
                  const SizedBox(height: 12),
                  _buildAuctionList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: Colors.white70),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
        ),
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
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  "Alex Jorda",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.notifications_active_outlined, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 80, 113, 244), Color(0xFF3B5BDB)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              "One Tap to Your\nNext Home.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.asset(
              'assets/images/home_text.png',
              width: 150,
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
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "00",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(width: 3),
              const Text(
                "/Sweep coins",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 10, 18, 32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Text(
                    "Get more coins",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white70,
                  ),
                ],
              ),
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
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "See all",
          style: TextStyle(color: Colors.blueAccent, fontSize: 14),
        ),
      ],
    );
  }

  // 🔹 Auction Cards
  Widget _buildAuctionList() {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _auctionCard(),
          const SizedBox(width: 12),
          _auctionCard(),
          const SizedBox(width: 12),
          _auctionCard(),
          const SizedBox(width: 12),
          _auctionCard(),
          const SizedBox(width: 12),
          _auctionCard(),
          const SizedBox(width: 12),
          _auctionCard(),
          const SizedBox(width: 12),
          _auctionCard(),
          const SizedBox(width: 12),
          _auctionCard(),
        ],
      ),
    );
  }

  Widget _auctionCard() {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white10,
      ),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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

          // Content
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Lord Villa",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "1580 Garden Rd, Australia",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          // Top badge
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Free",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Bottom Navigation
  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: AnimatedNotchBottomBar(
        notchBottomBarController: controller.notchBottomBarController,
        kIconSize: 22,
        kBottomRadius: 16,
        notchColor: const Color(0xFF3B5BDB),
        color: const Color(0xFF11192B),
        showLabel: true,
        itemLabelStyle: const TextStyle(color: Colors.white60, fontSize: 12),
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_rounded, color: Colors.white54),
            activeItem: Icon(Icons.home_rounded, color: Colors.white),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.bar_chart_rounded, color: Colors.white54),
            activeItem: Icon(Icons.bar_chart_rounded, color: Colors.white),
            itemLabel: 'Auction',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.menu_book_rounded, color: Colors.white54),
            activeItem: Icon(Icons.menu_book_rounded, color: Colors.white),
            itemLabel: 'Rental',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white54,
            ),
            activeItem: Icon(Icons.shopping_cart_rounded, color: Colors.white),
            itemLabel: 'Cart',
          ),
        ],
        onTap: controller.onBottomNavTap,
      ),
    );
  }
}
