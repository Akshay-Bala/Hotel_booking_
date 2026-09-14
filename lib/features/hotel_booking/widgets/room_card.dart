import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/room_badge.dart';
import '../data/models/room_model.dart';

/// Card displaying room specs, brass badge, pricing, and selection state.
class RoomCard extends StatelessWidget {
  final RoomModel room;
  final bool isSelected;
  final bool isBooked;
  final VoidCallback onSelect;

  const RoomCard({
    super.key,
    required this.room,
    required this.isSelected,
    required this.isBooked,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFF7FAFD)
            : (isBooked ? const Color(0xFFFBFBFB) : AppColors.cardBackground),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? AppColors.primaryNavy
              : (isBooked ? AppColors.borderSubtle : AppColors.border),
          width: isSelected ? 1.8 : 1.0,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primaryNavy.withValues(alpha: 0.1),
                  offset: const Offset(0, 3),
                  blurRadius: 8,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isBooked ? null : onSelect,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Metallic Brass Room Plate Badge
                RoomBadge(
                  roomCode: room.roomCode,
                  fontSize: 13,
                  isSelected: isSelected,
                ),

                const SizedBox(width: 14),

                // Room Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              room.roomType,
                              style: AppTextStyles.cardTitle.copyWith(
                                fontSize: 15,
                                color: isBooked ? AppColors.textMuted : AppColors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Floor Tag
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              'Floor ${room.floor}',
                              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.people_outline_rounded,
                            size: 14,
                            color: isBooked ? AppColors.textMuted : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Max ${room.maxGuests} Guests',
                            style: AppTextStyles.caption.copyWith(
                              color: isBooked ? AppColors.textMuted : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (room.amenities.isNotEmpty) ...[
                            Text(
                              '• ${room.amenities.first}',
                              style: AppTextStyles.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Price & Selection Indicator
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencyFormatter.format(room.pricePerNight),
                      style: AppTextStyles.priceHighlight.copyWith(
                        fontSize: 16,
                        color: isBooked ? AppColors.textMuted : AppColors.primaryNavy,
                      ),
                    ),
                    const Text(
                      'per night',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 6),
                    if (isBooked)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.statusOccupiedBg,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.statusOccupied.withValues(alpha: 0.3)),
                        ),
                        child: const Text(
                          'Occupied',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.statusOccupied,
                          ),
                        ),
                      )
                    else
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColors.primaryNavy : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? AppColors.primaryNavy : AppColors.border,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                            : null,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
