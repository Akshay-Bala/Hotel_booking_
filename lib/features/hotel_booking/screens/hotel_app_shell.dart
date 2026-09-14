import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'guest_check_in_screen.dart';
import 'guest_check_out_screen.dart';
import 'hotel_booking_screen.dart';
import 'main_dashboard_screen.dart';

/// Navigation shell providing smooth switching between all 3 screens from the assessment designs.
class HotelAppShell extends StatefulWidget {
  const HotelAppShell({super.key});

  @override
  State<HotelAppShell> createState() => _HotelAppShellState();
}

class _HotelAppShellState extends State<HotelAppShell> {
  int _currentIndex = 0;

  void _navigateToIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      // 0: Main Dashboard (Image 1)
      MainDashboardScreen(
        onNavigateToCheckIn: () => _navigateToIndex(1),
        onNavigateToCheckOut: () => _navigateToIndex(2),
      ),
      // 1: Guest Check-in (Image 3)
      GuestCheckInScreen(
        onBackToDashboard: () => _navigateToIndex(0),
        onNavigateToCheckOut: () => _navigateToIndex(2),
      ),
      // 2: Guest Check-out (Image 2)
      GuestCheckOutScreen(
        onBackToDashboard: () => _navigateToIndex(0),
        onNavigateToCheckIn: () => _navigateToIndex(1),
      ),
      // 3: Hotel Room Booking Assessment View
      const HotelBookingScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryNavy,
          border: Border(top: BorderSide(color: Color(0xFF265487), width: 1)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, -2)),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _navButton(
                index: 0,
                label: 'Main Dashboard',
                icon: Icons.dashboard_rounded,
                sub: 'Image 1',
              ),
              const SizedBox(width: 8),
              _navButton(
                index: 1,
                label: 'Guest Check-in',
                icon: Icons.assignment_turned_in_outlined,
                sub: 'Image 3',
              ),
              const SizedBox(width: 8),
              _navButton(
                index: 2,
                label: 'Guest Check-out',
                icon: Icons.logout_rounded,
                sub: 'Image 2',
              ),
              const SizedBox(width: 8),
              _navButton(
                index: 3,
                label: 'Room Booking',
                icon: Icons.hotel_rounded,
                sub: 'Calculator',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navButton({
    required int index,
    required String label,
    required IconData icon,
    required String sub,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => _navigateToIndex(index),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF265487) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF60A5FA) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 6),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
                  ),
                ),
                Text(
                  sub,
                  style: TextStyle(
                    fontSize: 9,
                    color: isSelected ? const Color(0xFF93C5FD) : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
