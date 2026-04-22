import 'package:get/get.dart';

import '../../auction_screen/controllers/auction_screen_controller.dart';
import '../controllers/home_controller.dart';
import '../../rental_screen/controllers/rental_screen_controller.dart';
import '../../setting_screen/controllers/setting_screen_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AuctionScreenController>(() => AuctionScreenController());
    Get.lazyPut<RentalScreenController>(() => RentalScreenController());
    Get.lazyPut<SettingScreenController>(() => SettingScreenController());
  }
}
