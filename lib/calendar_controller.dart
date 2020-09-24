import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/calendar_event.dart';
import 'extensions/date_range_extension.dart';

/// CalendarController provides configuration information to the CalendarWidget
/// and updates the view on changes to the event list.
class CalendarController {
  BoxConstraints constraints;
  List<CalendarEvent> _events = List();

  /// List of events currently in the calendar
  List<CalendarEvent> get events => _events;

  /// Width (in pixels) of event widgets
  double itemWidth;

  /// Margin on left side of the calendar
  double margin;

  /// Scale of hours shown on the screen
  double scale;
  double maxScale;
  double minScale;

  /// Designates if a line indicating the current time should be drawn.
  bool showCurrentTime;

  /// Formatter for displaying the time on the side of the calendar.
  DateFormat timeFormatter;

  /// Formatter for displaying the date on the side of the calendar.
  DateFormat dayFormatter;

  /// The number of pixels that represent an hour based upon the scale.
  double get interval {
    return constraints.maxHeight / scale;
  }

  /// Map of event id's to their horizontal index in the calendar view.
  Map<int, int> indexMap = Map();

  /// Date range that the calendar shows.
  DateTimeRange range;

  StreamController<CalendarEvent> eventAdded =
      StreamController<CalendarEvent>();
  StreamController<dynamic> eventRemoved = StreamController<dynamic>();
  CalendarController(this.range,
      {@required events,
      this.itemWidth = 200,
      this.margin = 24.0,
      this.scale = 12.0,
      this.minScale = 4.0,
      this.maxScale = 36,
      this.showCurrentTime = true,
      this.timeFormatter,
      this.dayFormatter}) {
    this._events = events;
    timeFormatter = timeFormatter ?? DateFormat.Hm();
    dayFormatter = dayFormatter ?? DateFormat.MEd();
  }

  /// Should be called when parent widget is to be destroyed.
  void dispose() {
    eventAdded.close();
    eventRemoved.close();
  }

  /// Returns horizontal index of given event id
  int getXIndex(id) {
    return indexMap[id];
  }

  void addEvent(CalendarEvent event) {
    this.events.add(event);
    this.generateIndices();
    eventAdded.add(event);
  }

  void removeEvent(dynamic id) {
    this.events.removeWhere((e) => e.id == id);
    eventRemoved.add(id);
  }

  /// Generates the horizontal index' of all the events in the calendar.
  /// This is called everytime the event list is changed.
  void generateIndices() {
    var temp = List<CalendarEvent>.from(events);
    var backup = List<CalendarEvent>();
    temp.sort();
    int i = 0;
    while (temp.isNotEmpty) {
      var e = temp.first;
      temp.remove(e);
      indexMap[e.id] = i;
      while (temp.isNotEmpty) {
        var r = temp.first;
        temp.remove(r);
        if (e.range.conflicts(r.range)) {
          backup.add(r);
        } else {
          indexMap[r.id] = i;
          e = r;
        }
      }
      temp = backup;
      backup = List<CalendarEvent>();
      temp.sort();
      i++;
    }
    print(indexMap.toString());
  }

  double getTimeWidth({double mult = 2.2}) {
    return margin * mult;
  }

  double getWidth() {
    return (getMaxXIndex() + 1) * itemWidth + margin + getTimeWidth();
  }

  int getMaxXIndex() {
    var mx = 0;
    indexMap.forEach((key, value) => mx = max(mx, value));
    return mx;
  }
}
