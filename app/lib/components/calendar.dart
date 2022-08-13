import 'package:flutter/material.dart';

import 'package:calendar_timeline/calendar_timeline.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(
      const Duration(days: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, bottom: 25),
      child: CalendarTimeline(
        // showYears: true,
        initialDate: _selectedDate,
        firstDate: DateTime.now().subtract(
          const Duration(days: 365 * 4),
        ),
        lastDate: DateTime.now().add(
          const Duration(days: 365 * 4),
        ),
        onDateSelected: (date) => setState(() => _selectedDate = date),
        leftMargin: (MediaQuery.of(context).size.width - 60) / 2,
        monthColor: Colors.white70,
        dayColor: Colors.teal[200],
        dayNameColor: const Color(0xFF333A47),
        activeDayColor: Colors.white,
        activeBackgroundDayColor: Colors.redAccent[200],
        dotsColor: const Color(0xFF333A47),
        // selectableDayPredicate: (date) => date.day != 23,
        locale: 'en',
      ),
    );
  }
}
