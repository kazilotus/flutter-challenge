import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateModel extends ChangeNotifier {
  DateTime _date = DateTime.now();

  void set(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  DateTime get() {
    return _date;
  }

  String getFormatted() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(_date);
    return formatted;
  }
}
