import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// Created by alfianhpratama on 28/05/23
///

extension StringExtension on String {
  DateTime toDateTime({String pattern = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(pattern).parse(this);
    } catch (_) {
      return DateTime.now();
    }
  }

  String toddMMMMyyyy({String inputPattern = 'yyyy-MM-dd'}) {
    try {
      return DateFormat('dd MMMM yyyy')
          .format(toDateTime(pattern: inputPattern));
    } catch (_) {
      return this;
    }
  }

  String toddMMMyyyy({String inputPattern = 'yyyy-MM-dd'}) {
    try {
      return DateFormat('dd MMM yyyy')
          .format(toDateTime(pattern: inputPattern));
    } catch (_) {
      return this;
    }
  }

  ThemeMode toThemeMode() {
    switch (this) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
