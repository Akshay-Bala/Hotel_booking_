class RoomModel {
  final String roomCode;
  final String roomType;
  final double pricePerNight;
  final int maxGuests;
  final int floor;
  final List<String> amenities;

  const RoomModel({
    required this.roomCode,
    required this.roomType,
    required this.pricePerNight,
    required this.maxGuests,
    this.floor = 1,
    this.amenities = const [],
  });

  RoomModel copyWith({
    String? roomCode,
    String? roomType,
    double? pricePerNight,
    int? maxGuests,
    int? floor,
    List<String>? amenities,
  }) {
    return RoomModel(
      roomCode: roomCode ?? this.roomCode,
      roomType: roomType ?? this.roomType,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      maxGuests: maxGuests ?? this.maxGuests,
      floor: floor ?? this.floor,
      amenities: amenities ?? this.amenities,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomModel &&
          runtimeType == other.runtimeType &&
          roomCode == other.roomCode;

  @override
  int get hashCode => roomCode.hashCode;

  @override
  String toString() {
    return 'RoomModel(roomCode: $roomCode, roomType: $roomType, pricePerNight: $pricePerNight, maxGuests: $maxGuests)';
  }
}
