import 'dart:async';

import 'package:clock_app/shapes_painter.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/home.dart';
import 'package:intl/intl.dart';

class WorldClock extends StatefulWidget {
  @override
  _WorldClockState createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  @override
  void initState() {
    super.initState();
    worldtime = utc;
    worldtimeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    // utc = DateTime.now();
  }

  void _getTime() {
    final DateTime now = DateTime.now().subtract(change);
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      utcString = formattedDateTime;
      worldtime = utc;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: CustomPaint(
              painter:
                  ShapesPainter(timeforclock: DateTime.now().subtract(change)),
              child: Container(
                height: 400,
              ),
            ),
          ),
          Text(
            utcString,
            style: TextStyle(
              color: Color(0xff65D1BA),
              // color: Colors.black,
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      Divider(
        indent: 50,
        endIndent: 50,
        color: Colors.grey[800],
      ),
      Center(
        child: RaisedButton.icon(
            color: Colors.white,
            elevation: 0,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        width: double.maxFinite,
                        height: 350,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                  child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                    new Text("one"),
                                    new Text("two"),
                                  ]))
                            ]),
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.location_on_outlined,
              color: Color(0xff65D1BA),
            ),
            label: Text(currentlocation)),
      )
    ]));
  }
}

String currentlocation = "UTC";
DateTime utc;
String utcString;
Duration change = Duration(hours: 5, minutes: 30);
