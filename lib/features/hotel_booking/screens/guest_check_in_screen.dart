import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/hotel_booking_provider.dart';
import '../widgets/booking_success_dialog.dart';
import '../widgets/browser_header_bar.dart';
import '../widgets/check_in_booking_guest_card.dart';
import '../widgets/check_in_finalize_payment_card.dart';
import '../widgets/check_in_review_details_card.dart';
import '../widgets/check_in_room_table.dart';
import '../widgets/section_header_search.dart';

/// Guest Check-in screen reproducing Image 3 from Raintech designs.
/// Implemented as a pure StatelessWidget composing modular custom widgets.
class GuestCheckInScreen extends StatelessWidget {
  final VoidCallback onBackToDashboard;
  final VoidCallback onNavigateToCheckOut;

  const GuestCheckInScreen({
    super.key,
    required this.onBackToDashboard,
    required this.onNavigateToCheckOut,
  });

  Future<void> _pickCheckInDate(BuildContext context, HotelBookingProvider provider) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final initialDate = provider.checkInDate ?? firstDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 365)),
      helpText: 'SELECT CHECK-IN DATE',
    );

    if (picked != null) {
      provider.selectCheckInDate(picked);
    }
  }

  Future<void> _pickCheckOutDate(BuildContext context, HotelBookingProvider provider) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final baseCheckIn = provider.checkInDate ?? today;
    final firstDate = baseCheckIn.add(const Duration(days: 1));
    final initialDate = (provider.checkOutDate != null && provider.checkOutDate!.isAfter(baseCheckIn))
        ? provider.checkOutDate!
        : firstDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: baseCheckIn.add(const Duration(days: 365)),
      helpText: 'SELECT CHECK-OUT DATE',
    );

    if (picked != null) {
      provider.selectCheckOutDate(picked);
    }
  }

  void _completeCheckIn(BuildContext context, HotelBookingProvider provider) {
    if (provider.selectedRoom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a room from the list below.'),
          backgroundColor: AppColors.statusDirty,
        ),
      );
      return;
    }

    if (provider.checkInDate == null || provider.checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please ensure both check-in and check-out dates are selected.'),
          backgroundColor: AppColors.statusDirty,
        ),
      );
      return;
    }

    final success = provider.confirmBooking();
    if (success) {
      showDialog(
        context: context,
        builder: (ctx) => BookingSuccessDialog(
          room: provider.selectedRoom!,
          checkIn: provider.checkInDate!,
          checkOut: provider.checkOutDate!,
          nights: provider.numberOfNights,
          totalPrice: provider.totalPrice,
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
    final dateFormat = DateFormat('dd/MM/yyyy');
    final selectedRoom = provider.selectedRoom ?? provider.rooms.first;
    final checkIn = provider.checkInDate ?? DateTime(2026, 4, 2);
    final checkOut = provider.checkOutDate ?? DateTime(2026, 4, 4);
    final nights = provider.numberOfNights > 0 ? provider.numberOfNights : 2;
    final roomRate = selectedRoom.pricePerNight;
    final totalAmount = provider.totalPrice > 0 ? provider.totalPrice : (nights * roomRate);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Browser Mock Bar: https://Management Pro
              BrowserHeaderBar(
                onBackToDashboard: onBackToDashboard,
                onSecondaryNavigation: onNavigateToCheckOut,
                secondaryNavLabel: 'Check-out Page',
                secondaryNavIcon: Icons.logout_rounded,
              ),

              const SizedBox(height: 10),

              // Page Title & Search
              const SectionHeaderSearch(title: 'Guest Check-in'),

              const SizedBox(height: 12),

              // 3 Column Grid: 1. Select Booking, 2. Review & Update, 3. Finalize
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 1050;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: CheckInBookingGuestCard(
                            checkInDate: checkIn,
                            dateFormat: dateFormat,
                            onPickDate: () => _pickCheckInDate(context, provider),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 6,
                          child: CheckInReviewDetailsCard(
                            room: selectedRoom,
                            checkOutDate: checkOut,
                            dateFormat: dateFormat,
                            tenantName: provider.tenantName,
                            onPickCheckOutDate: () => _pickCheckOutDate(context, provider),
                            onResetSelection: () => provider.clearSelection(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: CheckInFinalizePaymentCard(
                            totalAmount: totalAmount,
                            onCompleteCheckIn: () => _completeCheckIn(context, provider),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        CheckInBookingGuestCard(
                          checkInDate: checkIn,
                          dateFormat: dateFormat,
                          onPickDate: () => _pickCheckInDate(context, provider),
                        ),
                        const SizedBox(height: 12),
                        CheckInReviewDetailsCard(
                          room: selectedRoom,
                          checkOutDate: checkOut,
                          dateFormat: dateFormat,
                          tenantName: provider.tenantName,
                          onPickCheckOutDate: () => _pickCheckOutDate(context, provider),
                          onResetSelection: () => provider.clearSelection(),
                        ),
                        const SizedBox(height: 12),
                        CheckInFinalizePaymentCard(
                          totalAmount: totalAmount,
                          onCompleteCheckIn: () => _completeCheckIn(context, provider),
                        ),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              // Available Rooms / Guest Registration Table
              CheckInRoomTable(provider: provider, dateFormat: dateFormat),
            ],
          ),
        ),
      ),
    );
  }
}
