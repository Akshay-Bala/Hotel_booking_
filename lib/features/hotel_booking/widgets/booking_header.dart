import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
class BookingHeader extends StatelessWidget {
  final VoidCallback? onQuickActionsTap;

  const BookingHeader({
    super.key,
    this.onQuickActionsTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEE, MMM d, yyyy | h:mm a').format(now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final showFullSearch = width >= 1000;
          final showDate = width >= 850;

          return Row(
            children: [
              // Raintech Hotel Brand
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF16385C), Color(0xFF265487)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.domain_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Raintech',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryNavy,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        'HOTEL MANAGEMENT',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brassGoldDark,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (showFullSearch) ...[
                const SizedBox(width: 16),
                // Search Bar Mock
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
                            'Search guests, rooms, reservations...',
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
                          child: const Text(
                            'Ctrl+K',
                            style: TextStyle(fontSize: 9.5, color: AppColors.textMuted),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                const Spacer(),

              const SizedBox(width: 12),

              // Date & Time display
              if (showDate) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],

              // Quick Actions button matching screenshots
              ElevatedButton.icon(
                onPressed: onQuickActionsTap,
                icon: const Icon(Icons.flash_on_rounded, size: 15),
                label: Text(width < 500 ? 'Actions' : 'Quick Actions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: AppTextStyles.buttonText.copyWith(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
