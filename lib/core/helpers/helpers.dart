import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

class Helpers {
  static final Helpers _instance = Helpers._internal();

  factory Helpers() {
    return _instance;
  }

  Helpers._internal();

  String concealString({required String amount}) {
    return amount.replaceRange(0, amount.length, '*' * 6);
  }

  String? isNumber(value) {
    try {
      double.parse(value);
    } catch (e) {
      return S.current.pleaseEnterNumbersOnly;
    }

    return null;
  }

  String formatBalance({
    required String balance,
  }) {
    bool checkIfEndsWithZero = false;
    if (balance.contains('.')) {
      final split = balance.split('.');
      if (split[1].length == 1) {
        checkIfEndsWithZero = true;
      }
    }

    balance = checkIfEndsWithZero ? '${balance}0' : '$balance.00';

    final splittedValue = balance.split('.');
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return ("${splittedValue[0].replaceAllMapped(reg, mathFunc)}.${splittedValue[1]}");
  }
}
