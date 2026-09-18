import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';

class CheckInFinalizePaymentCard extends StatelessWidget {
  final double totalAmount;
  final VoidCallback onCompleteCheckIn;

  const CheckInFinalizePaymentCard({
    super.key,
    required this.totalAmount,
    required this.onCompleteCheckIn,
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
          // Navy Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
            ),
            child: const Text(
              '3. Finalize Check-in & Payment',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Room Charge', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text(CurrencyFormatter.format(totalAmount), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Extra Charges', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text('₹0.00', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text('₹0.00', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(color: AppColors.border, height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Total Amount:',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      CurrencyFormatter.format(totalAmount),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.primaryNavy),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Total Paid:',
                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(CurrencyFormatter.format(totalAmount), style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onCompleteCheckIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Complete Check-in', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _actionButton('Get Data')),
                    const SizedBox(width: 4),
                    Expanded(child: _actionButton('M-Pay')),
                    const SizedBox(width: 4),
                    Expanded(child: _actionButton('Print')),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: _actionButton('Print Registration Card'),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _actionButton('Download Folio')),
                    const SizedBox(width: 4),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onCompleteCheckIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNavy,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text('Complete Check-in', style: TextStyle(fontSize: 10, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFF1E9DF),
        side: const BorderSide(color: Color(0xFFD6C8B5), width: 0.8),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: Color(0xFF332D24))),
    );
  }
}
