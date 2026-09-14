import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography styles matching Raintech Hotel designs.
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle headerTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle sectionHeader = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnNavy,
    letterSpacing: 0.5,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle roomCodeBadge = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: Color(0xFF4A3814),
    letterSpacing: 0.5,
  );

  static const TextStyle priceHighlight = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryNavy,
  );

  static const TextStyle pricePerNight = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}
