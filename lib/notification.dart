import 'dart:math';

import 'package:flutter/material.dart';

//typedef int say(int a);
//typedef say = int Function(int a);

void main() => runApp(TestNotification());

class TestNotification extends StatefulWidget {
  @override
  _TestNotificationState createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationListener<MyNotification>(
        onNotification: (MyNotification notification) {
          print('receive notification');
          print(notification.count);
          return true;
        },
        child: Scaffold(
          key: _scaffoldState,
          body: RaisedButton(
            onPressed: _sendNotification,
            child: Text('send'),
          ),
        ),
      ),
    );
  }

  void _sendNotification() {
    MyNotification(count: Random().nextInt(100))
        .dispatch(_scaffoldState.currentContext);
  }
}

class MyNotification extends Notification {
  final int count;

  MyNotification({this.count}) {}
}
