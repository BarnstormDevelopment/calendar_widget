import 'dart:math';

import 'package:flutter/material.dart';
import 'models/calendar_event.dart';
import 'extensions/date_range_extension.dart';

class CalendarController {
  BoxConstraints constraints;
  List<CalendarEvent> events = List();
  List<int> selected = List();
  double itemWidth;
  double margin;
  double scale;
  double get interval {
    return constraints.maxHeight / scale;
  }

  Map<int, int> indexMap = Map();

  DateTimeRange range;
  CalendarController(@required this.range,
      {@required this.events,
      this.itemWidth = 200,
      this.margin = 24.0,
      this.scale = 12.0});

  int getXIndex(id) {
    return indexMap[id];
  }

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
