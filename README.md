# Hotel Room Booking — Flutter Coding Assessment

A Flutter application implementing the **Hotel Room Booking** assessment for **RAINTECH SOFTWARE LIMITED**. Built with Flutter, Dart, and Provider, reproducing the layout, aesthetics, metallic brass badges, and workflow of the Raintech Hotel Management system.

---

## 1. Technology Stack

* **Framework:** Flutter (3.44.1+ / Material 3)
* **Language:** Dart (3.12.1+)
* **State Management:** Provider (`ChangeNotifierProvider`, `Consumer`, `context.watch`)
* **Formatting:** `intl` package (Indian Rupee `₹` formatting and calendar date formats)
* **Testing:** `flutter_test` (Comprehensive unit tests & widget tests)

---

## 2. Key Features

* **Visual Fidelity:** Faithful reproduction of the Raintech Hotel Management PMS UI:
  * Warm cream/off-white background (`#F6F3EE`)
  * Deep corporate navy section banners (`#16385C`)
  * Metallic brass/gold room plate badge (`[hotel icon] R101`)
  * Clean rounded cards with subtle borders and shadows
  * Responsive layout adapting seamlessly across desktop, tablet, and mobile screens
* **Room Catalog:** Displays all five required rooms with room code, room type, price per night in INR (`₹`), maximum guest capacity, floor number, and amenities:
  * `R101` — Deluxe Room — ₹3,500/night — Max 2 Guests
  * `R102` — Deluxe Room — ₹3,500/night — Max 2 Guests
  * `R201` — Executive Suite — ₹5,800/night — Max 3 Guests
  * `R202` — Executive Suite — ₹5,800/night — Max 3 Guests
  * `R301` — Family Room — ₹4,200/night — Max 4 Guests
* **Date Selection & Validation:**
  * Check-in date picker (prevents selecting past dates; allows today onwards).
  * Check-out date picker (must be strictly after check-in date; prevents same-day and past check-out).
  * Automatic date correction: If check-in date is changed to on or after the chosen check-out date, check-out automatically advances to check-in + 1 day to prevent invalid silent states.
* **Night & Price Calculation:**
  * Night calculation: `numberOfNights = checkoutDate - checkinDate` (time-normalized to avoid DST/time-of-day discrepancies).
  * Total price formula: `totalPrice = numberOfNights × pricePerNight`.
  * Real-time calculation feedback formatted in Indian currency (`₹`).
* **Validation & Error Handling:**
  * Clear, prominent alert banners for invalid check-in, invalid check-out, unselected room, or booking collisions.
  * Incomplete selection guidance: Does not display premature prices or inaccurate totals when required fields are missing.
* **Bonus Feature A — Booked Room Collision Detection:**
  * Checks selected date ranges against existing bookings using standard hospitality overlap rules (`checkIn < booking.checkOut && booking.checkIn < checkOut`).
  * Flags conflicting rooms with "Occupied" status and prevents conflicting reservations.
* **Bonus Feature B — Comprehensive Unit & Widget Tests:**
  * Tests for night calculation (single night, multi-night, same-day, reversed dates).
  * Tests for total price calculation.
  * Tests for past check-in validation and same-day validation.
  * Tests for date range overlap collisions.
  * Widget & Provider integration tests for room selection, filters, and price updates.
* **Bonus Feature C — Filter by Maximum Guest Capacity:**
  * Interactive filter chips for All Rooms, 2 Guests, 3 Guests, and 4+ Guests.
* **Booking Confirmation Folio:**
  * Confirmation dialog presenting reservation details (Booking ID, Room, Dates, Nights, Total Paid) with download and close actions.

---

## 3. Project Architecture & Folder Structure

The project follows a clean, feature-oriented architecture separating domain models, state management, UI widgets, and pure utility business logic:

```text
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart            # Theme palette (Navy, Brass gold, Cream)
│   │   ├── app_text_styles.dart       # Typography styles
│   │   └── mock_rooms_data.dart       # 5 required rooms + sample bookings
│   ├── theme/
│   │   └── app_theme.dart             # Material 3 light theme configuration
│   ├── utils/
│   │   └── currency_formatter.dart    # Indian Rupee formatting (₹3,500, ₹10,500)
│   └── widgets/
│       └── room_badge.dart            # Metallic brass room number badge
│
├── features/
│   └── hotel_booking/
│       ├── data/
│       │   └── models/
│       │       ├── room_model.dart     # Room entity with copyWith and equality
│       │       └── booking_record.dart # Booking model for date overlap detection
│       ├── providers/
│       │   └── hotel_booking_provider.dart # ChangeNotifier state management
│       ├── screens/
│       │   └── hotel_booking_screen.dart   # Main responsive booking screen
│       ├── widgets/
│       │   ├── booking_header.dart         # Raintech Hotel top bar & search
│       │   ├── date_selection_widget.dart  # Check-in/out pickers & guest filter
│       │   ├── room_card.dart              # Individual room card with badge
│       │   ├── booking_summary.dart        # Summary card with calculation breakdown
│       │   ├── validation_message.dart     # Error and guidance banner
│       │   └── booking_success_dialog.dart # Reservation confirmation folio
│       └── utils/
│           └── booking_utils.dart          # Pure business logic & date calculations
│
└── main.dart                          # App entry point with MultiProvider
```

### State Management Separation
- **`BookingUtils`**: 100% pure Dart helper methods with zero UI coupling. Easily unit tested.
- **`HotelBookingProvider`**: Central state holder extending `ChangeNotifier`. Manages date choices, selected room, guest filter, night calculations, and validation states.
- **Widgets**: Pure presentation components that observe state via `context.watch<HotelBookingProvider>()` or Provider methods without embedded calculations.

---

## 4. How to Run

### 1. Install dependencies
```bash
flutter pub get
```

### 2. Run automated tests
```bash
flutter test
```

### 3. Run the application
```bash
# Run on connected desktop device (Windows, macOS, Linux) or Web
flutter run

# Or specify device:
flutter run -d windows
flutter run -d chrome
```

---

## 5. Potential Improvements With More Time

* **Backend & API Integration:** Connect to a REST / GraphQL backend for real-time room inventory.
* **Persistent Storage:** Cache bookings and user preferences locally via SQLite (`sqflite`) or Hive.
* **Authentication & Roles:** Multi-user authentication for Front Desk Agents, Housekeeping, and Guests.
* **Payment Gateway:** Integration with Razorpay / Stripe for live transaction processing.
* **Enhanced Room Media:** High-resolution photo galleries and 360-degree virtual room tours.
* **Accessibility (a11y):** Full screen reader semantics and high-contrast accessibility modes.
