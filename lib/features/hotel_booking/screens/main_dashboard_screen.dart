import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Main Dashboard screen faithfully reproducing Image 1 from Raintech HOTEL designs.
class MainDashboardScreen extends StatelessWidget {
  final VoidCallback onNavigateToCheckIn;
  final VoidCallback onNavigateToCheckOut;

  const MainDashboardScreen({
    super.key,
    required this.onNavigateToCheckIn,
    required this.onNavigateToCheckOut,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Header Bar
              _buildTopHeader(context),

              const SizedBox(height: 16),

              // Dashboard Title
              const Text(
                'Main Dashboard',
                style: AppTextStyles.headerTitle,
              ),

              const SizedBox(height: 14),

              // Action Tiles Grid & Operational Overview
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 1000;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left 12 Navigation Action Tiles
                        Expanded(
                          flex: 9,
                          child: _buildActionTilesGrid(context),
                        ),
                        const SizedBox(width: 16),
                        // Right Operational Overview Card
                        Expanded(
                          flex: 4,
                          child: _buildOperationalOverview(),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildActionTilesGrid(context),
                        const SizedBox(height: 16),
                        _buildOperationalOverview(),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              // Room Status - Interactive Floor View Card
              _buildFloorViewCard(),

              const SizedBox(height: 16),

              // Bottom Row: Going to Vacate Rooms & Quick Room Status Changer
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: _buildGoingToVacateCard()),
                        const SizedBox(width: 16),
                        Expanded(flex: 5, child: _buildQuickStatusChangerCard()),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildGoingToVacateCard(),
                        const SizedBox(height: 16),
                        _buildQuickStatusChangerCard(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Top Navigation Header ---
  Widget _buildTopHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final showSearch = width >= 800;
          final showDate = width >= 600;

          return Row(
            children: [
              // Logo Badge matching Image 1
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryNavyDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.apps_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.black87,
                      child: Text('R', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 6),
                    Text('Raintech', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Text('HOTEL', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                  ],
                ),
              ),

              if (showSearch) ...[
                const SizedBox(width: 16),
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
                            'Search guests, rooms, reservations, staff...',
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
                          child: const Text('Ctrl+K', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                const Spacer(),

              const SizedBox(width: 12),

              if (showDate) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.textSecondary),
                      SizedBox(width: 6),
                      Text('Thu, Jul 23, 2026 | 9:30 AM', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],

              // Quick Actions Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.attach_money_rounded, size: 15),
                label: Text(width < 500 ? 'Actions' : 'Quick Actions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),

              const SizedBox(width: 10),

              // Notification bell & profile avatar
              Stack(
                children: [
                  const Icon(Icons.notifications_none_rounded, size: 22, color: AppColors.textSecondary),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFF1E3A5F),
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }

  // --- 12 Quick Action Tiles Grid ---
  Widget _buildActionTilesGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 700 ? 6 : (constraints.maxWidth > 450 ? 3 : 2);

        final items = [
          _ActionItem(
            title: 'Guest Check-in',
            icon: Icons.assignment_turned_in_outlined,
            iconColor: const Color(0xFF2E8540),
            iconBg: const Color(0xFFE8F5E9),
            onTap: onNavigateToCheckIn,
          ),
          _ActionItem(
            title: 'Guest Check-Out',
            icon: Icons.logout_rounded,
            iconColor: const Color(0xFFD9534F),
            iconBg: const Color(0xFFFDE8E8),
            onTap: onNavigateToCheckOut,
          ),
          _ActionItem(
            title: 'Reservations',
            icon: Icons.calendar_month_outlined,
            iconColor: const Color(0xFF3B82F6),
            iconBg: const Color(0xFFEFF6FF),
            onTap: onNavigateToCheckIn,
          ),
          _ActionItem(
            title: 'Housekeeping',
            icon: Icons.cleaning_services_outlined,
            iconColor: const Color(0xFF0D9488),
            iconBg: const Color(0xFFF0FDFA),
          ),
          _ActionItem(
            title: 'Restaurant',
            icon: Icons.restaurant_rounded,
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFFFBEB),
          ),
          _ActionItem(
            title: 'WhatsApp',
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: const Color(0xFF22C55E),
            iconBg: const Color(0xFFF0FDF4),
          ),
          _ActionItem(
            title: 'Rooms',
            icon: Icons.hotel_rounded,
            iconColor: const Color(0xFF8B5CF6),
            iconBg: const Color(0xFFF5F3FF),
          ),
          _ActionItem(
            title: 'Staff',
            icon: Icons.badge_outlined,
            iconColor: const Color(0xFF3B82F6),
            iconBg: const Color(0xFFEFF6FF),
            badge: '2 tasks',
          ),
          _ActionItem(
            title: 'Floors',
            icon: Icons.layers_outlined,
            iconColor: const Color(0xFF14B8A6),
            iconBg: const Color(0xFFF0FDFA),
          ),
          _ActionItem(
            title: 'Reports',
            icon: Icons.bar_chart_rounded,
            iconColor: const Color(0xFFEAB308),
            iconBg: const Color(0xFFFEFCE8),
          ),
          _ActionItem(
            title: 'Settings',
            icon: Icons.tune_rounded,
            iconColor: const Color(0xFF64748B),
            iconBg: const Color(0xFFF8FAFC),
          ),
          _ActionItem(
            title: 'New: Group Booking',
            icon: Icons.group_add_outlined,
            iconColor: const Color(0xFF6366F1),
            iconBg: const Color(0xFFEEF2FF),
          ),
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.badge != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFF59E0B), width: 0.5),
                          ),
                          child: Text(item.badge!, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Color(0xFF92400E))),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item.iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(item.icon, color: item.iconColor, size: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- Operational Overview Card ---
  Widget _buildOperationalOverview() {
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
          const Text('Operational Overview', style: AppTextStyles.cardTitle),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    children: [
                      Text('Occupancy', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      SizedBox(height: 4),
                      Text('4%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primaryNavy)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Column(
                    children: [
                      Text('Pending Check-ins', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      SizedBox(height: 4),
                      Text('0', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Column(
                    children: [
                      Text('Pending Departures', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      SizedBox(height: 4),
                      Text('0', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    children: [
                      Text('Revenue Today', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      SizedBox(height: 4),
                      Text('₹0', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF166534))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Room Status - Interactive Floor View Card ---
  Widget _buildFloorViewCard() {
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
                            '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113', '114', '115', '116'
                          ], [
                            '101', '102', '103', '104', '105', '106', '107', '102', '103', '104', '104', '105', '106', '107', '108', '109'
                          ]),
                          const SizedBox(height: 12),
                          _buildFloorRow('Floor 2', [
                            '201', '202', '203', '204', '205', '210', '207', '202', '203', '205', '210', '211', '212', '213', '214', '215'
                          ], [
                            '201', '102', '103', '204', '105', '106', '207', '202', '203', '204', '205', '206', '206', '207', '208', '209'
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

  // --- Going to Vacate Rooms Card ---
  Widget _buildGoingToVacateCard() {
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
          const Row(
            children: [
              Icon(Icons.bed_outlined, size: 18, color: AppColors.primaryNavy),
              SizedBox(width: 8),
              Text('Going to Vacate Rooms', style: AppTextStyles.cardTitle),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Room 101 thumbnail
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD5BA85),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.hotel_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Room 101', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('Departing - Guest Check-Out Scheduled', style: TextStyle(fontSize: 10, color: AppColors.textMuted), maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Room 102 thumbnail
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD5BA85),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.hotel_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Room 102', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('Departing - Guest Checkout: 11:00 AM', style: TextStyle(fontSize: 10, color: AppColors.textMuted), maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Quick Room Status Changer & Actions Card ---
  Widget _buildQuickStatusChangerCard() {
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

class _ActionItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String? badge;
  final VoidCallback? onTap;

  _ActionItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    this.badge,
    this.onTap,
  });
}
