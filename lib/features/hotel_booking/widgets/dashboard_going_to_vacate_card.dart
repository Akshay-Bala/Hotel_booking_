import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DashboardGoingToVacateCard extends StatelessWidget {
  const DashboardGoingToVacateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.bed_outlined, size: 18, color: AppColors.primaryNavy),
              SizedBox(width: 8),
              Text('Going to Vacate Rooms', style: AppTextStyles.cardTitle),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Room 101 thumbnail
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD5BA85),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.hotel_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Room 101', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text(
                              'Departing - Guest Check-Out Scheduled',
                              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Room 102 thumbnail
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD5BA85),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.hotel_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Room 102', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text(
                              'Departing - Guest Checkout: 11:00 AM',
                              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
