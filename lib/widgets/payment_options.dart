import 'package:flutter/material.dart';
import '../Models/voucher_model.dart';

class PaymentOptions extends StatelessWidget {
  final List<DiscountMethod> discounts;
  final String selectedMethod;
  final Function(String) onMethodSelected;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const PaymentOptions({
    super.key,
    required this.discounts,
    required this.selectedMethod,
    required this.onMethodSelected,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...discounts.map((discount) {
          final isSelected = selectedMethod == discount.method;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onMethodSelected(discount.method),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF3F0FF) : const Color(0xFFFAFAFA),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF6C47FF) : const Color(0xFFE0E0E0),
                    width: isSelected ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getIconForMethod(discount.method),
                        const SizedBox(width: 6),
                        Text(
                          discount.method,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? const Color(0xFF6C47FF) : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${discount.percent.toStringAsFixed(0)}% OFF',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? const Color(0xFF6C47FF) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const Spacer(),
        // Quantity
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'QUANTITY',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                _QtyButton(
                  icon: Icons.remove,
                  onTap: quantity > 1 ? onDecrement : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    quantity.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _QtyButton(
                  icon: Icons.add,
                  onTap: onIncrement,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _getIconForMethod(String method) {
    if (method.toUpperCase() == 'UPI') {
      return Container(
        width: 20,
        height: 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          gradient: const LinearGradient(
            colors: [Color(0xFF097939), Color(0xFF6B2FA0), Color(0xFFE87100)],
          ),
        ),
        child: const Center(
          child: Text(
            'UPI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 6,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }
    return const Icon(Icons.credit_card, size: 18, color: Colors.blueGrey);
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _QtyButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: onTap != null ? const Color(0xFFF3F0FF) : Colors.grey[200],
          shape: BoxShape.circle,
          border: Border.all(
            color: onTap != null ? const Color(0xFF6C47FF) : Colors.grey[300]!,
          ),
        ),
        child: Icon(
          icon,
          size: 15,
          color: onTap != null ? const Color(0xFF6C47FF) : Colors.grey,
        ),
      ),
    );
  }
}
