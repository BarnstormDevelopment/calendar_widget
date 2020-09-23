import 'package:flutter/material.dart';

extension DateTimeRangeCompare on DateTimeRange {
  bool conflicts(DateTimeRange other) {
    return this.start.isBefore(other.end) && this.end.isAfter(other.start);
  }
}
