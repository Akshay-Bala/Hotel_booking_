import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DashboardActionTilesGrid extends StatelessWidget {
  final VoidCallback onNavigateToCheckIn;
  final VoidCallback onNavigateToCheckOut;

  const DashboardActionTilesGrid({
    super.key,
    required this.onNavigateToCheckIn,
    required this.onNavigateToCheckOut,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 700 ? 6 : (constraints.maxWidth > 450 ? 3 : 2);

        final items = [
          _ActionItem(
            title: 'Guest Check-in',
            icon: Icons.assignment_turned_in_outlined,
            iconColor: const Color(0xFF2E8540),
            iconBg: const Color(0xFFE8F5E9),
            onTap: onNavigateToCheckIn,
          ),
          _ActionItem(
            title: 'Guest Check-Out',
            icon: Icons.logout_rounded,
            iconColor: const Color(0xFFD9534F),
            iconBg: const Color(0xFFFDE8E8),
            onTap: onNavigateToCheckOut,
          ),
          _ActionItem(
            title: 'Reservations',
            icon: Icons.calendar_month_outlined,
            iconColor: const Color(0xFF3B82F6),
            iconBg: const Color(0xFFEFF6FF),
            onTap: onNavigateToCheckIn,
          ),
          _ActionItem(
            title: 'Housekeeping',
            icon: Icons.cleaning_services_outlined,
            iconColor: const Color(0xFF0D9488),
            iconBg: const Color(0xFFF0FDFA),
          ),
          _ActionItem(
            title: 'Restaurant',
            icon: Icons.restaurant_rounded,
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFFFBEB),
          ),
          _ActionItem(
            title: 'WhatsApp',
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: const Color(0xFF22C55E),
            iconBg: const Color(0xFFF0FDF4),
          ),
          _ActionItem(
            title: 'Rooms',
            icon: Icons.hotel_rounded,
            iconColor: const Color(0xFF8B5CF6),
            iconBg: const Color(0xFFF5F3FF),
          ),
          _ActionItem(
            title: 'Staff',
            icon: Icons.badge_outlined,
            iconColor: const Color(0xFF3B82F6),
            iconBg: const Color(0xFFEFF6FF),
            badge: '2 tasks',
          ),
          _ActionItem(
            title: 'Floors',
            icon: Icons.layers_outlined,
            iconColor: const Color(0xFF14B8A6),
            iconBg: const Color(0xFFF0FDFA),
          ),
          _ActionItem(
            title: 'Reports',
            icon: Icons.bar_chart_rounded,
            iconColor: const Color(0xFFEAB308),
            iconBg: const Color(0xFFFEFCE8),
          ),
          _ActionItem(
            title: 'Settings',
            icon: Icons.tune_rounded,
            iconColor: const Color(0xFF64748B),
            iconBg: const Color(0xFFF8FAFC),
          ),
          _ActionItem(
            title: 'New: Group Booking',
            icon: Icons.group_add_outlined,
            iconColor: const Color(0xFF6366F1),
            iconBg: const Color(0xFFEEF2FF),
          ),
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.badge != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFF59E0B), width: 0.5),
                          ),
                          child: Text(
                            item.badge!,
                            style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item.iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(item.icon, color: item.iconColor, size: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ActionItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String? badge;
  final VoidCallback? onTap;

  _ActionItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    this.badge,
    this.onTap,
  });
}
