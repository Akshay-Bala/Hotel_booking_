import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/room_badge.dart';
import '../data/models/room_model.dart';
import '../providers/hotel_booking_provider.dart';
import '../widgets/booking_success_dialog.dart';

/// Guest Check-in screen reproducing Image 3 from Raintech designs.
class GuestCheckInScreen extends StatefulWidget {
  final VoidCallback onBackToDashboard;
  final VoidCallback onNavigateToCheckOut;

  const GuestCheckInScreen({
    super.key,
    required this.onBackToDashboard,
    required this.onNavigateToCheckOut,
  });

  @override
  State<GuestCheckInScreen> createState() => _GuestCheckInScreenState();
}

class _GuestCheckInScreenState extends State<GuestCheckInScreen> {
  final TextEditingController _tenantNameController = TextEditingController(text: 'Mathew Hyden');
  final TextEditingController _adultsController = TextEditingController(text: '02');
  final TextEditingController _kidsController = TextEditingController(text: '00');
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _tenantNameController.dispose();
    _adultsController.dispose();
    _kidsController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _pickCheckInDate(BuildContext context, HotelBookingProvider provider) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final initialDate = provider.checkInDate ?? firstDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 365)),
      helpText: 'SELECT CHECK-IN DATE',
    );

    if (picked != null) {
      provider.selectCheckInDate(picked);
    }
  }

  Future<void> _pickCheckOutDate(BuildContext context, HotelBookingProvider provider) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final baseCheckIn = provider.checkInDate ?? today;
    final firstDate = baseCheckIn.add(const Duration(days: 1));
    final initialDate = (provider.checkOutDate != null && provider.checkOutDate!.isAfter(baseCheckIn))
        ? provider.checkOutDate!
        : firstDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: baseCheckIn.add(const Duration(days: 365)),
      helpText: 'SELECT CHECK-OUT DATE',
    );

    if (picked != null) {
      provider.selectCheckOutDate(picked);
    }
  }

  void _completeCheckIn(BuildContext context, HotelBookingProvider provider) {
    if (provider.selectedRoom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a room from the list below.'),
          backgroundColor: AppColors.statusDirty,
        ),
      );
      return;
    }

    if (provider.checkInDate == null || provider.checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please ensure both check-in and check-out dates are selected.'),
          backgroundColor: AppColors.statusDirty,
        ),
      );
      return;
    }

    final success = provider.confirmBooking();
    if (success) {
      showDialog(
        context: context,
        builder: (ctx) => BookingSuccessDialog(
          room: provider.selectedRoom!,
          checkIn: provider.checkInDate!,
          checkOut: provider.checkOutDate!,
          nights: provider.numberOfNights,
          totalPrice: provider.totalPrice,
          onDismiss: () {
            provider.clearSelection();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HotelBookingProvider>();
    final dateFormat = DateFormat('dd/MM/yyyy');
    final selectedRoom = provider.selectedRoom ?? provider.rooms.first;
    final checkIn = provider.checkInDate ?? DateTime(2026, 4, 2);
    final checkOut = provider.checkOutDate ?? DateTime(2026, 4, 4);
    final nights = provider.numberOfNights > 0 ? provider.numberOfNights : 2;
    final roomRate = selectedRoom.pricePerNight;
    final totalAmount = provider.totalPrice > 0 ? provider.totalPrice : (nights * roomRate);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Browser Mock Bar matching screenshot: https://Management Pro
              _buildBrowserHeader(),

              const SizedBox(height: 10),

              // Page Title and Search Row
              _buildSubHeader(),

              const SizedBox(height: 12),

              // 3 Column / Section Grid: 1. Select Booking, 2. Review & Update, 3. Finalize
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 1050;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Select Booking & Guest
                        Expanded(
                          flex: 3,
                          child: _buildCard1(context, provider, checkIn, dateFormat),
                        ),
                        const SizedBox(width: 12),
                        // 2. Review & Update Details
                        Expanded(
                          flex: 6,
                          child: _buildCard2(context, provider, selectedRoom, checkOut, dateFormat),
                        ),
                        const SizedBox(width: 12),
                        // 3. Finalize Check-in & Payment
                        Expanded(
                          flex: 3,
                          child: _buildCard3(context, provider, totalAmount),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildCard1(context, provider, checkIn, dateFormat),
                        const SizedBox(height: 12),
                        _buildCard2(context, provider, selectedRoom, checkOut, dateFormat),
                        const SizedBox(height: 12),
                        _buildCard3(context, provider, totalAmount),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              // Available Rooms / Guest Registration Table
              _buildRoomTable(provider, dateFormat),
            ],
          ),
        ),
      ),
    );
  }

  // --- Browser Header Bar: https://Management Pro ---
  Widget _buildBrowserHeader() {
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
                Text('https://Management Pro', style: TextStyle(fontSize: 11, color: Color(0xFF334155), fontWeight: FontWeight.w500)),
                SizedBox(width: 6),
                Icon(Icons.close_rounded, size: 11, color: Color(0xFF94A3B8)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.add, size: 14, color: Color(0xFF64748B)),
          const Spacer(),
          // Navigation links to other pages
          TextButton.icon(
            onPressed: widget.onBackToDashboard,
            icon: const Icon(Icons.dashboard_rounded, size: 14),
            label: const Text('Dashboard', style: TextStyle(fontSize: 11.5)),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
          TextButton.icon(
            onPressed: widget.onNavigateToCheckOut,
            icon: const Icon(Icons.logout_rounded, size: 14),
            label: const Text('Check-out Page', style: TextStyle(fontSize: 11.5)),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
        ],
      ),
    );
  }

  // --- Subheader: Guest Check-in + Search ---
  Widget _buildSubHeader() {
    return Row(
      children: [
        const Text(
          'Guest Check-in',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
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
            child: const Row(
              children: [
                Icon(Icons.search, size: 16, color: AppColors.textMuted),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search Booking ID / Guest Name',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Section 1: Select Booking & Guest ---
  Widget _buildCard1(BuildContext context, HotelBookingProvider provider, DateTime checkIn, DateFormat dateFormat) {
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
            child: const Text('1. Select Booking & Guest', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Booking ID
                Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 14, color: AppColors.textMuted),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text('Search Booking ID / Guest Name', style: TextStyle(fontSize: 11, color: AppColors.textMuted), overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Select Customer
                const Text('Select Customer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 34,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Name/Phone number', style: TextStyle(fontSize: 11, color: AppColors.textMuted), overflow: TextOverflow.ellipsis),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textMuted),
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
                      child: const Text('+ Add Guest', style: TextStyle(fontSize: 11, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Booking Date & Booking Time
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _pickCheckInDate(context, provider),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Booking Date', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
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
                                    child: Text(dateFormat.format(checkIn), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                  ),
                                  const Icon(Icons.calendar_today, size: 12, color: AppColors.primaryNavy),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Booking Time', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text('07:00 PM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                ),
                                Icon(Icons.access_time_rounded, size: 12, color: AppColors.primaryNavy),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  // --- Section 2: Review & Update Details ---
  Widget _buildCard2(BuildContext context, HotelBookingProvider provider, RoomModel room, DateTime checkOut, DateFormat dateFormat) {
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
            child: const Text('2. Review & Update Details', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
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
                      child: _inputColumn('Tenant Name', _tenantNameController.text),
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
                        onTap: () => _pickCheckOutDate(context, provider),
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
                                    child: Text(dateFormat.format(checkOut), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
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
                          child: Text(_tenantNameController.text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
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
                      onPressed: () => provider.clearSelection(),
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

  // --- Section 3: Finalize Check-in & Payment ---
  Widget _buildCard3(BuildContext context, HotelBookingProvider provider, double totalAmount) {
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
            child: const Text('3. Finalize Check-in & Payment', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Room Charge', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text(CurrencyFormatter.format(totalAmount), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Extra Charges', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text('₹0.00', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    Text('₹0.00', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(color: AppColors.border, height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Total Amount:', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      CurrencyFormatter.format(totalAmount),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.primaryNavy),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Total Paid:', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 6),
                    Text(CurrencyFormatter.format(totalAmount), style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _completeCheckIn(context, provider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Complete Check-in', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _actionButton('Get Data')),
                    const SizedBox(width: 4),
                    Expanded(child: _actionButton('M-Pay')),
                    const SizedBox(width: 4),
                    Expanded(child: _actionButton('Print')),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: _actionButton('Print Registration Card'),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _actionButton('Download Folio')),
                    const SizedBox(width: 4),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _completeCheckIn(context, provider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNavy,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text('Complete Check-in', style: TextStyle(fontSize: 10, color: Colors.white)),
                      ),
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

  // --- Table Below: Available Rooms List / Guest Registration Table ---
  Widget _buildRoomTable(HotelBookingProvider provider, DateFormat dateFormat) {
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
                    DataCell(Text(CurrencyFormatter.format(room.pricePerNight), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryNavy))),
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
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isBooked ? const Color(0xFF1D4ED8) : const Color(0xFF15803D)),
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

  Widget _actionButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFF1E9DF),
        side: const BorderSide(color: Color(0xFFD6C8B5), width: 0.8),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: Color(0xFF332D24))),
    );
  }
}
