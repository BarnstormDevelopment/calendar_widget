import 'package:flutter/material.dart';

/// Theme for a [CalendarWidget]
class CalendarTheme {
  Color cardColor;

  /// [Color] of the time indicating lines
  Color lineColor;

  /// [TextStyle] of the time and date shown in the sidebar
  TextStyle timeTextStyle;

  /// [Color] of the background of the sidebar
  Color timeBackgroundColor;

  /// [Color] of the background of the dates on the sidebar.
  Color dayTimeBackgroundColor;

  /// [Color] of the line that indicates the current time
  Color currentTimeColor;
  double cardElevation;
  bool rounded;
  double radius;

  CalendarTheme(BuildContext context,
      {this.cardColor,
      this.cardElevation,
      this.lineColor,
      this.timeTextStyle,
      this.timeBackgroundColor,
      this.dayTimeBackgroundColor,
      this.currentTimeColor,
      this.rounded = true,
      this.radius = 8}) {
    var theme = Theme.of(context);
    cardColor = cardColor ?? theme.cardColor;
    cardElevation = cardElevation ?? theme.cardTheme.elevation ?? 2.0;
    lineColor = lineColor ?? theme.dividerColor;
    timeTextStyle = timeTextStyle ?? theme.primaryTextTheme.bodyText1;
    timeBackgroundColor = timeBackgroundColor ?? theme.primaryColor;
    dayTimeBackgroundColor = dayTimeBackgroundColor ?? theme.primaryColor;
    currentTimeColor = currentTimeColor ?? theme.accentColor;
  }
}
