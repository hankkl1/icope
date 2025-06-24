import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class NotiService{
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //INITIALIZE
  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {}
    );
  }

  NotificationDetails notificationDetails(){
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id', 
        'channel_name',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  //show immediate notification
  Future<void> showNotifications({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }


  //schedule a notification at a specified time

  Future scheduleNotification({
    int id = 0,
    required String title,
    required String body,
    required DateTime scheduledDate
  }) async {
    final now = tz.TZDateTime.now(tz.local);


    await notificationsPlugin.zonedSchedule(
      id, 
      title, 
      body, 
      tz.TZDateTime.from(scheduledDate, tz.local), 
      await notificationDetails(), 
      /*
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime, */

      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      //matchDateTimeComponents: DateTimeComponents.time,
    );

    print("Notification Scheduled ${scheduledDate}");
  }

  Future<void> cancelAllNotifications()async {
    await notificationsPlugin.cancelAll();
  }

}
