import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/room_badge.dart';
import '../providers/hotel_booking_provider.dart';

class CheckInRoomTable extends StatelessWidget {
  final HotelBookingProvider provider;
  final DateFormat dateFormat;

  const CheckInRoomTable({
    super.key,
    required this.provider,
    required this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    final rooms = provider.rooms;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Available Rooms Registry', style: AppTextStyles.cardTitle),
                Text('${rooms.length} rooms listed • Click a row to select', style: AppTextStyles.caption),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF1F5F9)),
              headingTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
              dataRowMinHeight: 40,
              dataRowMaxHeight: 45,
              columns: const [
                DataColumn(label: Text('ROOM NO.')),
                DataColumn(label: Text('ROOM TYPE')),
                DataColumn(label: Text('RENT (₹)')),
                DataColumn(label: Text('GST')),
                DataColumn(label: Text('MAX GUESTS')),
                DataColumn(label: Text('CHECKOUT DATE')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: rooms.map((room) {
                final isSelected = provider.selectedRoom?.roomCode == room.roomCode;
                final isBooked = provider.isRoomBookedForSelectedDates(room);

                return DataRow(
                  selected: isSelected,
                  onSelectChanged: isBooked
                      ? null
                      : (_) {
                          provider.selectRoom(room);
                        },
                  cells: [
                    DataCell(RoomBadge(roomCode: room.roomCode, fontSize: 11, isSelected: isSelected)),
                    DataCell(Text(room.roomType, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                    DataCell(Text(
                      CurrencyFormatter.format(room.pricePerNight),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
                    )),
                    DataCell(const Text('₹112.00', style: TextStyle(fontSize: 11))),
                    DataCell(Text('0${room.maxGuests}', style: const TextStyle(fontSize: 11))),
                    DataCell(Text(dateFormat.format(provider.checkOutDate ?? DateTime(2026, 4, 4)), style: const TextStyle(fontSize: 11))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isBooked ? const Color(0xFFEFF6FF) : const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: isBooked ? const Color(0xFF3B82F6) : const Color(0xFF22C55E), width: 0.5),
                        ),
                        child: Text(
                          isBooked ? 'Occupied' : 'Available',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isBooked ? const Color(0xFF1D4ED8) : const Color(0xFF15803D),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      ElevatedButton(
                        onPressed: isBooked ? null : () => provider.selectRoom(room),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? const Color(0xFF22C55E) : AppColors.primaryNavy,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(isSelected ? 'Selected' : 'Select', style: const TextStyle(fontSize: 10, color: Colors.white)),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
