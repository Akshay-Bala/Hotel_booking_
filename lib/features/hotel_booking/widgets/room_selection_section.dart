import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../data/models/room_model.dart';
import '../providers/hotel_booking_provider.dart';
import 'room_card.dart';

class RoomSelectionSection extends StatelessWidget {
  final List<RoomModel> rooms;
  final HotelBookingProvider provider;

  const RoomSelectionSection({
    super.key,
    required this.rooms,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Navy Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.bed_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                const Text(
                  '2. CHOOSE HOTEL ROOM',
                  style: AppTextStyles.sectionHeader,
                ),
                const Spacer(),
                Text(
                  '${rooms.length} ${rooms.length == 1 ? 'room' : 'rooms'} listed',
                  style: const TextStyle(fontSize: 11, color: Color(0xFFC0D3E5)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: rooms.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Icon(Icons.search_off_rounded, size: 36, color: AppColors.textMuted),
                        const SizedBox(height: 8),
                        const Text(
                          'No rooms match the guest filter',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () => provider.setGuestFilter(null),
                          child: const Text('Reset Filter'),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: rooms.map((room) {
                      final isSelected = provider.selectedRoom?.roomCode == room.roomCode;
                      final isBooked = provider.isRoomBookedForSelectedDates(room);

                      return RoomCard(
                        room: room,
                        isSelected: isSelected,
                        isBooked: isBooked,
                        onSelect: () => provider.selectRoom(room),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
