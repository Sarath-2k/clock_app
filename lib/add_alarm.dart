import 'package:clock_app/widgets/circle_day.dart';
import 'package:flutter/material.dart';

class AddAlarm extends StatefulWidget {
  AddAlarm({Key key}) : super(key: key);

  _AddAlarmState createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  TimeOfDay _selectedTime;
  ValueChanged<TimeOfDay> selectTime;

  @override
  void initState() {
    _selectedTime = new TimeOfDay(hour: 12, minute: 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1B2C57),
        appBar: AppBar(
          backgroundColor: Color(0xff1B2C57),
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  new GestureDetector(
                    child: Text(
                      _selectedTime.format(context),
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _selectTime(context);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      circleDay('M', context, false),
                      circleDay('T', context, true),
                      circleDay('W', context, true),
                      circleDay('T', context, true),
                      circleDay('F', context, false),
                      circleDay('S', context, true),
                      circleDay('S', context, false),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FlatButton(
                      color: Theme.of(context).accentColor,
                      child:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      onPressed: () => Navigator.of(context).pop())
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.white,
          child: Icon(
            Icons.delete,
            size: 20.0,
            color: Theme.of(context).accentColor,
          ),
        ));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    setState(() {
      _selectedTime = picked;
    });
  }
}
