import 'package:intl/intl.dart';

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

  static String format(num amount) {
    return _inrFormat.format(amount);
  }

  static String formatWithDecimals(num amount) {
    return _inrWithDecimalsFormat.format(amount);
  }
}
