# Calendar Widget

Customizable calendar widget that is fully customizable.

![](example.gif)

## Example
See the examples directory for a full example app.

## Usage

Adding events to the calendar will require them to subclass the `CalendarEvent` class.

You need to supply a builder function for the `CalendarWidget` to use to draw the events on the screen. You will also need to pass a `CalendarController` which provides persistance of the event list and configuration variables for the calendar. Optionally you can pass a `CalendarTheme` to customize the look of the calendar.

```
CalendarWidget(calendarController,
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
    })
```
