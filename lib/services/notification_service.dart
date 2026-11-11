// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin _notifications =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     tz.initializeTimeZones();

//     const settings = InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(
//         requestAlertPermission: false,
//         requestBadgePermission: false,
//         requestSoundPermission: false,
//       ),
//     );

//     await _notifications.initialize(settings: settings);
//   }

//   Future<bool> requestPermission() async {
//     final android = _notifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >();

//     if (android != null) {
//       final granted = await android.requestNotificationsPermission();
//       return granted ?? true;
//     }

//     final ios = _notifications
//         .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin
//         >();

//     if (ios != null) {
//       final granted = await ios.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );

//       return granted ?? false;
//     }

//     return false;
//   }

//   Future<void> checkPendingNotifications() async {
//     final pending = await _notifications.pendingNotificationRequests();

//     debugPrint('PENDING NOTIFICATIONS: ${pending.length}');

//     for (final notification in pending) {
//       debugPrint(
//         'ID: ${notification.id}, '
//         'Title: ${notification.title}',
//       );
//     }
//   }

//   Future<bool> requestNotificationPermission() async {
//     final android = _notifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >();

//     if (android == null) return false;

//     final result = await android.requestNotificationsPermission();

//     if (result != null) return result;

//     return await android.areNotificationsEnabled() ?? false;
//   }

//   Future<bool> requestExactAlarmPermission() async {
//     final android = _notifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >();

//     if (android == null) return false;

//     final canSchedule = await android.canScheduleExactNotifications();

//     if (canSchedule == true) return true;

//     final granted = await android.requestExactAlarmsPermission();

//     return granted ?? false;
//   }

//   Future<void> checkNotificationPermissions() async {
//     final android = _notifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >();

//     if (android == null) return;

//     final notificationsEnabled = await android.areNotificationsEnabled();

//     final exactAlarmAllowed = await android.canScheduleExactNotifications();

//     debugPrint('NOTIFICATIONS ENABLED: $notificationsEnabled');
//     debugPrint('EXACT ALARM ALLOWED: $exactAlarmAllowed');
//   }

//   Future<void> scheduleTestNotification() async {
//     final karachi = tz.getLocation('Asia/Karachi');

//     final scheduledDate = tz.TZDateTime.now(karachi)
//         .add(const Duration(minutes: 2));

//     const notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'waqt_test_channel',
//         'Waqt Test Notifications',
//         channelDescription: 'Testing scheduled prayer notifications',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );

//     await _notifications.zonedSchedule(
//       id: 9999,
//       title: 'Waqt notification test',
//       body: 'Your scheduled local notifications are working!',
//       scheduledDate: scheduledDate,
//       notificationDetails: notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );

//     debugPrint('Test notification scheduled for $scheduledDate');
//     await checkNotificationPermissions();
//     await checkPendingNotifications();
//   }
// }
