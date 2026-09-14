import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../providers/hotel_booking_provider.dart';

/// Section 1: Check-in, Check-out date pickers and guest capacity filter.
class DateSelectionWidget extends StatelessWidget {
  const DateSelectionWidget({super.key});

  Future<void> _pickCheckInDate(BuildContext context, HotelBookingProvider provider) async {
    final now = DateTime.now();
    final initialDate = provider.checkInDate ?? now;
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = now.add(const Duration(days: 365));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'SELECT CHECK-IN DATE',
      builder: (context, child) => _datePickerTheme(context, child),
    );

    if (picked != null) {
      provider.selectCheckInDate(picked);
    }
  }

  Future<void> _pickCheckOutDate(BuildContext context, HotelBookingProvider provider) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Minimum checkout date is checkIn + 1 day, or today + 1 day
    final baseCheckIn = provider.checkInDate ?? today;
    final firstDate = baseCheckIn.add(const Duration(days: 1));
    final initialDate = (provider.checkOutDate != null && provider.checkOutDate!.isAfter(baseCheckIn))
        ? provider.checkOutDate!
        : firstDate;
    final lastDate = baseCheckIn.add(const Duration(days: 365));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'SELECT CHECK-OUT DATE',
      builder: (context, child) => _datePickerTheme(context, child),
    );

    if (picked != null) {
      provider.selectCheckOutDate(picked);
    }
  }

  Widget _datePickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryNavy,
          onPrimary: Colors.white,
          onSurface: AppColors.textPrimary,
        ),
      ),
      child: child ?? const SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HotelBookingProvider>();
    final dateFormat = DateFormat('dd/MM/yyyy');
    final friendlyFormat = DateFormat('dd MMM yyyy');

    final checkIn = provider.checkInDate;
    final checkOut = provider.checkOutDate;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Navy Banner matching screenshot
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.calendar_month_rounded, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  '1. SELECT STAY DATES & GUESTS',
                  style: AppTextStyles.sectionHeader,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Pickers row / column
                Row(
                  children: [
                    // Check-in Selector
                    Expanded(
                      child: _DateCard(
                        label: 'Check-in Date',
                        dateDisplay: checkIn != null ? friendlyFormat.format(checkIn) : 'Select date',
                        subLabel: checkIn != null ? dateFormat.format(checkIn) : 'Arrival',
                        icon: Icons.login_rounded,
                        onTap: () => _pickCheckInDate(context, provider),
                        isSelected: checkIn != null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Check-out Selector
                    Expanded(
                      child: _DateCard(
                        label: 'Check-out Date',
                        dateDisplay: checkOut != null ? friendlyFormat.format(checkOut) : 'Select date',
                        subLabel: checkOut != null ? dateFormat.format(checkOut) : 'Departure',
                        icon: Icons.logout_rounded,
                        onTap: () => _pickCheckOutDate(context, provider),
                        isSelected: checkOut != null,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Guest Filter (Bonus C)
                const Text(
                  'Filter by Guests Capacity',
                  style: AppTextStyles.label,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _FilterChip(
                      label: 'All Rooms',
                      isSelected: provider.guestFilter == null,
                      onTap: () => provider.setGuestFilter(null),
                    ),
                    _FilterChip(
                      label: '2 Guests',
                      isSelected: provider.guestFilter == 2,
                      onTap: () => provider.setGuestFilter(2),
                    ),
                    _FilterChip(
                      label: '3 Guests',
                      isSelected: provider.guestFilter == 3,
                      onTap: () => provider.setGuestFilter(3),
                    ),
                    _FilterChip(
                      label: '4+ Guests',
                      isSelected: provider.guestFilter == 4,
                      onTap: () => provider.setGuestFilter(4),
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
}

class _DateCard extends StatelessWidget {
  final String label;
  final String dateDisplay;
  final String subLabel;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const _DateCard({
    required this.label,
    required this.dateDisplay,
    required this.subLabel,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3F7FA) : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isSelected ? AppColors.primaryNavy : AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.primaryNavy : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              dateDisplay,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subLabel,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.textSecondary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryNavy : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
