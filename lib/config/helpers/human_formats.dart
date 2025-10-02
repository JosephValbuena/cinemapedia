import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    int numberRevised = int.parse(number.toString().replaceAll('.', ''));
    final formatterNumber =
        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '', locale: 'en')
            .format(numberRevised);

    return formatterNumber;
  }

  static String average(double number, [int decimals = 0]) {
    final formatterNumber =
        NumberFormat.compactCurrency(decimalDigits: decimals, symbol: '', locale: 'en')
            .format(number);

    return formatterNumber;
  }
}
