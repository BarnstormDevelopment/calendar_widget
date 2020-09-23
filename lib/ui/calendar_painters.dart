import 'package:calendar_widget/ui/calendar_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
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
      canvas.drawLine(Offset(controller.margin, y),
          Offset(size.width - controller.getTimeWidth(mult: 2.3), y), paint);
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
    side = Path.combine(
        PathOperation.difference,
        side,
        Path()
          ..addRRect(RRect.fromLTRBR(
              0,
              0,
              size.width - controller.getTimeWidth(),
              size.height,
              Radius.circular(16))));
    canvas.drawPath(side, backgroundPaint);
    for (var i = 0; i < controller.range.duration.inHours; i++) {
      y += controller.interval;

      // Text
      final date = controller.range.start.add(Duration(hours: i));
      final textSpan = TextSpan(
        text: date.hour == 0
            ? intl.DateFormat.MEd().format(date)
            : intl.DateFormat.Hm().format(date),
        style: theme.timeTextStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      if (date.hour == 0) {
        final RRect borderRect = RRect.fromLTRBR(
            size.width - controller.margin * 3.2,
            y - textPainter.height,
            size.width,
            y + textPainter.height,
            Radius.circular(8));
        canvas.drawPath(Path()..addRRect(borderRect), selectedBackgroundPaint);
      }
      var offset = date.hour == 0
          ? Offset(
              size.width - controller.margin * 3, y - (textPainter.height / 2))
          : Offset(
              size.width - controller.margin * 2, y - (textPainter.height / 2));

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
