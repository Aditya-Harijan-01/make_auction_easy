import 'package:get/get.dart';

import '../modules/auction_detail_screen/bindings/auction_detail_screen_binding.dart';
import '../modules/auction_detail_screen/views/auction_detail_screen_view.dart';
import '../modules/auction_screen/bindings/auction_screen_binding.dart';
import '../modules/auction_screen/views/auction_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/rental_detail_screen/bindings/rental_detail_screen_binding.dart';
import '../modules/rental_detail_screen/views/rental_detail_screen_view.dart';
import '../modules/rental_screen/bindings/rental_screen_binding.dart';
import '../modules/rental_screen/views/rental_screen_view.dart';
import '../modules/setting_screen/bindings/setting_screen_binding.dart';
import '../modules/setting_screen/views/setting_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_SCREEN,
      page: () => const SettingScreenView(),
      binding: SettingScreenBinding(),
    ),
    GetPage(
      name: _Paths.AUCTION_SCREEN,
      page: () => const AuctionScreenView(),
      binding: AuctionScreenBinding(),
    ),
    GetPage(
      name: _Paths.RENTAL_SCREEN,
      page: () => const RentalScreenView(),
      binding: RentalScreenBinding(),
    ),
    GetPage(
      name: _Paths.AUCTION_DETAIL_SCREEN,
      page: () => const AuctionDetailScreenView(),
      binding: AuctionDetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.RENTAL_DETAIL_SCREEN,
      page: () => const RentalDetailScreenView(),
      binding: RentalDetailScreenBinding(),
    ),
  ];
}
