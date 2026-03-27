import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auction_screen_controller.dart';

class AuctionScreenView extends GetView<AuctionScreenController> {
  const AuctionScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0F1F),
        leading: Container(
          decoration:BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          )
        ),
        title: Text('Auctions'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AuctionScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
