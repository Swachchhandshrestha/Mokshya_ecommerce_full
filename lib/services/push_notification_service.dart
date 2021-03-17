// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging();

//   Future initialise() async {
//     if (Platform.isIOS) {
//       //request permissions if we are on android
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     }

//     _fcm.configure(
//       //called when the app is in the foreground and we receive a push notification
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//       },
//       //called when the app has been closed completely and its opened from the push notification
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//       },
//       //called when the app is in the background and its opened from the push notification
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//     );
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mokshyauser/models/message.dart';

// class PushMessagingExample extends StatefulWidget {
//   @override
//   _PushMessagingExampleState createState() => _PushMessagingExampleState();
// }

// class _PushMessagingExampleState extends State<PushMessagingExample> {
//   String _homeScreenText = "Waiting for token...";
//   String _messageText = "Waiting for message...";

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   @override
//   void initState() {
//     super.initState();
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         setState(() {
//           _messageText = "Push Messaging message: $message";
//         });
//         print("onMessage: $message");
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         setState(() {
//           _messageText = "Push Messaging message: $message";
//         });
//         print("onLaunch: $message");
//       },
//       onResume: (Map<String, dynamic> message) async {
//         setState(() {
//           _messageText = "Push Messaging message: $message";
//         });
//         print("onResume: $message");
//       },
//     );
//     _firebaseMessaging.requestNotificationPermissions(
//         const IosNotificationSettings(sound: true, badge: true, alert: true));
//     _firebaseMessaging.onIosSettingsRegistered
//         .listen((IosNotificationSettings settings) {
//       print("Settings registered: $settings");
//     });
//     _firebaseMessaging.getToken().then((String token) {
//       assert(token != null);
//       setState(() {
//         _homeScreenText = "Push Messaging token: $token";
//       });
//       print(_homeScreenText);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Notification'),
//         ),
//         body: Material(
//           child: Column(
//             children: <Widget>[
//               Center(
//                 child: Text(_homeScreenText),
//               ),
//               Row(children: <Widget>[
//                 Expanded(
//                   child: Text(_messageText),
//                 ),
//               ])
//             ],

//           ),
//         ));
//   }
// }

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  

  @override
  Widget build(BuildContext context) => ListView(
        children: messages.map(buildMessage).toList(),
      );

  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}




