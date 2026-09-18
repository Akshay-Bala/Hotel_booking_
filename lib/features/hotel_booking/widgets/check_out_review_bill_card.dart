import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CheckOutReviewBillCard extends StatelessWidget {
  const CheckOutReviewBillCard({super.key});

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
              '2. Review & Finalize Bill',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room 101 header
                const Text('[Room 101]', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                const Text('(Nights: 2, Rate: ₹1200.00, Total: ₹2400.00)', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(height: 6),

                // Additional Charges bar
                Row(
                  children: [
                    const Expanded(
                      child: Text('Additional Charges', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 4),
                    _tagButton('Mini-bar'),
                    const SizedBox(width: 4),
                    _tagButton('Laundry'),
                    const SizedBox(width: 4),
                    _tagButton('+'),
                  ],
                ),
                const SizedBox(height: 8),

                // Itemized bill table for 101
                _buildBillItem('Mini-bar (Water x2)', '03/04/2026', '₹100.00'),
                _buildBillItem('Room Service', '03/04/2026', '₹1200.00'),
                _buildBillItem('Restaurant Bill (Room 101)', '03/04/2026', '₹850.00'),
                const Divider(color: AppColors.border, height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Room 101 Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text('₹4550.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.primaryNavy)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _actionButton('Print Room 101 Invoice', Icons.print_outlined)),
                    const SizedBox(width: 6),
                    Expanded(child: _actionButton('Adjust Charges (Room 101)', Icons.swap_horiz_rounded)),
                  ],
                ),

                const Divider(color: AppColors.border, height: 20),

                // Room 103 header & breakdown
                const Text('[Room 103]', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                const Text('(Nights: 2, Rate: ₹1200.00, Total: ₹2400.00)', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                _buildBillItem('Mini-bar (Chips)', '03/04/2026', '₹50.00'),
                _buildBillItem('Restaurant Bill (Room 103)', '03/04/2026', '₹1200.00'),
                const Divider(color: AppColors.border, height: 12),
                Row(
                  children: [
                    Expanded(child: _actionButton('Print Room 103 Invoice', Icons.print_outlined)),
                    const SizedBox(width: 6),
                    Expanded(child: _actionButton('Adjust Charges (Room 103)', Icons.swap_horiz_rounded)),
                  ],
                ),
                const SizedBox(height: 12),

                // Combined total bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1E9DF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Selected Rooms Combined Total:',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('₹8200.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.primaryNavy)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillItem(String title, String date, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textPrimary))),
          Text(date, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          const SizedBox(width: 12),
          Text(amount, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _tagButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1E9DF),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFD6C8B5)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
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
