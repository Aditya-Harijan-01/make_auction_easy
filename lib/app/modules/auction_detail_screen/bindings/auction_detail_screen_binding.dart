import 'package:get/get.dart';

import '../controllers/auction_detail_screen_controller.dart';

class AuctionDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuctionDetailScreenController>(
      () => AuctionDetailScreenController(),
    );
  }
}
