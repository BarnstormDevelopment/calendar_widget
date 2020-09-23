import 'package:calendar_widget/models/calendar_event.dart';
import 'package:calendar_widget/ui/calendar_provider.dart';
import 'package:flutter/material.dart';

import '../calendar_controller.dart';
import 'calendar_theme.dart';

class CalendarItem extends StatefulWidget {
  final CalendarEvent event;
  CalendarItem(this.event, {Key key}) : super(key: key);

  @override
  _CalendarItemState createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  CalendarProvider get provider => CalendarProvider.of(context);
  CalendarController get controller => provider.controller;
  CalendarTheme get theme => provider.theme;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2.0),
        width: controller.itemWidth,
        height: widget.event.range.duration.inHours * controller.interval,
        child: Material(
            elevation: theme.cardElevation,
            borderRadius: BorderRadius.circular(8.0),
            color: theme.cardColor,
            child: InkWell(child: Text(widget.event.name))));
  }
}
