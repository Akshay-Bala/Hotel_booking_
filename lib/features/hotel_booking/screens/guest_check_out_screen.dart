import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/hotel_booking_provider.dart';
import '../widgets/browser_header_bar.dart';
import '../widgets/check_out_identify_guest_card.dart';
import '../widgets/check_out_payment_card.dart';
import '../widgets/check_out_review_bill_card.dart';
import '../widgets/section_header_search.dart';

/// Guest Check-out screen reproducing Image 2 from Raintech designs.
/// Implemented as a pure StatelessWidget composing modular custom widgets.
class GuestCheckOutScreen extends StatelessWidget {
  final VoidCallback onBackToDashboard;
  final VoidCallback onNavigateToCheckIn;

  const GuestCheckOutScreen({
    super.key,
    required this.onBackToDashboard,
    required this.onNavigateToCheckIn,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HotelBookingProvider>();

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
                onSecondaryNavigation: onNavigateToCheckIn,
                secondaryNavLabel: 'Check-in Page',
                secondaryNavIcon: Icons.assignment_turned_in_outlined,
              ),

              const SizedBox(height: 10),

              // Page Title & Search
              const SectionHeaderSearch(title: 'Guest Check-out'),

              const SizedBox(height: 12),

              // 3 Column Grid: 1. Identify Departing Guest, 2. Review & Finalize Bill, 3. Payment & Check-out
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 1050;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: CheckOutIdentifyGuestCard(
                            room101Selected: provider.room101Selected,
                            room103Selected: provider.room103Selected,
                            onToggleRoom101: provider.toggleRoom101Selected,
                            onToggleRoom103: provider.toggleRoom103Selected,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          flex: 5,
                          child: CheckOutReviewBillCard(),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: CheckOutPaymentCard(
                            paymentMethod: provider.paymentMethod,
                            onPaymentMethodChanged: (v) {
                              if (v != null) provider.setPaymentMethod(v);
                            },
                            onProcessPayment: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Payment processed and Check-out completed!'),
                                  backgroundColor: Color(0xFF166534),
                                ),
                              );
                            },
                            onCombinedCheckOut: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Combined rooms checked out successfully!'),
                                  backgroundColor: Color(0xFF166534),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        CheckOutIdentifyGuestCard(
                          room101Selected: provider.room101Selected,
                          room103Selected: provider.room103Selected,
                          onToggleRoom101: provider.toggleRoom101Selected,
                          onToggleRoom103: provider.toggleRoom103Selected,
                        ),
                        const SizedBox(height: 12),
                        const CheckOutReviewBillCard(),
                        const SizedBox(height: 12),
                        CheckOutPaymentCard(
                          paymentMethod: provider.paymentMethod,
                          onPaymentMethodChanged: (v) {
                            if (v != null) provider.setPaymentMethod(v);
                          },
                          onProcessPayment: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Payment processed and Check-out completed!'),
                                backgroundColor: Color(0xFF166534),
                              ),
                            );
                          },
                          onCombinedCheckOut: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Combined rooms checked out successfully!'),
                                backgroundColor: Color(0xFF166534),
                              ),
                            );
                          },
                        ),
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
}
