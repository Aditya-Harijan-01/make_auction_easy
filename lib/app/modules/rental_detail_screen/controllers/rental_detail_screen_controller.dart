import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/rental_property.dart';

class RentalDetailScreenController extends GetxController {
  late final RentalProperty property;
  final RxBool isFavorite = false.obs;
  final RxInt selectedLeaseMonths = 12.obs;
  final Rxn<DateTime> moveInDate = Rxn<DateTime>();
  final RxInt adults = 1.obs;
  final RxInt children = 0.obs;
  final RxBool includePets = false.obs;
  final RxString selectedPaymentMethod = 'Card'.obs;
  final RxBool acceptedTerms = false.obs;
  final RxBool isSubmitting = false.obs;
  final TextEditingController noteController = TextEditingController();

  final List<int> leaseOptions = const <int>[6, 12, 18, 24];
  final List<String> paymentMethods = const <String>['Card', 'UPI', 'Bank'];

  int get totalOccupants => adults.value + children.value;
  int get monthlyBaseRent => property.monthlyRent;
  int get maintenanceFee => property.maintenanceFee;
  int get petFee => includePets.value ? 50 : 0;
  int get securityDeposit =>
      property.monthlyRent * property.securityDepositMonths;
  int get processingFee => 99;
  int get leaseDiscount => selectedLeaseMonths.value >= 12 ? 75 : 0;
  int get monthlyPayable => monthlyBaseRent + maintenanceFee + petFee;
  int get dueNow =>
      monthlyPayable + securityDeposit + processingFee - leaseDiscount;

  bool get canSubmit {
    return moveInDate.value != null &&
        acceptedTerms.value &&
        !isSubmitting.value;
  }

  String get moveInDateLabel {
    final DateTime? selectedDate = moveInDate.value;
    if (selectedDate == null) {
      return 'Select date';
    }
    return formatDate(selectedDate);
  }

  @override
  void onInit() {
    _loadProperty();
    final DateTime initialDate = property.availableFrom.isAfter(DateTime.now())
        ? property.availableFrom
        : DateTime.now().add(const Duration(days: 3));
    moveInDate.value = initialDate;
    super.onInit();
  }

  void _loadProperty() {
    final dynamic args = Get.arguments;

    if (args is RentalProperty) {
      property = args;
      return;
    }

    if (args is Map) {
      final Map<String, dynamic> payload = <String, dynamic>{};
      for (final MapEntry<dynamic, dynamic> entry in args.entries) {
        payload[entry.key.toString()] = entry.value;
      }
      property = RentalProperty.fromMap(payload);
      return;
    }

    property = RentalProperty.fallback();
  }

  String formatDate(DateTime value) {
    const List<String> monthNames = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${monthNames[value.month - 1]} ${value.day}, ${value.year}';
  }

  String formatMoney(int amount) {
    final String number = amount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => ',',
    );
    return '\$$number';
  }

  void toggleFavorite() {
    isFavorite.toggle();
  }

  void selectLeaseMonths(int months) {
    selectedLeaseMonths.value = months;
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void toggleTerms(bool? checked) {
    acceptedTerms.value = checked ?? false;
  }

  void togglePets(bool value) {
    includePets.value = value;
  }

  void incrementAdults() {
    if (totalOccupants >= property.maxTenants) {
      _showOccupancyLimitMessage();
      return;
    }
    adults.value++;
  }

  void decrementAdults() {
    if (adults.value > 1) {
      adults.value--;
    }
  }

  void incrementChildren() {
    if (totalOccupants >= property.maxTenants) {
      _showOccupancyLimitMessage();
      return;
    }
    children.value++;
  }

  void decrementChildren() {
    if (children.value > 0) {
      children.value--;
    }
  }

  Future<void> pickMoveInDate() async {
    final BuildContext? context = Get.context;
    if (context == null) {
      return;
    }

    final DateTime now = DateTime.now();
    final DateTime firstDate = property.availableFrom.isAfter(now)
        ? property.availableFrom
        : now;
    final DateTime initialDate =
        moveInDate.value != null && !moveInDate.value!.isBefore(firstDate)
        ? moveInDate.value!
        : firstDate;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: firstDate.add(const Duration(days: 365)),
      helpText: 'Select move-in date',
      cancelText: 'Cancel',
      confirmText: 'Select',
    );

    if (pickedDate != null) {
      moveInDate.value = pickedDate;
    }
  }

  Future<void> submitRentalRequest() async {
    if (moveInDate.value == null) {
      Get.snackbar(
        'Move-in date required',
        'Please select a move-in date to continue.',
        backgroundColor: const Color(0xFF1F2937),
        colorText: Colors.white,
      );
      return;
    }

    if (!acceptedTerms.value) {
      Get.snackbar(
        'Terms not accepted',
        'Please accept the terms before confirming your rental.',
        backgroundColor: const Color(0xFF1F2937),
        colorText: Colors.white,
      );
      return;
    }

    isSubmitting.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 900));
    isSubmitting.value = false;

    Get.dialog<void>(
      AlertDialog(
        backgroundColor: const Color(0xFF111827),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'Rental Request Submitted',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'You requested ${property.title}.\n'
          'Move-in: $moveInDateLabel\n'
          'Due now: ${formatMoney(dueNow)}',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back<void>(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showOccupancyLimitMessage() {
    Get.snackbar(
      'Occupancy limit reached',
      'This property allows up to ${property.maxTenants} tenants.',
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
