import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_room_booking/core/constants/mock_rooms_data.dart';
import 'package:hotel_room_booking/features/hotel_booking/providers/hotel_booking_provider.dart';
import 'package:hotel_room_booking/main.dart';

void main() {
  testWidgets('Renders Raintech Hotel booking screen with rooms', (WidgetTester tester) async {
    await tester.pumpWidget(const HotelBookingApp());
    await tester.pumpAndSettle();

    // Verify header branding
    expect(find.text('Raintech'), findsOneWidget);
    expect(find.text('Hotel Room Booking'), findsOneWidget);

    // Verify 3 sections
    expect(find.text('1. SELECT STAY DATES & GUESTS'), findsOneWidget);
    expect(find.text('2. CHOOSE HOTEL ROOM'), findsOneWidget);
    expect(find.text('3. BOOKING SUMMARY & PAYMENT'), findsOneWidget);

    // Verify room codes are displayed
    expect(find.text('R101'), findsOneWidget);
    expect(find.text('R102'), findsOneWidget);
    expect(find.text('R201'), findsOneWidget);
    expect(find.text('R202'), findsOneWidget);
    expect(find.text('R301'), findsOneWidget);

    // Verify incomplete guidance is shown initially
    expect(find.text('Incomplete Selection'), findsOneWidget);
  });

  testWidgets('Provider updates night calculation and price dynamically', (WidgetTester tester) async {
    final provider = HotelBookingProvider();

    // Initial state
    expect(provider.numberOfNights, equals(0));
    expect(provider.totalPrice, equals(0.0));
    expect(provider.isBookingValid, isFalse);

    // Select dates: 3 nights
    final checkIn = DateTime(2026, 9, 20);
    final checkOut = DateTime(2026, 9, 23);
    provider.selectCheckInDate(checkIn);
    provider.selectCheckOutDate(checkOut);

    expect(provider.numberOfNights, equals(3));

    // Select R101 (Deluxe Room @ ₹3,500)
    final r101 = MockRoomsData.rooms.firstWhere((r) => r.roomCode == 'R101');
    provider.selectRoom(r101);

    expect(provider.selectedRoom?.roomCode, equals('R101'));
    expect(provider.totalPrice, equals(10500.0));
    expect(provider.isBookingValid, isTrue);

    // Change room to R201 (Executive Suite @ ₹5,800)
    final r201 = MockRoomsData.rooms.firstWhere((r) => r.roomCode == 'R201');
    provider.selectRoom(r201);

    // 3 nights * 5800 = 17,400
    expect(provider.totalPrice, equals(17400.0));

    // Change check-in date: if checkout is earlier or same, it adjusts automatically
    provider.selectCheckInDate(DateTime(2026, 9, 25));
    // Check-out should have automatically adjusted to 2026-09-26 (1 night)
    expect(provider.numberOfNights, equals(1));
    expect(provider.totalPrice, equals(5800.0));
  });

  testWidgets('Filter by guest capacity updates visible room list', (WidgetTester tester) async {
    final provider = HotelBookingProvider();

    // Default: 5 rooms
    expect(provider.rooms.length, equals(5));

    // Filter for 3+ guests (R201, R202, R301)
    provider.setGuestFilter(3);
    expect(provider.rooms.length, equals(3));
    expect(provider.rooms.every((r) => r.maxGuests >= 3), isTrue);

    // Filter for 4+ guests (R301)
    provider.setGuestFilter(4);
    expect(provider.rooms.length, equals(1));
    expect(provider.rooms.first.roomCode, equals('R301'));

    // Reset filter
    provider.setGuestFilter(null);
    expect(provider.rooms.length, equals(5));
  });
}
