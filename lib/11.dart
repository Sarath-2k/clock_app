import 'package:clock_app/add_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'home.dart';

void main() => runApp(AlarmApp());

class AlarmApp extends StatefulWidget {
  _AlarmAppState createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/add-alarm': (context) => AddAlarm(),
        },
        theme: ThemeData(
            primaryColor: Color(0xFF000000), accentColor: Color(0xff65D1BA)),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

class AlarmTime {
  List days;
  TimeOfDay time;
  AlarmTime({this.days, this.time});
}

List<AlarmTime> alarmlist = [];
int alarmcount = alarmlist.length;

List<String> timeZone = [
  "Greenwich Mean Time",
  "Universal Coordinated Time",
  "European Central Time",
  "Eastern European Time",
  "(Arabic) Egypt Standard Time",
  "Eastern African Time",
  "Middle East Time",
  "Near East Time",
  "Pakistan Lahore Time",
  "India Standard Time",
  "Bangladesh Standard Time",
  "Vietnam Standard Time",
  "China Taiwan Time",
  "Japan Standard Time",
  "Australia Central Time",
  "Australia Eastern Time",
  "Solomon Standard Time",
  "New Zealand Standard Time",
  "Midway Islands Time",
  "Hawaii Standard Time",
  "Alaska Standard Time",
  "Pacific Standard Time",
  "Phoenix Standard Time",
  "Mountain Standard Time",
  "Central Standard Time",
  "Eastern Standard Time",
  "Indiana Eastern Standard Time",
  "Puerto Rico and US Virgin Islands Time",
  "Canada Newfoundland Time",
  "Argentina Standard Time",
  "Brazil Eastern Time",
  "Central African Time",
];
List<int> hour = [
  -5,
  -5,
  -4,
  -3,
  -3,
  -2,
  -2,
  -1,
  0,
  0,
  0,
  1,
  2,
  3,
  4,
  4,
  5,
  6,
  -16,
  -15,
  -14,
  -13,
  -12,
  -12,
  -11,
  0,
  0,
  -1,
  -2,
  -2,
  -2,
  -4,
];
List<int> min = [
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  0,
  -30,
  -30,
  0,
  30,
  30,
  30,
  30,
  0,
  30,
  30,
  30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  0,
  -30,
  -30,
  -30,
];
