import 'package:intl/intl.dart';

/// Utility class for formatting currency in Indian Rupees (INR).
class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _inrFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final NumberFormat _inrWithDecimalsFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  /// Formats amount to INR without decimals, e.g. `₹3,500` or `₹10,500`.
  static String format(num amount) {
    return _inrFormat.format(amount);
  }

  /// Formats amount to INR with two decimals, e.g. `₹3,500.00`.
  static String formatWithDecimals(num amount) {
    return _inrWithDecimalsFormat.format(amount);
  }
}
