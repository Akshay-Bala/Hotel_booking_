import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DashboardQuickStatusChangerCard extends StatelessWidget {
  const DashboardQuickStatusChangerCard({super.key});

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
          const Text('Quick Room Status Changer & Actions', style: AppTextStyles.cardTitle),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Enter number', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 6,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.cleaning_services_rounded, size: 15),
                  label: const Text('Cleaning done, ready', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF95D5B2),
                    foregroundColor: const Color(0xFF1E3A5F),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFDE8E8),
                    side: const BorderSide(color: Color(0xFFF87171), width: 0.5),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Set all Dirty to Cleaning', style: TextStyle(fontSize: 11, color: Color(0xFF991B1B))),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.surfaceLight,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('View All Maintenance', style: TextStyle(fontSize: 11, color: AppColors.textPrimary)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
