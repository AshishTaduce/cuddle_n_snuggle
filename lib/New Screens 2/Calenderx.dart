import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cns/models/event.dart';
import 'package:cns/screens/add_event.dart';
import 'package:cns/services/db_service.dart';
import 'package:cns/util/database_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  // CalendarController _calendarController;
  PageController? _calendarController;
  TextEditingController? _eventController;
  late Map<DateTime, List<EventModel>> _events;
  late final ValueNotifier<List<EventModel>> _selectedEvents;
  SharedPreferences? prefs;
  DbService? dbService;
  DatabaseHelper? databaseHelper;
  bool valueFromAddEvent = false;
  final DateFormat dateFormat = DateFormat("yyyy-mm-dd");

  @override
  void initState() {
    super.initState();
    // _calendarController = PageController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    dbService = DbService();
    databaseHelper = DatabaseHelper();
  }

  Map<DateTime, List<EventModel>> _fromModelToEvent(List<EventModel> events) {
    Map<DateTime, List<EventModel>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date]!.add(event);
    });
    return data;
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });

    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  awaitReturnValueFromAddEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(),
        ));
    setState(() {});
  }

  awaitReturnValueFromAddEventForUpdate(EventModel event) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(
            event: event,
          ),
        ));

    setState(() {
      valueFromAddEvent = result;
    });
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }

  // _reloadPage() async {
  //   print("reload");
  //   Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
  //       PageRouteBuilder(
  //         pageBuilder: (_, __, ___) => CalenderPage(),
  //         transitionDuration: Duration(seconds: 0),
  //       ),(Route<dynamic> route) => false);
  // }

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(valueFromAddEvent.toString()),
      body: FutureBuilder<List<EventModel>>(
          future: databaseHelper!.getTaskList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel>? allEvents = snapshot.data;

              _events = _fromModelToEvent(allEvents!);
            }
            return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.bottomLeft,
                      height: 80,
                      child: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "All",
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(height: 10),
                          Text("Vaccination Reminders", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        eventLoader: (event) {
                          // setState(() {
                          //   _selectedEvents =  _events![event] ?? [];
                          // });

                          return _events[event] ?? [];
                        },
                        calendarFormat: CalendarFormat.month,
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(color: Theme.of(context).primaryColor),
                          selectedDecoration: BoxDecoration(color: Theme.of(context).primaryColor),
                          todayTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
                          weekendTextStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                          outsideDaysVisible: true,
                        ),
                        headerStyle: HeaderStyle(
                            titleCentered: true,
                            formatButtonDecoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            formatButtonTextStyle: TextStyle(color: Colors.white),
                            formatButtonShowsNext: false),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            weekendStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        onPageChanged: (focusedDate) {
                          _focusedDay = focusedDate;
                        },
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDate, focusedDate) {
                          print("Events are: ${_events[dateFormat.format(selectedDate)]} for ${dateFormat.format(selectedDate)}");
                          print("All Events are: $_events");

                          ///TODO: Rewrite this concept.
                          bool temp = _events.keys.toList().any((element) => dateFormat
                              .format
                            (element) == dateFormat.format(selectedDate), );
                          setState(() {
                            _focusedDay = focusedDate;
                            _selectedDay = selectedDate;
                            _selectedEvents.value = (temp ? _events[_events.keys.toList().firstWhere((element) => dateFormat
                                .format
                              (element) == dateFormat.format(selectedDate), )] : [])!;
                          });
                        },
                        calendarBuilders: CalendarBuilders(
                          selectedBuilder: (context, date, events) => Container(
                              margin: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                          holidayBuilder: (context, date, enevts) => Container(
                              margin: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        // : _calendarController,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Upcoming Reminders',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    ..._selectedEvents.value.map((event) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                child: Text(
                              event.time!.format(context),
                              // event.time.toString(),
                              style: TextStyle(fontSize: 16),
                            )),
                            GestureDetector(
                              onTap: () {
                                awaitReturnValueFromAddEventForUpdate(event);
                              },
                              child: Container(
                                key: Key("$valueFromAddEvent"),
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.red[300],
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        event.title,
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        event.description,
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        )))
                  ],
                ));
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            awaitReturnValueFromAddEvent();
          }),
    );
  }
}
