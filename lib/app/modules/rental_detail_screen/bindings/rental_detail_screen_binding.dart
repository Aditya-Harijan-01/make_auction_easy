import 'package:get/get.dart';

import '../controllers/rental_detail_screen_controller.dart';

class RentalDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentalDetailScreenController>(
      () => RentalDetailScreenController(),
    );
  }
}
