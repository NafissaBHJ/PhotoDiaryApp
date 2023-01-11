import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart';
import 'package:photo_diary/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  print('-------------------------------------------');

  // initialise the plugin of flutterlocalnotifications.

  Workmanager().executeTask((task, inputData) {
    var flip = NotificationService.initializePlatformNotifications();
    _showNotificationWithDefaultSound(flip);

    return Future.value(true);
  });
}

void _showNotificationWithDefaultSound(
    FlutterLocalNotificationsPlugin flip) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'wcnwncwnxc', 'your channel name',
     
      importance: Importance.high,
      priority: Priority.high);
  var platformChannelSpecifics =
      new NotificationDetails(android: androidPlatformChannelSpecifics);
  await flip.show(0, 'Photo Diary', 'Don\'t forget todays memory !',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}

Future<void> startBackgroundUpdate() async {
  // print('--------------------__________________-----------------------');
  Workmanager().registerPeriodicTask(
    '15',
    'mytask15',
    frequency: const Duration(hours: 24),
  );
  // Workmanager().cancelAll();
}
