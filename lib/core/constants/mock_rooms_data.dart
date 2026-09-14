import '../../features/hotel_booking/data/models/booking_record.dart';
import '../../features/hotel_booking/data/models/room_model.dart';

class MockRoomsData {
  MockRoomsData._();

  static const List<RoomModel> rooms = [
    RoomModel(
      roomCode: 'R101',
      roomType: 'Deluxe Room',
      pricePerNight: 3500.0,
      maxGuests: 2,
      floor: 1,
      amenities: ['King Bed', 'AC', 'Free High-speed Wi-Fi', 'City View'],
    ),
    RoomModel(
      roomCode: 'R102',
      roomType: 'Deluxe Room',
      pricePerNight: 3500.0,
      maxGuests: 2,
      floor: 1,
      amenities: ['Twin Beds', 'AC', 'Free High-speed Wi-Fi', 'Garden View'],
    ),
    RoomModel(
      roomCode: 'R201',
      roomType: 'Executive Suite',
      pricePerNight: 5800.0,
      maxGuests: 3,
      floor: 2,
      amenities: ['Master Bedroom', 'Living Area', 'Mini-bar', 'Balcony'],
    ),
    RoomModel(
      roomCode: 'R202',
      roomType: 'Executive Suite',
      pricePerNight: 5800.0,
      maxGuests: 3,
      floor: 2,
      amenities: ['King Bed + Sofa Bed', 'Workstation', 'Mini-bar', 'Smart TV'],
    ),
    RoomModel(
      roomCode: 'R301',
      roomType: 'Family Room',
      pricePerNight: 4200.0,
      maxGuests: 4,
      floor: 3,
      amenities: ['2 Queen Beds', 'Spacious Bath', 'Kid Friendly', 'Dining Space'],
    ),
  ];

  static List<BookingRecord> sampleBookings = [
    BookingRecord(
      bookingId: 'BK-1001',
      roomCode: 'R101',
      checkIn: DateTime(2026, 10, 10),
      checkOut: DateTime(2026, 10, 14),
      guestName: 'Mathew Hyden',
    ),
    BookingRecord(
      bookingId: 'BK-1002',
      roomCode: 'R202',
      checkIn: DateTime(2026, 10, 20),
      checkOut: DateTime(2026, 10, 25),
      guestName: 'Sarah Thompson',
    ),
  ];
}
