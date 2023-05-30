import 'package:intl/intl.dart';

///
/// Created by alfianhpratama on 28/05/23
///

extension DateTimeExtensions on DateTime {
  String format({String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    try {
      return DateFormat(pattern).format(this);
    } catch (e) {
      return toString();
    }
  }

  String toddMMMMyyyy() => format(pattern: 'dd MMMM yyyy');

  String toddMMMyyyy() => format(pattern: 'dd MMM yyyy');
}
