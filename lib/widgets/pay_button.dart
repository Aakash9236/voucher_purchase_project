import 'package:flutter/material.dart';

class PayButton extends StatelessWidget {
  final bool isEnabled;
  final double youPay;
  final VoidCallback? onPay;

  const PayButton({
    super.key,
    required this.isEnabled,
    required this.youPay,
    this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 250),
      child: GestureDetector(
        onTap: isEnabled ? onPay : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            gradient: isEnabled
                ? const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6C47FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: isEnabled ? null : Colors.grey[400],
            borderRadius: BorderRadius.circular(14),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: const Color(0xFF6C47FF).withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pay ₹${youPay.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(width: 8),
              const Text('✨', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
