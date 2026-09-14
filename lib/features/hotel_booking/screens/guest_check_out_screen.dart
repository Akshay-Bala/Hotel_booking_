import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/room_badge.dart';

/// Guest Check-out screen reproducing Image 2 from Raintech designs.
class GuestCheckOutScreen extends StatefulWidget {
  final VoidCallback onBackToDashboard;
  final VoidCallback onNavigateToCheckIn;

  const GuestCheckOutScreen({
    super.key,
    required this.onBackToDashboard,
    required this.onNavigateToCheckIn,
  });

  @override
  State<GuestCheckOutScreen> createState() => _GuestCheckOutScreenState();
}

class _GuestCheckOutScreenState extends State<GuestCheckOutScreen> {
  bool _room101Selected = true;
  bool _room103Selected = true;
  String _paymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Browser Mock Bar matching screenshot
              _buildBrowserHeader(),

              const SizedBox(height: 10),

              // Page Title & Search
              _buildSubHeader(),

              const SizedBox(height: 12),

              // 3 Column Grid: 1. Identify Departing Guest, 2. Review & Finalize Bill, 3. Payment & Check-out
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 1050;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4, child: _buildCard1()),
                        const SizedBox(width: 12),
                        Expanded(flex: 5, child: _buildCard2()),
                        const SizedBox(width: 12),
                        Expanded(flex: 3, child: _buildCard3()),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildCard1(),
                        const SizedBox(height: 12),
                        _buildCard2(),
                        const SizedBox(height: 12),
                        _buildCard3(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrowserHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD0D7DE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_rounded, size: 12, color: Color(0xFF0284C7)),
                SizedBox(width: 6),
                Text('https://Management Pro', style: TextStyle(fontSize: 11, color: Color(0xFF334155), fontWeight: FontWeight.w500)),
                SizedBox(width: 6),
                Icon(Icons.close_rounded, size: 11, color: Color(0xFF94A3B8)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.add, size: 14, color: Color(0xFF64748B)),
          const Spacer(),
          TextButton.icon(
            onPressed: widget.onBackToDashboard,
            icon: const Icon(Icons.dashboard_rounded, size: 14),
            label: const Text('Dashboard', style: TextStyle(fontSize: 11.5)),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
          TextButton.icon(
            onPressed: widget.onNavigateToCheckIn,
            icon: const Icon(Icons.assignment_turned_in_outlined, size: 14),
            label: const Text('Check-in Page', style: TextStyle(fontSize: 11.5)),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader() {
    return Row(
      children: [
        const Text(
          'Guest Check-out',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 16, color: AppColors.textMuted),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search Booking ID / Guest Name',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Section 1: Identify Departing Guest ---
  Widget _buildCard1() {
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
            child: const Text('1. Identify Departing Guest', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Find Guest & Identify by Room
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Find Guest', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Search Guest', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textMuted),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Identify by Room', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                Icon(Icons.unfold_more_rounded, size: 14, color: AppColors.textMuted),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Select Guest from List + Find Room/Guest Button
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Select Guest from List', style: TextStyle(fontSize: 11, color: AppColors.textMuted), overflow: TextOverflow.ellipsis),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textMuted),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryNavy,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('Find Room/Guest', style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Guest Name & Room No Plate
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Guest Name', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                        Text('Mathew Hyden', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Room No.', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                        const SizedBox(height: 2),
                        RoomBadge(roomCode: '101', fontSize: 13, isSelected: true),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Rooms & Stay dates table matching screenshot
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 320),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Room', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              SizedBox(width: 24),
                              Text('Stay Dates', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              SizedBox(width: 24),
                              Text('Actions', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(color: AppColors.border, height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('101', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 20),
                              const Text('02/04/2026-04/04/2026', style: TextStyle(fontSize: 11)),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _room101Selected,
                                    onChanged: (v) => setState(() => _room101Selected = v ?? true),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const Text('Select for Check-out', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('103', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 20),
                              const Text('02/04/2026-04/04/2026', style: TextStyle(fontSize: 11)),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _room103Selected,
                                    onChanged: (v) => setState(() => _room103Selected = v ?? true),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const Text('Select for Check-out', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Add/Change Selected Rooms button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.search, size: 14),
                    label: const Text('Add/Change Selected Rooms', style: TextStyle(fontSize: 11)),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1E9DF),
                      side: const BorderSide(color: Color(0xFFD6C8B5)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Section 2: Review & Finalize Bill ---
  Widget _buildCard2() {
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
            child: const Text('2. Review & Finalize Bill', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
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
                        child: Text('Selected Rooms Combined Total:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
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

  // --- Section 3: Payment & Check-out ---
  Widget _buildCard3() {
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
            child: const Text('3. Payment & Check-out', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
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
                      child: Text('Total Amount Due', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
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
                      value: _paymentMethod,
                      isExpanded: true,
                      items: ['Credit Card', 'Cash', 'M-Pay'].map((m) {
                        return DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (v) => setState(() => _paymentMethod = v ?? 'Credit Card'),
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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Payment processed and Check-out completed!'), backgroundColor: Color(0xFF166534)),
                      );
                    },
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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Combined rooms checked out successfully!'), backgroundColor: Color(0xFF166534)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16385C),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text('Payment & Check-out\nCombine and Proceed with Selected Rooms Check-out',
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.white)),
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
