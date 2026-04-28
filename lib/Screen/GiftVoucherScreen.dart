import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Contoller/gift_voucher_controller.dart';
import '../widgets/voucher_header.dart';
import '../widgets/amount_input.dart';
import '../widgets/savings_row.dart';
import '../widgets/payment_options.dart';
import '../widgets/how_to_redeem.dart';
import '../widgets/pay_button.dart';

class GiftVoucherScreen extends StatelessWidget {
  GiftVoucherScreen({super.key});

  final GiftVoucherController controller = Get.put(GiftVoucherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VoucherHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildVoucherCard(),
                      const SizedBox(height: 12),
                      Text(
                        controller.voucherData.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                      HowToRedeem(steps: controller.voucherData.redeemSteps),
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
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
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

  Widget _buildVoucherCard() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFCC1A1A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: CustomPaint(
          size: const Size(100, 70),
          painter: _WLogoPainter(),
        ),
      ),
    );
  }
}

class _WLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeJoin = StrokeJoin.miter
      ..strokeCap = StrokeCap.square;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Draw stylized W
    path.moveTo(0, 0);
    path.lineTo(w * 0.2, h);
    path.lineTo(w * 0.5, h * 0.35);
    path.lineTo(w * 0.8, h);
    path.lineTo(w, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WLogoPainter oldDelegate) => false;
}