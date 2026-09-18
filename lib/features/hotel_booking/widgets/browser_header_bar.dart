import 'package:flutter/material.dart';

class BrowserHeaderBar extends StatelessWidget {
  final VoidCallback onBackToDashboard;
  final VoidCallback onSecondaryNavigation;
  final String secondaryNavLabel;
  final IconData secondaryNavIcon;

  const BrowserHeaderBar({
    super.key,
    required this.onBackToDashboard,
    required this.onSecondaryNavigation,
    required this.secondaryNavLabel,
    required this.secondaryNavIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD0D7DE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_rounded, size: 12, color: Color(0xFF0284C7)),
                SizedBox(width: 6),
                Text(
                  'https://Management Pro',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF334155),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.close_rounded, size: 11, color: Color(0xFF94A3B8)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.add, size: 14, color: Color(0xFF64748B)),
          const Spacer(),
          TextButton.icon(
            onPressed: onBackToDashboard,
            icon: const Icon(Icons.dashboard_rounded, size: 14),
            label: const Text('Dashboard', style: TextStyle(fontSize: 11.5)),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
          TextButton.icon(
            onPressed: onSecondaryNavigation,
            icon: Icon(secondaryNavIcon, size: 14),
            label: Text(secondaryNavLabel, style: const TextStyle(fontSize: 11.5)),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
        ],
      ),
    );
  }
}
