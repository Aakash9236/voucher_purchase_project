import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Contoller/gift_voucher_controller.dart';
import '../widgets/voucher_header.dart';
import '../widgets/amount_input.dart';
import '../widgets/savings_row.dart';
import '../widgets/payment_options.dart';
import '../widgets/how_to_redeem.dart';
import '../widgets/pay_button.dart';
import '../widgets/action_buttons.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GiftVoucherController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VoucherHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        controller.voucherData.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AmountInput(
                        controller: controller.amountController,
                        maxAmount: controller.voucherData.maxAmount,
                      ),
                      const SizedBox(height: 16),
                      Obx(() => SavingsRow(
                        youPay: controller.youPay,
                        savings: controller.savings,
                      )),
                      const SizedBox(height: 16),
                      Obx(() => PaymentOptions(
                        discounts: controller.voucherData.discounts,
                        selectedMethod: controller.selectedPayment.value,
                        onMethodSelected: controller.setPayment,
                        quantity: controller.quantity.value,
                        onIncrement: controller.incrementQuantity,
                        onDecrement: controller.decrementQuantity,
                      )),
                      const SizedBox(height: 20),
                      HowToRedeem(steps: controller.voucherData.howToRedeem),
                      const SizedBox(height: 16),
                      const ActionButtons(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              // Sticky Pay Button at the bottom
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                  border: Border(
                    top: BorderSide(color: Color(0xFFF0F0F0)),
                  ),
                ),
                child: Obx(() => PayButton(
                  isEnabled: controller.isPayButtonEnabled,
                  youPay: controller.youPay,
                  onPay: controller.onPay,
                )),
              ),
            ],
        ),
      ),
    );
  }
}
