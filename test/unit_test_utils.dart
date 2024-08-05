import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

Future<S> setupLocale([String langCode = 'en']) {
  return S.load(Locale(langCode));
}
