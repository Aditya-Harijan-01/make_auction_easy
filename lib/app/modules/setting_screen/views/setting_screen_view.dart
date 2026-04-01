import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/setting_screen_controller.dart';

class SettingScreenView extends GetView<SettingScreenController> {
  const SettingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1C),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 20),

                  _sectionTitle("General"),
                  _settingsTile(Icons.person_outline, "Edit Profile"),
                  _settingsTile(Icons.lock_outline, "Change Password"),
                  _settingsTile(Icons.notifications_none, "Notifications"),

                  const SizedBox(height: 20),

                  _sectionTitle("Preferences"),
                  _settingsTile(Icons.dark_mode_outlined, "Dark Mode", isSwitch: true),
                  _settingsTile(Icons.language, "Language"),
                  _settingsTile(Icons.location_on_outlined, "Location"),

                  const SizedBox(height: 20),

                  _sectionTitle("Support"),
                  _settingsTile(Icons.help_outline, "Help Center"),
                  _settingsTile(Icons.privacy_tip_outlined, "Privacy Policy"),
                  _settingsTile(Icons.info_outline, "About App"),

                  const SizedBox(height: 30),

                  _logoutButton(),
                  const SizedBox(height: 30),
                ],
              ),
            )
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
            "Settings",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
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

  // 🔹 Profile Card
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage("assets/images/house.webp"),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aditya Kumar",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("aditya@email.com",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.edit, color: Colors.white, size: 18),
          )
        ],
      ),
    );
  }

  // 🔹 Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white70, fontWeight: FontWeight.w500),
      ),
    );
  }

  // 🔹 Settings Tile
  Widget _settingsTile(IconData icon, String title, {bool isSwitch = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(color: Colors.white)),
          ),
          isSwitch
              ? Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: Colors.blue,
                )
              : const Icon(Icons.arrow_forward_ios,
                  size: 14, color: Colors.white54),
        ],
      ),
    );
  }

  // 🔹 Logout Button
  Widget _logoutButton() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.orange],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          "Logout",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }
}