import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SectionHeaderSearch extends StatelessWidget {
  final String title;
  final String searchHint;

  const SectionHeaderSearch({
    super.key,
    required this.title,
    this.searchHint = 'Search Booking ID / Guest Name',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    searchHint,
                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
