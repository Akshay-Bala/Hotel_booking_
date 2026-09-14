import 'package:flutter/foundation.dart';
import '../../../core/constants/mock_rooms_data.dart';
import '../data/models/booking_record.dart';
import '../data/models/room_model.dart';
import '../utils/booking_utils.dart';

class HotelBookingProvider extends ChangeNotifier {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  RoomModel? _selectedRoom;
  int? _guestFilter;
  String? _validationError;
  bool _isBookingConfirmed = false;

  final List<RoomModel> _allRooms;
  final List<BookingRecord> _existingBookings;

  HotelBookingProvider({
    List<RoomModel>? initialRooms,
    List<BookingRecord>? initialBookings,
  })  : _allRooms = initialRooms ?? List.from(MockRoomsData.rooms),
        _existingBookings = initialBookings ?? List.from(MockRoomsData.sampleBookings);

  // Getters
  DateTime? get checkInDate => _checkInDate;
  DateTime? get checkOutDate => _checkOutDate;
  RoomModel? get selectedRoom => _selectedRoom;
  int? get guestFilter => _guestFilter;
  String? get validationError => _validationError;
  bool get isBookingConfirmed => _isBookingConfirmed;
  List<BookingRecord> get existingBookings => List.unmodifiable(_existingBookings);

  /// Filtered rooms based on the guest capacity filter.
  List<RoomModel> get rooms {
    if (_guestFilter == null) {
      return List.unmodifiable(_allRooms);
    }
    return _allRooms.where((room) => room.maxGuests >= _guestFilter!).toList();
  }

  int get numberOfNights {
    if (_checkInDate == null || _checkOutDate == null) {
      return 0;
    }
    return BookingUtils.calculateNights(_checkInDate!, _checkOutDate!);
  }

  double get totalPrice {
    if (_selectedRoom == null || numberOfNights == 0) {
      return 0.0;
    }
    return BookingUtils.calculateTotalPrice(numberOfNights, _selectedRoom!.pricePerNight);
  }

  bool get isBookingValid {
    if (_checkInDate == null || _checkOutDate == null || _selectedRoom == null) {
      return false;
    }
    if (numberOfNights <= 0) {
      return false;
    }
    if (isRoomBookedForSelectedDates(_selectedRoom!)) {
      return false;
    }
    return _validationError == null;
  }

  bool isRoomBookedForSelectedDates(RoomModel room) {
    if (_checkInDate == null || _checkOutDate == null) {
      return false;
    }
    return _existingBookings.any((booking) {
      return booking.roomCode == room.roomCode &&
          BookingUtils.isBookingOverlap(
            checkIn: _checkInDate!,
            checkOut: _checkOutDate!,
            existingBooking: booking,
          );
    });
  }

  void selectCheckInDate(DateTime date) {
    _checkInDate = BookingUtils.normalizeDate(date);
    _isBookingConfirmed = false;
    if (_checkOutDate != null && !_checkOutDate!.isAfter(_checkInDate!)) {
      _checkOutDate = _checkInDate!.add(const Duration(days: 1));
    }

    _recalculateAndValidate();
    notifyListeners();
  }

  /// Selects check-out date.
  void selectCheckOutDate(DateTime date) {
    _checkOutDate = BookingUtils.normalizeDate(date);
    _isBookingConfirmed = false;
    _recalculateAndValidate();
    notifyListeners();
  }

  /// Selects exactly one room. If the room is already selected, it remains selected.
  void selectRoom(RoomModel room) {
    if (isRoomBookedForSelectedDates(room)) {
      _validationError = 'Room ${room.roomCode} is already booked for the selected dates.';
      notifyListeners();
      return;
    }

    _selectedRoom = room;
    _isBookingConfirmed = false;
    _recalculateAndValidate();
    notifyListeners();
  }

  /// Deselects current room.
  void unselectRoom() {
    _selectedRoom = null;
    _recalculateAndValidate();
    notifyListeners();
  }

  /// Sets guest capacity filter (Bonus C).
  void setGuestFilter(int? maxGuests) {
    _guestFilter = maxGuests;
    if (_selectedRoom != null && _guestFilter != null && _selectedRoom!.maxGuests < _guestFilter!) {
      _selectedRoom = null;
    }
    _recalculateAndValidate();
    notifyListeners();
  }

  /// Validates booking and returns true if valid, false otherwise.
  bool validateBooking() {
    if (_checkInDate == null) {
      _validationError = 'Please select a check-in date.';
      notifyListeners();
      return false;
    }

    final checkInErr = BookingUtils.validateCheckIn(_checkInDate);
    if (checkInErr != null) {
      _validationError = checkInErr;
      notifyListeners();
      return false;
    }

    if (_checkOutDate == null) {
      _validationError = 'Please select a check-out date.';
      notifyListeners();
      return false;
    }

    final checkOutErr = BookingUtils.validateCheckOut(_checkInDate, _checkOutDate);
    if (checkOutErr != null) {
      _validationError = checkOutErr;
      notifyListeners();
      return false;
    }

    if (_selectedRoom == null) {
      _validationError = 'Please select a room.';
      notifyListeners();
      return false;
    }

    if (isRoomBookedForSelectedDates(_selectedRoom!)) {
      _validationError = 'Room ${_selectedRoom!.roomCode} is already booked for these dates.';
      notifyListeners();
      return false;
    }

    _validationError = null;
    notifyListeners();
    return true;
  }

  /// Confirms booking if valid.
  bool confirmBooking() {
    if (!validateBooking()) {
      return false;
    }

    // Add confirmed booking to existing bookings to demonstrate state tracking
    final newBooking = BookingRecord(
      bookingId: 'BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      roomCode: _selectedRoom!.roomCode,
      checkIn: _checkInDate!,
      checkOut: _checkOutDate!,
      guestName: 'Valued Guest',
    );
    _existingBookings.add(newBooking);
    _isBookingConfirmed = true;
    notifyListeners();
    return true;
  }

  /// Clears all selections and resets state.
  void clearSelection() {
    _checkInDate = null;
    _checkOutDate = null;
    _selectedRoom = null;
    _guestFilter = null;
    _validationError = null;
    _isBookingConfirmed = false;
    notifyListeners();
  }

  /// Internal validation helper.
  void _recalculateAndValidate() {
    _validationError = null;

    if (_checkInDate != null) {
      final checkInError = BookingUtils.validateCheckIn(_checkInDate);
      if (checkInError != null) {
        _validationError = checkInError;
        return;
      }
    }

    if (_checkInDate != null && _checkOutDate != null) {
      final checkOutError = BookingUtils.validateCheckOut(_checkInDate, _checkOutDate);
      if (checkOutError != null) {
        _validationError = checkOutError;
        return;
      }
    }

    if (_selectedRoom != null && isRoomBookedForSelectedDates(_selectedRoom!)) {
      _validationError = 'Room ${_selectedRoom!.roomCode} is already booked for these dates.';
      return;
    }
  }
}
