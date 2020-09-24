import 'package:flutter/material.dart';

/// Base class for events that are added to the calendar.
class CalendarEvent implements Comparable {
  final int id;
  DateTimeRange range;
  String name;

  CalendarEvent({this.id, this.range, this.name});

  @override
  int compareTo(other) {
    if (range.start.isAtSameMomentAs(other.range.start)) {
      return this.id < other.id ? 1 : 0;
    }
    return range.start.isBefore(other.range.start) ? 1 : 0;
  }
}
