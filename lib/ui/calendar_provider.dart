import 'package:calendar_widget/models/calendar_event.dart';
import 'package:flutter/material.dart';

import '../calendar_controller.dart';
import 'calendar_theme.dart';

/// Provides [CalendarController] and [CalendarTheme] to the rest of the
/// calendar widget tree.
class CalendarProvider extends InheritedWidget {
  final Widget Function(BuildContext, CalendarEvent) childBuilder;
  final CalendarController controller;
  final CalendarTheme theme;
  CalendarProvider(
      {@required Widget child,
      @required this.childBuilder,
      @required this.controller,
      @required this.theme,
      Key key})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CalendarProvider oldWidget) {
    return this.theme == oldWidget.theme &&
        this.controller == oldWidget.controller;
  }

  @override
  static CalendarProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CalendarProvider>();
}
