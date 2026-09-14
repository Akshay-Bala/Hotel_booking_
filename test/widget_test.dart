import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_room_booking/core/constants/mock_rooms_data.dart';
import 'package:hotel_room_booking/features/hotel_booking/providers/hotel_booking_provider.dart';
import 'package:hotel_room_booking/main.dart';

void main() {
  testWidgets('Renders Raintech Hotel app shell and navigates screens', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const HotelBookingApp());
    await tester.pumpAndSettle();

    // Verify Main Dashboard renders
    expect(find.text('Main Dashboard'), findsAtLeast(1));
    expect(find.text('Guest Check-in'), findsAtLeast(1));
    expect(find.text('Guest Check-Out'), findsAtLeast(1));
    expect(find.text('Operational Overview'), findsOneWidget);

    // Tap on Guest Check-in in navigation bar
    await tester.tap(find.text('Guest Check-in').last);
    await tester.pumpAndSettle();

    // Verify Guest Check-in screen is visible
    expect(find.text('https://Management Pro'), findsOneWidget);
    expect(find.text('1. Select Booking & Guest'), findsOneWidget);
    expect(find.text('2. Review & Update Details'), findsOneWidget);
    expect(find.text('3. Finalize Check-in & Payment'), findsOneWidget);

    // Tap on Guest Check-out in navigation bar
    await tester.tap(find.text('Guest Check-out').last);
    await tester.pumpAndSettle();

    // Verify Guest Check-out screen is visible
    expect(find.text('1. Identify Departing Guest'), findsOneWidget);
    expect(find.text('2. Review & Finalize Bill'), findsOneWidget);
    expect(find.text('3. Payment & Check-out'), findsOneWidget);
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
  });

  testWidgets('Filter by guest capacity updates visible room list', (WidgetTester tester) async {
    final provider = HotelBookingProvider();

    // Default: 5 rooms
    expect(provider.rooms.length, equals(5));

    // Filter for 3+ guests (R201, R202, R301)
    provider.setGuestFilter(3);
    expect(provider.rooms.length, equals(3));
    expect(provider.rooms.every((r) => r.maxGuests >= 3), isTrue);

    // Reset filter
    provider.setGuestFilter(null);
    expect(provider.rooms.length, equals(5));
  });
}
