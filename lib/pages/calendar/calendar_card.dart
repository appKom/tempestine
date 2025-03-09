import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '/core/models/event_model.dart';
import '/theme/theme.dart';

// Constants
const List<String> NORWEGIAN_MONTHS = [
  'Januar',
  'Februar',
  'Mars',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Desember'
];

const List<String> NORWEGIAN_WEEKDAYS = ['Man', 'Tir', 'Ons', 'Tor', 'Fre', 'Lør', 'Søn'];

// Utility function
bool isEventOnDay(EventModel event, DateTime day) {
  final startDate = DateTime.parse(event.startDate).toLocal();
  final endDate = DateTime.parse(event.endDate).toLocal();
  final comparisonDayStart = DateTime(day.year, day.month, day.day);
  final comparisonDayEnd = DateTime(day.year, day.month, day.day, 23, 59, 59);

  return (startDate.isAtSameMomentAs(comparisonDayStart) || startDate.isBefore(comparisonDayEnd)) &&
      (endDate.isAtSameMomentAs(comparisonDayStart) || endDate.isAfter(comparisonDayStart));
}

class CalendarCard extends StatefulWidget {
  final List<EventModel> upcomingEvents;
  final List<EventModel> pastEvents;

  const CalendarCard({super.key, required this.upcomingEvents, required this.pastEvents});

  @override
  CalendarCardState createState() => CalendarCardState();
}

class CalendarCardState extends State<CalendarCard> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<EventModel> _getEventsForDay(DateTime day) {
    List<EventModel> selectedEvents = [];

    selectedEvents.addAll(widget.upcomingEvents.where((event) => isEventOnDay(event, day)));
    selectedEvents.addAll(widget.pastEvents.where((event) => isEventOnDay(event, day)));

    return selectedEvents;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });

    List<EventModel> eventsForSelectedDay = _getEventsForDay(selectedDay);
    if (eventsForSelectedDay.isNotEmpty) {
      final event = eventsForSelectedDay.first;
      context.go('/calendar/event/${event.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = OnlineTheme.current;

    return Column(
      children: [
        _buildCalendarHeader(),
        buildWeekdayHeader(),
        _buildCalendar(theme),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day);
              });
            },
          ),
          Text('${NORWEGIAN_MONTHS[_focusedDay.month - 1]} ${_focusedDay.year}',
              style: OnlineTheme.textStyle(size: 16, color: OnlineTheme.current.fg)),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day);
              });
            },
          ),
        ],
      ),
    );
  }

  static Widget buildWeekdayHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: NORWEGIAN_WEEKDAYS
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: OnlineTheme.textStyle(),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendar(ThemeConfig theme) {
    return TableCalendar(
      headerVisible: false,
      daysOfWeekVisible: false,
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {CalendarFormat.month: ''},
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      focusedDay: _focusedDay,
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: _onDaySelected,
      eventLoader: _getEventsForDay,
      calendarBuilders: _buildCalendarBuilders(theme),
      calendarStyle: _buildCalendarStyle(theme),
      headerStyle: _buildHeaderStyle(theme),
      daysOfWeekStyle: _buildDaysOfWeekStyle(theme),
    );
  }

  CalendarBuilders _buildCalendarBuilders(ThemeConfig theme) {
    return CalendarBuilders(
      selectedBuilder: (context, date, focusedDay) => _buildSelectedDay(date, theme),
      defaultBuilder: (context, date, _) => _buildDefaultDay(date, theme),
    );
  }

  Widget _buildSelectedDay(DateTime date, ThemeConfig theme) {
    final eventful = _getEventsForDay(date).isNotEmpty;
    return Container(
      margin: const EdgeInsets.all(2.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: eventful ? theme.posBg : theme.card,
        shape: BoxShape.rectangle,
        border: Border.fromBorderSide(
          BorderSide(color: eventful ? theme.pos : theme.fg),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        date.day.toString(),
        style: OnlineTheme.textStyle(weight: 5),
      ),
    );
  }

  Widget _buildDefaultDay(DateTime date, ThemeConfig theme) {
    final events = _getEventsForDay(date);

    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: events.isNotEmpty ? theme.posBg : theme.card,
        shape: BoxShape.rectangle,
        border: events.isNotEmpty ? Border.all(color: theme.pos) : null,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        date.day.toString(),
        style: OnlineTheme.textStyle(weight: events.isNotEmpty ? 5 : 4),
      ),
    );
  }

  CalendarStyle _buildCalendarStyle(ThemeConfig theme) {
    return CalendarStyle(
      todayDecoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: theme.border,
        border: Border.fromBorderSide(BorderSide(color: theme.muted)),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      markerDecoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      selectedDecoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.fromBorderSide(BorderSide(color: theme.fg)),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
    );
  }

  HeaderStyle _buildHeaderStyle(ThemeConfig theme) {
    return HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      leftChevronIcon: Icon(LucideIcons.chevron_left, color: theme.fg),
      rightChevronIcon: Icon(LucideIcons.chevron_right, color: theme.fg),
      titleTextStyle: TextStyle(color: theme.fg),
    );
  }

  DaysOfWeekStyle _buildDaysOfWeekStyle(ThemeConfig theme) {
    return DaysOfWeekStyle(
      weekendStyle: TextStyle(color: theme.fg),
      weekdayStyle: TextStyle(color: theme.fg),
    );
  }
}
