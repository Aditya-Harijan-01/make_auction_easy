import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/setting_screen_controller.dart';

class SettingScreenView extends GetView<SettingScreenController> {
  const SettingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1F),
      appBar: AppBar(
        title: const Text('SettingScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SettingScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
