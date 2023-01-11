import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();
  static var _localNotifications = FlutterLocalNotificationsPlugin();
  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  final String navigationActionId = 'id_1';

  static FlutterLocalNotificationsPlugin initializePlatformNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      "@drawable/pdiary",
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _localNotifications.initialize(
      initializationSettings,
    );
    return _localNotifications;
  }

  NotificationDetails notifications() {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
    );

    // initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    return platformChannelSpecifics;
  }
}
