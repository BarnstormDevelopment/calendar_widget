import 'package:calendar_widget/ui/calendar_theme.dart';
import 'package:flutter/material.dart';
import '../calendar_controller.dart';
import 'calendar_provider.dart';

class LinePainter extends CustomPainter {
  final BuildContext context;
  CalendarController get controller => CalendarProvider.of(context).controller;
  CalendarTheme get theme => CalendarProvider.of(context).theme;
  LinePainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    double y = 0;
    for (var i = 0; i < controller.range.duration.inHours; i++) {
      y += controller.interval;
      // Line
      final paint = Paint()
        ..color = theme.lineColor
        ..strokeWidth = 1;
      final linePaint = Paint()
        ..color = theme.lineColor.withAlpha(12)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(controller.margin, y),
          Offset(size.width - controller.getTimeWidth(mult: 2.3), y), paint);
      if (controller.scale <= 12)
        canvas.drawLine(
            Offset(controller.margin, y + controller.interval / 2),
            Offset(size.width - controller.getTimeWidth(mult: 2.3),
                y + controller.interval / 2),
            linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurrentTimePainter extends CustomPainter {
  final BuildContext context;
  CalendarController get controller => CalendarProvider.of(context).controller;
  CalendarTheme get theme => CalendarProvider.of(context).theme;

  CurrentTimePainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    var now = DateTime.now();
    if (controller.showCurrentTime &&
        now.isAfter(controller.range.start) &&
        now.isBefore(controller.range.end)) {
      var range = DateTimeRange(end: now, start: controller.range.start);
      final linePaint = Paint()
        ..color = theme.currentTimeColor
        ..strokeWidth = 1;
      var y = controller.interval * (range.duration.inMinutes / 60);
      canvas.drawLine(
          Offset(controller.margin, y),
          Offset(size.width - controller.getTimeWidth(mult: 2.3), y),
          linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TimePainter extends CustomPainter {
  final BuildContext context;
  CalendarController get controller => CalendarProvider.of(context).controller;
  CalendarTheme get theme => CalendarProvider.of(context).theme;

  TimePainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    var now = DateTime.now();
    if (controller.showCurrentTime &&
        now.isAfter(controller.range.start) &&
        now.isBefore(controller.range.end)) {
      var range = DateTimeRange(end: now, start: controller.range.start);
      final linePaint = Paint()
        ..color = theme.currentTimeColor
        ..strokeWidth = 1;
      var y = controller.interval * (range.duration.inMinutes / 60);
      canvas.drawLine(
          Offset(controller.margin, y),
          Offset(size.width - controller.getTimeWidth(mult: 2.3), y),
          linePaint);
    }
    double y = 0;

    var backgroundPaint = Paint()
      ..color = theme.timeBackgroundColor
      ..style = PaintingStyle.fill;
    var selectedBackgroundPaint = Paint()
      ..color = theme.dayTimeBackgroundColor
      ..style = PaintingStyle.fill;
    var basex = size.width - controller.getTimeWidth(mult: 2.8);
    var side = Path()
      ..moveTo(basex, 0)
      ..lineTo(basex, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(basex, 0);
    var mask = theme.rounded
        ? (Path()
          ..addRRect(RRect.fromLTRBR(
              0,
              0,
              size.width - controller.getTimeWidth(),
              size.height,
              Radius.circular(theme.radius))))
        : (Path()
          ..addRect(Rect.fromLTRB(
            0,
            0,
            size.width - controller.getTimeWidth(),
            size.height,
          )));
    side = Path.combine(PathOperation.difference, side, mask);
    canvas.drawPath(side, backgroundPaint);
    for (var i = 0; i < controller.range.duration.inHours; i++) {
      y += controller.interval;

      // Text
      final date = controller.range.start.add(Duration(hours: i));
      final textSpan = TextSpan(
        text: date.hour == 0
            ? controller.dayFormatter.format(date)
            : controller.timeFormatter.format(date),
        style: theme.timeTextStyle,
      );
      final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right);
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      if (date.hour == 0) {
        final RRect borderRect = RRect.fromLTRBR(
            size.width - (textPainter.width + controller.margin / 2),
            y - textPainter.height,
            size.width,
            y + textPainter.height,
            Radius.circular(8));
        canvas.drawPath(Path()..addRRect(borderRect), selectedBackgroundPaint);
      }
      var offset = Offset(
          size.width - (textPainter.width + controller.margin / 4),
          y - (textPainter.height / 2));

      textPainter.textAlign = TextAlign.right;
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
