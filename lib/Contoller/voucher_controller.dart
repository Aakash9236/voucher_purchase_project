import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/voucher_model.dart';
import '../Screen/VoucherScreen.dart';

class VoucherController extends GetxController {
  late final VoucherModel voucherData;

  final TextEditingController amountController = TextEditingController();

  final RxDouble enteredAmount = 0.0.obs;
  final RxInt quantity = 1.obs;
  final RxString selectedPayment = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load mock data
    voucherData = VoucherModel.mockData;

    // Initialize default values
    enteredAmount.value = voucherData.minAmount;
    amountController.text = voucherData.minAmount.toStringAsFixed(0);

    if (voucherData.discounts.isNotEmpty) {
      selectedPayment.value = voucherData.discounts.first.method;
    }

    amountController.addListener(() {
      enteredAmount.value = double.tryParse(amountController.text) ?? 0.0;
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  // --- Getters based on Business Rules ---

  double get currentDiscountPercent {
    final discount = voucherData.discounts.firstWhere(
      (d) => d.method == selectedPayment.value,
      orElse: () => DiscountMethod(method: 'NONE', percent: 0),
    );
    return discount.percent;
  }

  double get discountAmount => enteredAmount.value * (currentDiscountPercent / 100);

  double get youPay => (enteredAmount.value - discountAmount) * quantity.value;

  double get savings => discountAmount * quantity.value;

  bool get isAmountValid =>
      enteredAmount.value >= voucherData.minAmount &&
      enteredAmount.value <= voucherData.maxAmount;

  bool get isPayButtonEnabled => isAmountValid && !voucherData.disablePurchase;

  // --- Actions ---

  void selectPayment(String method) {
    selectedPayment.value = method;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void onPay() {
    if (!isPayButtonEnabled) return;
    Get.to(() => const VoucherScreen());
  }
}
