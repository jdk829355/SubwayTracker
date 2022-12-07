import 'package:flutter_local_notifications/flutter_local_notifications.dart';

LocalNotification localNotification = LocalNotification();

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initLocalNotificationPlugin() async {
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);
    final InitializationSettings initializationSettings =
        InitializationSettings(iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void requestPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> sampleNotification(station) async {
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(iOS: DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.show(
        0, '${station}역에 도착했습니다.', "하차할 시간입니다!", platformChannelSpecifics,
        payload: 'item x');
  }
}
