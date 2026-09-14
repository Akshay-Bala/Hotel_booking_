import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/hotel_booking/providers/hotel_booking_provider.dart';
import 'features/hotel_booking/screens/hotel_app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HotelBookingApp());
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HotelBookingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Raintech Hotel — Management & Room Booking',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HotelAppShell(),
      ),
    );
  }
}
