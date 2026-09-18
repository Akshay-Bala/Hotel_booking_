import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DashboardTopHeader extends StatelessWidget {
  const DashboardTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final showSearch = width >= 800;
          final showDate = width >= 600;

          return Row(
            children: [
              // Logo Badge matching Image 1
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryNavyDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.apps_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.black87,
                      child: Text(
                        'R',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text('Raintech', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Text('HOTEL', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                  ],
                ),
              ),

              if (showSearch) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded, size: 16, color: AppColors.textMuted),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Search guests, rooms, reservations, staff...',
                            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Text('Ctrl+K', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                const Spacer(),

              const SizedBox(width: 12),

              if (showDate) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.textSecondary),
                      SizedBox(width: 6),
                      Text('Thu, Jul 23, 2026 | 9:30 AM', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],

              // Quick Actions Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.attach_money_rounded, size: 15),
                label: Text(width < 500 ? 'Actions' : 'Quick Actions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),

              const SizedBox(width: 10),

              // Notification bell & profile avatar
              Stack(
                children: [
                  const Icon(Icons.notifications_none_rounded, size: 22, color: AppColors.textSecondary),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFF1E3A5F),
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
