import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auction_detail_screen_controller.dart';

class AuctionDetailScreenView extends GetView<AuctionDetailScreenController> {
  const AuctionDetailScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1C),
      body: Stack(
        children: [
          _buildHeaderImage(),
          _buildTopBar(),
          _buildContent(),
          _buildBottomButton(),
        ],
      ),
    );
  }

  // 🔹 Header Image
  Widget _buildHeaderImage() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Image.asset(
        "assets/images/house.webp",
        fit: BoxFit.cover,
      ),
    );
  }

  // 🔹 Top Bar
  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            _circleButton(Icons.arrow_back_ios_new),
            const Spacer(),
            _circleButton(Icons.more_vert),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  // 🔹 Main Content
  Widget _buildContent() {
    return Positioned(
      top: 250,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF0A0F1C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          children: [
            _buildTimer(),
            const SizedBox(height: 10),
            _buildTags(),
            const SizedBox(height: 12),
            _buildTitle(),
            const SizedBox(height: 12),
            _buildParticipants(),
            const SizedBox(height: 20),
            _buildTabs(),
            const SizedBox(height: 20),
            _buildBidStats(),
            const SizedBox(height: 20),
            _buildBanner(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // 🔹 Timer
  Widget _buildTimer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Auction ends in 10:15:12",
        style: TextStyle(color: Colors.orange),
      ),
    );
  }

  // 🔹 Tags
  Widget _buildTags() {
    return Row(
      children: [
        _tag("Joined", Colors.green),
        const SizedBox(width: 10),
        _tag("Round 2", Colors.grey.shade800),
      ],
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  // 🔹 Title
  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Luxury BR villa with private pool and ricefield view.",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          "1580 Garden Rd, Australia",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  // 🔹 Participants + Price
  Widget _buildParticipants() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 14,
          backgroundImage: AssetImage("assets/images/house.webp"),
        ),
        const SizedBox(width: 6),
        const CircleAvatar(
          radius: 14,
          backgroundImage: AssetImage("assets/images/house2.webp"),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("5+", style: TextStyle(color: Colors.white)),
        ),
        const Spacer(),
        Row(
          children: const [
            Icon(Icons.monetization_on, color: Colors.orange),
            SizedBox(width: 4),
            Text("250", style: TextStyle(color: Colors.white)),
          ],
        )
      ],
    );
  }

  // 🔹 Tabs
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(child: _tabButton("Auction details", true)),
          Expanded(child: _tabButton("Bidding details", false)),
        ],
      ),
    );
  }

  Widget _tabButton(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // 🔹 Bid Stats
  Widget _buildBidStats() {
    return Row(
      children: [
        Expanded(child: _bidCard("Lowest bid", "\$0.90M")),
        const SizedBox(width: 10),
        Expanded(child: _bidCard("Highest bid", "\$2.31M")),
      ],
    );
  }

  Widget _bidCard(String title, String price) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(price,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  // 🔹 Banner
  Widget _buildBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              "Join and bid in more rounds to boost your winning chances.\nJoin another round →",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Icon(Icons.house, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  // 🔹 Bottom Button
  Widget _buildBottomButton() {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            "Place your bid →",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}