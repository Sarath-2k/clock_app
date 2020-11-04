import 'package:clock_app/add_alarm.dart';
import 'package:clock_app/11.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView.builder(
            itemCount: alarmcount,
            itemBuilder: (BuildContext context, int count) => ListTile(
                  leading: Text(
                    alarmlist[count].time.toString(),
                    style: TextStyle(color: Color(0xff65D1BA)),
                  ),
                )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(400)),
                  elevation: 16,
                  child: Container(
                    height: 400.0,
                    width: 360.0,
                    child: AddAlarm(),
                  ));
            },
          );
        },
        backgroundColor: Color(0xff65D1BA),
        child: Icon(
          Icons.add,
          size: 20.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
