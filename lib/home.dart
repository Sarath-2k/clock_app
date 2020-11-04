import 'dart:async';
import 'package:clock_app/alarmpage.dart';
import 'package:clock_app/shapes_painter.dart';
import 'package:clock_app/stopwatch.dart';
import 'package:clock_app/timer.dart';
import 'package:clock_app/worldtime.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String _timeString;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);

    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    worldtime = DateTime.now();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
      time = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Container(
            padding: EdgeInsets.only(top: 30),
            color: Theme.of(context).primaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).accentColor,
              indicatorWeight: 4.0,
              tabs: [
                Tab(
                  icon: Icon(Icons.access_time),
                  text: 'Clock',
                ),
                Tab(icon: Icon(Icons.alarm), text: 'Alarm'),
                Tab(icon: Icon(Icons.hourglass_empty), text: 'Timer'),
                Tab(icon: Icon(Icons.timer), text: 'Stopwatch'),
              ],
            ),
          ),
        ),
        body: Container(
          // color: Theme.of(context).primaryColor,
          color: Colors.black,
          child: TabBarView(
            controller: _tabController,
            children: [
              //ClockPage
              FlipCard(
                front: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  elevation: 30.0,
                  color: Theme.of(context).primaryColor,
                  // color: Colors.,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CustomPaint(
                            painter:
                                ShapesPainter(timeforclock: DateTime.now()),
                            child: Container(
                              height: 500,
                            ),
                          ),
                        ),
                        Text(
                          _timeString.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // FlatButton.icon(onPressed: null, icon: null, label: null)
                      ],
                    ),
                  ),
                ),
                back: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    color: Colors.white,
                    // color: Theme.of(context).primaryColor,
                    child: Container(
                      child: WorldClock(),
                      // Text("BackSide"),
                    ),
                  ),
                ),
              ),
              //AlarmPage
              AlarmPage(),
              //Timer
              TimerPage(),
              //Stopwatch
              StopWatchPage()
            ],
          ),
        ),
      ),
    );
  }
}

String time;
DateTime worldtime;
String worldtimeString;
DateTime oola;
