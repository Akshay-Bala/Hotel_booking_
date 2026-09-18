import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/hotel_booking_provider.dart';
import '../widgets/hotel_nav_bar.dart';
import 'guest_check_in_screen.dart';
import 'guest_check_out_screen.dart';
import 'hotel_booking_screen.dart';
import 'main_dashboard_screen.dart';

/// Navigation shell providing smooth switching between all screens as a pure StatelessWidget.
class HotelAppShell extends StatelessWidget {
  const HotelAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HotelBookingProvider>();
    final currentIndex = provider.currentNavIndex;

    final screens = [
      // 0: Main Dashboard (Image 1)
      MainDashboardScreen(
        onNavigateToCheckIn: () => provider.setNavIndex(1),
        onNavigateToCheckOut: () => provider.setNavIndex(2),
      ),
      // 1: Guest Check-in (Image 3)
      GuestCheckInScreen(
        onBackToDashboard: () => provider.setNavIndex(0),
        onNavigateToCheckOut: () => provider.setNavIndex(2),
      ),
      // 2: Guest Check-out (Image 2)
      GuestCheckOutScreen(
        onBackToDashboard: () => provider.setNavIndex(0),
        onNavigateToCheckIn: () => provider.setNavIndex(1),
      ),
      // 3: Hotel Room Booking Assessment View
      const HotelBookingScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: HotelNavBar(
        currentIndex: currentIndex,
        onTabSelected: (index) => provider.setNavIndex(index),
      ),
    );
  }
}
