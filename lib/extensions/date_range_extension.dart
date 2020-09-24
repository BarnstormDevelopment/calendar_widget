import 'package:flutter/material.dart';

extension DateTimeRangeCompare on DateTimeRange {
  /// Determines if the current [DateTimeRange] conflicts with [other]
  bool conflicts(DateTimeRange other) {
    return this.start.isBefore(other.end) && this.end.isAfter(other.start);
  }
}
