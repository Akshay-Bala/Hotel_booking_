import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/models/room_model.dart';
import '../providers/hotel_booking_provider.dart';
import '../widgets/booking_header.dart';
import '../widgets/booking_success_dialog.dart';
import '../widgets/booking_summary.dart';
import '../widgets/date_selection_widget.dart';
import '../widgets/room_card.dart';
import '../widgets/validation_message.dart';

/// Main Hotel Room Booking Screen matching Raintech Hotel designs.
class HotelBookingScreen extends StatelessWidget {
  const HotelBookingScreen({super.key});

  void _handleCompleteBooking(BuildContext context, HotelBookingProvider provider) {
    if (!provider.isBookingValid) {
      provider.validateBooking();
      return;
    }

    final room = provider.selectedRoom!;
    final checkIn = provider.checkInDate!;
    final checkOut = provider.checkOutDate!;
    final nights = provider.numberOfNights;
    final total = provider.totalPrice;

    final success = provider.confirmBooking();
    if (success) {
      showDialog(
        context: context,
        builder: (ctx) => BookingSuccessDialog(
          room: room,
          checkIn: checkIn,
          checkOut: checkOut,
          nights: nights,
          totalPrice: total,
          onDismiss: () {
            provider.clearSelection();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HotelBookingProvider>();
    final rooms = provider.rooms;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation & Branding Header
            BookingHeader(
              onQuickActionsTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Quick Actions: System status all normal.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            // Main Content Area
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWideScreen = constraints.maxWidth >= 960;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Page Title & Breadcrumb matching screenshots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hotel Room Booking',
                                      style: AppTextStyles.headerTitle,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Select dates and an available room to complete guest reservation',
                                      style: AppTextStyles.caption.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardBackground,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: AppColors.statusAvailable,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'PMS Active',
                                        style: AppTextStyles.caption.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.statusAvailable,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Dynamic Validation & Error Banner
                            if (provider.validationError != null)
                              ValidationMessage(
                                message: provider.validationError!,
                                severity: ValidationSeverity.error,
                              )
                            else if (provider.checkInDate == null || provider.checkOutDate == null)
                              const ValidationMessage(
                                message: 'Please select check-in and check-out dates to view available rooms.',
                                severity: ValidationSeverity.info,
                              )
                            else if (provider.selectedRoom == null)
                              const ValidationMessage(
                                message: 'Please select a room to review the booking summary.',
                                severity: ValidationSeverity.warning,
                              ),

                            // Responsive layout: Wide multi-column vs Compact single-column
                            if (isWideScreen)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left & Center Column: Dates & Room Cards
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      children: [
                                        const DateSelectionWidget(),
                                        const SizedBox(height: 16),
                                        _RoomSelectionSection(
                                          rooms: rooms,
                                          provider: provider,
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 20),

                                  // Right Column: Booking Summary
                                  Expanded(
                                    flex: 5,
                                    child: BookingSummary(
                                      onConfirmBooking: () => _handleCompleteBooking(context, provider),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  const DateSelectionWidget(),
                                  const SizedBox(height: 16),
                                  _RoomSelectionSection(
                                    rooms: rooms,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  BookingSummary(
                                    onConfirmBooking: () => _handleCompleteBooking(context, provider),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomSelectionSection extends StatelessWidget {
  final List<RoomModel> rooms;
  final HotelBookingProvider provider;

  const _RoomSelectionSection({
    required this.rooms,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
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
          // Section Navy Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.bed_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                const Text(
                  '2. CHOOSE HOTEL ROOM',
                  style: AppTextStyles.sectionHeader,
                ),
                const Spacer(),
                Text(
                  '${rooms.length} ${rooms.length == 1 ? 'room' : 'rooms'} listed',
                  style: const TextStyle(fontSize: 11, color: Color(0xFFC0D3E5)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: rooms.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Icon(Icons.search_off_rounded, size: 36, color: AppColors.textMuted),
                        const SizedBox(height: 8),
                        const Text(
                          'No rooms match the guest filter',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () => provider.setGuestFilter(null),
                          child: const Text('Reset Filter'),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: rooms.map((room) {
                      final isSelected = provider.selectedRoom?.roomCode == room.roomCode;
                      final isBooked = provider.isRoomBookedForSelectedDates(room);

                      return RoomCard(
                        room: room,
                        isSelected: isSelected,
                        isBooked: isBooked,
                        onSelect: () => provider.selectRoom(room),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
