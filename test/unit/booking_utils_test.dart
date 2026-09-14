import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_room_booking/features/hotel_booking/data/models/booking_record.dart';
import 'package:hotel_room_booking/features/hotel_booking/utils/booking_utils.dart';

void main() {
  group('BookingUtils — Night Calculation', () {
    test('Calculates 1 night correctly (10 Sep -> 11 Sep)', () {
      final checkIn = DateTime(2026, 9, 10);
      final checkOut = DateTime(2026, 9, 11);
      expect(BookingUtils.calculateNights(checkIn, checkOut), equals(1));
    });

    test('Calculates 5 nights correctly (10 Sep -> 15 Sep)', () {
      final checkIn = DateTime(2026, 9, 10);
      final checkOut = DateTime(2026, 9, 15);
      expect(BookingUtils.calculateNights(checkIn, checkOut), equals(5));
    });

    test('Calculates 0 nights for same-day booking (10 Sep -> 10 Sep)', () {
      final checkIn = DateTime(2026, 9, 10, 14, 0);
      final checkOut = DateTime(2026, 9, 10, 18, 0);
      expect(BookingUtils.calculateNights(checkIn, checkOut), equals(0));
    });

    test('Calculates 0 nights if check-out is before check-in', () {
      final checkIn = DateTime(2026, 9, 15);
      final checkOut = DateTime(2026, 9, 10);
      expect(BookingUtils.calculateNights(checkIn, checkOut), equals(0));
    });

    test('Ignores time-of-day discrepancies when calculating nights', () {
      // Check-in at 2:00 PM, Check-out at 11:00 AM next day
      final checkIn = DateTime(2026, 9, 10, 14, 0);
      final checkOut = DateTime(2026, 9, 11, 11, 0);
      expect(BookingUtils.calculateNights(checkIn, checkOut), equals(1));
    });
  });

  group('BookingUtils — Total Price Calculation', () {
    test('Calculates total price correctly: 3 nights * ₹3,500 = ₹10,500', () {
      const nights = 3;
      const pricePerNight = 3500.0;
      final total = BookingUtils.calculateTotalPrice(nights, pricePerNight);
      expect(total, equals(10500.0));
    });

    test('Calculates total price correctly for Executive Suite: 2 nights * ₹5,800 = ₹11,600', () {
      const nights = 2;
      const pricePerNight = 5800.0;
      final total = BookingUtils.calculateTotalPrice(nights, pricePerNight);
      expect(total, equals(11600.0));
    });

    test('Returns 0.0 for 0 nights or 0 price', () {
      expect(BookingUtils.calculateTotalPrice(0, 3500.0), equals(0.0));
      expect(BookingUtils.calculateTotalPrice(3, 0.0), equals(0.0));
    });
  });

  group('BookingUtils — Date Validation', () {
    final fixedToday = DateTime(2026, 9, 14);

    test('Allows check-in for today', () {
      final checkIn = DateTime(2026, 9, 14);
      final error = BookingUtils.validateCheckIn(checkIn, referenceToday: fixedToday);
      expect(error, isNull);
    });

    test('Allows check-in for future dates', () {
      final checkIn = DateTime(2026, 9, 20);
      final error = BookingUtils.validateCheckIn(checkIn, referenceToday: fixedToday);
      expect(error, isNull);
    });

    test('Rejects check-in date in the past', () {
      final pastDate = DateTime(2026, 9, 10);
      final error = BookingUtils.validateCheckIn(pastDate, referenceToday: fixedToday);
      expect(error, equals('Check-in date cannot be in the past.'));
    });

    test('Rejects same-day booking (check-out equals check-in)', () {
      final checkIn = DateTime(2026, 9, 15);
      final checkOut = DateTime(2026, 9, 15);
      final error = BookingUtils.validateCheckOut(checkIn, checkOut);
      expect(error, contains('Check-out date must be after the check-in date'));
    });

    test('Rejects check-out date earlier than check-in', () {
      final checkIn = DateTime(2026, 9, 20);
      final checkOut = DateTime(2026, 9, 18);
      final error = BookingUtils.validateCheckOut(checkIn, checkOut);
      expect(error, contains('Check-out date must be after the check-in date'));
    });

    test('Accepts valid check-out date after check-in', () {
      final checkIn = DateTime(2026, 9, 15);
      final checkOut = DateTime(2026, 9, 18);
      final error = BookingUtils.validateCheckOut(checkIn, checkOut);
      expect(error, isNull);
    });
  });

  group('BookingUtils — Date Overlap Collision (Bonus Feature A)', () {
    final existingBooking = BookingRecord(
      bookingId: 'BK-1001',
      roomCode: 'R101',
      checkIn: DateTime(2026, 10, 10),
      checkOut: DateTime(2026, 10, 14),
      guestName: 'Mathew Hyden',
    );

    test('Detects direct overlap within existing booking dates', () {
      final overlaps = BookingUtils.isBookingOverlap(
        checkIn: DateTime(2026, 10, 11),
        checkOut: DateTime(2026, 10, 13),
        existingBooking: existingBooking,
      );
      expect(overlaps, isTrue);
    });

    test('Detects overlap when new check-in starts during existing booking', () {
      final overlaps = BookingUtils.isBookingOverlap(
        checkIn: DateTime(2026, 10, 12),
        checkOut: DateTime(2026, 10, 16),
        existingBooking: existingBooking,
      );
      expect(overlaps, isTrue);
    });

    test('Allows check-in on the exact day existing booking checks out (hospitality standard)', () {
      final overlaps = BookingUtils.isBookingOverlap(
        checkIn: DateTime(2026, 10, 14),
        checkOut: DateTime(2026, 10, 18),
        existingBooking: existingBooking,
      );
      expect(overlaps, isFalse);
    });

    test('Allows check-out on the exact day existing booking checks in', () {
      final overlaps = BookingUtils.isBookingOverlap(
        checkIn: DateTime(2026, 10, 6),
        checkOut: DateTime(2026, 10, 10),
        existingBooking: existingBooking,
      );
      expect(overlaps, isFalse);
    });

    test('Allows completely non-overlapping dates', () {
      final overlaps = BookingUtils.isBookingOverlap(
        checkIn: DateTime(2026, 11, 1),
        checkOut: DateTime(2026, 11, 5),
        existingBooking: existingBooking,
      );
      expect(overlaps, isFalse);
    });
  });
}
