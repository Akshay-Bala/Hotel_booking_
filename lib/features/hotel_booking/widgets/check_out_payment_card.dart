import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CheckOutPaymentCard extends StatelessWidget {
  final String paymentMethod;
  final ValueChanged<String?> onPaymentMethodChanged;
  final VoidCallback onProcessPayment;
  final VoidCallback onCombinedCheckOut;

  const CheckOutPaymentCard({
    super.key,
    required this.paymentMethod,
    required this.onPaymentMethodChanged,
    required this.onProcessPayment,
    required this.onCombinedCheckOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
            ),
            child: const Text(
              '3. Payment & Check-out',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Total Amount Due',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('₹8200.00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.primaryNavy)),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('(Selected Rooms)', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    Text('₹0.00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),

                // Payment Method
                const Text('Payment Method', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: paymentMethod,
                      isExpanded: true,
                      items: ['Credit Card', 'Cash', 'M-Pay'].map((m) {
                        return DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: onPaymentMethodChanged,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Payment Amount
                const Text('Payment Amount', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text('₹8200.00', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 14),

                // Primary Navy Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onProcessPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Column(
                      children: [
                        Text('Process Payment & Check-out', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Proceed with Room 101 Check-out', style: TextStyle(fontSize: 9.5, color: Color(0xFFCBD5E1))),
                        Text('Complete Check-out', style: TextStyle(fontSize: 9.5, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onCombinedCheckOut,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16385C),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Payment & Check-out\nCombine and Proceed with Selected Rooms Check-out',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Footer print/email buttons
                SizedBox(
                  width: double.infinity,
                  child: _actionButton('Print Final Invoice', Icons.print_outlined),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: _actionButton('Email Final Invoice', Icons.email_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, [IconData? icon]) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: icon != null ? Icon(icon, size: 13) : const SizedBox.shrink(),
      label: Text(label, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: Color(0xFF332D24))),
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFF1E9DF),
        side: const BorderSide(color: Color(0xFFD6C8B5), width: 0.8),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
