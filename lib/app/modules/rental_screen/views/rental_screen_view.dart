import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            const SizedBox(height: 10),
            _buildHeader(),
            const SizedBox(height: 15),
            _buildSearch(),
            const SizedBox(height: 15),
            _buildFilters(),
            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  RentalCard(),
                  SizedBox(height: 20),
                  RentalCard(isSecond: true),
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
          const Text("Rentals",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const Spacer(),
          _circleButton(Icons.tune),
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

  // 🔹 Search
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.white54),
            hintText: "Search property...",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // 🔹 Filters
  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          FilterChipWidget(title: "All", isSelected: true),
          SizedBox(width: 10),
          FilterChipWidget(title: "House"),
          SizedBox(width: 10),
          FilterChipWidget(title: "Apartment"),
          SizedBox(width: 10),
          FilterChipWidget(title: "Villa"),
        ],
      ),
    );
  }
}

// 🔹 Rental Card
class RentalCard extends StatelessWidget {
  final bool isSecond;
  const RentalCard({super.key, this.isSecond = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.RENTAL_DETAIL_SCREEN);
      },
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(isSecond
                ? "assets/images/house2.webp"
                : "assets/images/house3.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.favorite_border,
                        color: Colors.white),
                  )
                ],
              ),
              const Spacer(),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text("Modern Family House",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text("New York, USA",
                    style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Text("\$1200/month",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Icon(Icons.bed, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text("3", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.bathtub, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text("2", style: TextStyle(color: Colors.white)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 Filter Chip (reuse from previous)
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}