import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rental_screen_controller.dart';

class RentalScreenView extends GetView<RentalScreenController> {
  const RentalScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1F),
      appBar: AppBar(
        title: const Text('RentalScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RentalScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
