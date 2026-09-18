import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/room_badge.dart';

class CheckOutIdentifyGuestCard extends StatelessWidget {
  final bool room101Selected;
  final bool room103Selected;
  final ValueChanged<bool?> onToggleRoom101;
  final ValueChanged<bool?> onToggleRoom103;

  const CheckOutIdentifyGuestCard({
    super.key,
    required this.room101Selected,
    required this.room103Selected,
    required this.onToggleRoom101,
    required this.onToggleRoom103,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
            ),
            child: const Text(
              '1. Identify Departing Guest',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Find Guest & Identify by Room
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Find Guest', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Search Guest', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textMuted),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Identify by Room', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('1', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                Icon(Icons.unfold_more_rounded, size: 14, color: AppColors.textMuted),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Select Guest from List + Find Room/Guest Button
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Select Guest from List', style: TextStyle(fontSize: 11, color: AppColors.textMuted), overflow: TextOverflow.ellipsis),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textMuted),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryNavy,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('Find Room/Guest', style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Guest Name & Room No Plate
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Guest Name', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                        Text('Mathew Hyden', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Room No.', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                        const SizedBox(height: 2),
                        RoomBadge(roomCode: '101', fontSize: 13, isSelected: true),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Rooms & Stay dates table matching screenshot
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 320),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Room', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              SizedBox(width: 24),
                              Text('Stay Dates', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              SizedBox(width: 24),
                              Text('Actions', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(color: AppColors.border, height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('101', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 20),
                              const Text('02/04/2026-04/04/2026', style: TextStyle(fontSize: 11)),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    value: room101Selected,
                                    onChanged: onToggleRoom101,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const Text('Select for Check-out', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('103', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 20),
                              const Text('02/04/2026-04/04/2026', style: TextStyle(fontSize: 11)),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    value: room103Selected,
                                    onChanged: onToggleRoom103,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const Text('Select for Check-out', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Add/Change Selected Rooms button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.search, size: 14),
                    label: const Text('Add/Change Selected Rooms', style: TextStyle(fontSize: 11)),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1E9DF),
                      side: const BorderSide(color: Color(0xFFD6C8B5)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
