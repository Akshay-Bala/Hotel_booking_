import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Metallic brass room number badge reproducing the plate design from Raintech UI.
class RoomBadge extends StatelessWidget {
  final String roomCode;
  final double fontSize;
  final bool isSelected;

  const RoomBadge({
    super.key,
    required this.roomCode,
    this.fontSize = 13,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSelected
              ? const [Color(0xFFE8C87A), Color(0xFFD4AF37), Color(0xFFB88E45)]
              : const [Color(0xFFF6E7C4), Color(0xFFE5CE9F), Color(0xFFD5BA85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? const Color(0xFF8C661A) : AppColors.brassBadgeBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: const Offset(0, 1.5),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.hotel_rounded,
            size: fontSize + 2,
            color: const Color(0xFF4A3814),
          ),
          const SizedBox(width: 5),
          Text(
            roomCode,
            style: AppTextStyles.roomCodeBadge.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
