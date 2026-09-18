import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DashboardFloorViewCard extends StatelessWidget {
  const DashboardFloorViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Room Status - Interactive Floor View', style: AppTextStyles.cardTitle),
                  SizedBox(height: 2),
                  Text('50 rooms across your property', style: AppTextStyles.caption),
                ],
              ),
              Row(
                children: [
                  _statusDot(const Color(0xFF48BB78), 'Available'),
                  const SizedBox(width: 10),
                  _statusDot(const Color(0xFF3182CE), 'Occupied'),
                  const SizedBox(width: 10),
                  _statusDot(const Color(0xFFE53E3E), 'Dirty'),
                  const SizedBox(width: 10),
                  _statusDot(const Color(0xFFDD6B20), 'Maintenance'),
                  const SizedBox(width: 10),
                  _statusDot(const Color(0xFFA0AEC0), 'Blocked'),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Interactive Grid with Floor 1 and Floor 2 rows
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 850;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFloorRow('Floor 1', [
                            '101', '102', '103', '104', '105', '106', '107', '108',
                            '109', '110', '111', '112', '113', '114', '115', '116'
                          ], [
                            '101', '102', '103', '104', '105', '106', '107', '102',
                            '103', '104', '104', '105', '106', '107', '108', '109'
                          ]),
                          const SizedBox(height: 12),
                          _buildFloorRow('Floor 2', [
                            '201', '202', '203', '204', '205', '210', '207', '202',
                            '203', '205', '210', '211', '212', '213', '214', '215'
                          ], [
                            '201', '102', '103', '204', '105', '106', '207', '202',
                            '203', '204', '205', '206', '206', '207', '208', '209'
                          ]),
                        ],
                      ),
                    ),
                  ),

                  if (isWide) ...[
                    const SizedBox(width: 20),
                    // 200 Rooms Gauge matching Image 1
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF38A169), width: 5),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('200', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                            Text('Rooms Total', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                            Text('4% Occupied', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF38A169))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'Clicking a room tile opens its quick-edit menu',
            style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildFloorRow(String floorLabel, List<String> row1, List<String> row2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 55,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(floorLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: row1.map((roomNo) => _roomTile(roomNo, _getColorForRoom(roomNo, false))).toList()),
            const SizedBox(height: 4),
            Row(children: row2.map((roomNo) => _roomTile(roomNo, _getColorForRoom(roomNo, true))).toList()),
          ],
        ),
      ],
    );
  }

  Widget _roomTile(String number, Color color) {
    return Container(
      width: 32,
      height: 26,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Color _getColorForRoom(String num, bool isSecondRow) {
    if (num == '104' || num == '206' || (num == '105' && isSecondRow)) return const Color(0xFFE53E3E); // Dirty
    if (num == '103' || num == '202' || num == '109') return const Color(0xFF3182CE); // Occupied
    if (num == '190' || num == '205') return const Color(0xFFDD6B20); // Maintenance
    if (num == '210' || num == '208') return const Color(0xFFA0AEC0); // Blocked
    return const Color(0xFF48BB78); // Available
  }

  Widget _statusDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10.5, color: AppColors.textSecondary)),
      ],
    );
  }
}
