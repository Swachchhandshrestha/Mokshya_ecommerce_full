import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mokshyauser/services/push_notification_service.dart';
import 'package:mokshyauser/widgets/buttom_nav_all.dart';

class NotiFication extends StatefulWidget {
  @override
  _NotiFicationState createState() => _NotiFicationState();
}

class _NotiFicationState extends State<NotiFication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#660099"),
        title: Text('Notification'),
      ),
      bottomNavigationBar: ButtomNav(),
      body: MessagingWidget(),
    );
  }
}
