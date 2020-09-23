library calendar_widget;

import 'package:flutter/material.dart';
import 'calendar_controller.dart';
import 'models/calendar_event.dart';
import 'ui/calendar_provider.dart';
import 'ui/calendar_list.dart';
import 'ui/calendar_theme.dart';

export 'ui/calendar_theme.dart';
export 'ui/calendar_item.dart';
export 'ui/calendar_provider.dart';
export 'calendar_controller.dart';
export 'extensions/date_range_extension.dart';

class CalendarWidget extends StatelessWidget {
  final CalendarController calendarController;
  final CalendarTheme theme;
  final Widget Function(BuildContext, CalendarEvent) builder;
  CalendarWidget(this.calendarController,
      {@required this.builder, Key key, this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      calendarController.constraints = constraints;
      return CalendarProvider(
          child: CalendarList(),
          childBuilder: builder,
          controller: calendarController,
          theme: theme ?? CalendarTheme(context));
    });
  }
}
