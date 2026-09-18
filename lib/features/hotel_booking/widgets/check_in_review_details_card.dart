import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/room_badge.dart';
import '../data/models/room_model.dart';

class CheckInReviewDetailsCard extends StatelessWidget {
  final RoomModel room;
  final DateTime checkOutDate;
  final DateFormat dateFormat;
  final String tenantName;
  final VoidCallback onPickCheckOutDate;
  final VoidCallback onResetSelection;

  const CheckInReviewDetailsCard({
    super.key,
    required this.room,
    required this.checkOutDate,
    required this.dateFormat,
    required this.tenantName,
    required this.onPickCheckOutDate,
    required this.onResetSelection,
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
          // Navy Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: const BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
            ),
            child: const Text(
              '2. Review & Update Details',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Top Row: Room No, Rent, GST %, Tenant Name, No:of Adults, No:of Kids
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Room No Plate Badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Room No.', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        RoomBadge(roomCode: room.roomCode, fontSize: 12, isSelected: true),
                      ],
                    ),
                    const SizedBox(width: 8),
                    // Rent
                    Expanded(
                      flex: 2,
                      child: _inputColumn('Rent', room.pricePerNight.toStringAsFixed(2)),
                    ),
                    const SizedBox(width: 8),
                    // GST
                    Expanded(
                      flex: 2,
                      child: _inputColumn('GST %', '112.00'),
                    ),
                    const SizedBox(width: 8),
                    // Tenant Name
                    Expanded(
                      flex: 3,
                      child: _inputColumn('Tenant Name', tenantName),
                    ),
                    const SizedBox(width: 8),
                    // No:of Adults
                    Expanded(
                      flex: 2,
                      child: _inputColumn('Adults', '0${room.maxGuests}'),
                    ),
                    const SizedBox(width: 8),
                    // No:of Kids
                    Expanded(
                      flex: 2,
                      child: _inputColumn('Kids', '00'),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Middle Row: Checkout Date, Update ID Proof, Update Adults/Kids, Additional Charges
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Checkout Date picker
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: onPickCheckOutDate,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Checkout Date', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      dateFormat.format(checkOutDate),
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.calendar_today, size: 12, color: AppColors.primaryNavy),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Update ID Proof
                    Expanded(
                      flex: 3,
                      child: _inputColumnWithIcon('Update ID Proof', 'mathewhyden...', Icons.description_outlined),
                    ),
                    const SizedBox(width: 8),
                    // Update No. of Adults/Kids
                    Expanded(
                      flex: 3,
                      child: _inputColumn('Update Adults/Kids', 'Mathew Hade'),
                    ),
                    const SizedBox(width: 8),
                    // Additional Charges Box matching Image 3
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.borderSubtle),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Additional Charges', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 3),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text('Room Charge', style: TextStyle(fontSize: 8.5, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis)),
                                Text('2 beds', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text('Extra Charges', style: TextStyle(fontSize: 8.5, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis)),
                                Text('₹200', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(child: Text('Tax', style: TextStyle(fontSize: 8.5, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis)),
                                Text(CurrencyFormatter.format(room.pricePerNight), style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Bottom Inputs & Action Buttons
                Row(
                  children: [
                    // Upload button
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file_rounded, size: 14),
                      label: const Text('Upload', style: TextStyle(fontSize: 11)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Guest Count dropdown
                    Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Text('0${room.maxGuests}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 6),
                          const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textMuted),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Update Guest Name
                    Expanded(
                      child: Container(
                        height: 34,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(tenantName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Buttons: Delete, Edit, Update, Confirm Guest Details
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline, size: 16, color: Color(0xFFDC2626)),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined, size: 16, color: AppColors.primaryNavy),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      onPressed: onResetSelection,
                      icon: const Icon(Icons.refresh_rounded, size: 16, color: AppColors.textSecondary),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Update',
                    ),
                    const SizedBox(width: 4),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Guest details confirmed!'), duration: Duration(seconds: 1)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryNavy,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Confirm Guest Details', style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.centerLeft,
          child: Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _inputColumnWithIcon(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              Icon(icon, size: 12, color: AppColors.textMuted),
            ],
          ),
        ),
      ],
    );
  }
}
