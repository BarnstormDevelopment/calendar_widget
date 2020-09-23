import 'package:flutter/material.dart';

class CalendarTheme {
  Color cardColor;
  Color lineColor;
  TextStyle timeTextStyle;
  Color timeBackgroundColor;
  Color dayTimeBackgroundColor;
  double cardElevation;

  CalendarTheme(
    BuildContext context, {
    this.cardColor,
    this.cardElevation,
    this.lineColor,
    this.timeTextStyle,
    this.timeBackgroundColor,
    this.dayTimeBackgroundColor,
  }) {
    var theme = Theme.of(context);
    cardColor = cardColor ?? theme.cardColor;
    cardElevation = cardElevation ?? theme.cardTheme.elevation ?? 2.0;
    lineColor = lineColor ?? theme.dividerColor;
    timeTextStyle = timeTextStyle ?? theme.primaryTextTheme.bodyText1;
    timeBackgroundColor = timeBackgroundColor ?? theme.primaryColor;
    dayTimeBackgroundColor = dayTimeBackgroundColor ?? theme.primaryColor;
  }
}
