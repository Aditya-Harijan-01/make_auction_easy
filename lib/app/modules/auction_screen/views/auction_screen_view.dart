import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auction_screen_controller.dart';

class AuctionScreenView extends GetView<AuctionScreenController> {
  const AuctionScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1C),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildHeader(),
            const SizedBox(height: 15),
            _buildFilters(),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  AuctionCard(),
                  SizedBox(height: 20),
                  AuctionCard(isSecond: true),
                  SizedBox(height: 20,),
                  AuctionCard(),
                  SizedBox(height: 20),
                  AuctionCard(isSecond: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Header
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _circleButton(Icons.arrow_back_ios_new),
          const Spacer(),
          const Text(
            "Auctions",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          _circleButton(Icons.more_vert),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  // 🔹 Filters
  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            FilterChipWidget(title: "All", isSelected: true),
            SizedBox(width: 10),
            FilterChipWidget(title: "On-Going"),
            SizedBox(width: 10),
            FilterChipWidget(title: "Up-Coming"),
            SizedBox(width: 10),
            FilterChipWidget(title: "Scheduled"),
          ],
        ),
      ),
    );
  }
}

// 🔹 Filter Chip Widget
class FilterChipWidget extends StatelessWidget {
  final String title;
  final bool isSelected;

  const FilterChipWidget({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// 🔹 Auction Card
class AuctionCard extends StatelessWidget {
  final bool isSecond;

  const AuctionCard({super.key, this.isSecond = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(
            isSecond
                ? "assets/images/house2.webp"
                : "assets/images/house.webp",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Auction starts in 10:15:12",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),

            const Spacer(),

            const Text(
              "Lord Villa",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "1580 Garden Rd, Australia",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/images/house.webp"),
                ),
                const SizedBox(width: 6),
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/images/house2.webp"),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "5+",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const Spacer(),
                Row(
                  children: const [
                    Icon(Icons.monetization_on,
                        color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "250",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}