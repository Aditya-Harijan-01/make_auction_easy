import 'package:get/get.dart';

import '../controllers/rental_screen_controller.dart';

class RentalScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentalScreenController>(
      () => RentalScreenController(),
    );
  }
}
