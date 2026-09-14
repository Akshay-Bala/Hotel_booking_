import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/room_badge.dart';
import '../providers/hotel_booking_provider.dart';

/// Section 3: Booking summary, night calculation, total price and booking confirmation.
class BookingSummary extends StatelessWidget {
  final VoidCallback onConfirmBooking;

  const BookingSummary({
    super.key,
    required this.onConfirmBooking,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HotelBookingProvider>();
    final dateFormat = DateFormat('dd MMM yyyy');

    final checkIn = provider.checkInDate;
    final checkOut = provider.checkOutDate;
    final room = provider.selectedRoom;
    final nights = provider.numberOfNights;
    final isReady = provider.isBookingValid;

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
          // Navy Banner matching screenshot
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
                Icon(Icons.receipt_long_rounded, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  '3. BOOKING SUMMARY & PAYMENT',
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
                if (!isReady) ...[
                  // Incomplete Booking State Guidance
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.playlist_add_check_rounded,
                          size: 32,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Incomplete Selection',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getMissingItemDescription(checkIn, checkOut, room),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Valid Booking Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room!.roomType,
                            style: AppTextStyles.cardTitle,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Floor ${room.floor} • Max ${room.maxGuests} Guests',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                      RoomBadge(
                        roomCode: room.roomCode,
                        isSelected: true,
                        fontSize: 13,
                      ),
                    ],
                  ),

                  const Divider(color: AppColors.border, height: 24),

                  // Dates row
                  _SummaryRow(
                    icon: Icons.calendar_today_rounded,
                    label: 'Stay Duration',
                    value: '${dateFormat.format(checkIn!)} → ${dateFormat.format(checkOut!)}',
                  ),
                  const SizedBox(height: 10),

                  // Nights count calculation
                  _SummaryRow(
                    icon: Icons.nights_stay_rounded,
                    label: 'Number of Nights',
                    value: '$nights ${nights == 1 ? 'Night' : 'Nights'}',
                    valueHighlight: true,
                  ),
                  const SizedBox(height: 10),

                  // Price per night
                  _SummaryRow(
                    icon: Icons.sell_outlined,
                    label: 'Rate per Night',
                    value: '${CurrencyFormatter.format(room.pricePerNight)} / night',
                  ),

                  const Divider(color: AppColors.border, height: 24),

                  // Calculation breakdown formula
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Calculation:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '$nights nights × ${CurrencyFormatter.format(room.pricePerNight)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Total Amount Highlight
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount Due',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(provider.totalPrice),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryNavy,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 20),

                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: isReady ? onConfirmBooking : null,
                    icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
                    label: const Text('Complete Booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.buttonSecondaryBg,
                      disabledForegroundColor: AppColors.textMuted,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton.icon(
                    onPressed: (checkIn != null || checkOut != null || room != null)
                        ? () => provider.clearSelection()
                        : null,
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Clear Selection'),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.surfaceLight,
                      foregroundColor: AppColors.textSecondary,
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

  static String _getMissingItemDescription(
    DateTime? checkIn,
    DateTime? checkOut,
    dynamic room,
  ) {
    final missing = <String>[];
    if (checkIn == null) missing.add('Check-in date');
    if (checkOut == null) missing.add('Check-out date');
    if (room == null) missing.add('Room');

    if (missing.isEmpty) {
      return 'Please ensure your dates and room selection are valid.';
    }
    return 'Please select ${missing.join(', ')} to view total and finalize.';
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool valueHighlight;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppColors.textMuted),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: valueHighlight ? FontWeight.w800 : FontWeight.w600,
            color: valueHighlight ? AppColors.primaryNavy : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
