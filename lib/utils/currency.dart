import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final NumberFormat idrFormat = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp',
  decimalDigits: 0,
);

String formatCurrency(int amount) {
  return idrFormat.format(amount);
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is empty, just return an empty string.
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove non-numeric characters like currency symbols and separators.
    String numericsOnly = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    // If the numeric string is not empty, format it as currency.
    if (numericsOnly.isNotEmpty) {
      int valueAsInt = int.parse(numericsOnly);
      String formattedValue = idrFormat.format(valueAsInt);

      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } else {
      // If numericsOnly is empty (all characters were non-numeric), return an empty string.
      return newValue.copyWith(
          text: '', selection: const TextSelection.collapsed(offset: 0));
    }
  }
}
