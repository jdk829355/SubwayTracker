import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subwaytracker/stationPicker.dart';
import 'firebase_options.dart';
import 'traindatacontroller.dart';
import 'navigationBar.dart';
import 'navigationBar.dart';
import 'informationPanel.dart';
import 'scannedPage.dart';
import 'mainpage.dart';
import 'local_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotification().initLocalNotificationPlugin();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomeWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: "SubwayTracker",
            home: MainPage(),
            theme: ThemeData(
                backgroundColor: Colors.white, primarySwatch: Colors.blue),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Loading")),
    );
  }
}

class SomeWentWrong extends StatelessWidget {
  const SomeWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Error")),
    );
  }
}
