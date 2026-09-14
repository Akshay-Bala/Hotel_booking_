import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

enum ValidationSeverity { info, warning, error }

/// Validation and guidance banner matching Raintech design aesthetics.
class ValidationMessage extends StatelessWidget {
  final String message;
  final ValidationSeverity severity;
  final VoidCallback? onDismiss;

  const ValidationMessage({
    super.key,
    required this.message,
    this.severity = ValidationSeverity.warning,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color text;
    IconData icon;

    switch (severity) {
      case ValidationSeverity.error:
        bg = AppColors.statusDirtyBg;
        border = AppColors.statusDirty.withValues(alpha: 0.3);
        text = const Color(0xFF991B1B);
        icon = Icons.error_outline_rounded;
        break;
      case ValidationSeverity.warning:
        bg = AppColors.statusMaintenanceBg;
        border = AppColors.statusMaintenance.withValues(alpha: 0.3);
        text = const Color(0xFF92400E);
        icon = Icons.warning_amber_rounded;
        break;
      case ValidationSeverity.info:
        bg = AppColors.statusOccupiedBg;
        border = AppColors.statusOccupied.withValues(alpha: 0.3);
        text = const Color(0xFF1E40AF);
        icon = Icons.info_outline_rounded;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: text),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: text,
              ),
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close_rounded, size: 16, color: text),
            ),
        ],
      ),
    );
  }
}
