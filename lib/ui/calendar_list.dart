import 'dart:math';

import 'package:calendar_widget/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'calendar_provider.dart';
import 'calendar_item.dart';
import 'calendar_painters.dart';

class CalendarList extends StatefulWidget {
  CalendarList({Key key}) : super(key: key);

  @override
  _CalendarListState createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();
  CalendarProvider get provider => CalendarProvider.of(context);
  CalendarController get controller => provider.controller;

  DateTime now;
  double animatedScale;
  double animatedScrollRatio;
  double animatedPoint;
  double hourPivot;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.generateIndices();
    return GestureDetector(
        onScaleStart: (details) {
          animatedScale = controller.scale;
          animatedPoint = details.localFocalPoint.dy;
          var scrollDy = verticalScrollController.position.pixels;

          hourPivot = (animatedPoint + scrollDy) /
              (controller.constraints.maxHeight / controller.scale);
          print(hourPivot.toString());
        },
        onScaleUpdate: (details) {
          var val = animatedScale / details.scale;
          val = max(val, 4);
          val = min(val, 36);
          setState(() {
            controller.scale = val;
          });

          var px =
              hourPivot * (controller.constraints.maxHeight / controller.scale);
          verticalScrollController.jumpTo(px - animatedPoint);
        },
        onScaleEnd: (details) {},
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: verticalScrollController,
            child: Container(
                height: controller.constraints.maxHeight *
                    ((controller.range.duration.inHours + 1) /
                        controller.scale),
                child: Stack(children: [
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: horizontalScrollController,
                      child: Container(
                          width: max(controller.getWidth(),
                              controller.constraints.maxWidth),
                          child: CustomPaint(
                            painter: LinePainter(context),
                            child: Stack(
                              children: controller.events
                                  .map((e) => Positioned(
                                      top: yFromTime(
                                          controller.interval, e.range.start),
                                      left: controller.margin +
                                          (controller.getXIndex(e.id) *
                                              controller.itemWidth),
                                      child: provider.childBuilder(context, e)))
                                  .toList(),
                            ),
                          ))),
                  IgnorePointer(
                    child: CustomPaint(
                        painter: TimePainter(context), child: Container()),
                  )
                ]))));
  }

  double yFromTime(double scale, DateTime time, {DateTime from}) {
    if (from == null) {
      from = controller.range.start;
    }
    var range = DateTimeRange(start: from, end: time);
    var y = scale * range.duration.inHours;
    return y;
  }
}
