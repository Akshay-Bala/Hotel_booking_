/// Represents an existing or confirmed hotel room booking.
class BookingRecord {
  final String bookingId;
  final String roomCode;
  final DateTime checkIn;
  final DateTime checkOut;
  final String guestName;

  const BookingRecord({
    required this.bookingId,
    required this.roomCode,
    required this.checkIn,
    required this.checkOut,
    required this.guestName,
  });
}
