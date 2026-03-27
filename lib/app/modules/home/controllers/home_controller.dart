import 'package:get/get.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  final NotchBottomBarController notchBottomBarController =
      NotchBottomBarController(index: 0);

  @override
  void onClose() {
    notchBottomBarController.dispose();
    super.onClose();
  }

  void onBottomNavTap(int index) {
    selectedIndex.value = index;

    /// optional (sync notch controller)
    notchBottomBarController.jumpTo(index);
  }
}
