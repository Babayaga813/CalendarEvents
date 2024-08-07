import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/BOs/EventDetailBO.dart';

extension filterEvents on List {}

extension DateTimeFormatting on DateTime {
  String toFormattedDateString() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  String dateToString() {
    final DateFormat formatter = DateFormat('d MMMM yyyy');
    return formatter.format(this);
  }
}

extension MinutesExtension on int {
  String toHoursAndMinutes() {
    final hours = this ~/ 60;
    final minutes = this % 60;

    // Format hours
    final hoursStr = hours > 0 ? '${hours} ${hours == 1 ? 'hr' : 'hrs'}' : '';

    // Format minutes
    final minutesStr =
        minutes > 0 ? '${minutes} ${minutes == 1 ? 'min' : 'mins'}' : '';

    // Combine and return
    return [hoursStr, minutesStr].where((str) => str.isNotEmpty).join(' ');
  }
}

List<EventDetail> filteredList(DateTime time, List<EventDetail> eventsList) {
  var data = eventsList.where((events) {
    return events.startAt.toFormattedDateString() ==
        time.toFormattedDateString();
  }).toList();
  return data;
}

bool eventStatus(EventDetail event) {
  return event.status == "Confirmed" ? true : false;
}

Color getTileColor(EventDetail event) {
  return event.status == "Confirmed"
      ? const Color(0xffF0F8EF)
      : const Color(0xffFEF2F2);
}

Color getStatusColor(EventDetail event) {
  return event.status == "Confirmed"
      ? const Color(0xff9DDBA1)
      : const Color(0xffFDA4A4);
}
