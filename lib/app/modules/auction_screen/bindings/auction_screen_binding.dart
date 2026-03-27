import 'package:get/get.dart';

import '../controllers/auction_screen_controller.dart';

class AuctionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuctionScreenController>(
      () => AuctionScreenController(),
    );
  }
}
