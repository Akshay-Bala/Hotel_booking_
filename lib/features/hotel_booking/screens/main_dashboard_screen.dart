import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../widgets/dashboard_action_tiles_grid.dart';
import '../widgets/dashboard_floor_view_card.dart';
import '../widgets/dashboard_going_to_vacate_card.dart';
import '../widgets/dashboard_operational_overview.dart';
import '../widgets/dashboard_quick_status_changer_card.dart';
import '../widgets/dashboard_top_header.dart';

/// Main Dashboard screen faithfully reproducing Image 1 from Raintech HOTEL designs.
/// Built cleanly as a StatelessWidget composing specialized custom widgets.
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
              const DashboardTopHeader(),

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
                          child: DashboardActionTilesGrid(
                            onNavigateToCheckIn: onNavigateToCheckIn,
                            onNavigateToCheckOut: onNavigateToCheckOut,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Operational Overview Card
                        const Expanded(
                          flex: 4,
                          child: DashboardOperationalOverview(),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        DashboardActionTilesGrid(
                          onNavigateToCheckIn: onNavigateToCheckIn,
                          onNavigateToCheckOut: onNavigateToCheckOut,
                        ),
                        const SizedBox(height: 16),
                        const DashboardOperationalOverview(),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              // Room Status - Interactive Floor View Card
              const DashboardFloorViewCard(),

              const SizedBox(height: 16),

              // Bottom Row: Going to Vacate Rooms & Quick Room Status Changer
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;
                  if (isWide) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: DashboardGoingToVacateCard()),
                        SizedBox(width: 16),
                        Expanded(flex: 5, child: DashboardQuickStatusChangerCard()),
                      ],
                    );
                  } else {
                    return const Column(
                      children: [
                        DashboardGoingToVacateCard(),
                        SizedBox(height: 16),
                        DashboardQuickStatusChangerCard(),
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
}
