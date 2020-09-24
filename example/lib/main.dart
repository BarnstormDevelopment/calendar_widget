import 'dart:math';

import 'package:calendar_widget/calendar_controller.dart';
import 'package:calendar_widget/models/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:calendar_widget/calendar_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarController calendarController;
  int i;

  @override
  void initState() {
    super.initState();
    // TEST DATA
    var now = DateTime.now();
    now = DateTime(now.year, now.month, now.day, now.hour);
    var start = DateTime(now.year, now.month, now.day);
    var dateTimeRange =
        DateTimeRange(start: start, end: start.add(Duration(days: 2)));
    var events = [
      CalendarEvent(
          id: 0,
          name: 'test1',
          range: DateTimeRange(start: now, end: now.add(Duration(hours: 1)))),
      CalendarEvent(
          id: 1,
          name: 'test2',
          range: DateTimeRange(
              start: now.add(Duration(hours: 1)),
              end: now.add(Duration(hours: 2)))),
      CalendarEvent(
          id: 2,
          name: 'test3',
          range: DateTimeRange(
              start: now.add(Duration(hours: 3)),
              end: now.add(Duration(hours: 6)))),
      CalendarEvent(
          id: 3,
          name: 'test4',
          range: DateTimeRange(
              start: now.add(Duration(hours: 1)),
              end: now.add(Duration(hours: 4)))),
      CalendarEvent(
          id: 4,
          name: 'test5',
          range: DateTimeRange(
              start: now.add(Duration(hours: 8)),
              end: now.add(Duration(hours: 16))))
    ];
    i = 5;
    // END TEST DATA
    calendarController = CalendarController(dateTimeRange, events: events);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: CalendarWidget(calendarController,
          builder: (BuildContext context, CalendarEvent event) {
        CalendarProvider provider = CalendarProvider.of(context);
        CalendarController controller = provider.controller;
        CalendarTheme theme = provider.theme;
        return Container(
            padding: EdgeInsets.all(2.0),
            width: controller.itemWidth,
            height: event.range.duration.inHours * controller.interval,
            child: Material(
                elevation: theme.cardElevation,
                borderRadius: BorderRadius.circular(8.0),
                color: theme.cardColor,
                child: InkWell(
                    child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(event.name)))));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Random random = Random();
          var min = random.nextInt(8);
          var now = DateTime.now();
          now = DateTime(now.year, now.month, now.day, now.hour);
          calendarController.removeEvent(i - 1);
          calendarController.addEvent(CalendarEvent(
              id: i,
              name: 'test',
              range: DateTimeRange(
                  start: now.add(Duration(hours: min)),
                  end: now.add(Duration(hours: min + 2)))));
          i++;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
