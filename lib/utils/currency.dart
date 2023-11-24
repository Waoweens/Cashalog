import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  final NumberFormat formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  return formatter.format(amount);
}
