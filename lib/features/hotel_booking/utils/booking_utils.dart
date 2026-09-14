import '../data/models/booking_record.dart';

/// Pure business logic and calculation helpers for hotel booking.
class BookingUtils {
  BookingUtils._();

  /// Normalizes a [DateTime] to start of day (00:00:00.000) to eliminate
  /// time-of-day differences when comparing calendar dates.
  static DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Calculates the number of nights between [checkIn] and [checkOut].
  /// Returns 0 if checkOut is not after checkIn.
  static int calculateNights(DateTime checkIn, DateTime checkOut) {
    final start = normalizeDate(checkIn);
    final end = normalizeDate(checkOut);
    final difference = end.difference(start).inDays;
    return difference > 0 ? difference : 0;
  }

  /// Calculates total price based on [nights] and [pricePerNight].
  static double calculateTotalPrice(int nights, double pricePerNight) {
    if (nights <= 0 || pricePerNight <= 0) {
      return 0.0;
    }
    return nights * pricePerNight;
  }

  /// Validates check-in date. Returns error message if invalid, null if valid.
  static String? validateCheckIn(DateTime? checkIn, {DateTime? referenceToday}) {
    if (checkIn == null) {
      return 'Please select a check-in date.';
    }

    final today = normalizeDate(referenceToday ?? DateTime.now());
    final start = normalizeDate(checkIn);

    if (start.isBefore(today)) {
      return 'Check-in date cannot be in the past.';
    }

    return null;
  }

  /// Validates check-out date against check-in.
  /// Returns error message if invalid, null if valid.
  static String? validateCheckOut(DateTime? checkIn, DateTime? checkOut) {
    if (checkOut == null) {
      return 'Please select a check-out date.';
    }

    if (checkIn == null) {
      return 'Please select a check-in date first.';
    }

    final start = normalizeDate(checkIn);
    final end = normalizeDate(checkOut);

    if (end.isAtSameMomentAs(start)) {
      return 'Check-out date must be after the check-in date (same-day booking is not allowed).';
    }

    if (end.isBefore(start)) {
      return 'Check-out date must be after the check-in date.';
    }

    return null;
  }

  /// Overall date range validation helper.
  static String? validateDateRange(DateTime? checkIn, DateTime? checkOut, {DateTime? referenceToday}) {
    final checkInError = validateCheckIn(checkIn, referenceToday: referenceToday);
    if (checkInError != null) return checkInError;

    final checkOutError = validateCheckOut(checkIn, checkOut);
    if (checkOutError != null) return checkOutError;

    return null;
  }

  /// Checks whether [checkIn]..[checkOut] overlaps with an existing [BookingRecord].
  /// In the hospitality industry, a new guest can check in on the same calendar day
  /// another guest checks out: overlap occurs only if `checkIn < booking.checkOut`
  /// and `booking.checkIn < checkOut`.
  static bool isBookingOverlap({
    required DateTime checkIn,
    required DateTime checkOut,
    required BookingRecord existingBooking,
  }) {
    final start = normalizeDate(checkIn);
    final end = normalizeDate(checkOut);
    final bookedStart = normalizeDate(existingBooking.checkIn);
    final bookedEnd = normalizeDate(existingBooking.checkOut);

    return start.isBefore(bookedEnd) && bookedStart.isBefore(end);
  }
}
