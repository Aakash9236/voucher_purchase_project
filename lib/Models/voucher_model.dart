class DiscountMethod {
  final String method;
  final double percent;

  DiscountMethod({required this.method, required this.percent});

  factory DiscountMethod.fromJson(Map<String, dynamic> json) {
    return DiscountMethod(
      method: json['method'] as String,
      percent: (json['percent'] as num).toDouble(),
    );
  }
}

class VoucherModel {
  final String id;
  final String title;
  final double minAmount;
  final double maxAmount;
  final bool disablePurchase;
  final List<DiscountMethod> discounts;
  final List<String> redeemSteps;
  final List<String> howToRedeem;

  VoucherModel({
    required this.id,
    required this.title,
    required this.minAmount,
    required this.maxAmount,
    required this.disablePurchase,
    required this.discounts,
    required this.redeemSteps,
    required this.howToRedeem,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'] as String,
      title: json['title'] as String,
      minAmount: (json['minAmount'] as num).toDouble(),
      maxAmount: (json['maxAmount'] as num).toDouble(),
      disablePurchase: json['disablePurchase'] as bool,
      discounts: (json['discounts'] as List)
          .map((e) => DiscountMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      redeemSteps: (json['redeemSteps'] as List).map((e) => e as String).toList(),
      howToRedeem: (json['howToRedeem'] as List?)?.map((e) => e as String).toList() ?? [],
    );
  }

  // Mock Data provided in assignment
  static VoucherModel get mockData {
    return VoucherModel.fromJson({
      "id": "zepto-100",
      "title": "Zepto Instant Voucher",
      "minAmount": 50,
      "maxAmount": 10000,
      "disablePurchase": false,
      "discounts": [
        {"method": "UPI", "percent": 10},
        {"method": "CARD", "percent": 10}
      ],
      "redeemSteps": [
        "Use the outlet locator to locate the nearest outlet that accepts this Gift Voucher.",
        "Select your choice of product.",
        "Share your Gift Voucher with the cashier at the time of billing & pay the remaining amount by cash or card if required."
      ],
       "howToRedeem": [
        "Login to zeptol platform",
        "Click on my profile/setting",
        "Go to zepto cash & gift card",
        "Click on add card Option to ad the goft card",
        "Enter the 16 digit card number and 6 digit pin and submit"
      ]

    });
  }
}
