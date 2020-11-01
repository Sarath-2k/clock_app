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
  String key;
  bool locked;
  AlarmTime({this.key, this.locked});
}

List<AlarmTime> alarmlist = [];
