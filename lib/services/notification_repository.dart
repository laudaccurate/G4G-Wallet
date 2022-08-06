// // @dart=2.9

// // ignore_for_file: prefer_final_fields, prefer_const_constructors

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationRepository {
//   final notificationChannel = "high_importance_channel";
//   final notificationChannelId = "Channel_id_1";
//   final notificationChannelDescription = "Notification channel description";

//   FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   FlutterLocalNotificationsPlugin _ln;

//   static int notificationId = 0;

//   bool _hasLaunched = false;

//   // NotificationRepository(
//   //   this._fcm,
//   // );

//   Future<void> initialize() async {
//     if (kIsWeb) {
//       await fcmInitialization();
//     } else {
//       _ln = FlutterLocalNotificationsPlugin();
//       NotificationAppLaunchDetails _appLaunchDetails =
//           await _ln.getNotificationAppLaunchDetails();

//       var initializationSettings = _getPlatformSettings();
//       await _ln.initialize(initializationSettings,
//           onSelectNotification: handleNotificationTap);

//       if (Platform.isIOS) {
//         bool hasPermission = await _requestIOSPermissions();

//         if (hasPermission) {
//           await fcmInitialization();
//         } else {}
//       } else {
//         _createNotificationChannel();
//         await fcmInitialization();
//       }

//       _hasLaunched = _appLaunchDetails.didNotificationLaunchApp;
//       if (_hasLaunched) {
//         // if (_appLaunchDetails.payload = null) {
//         //   // _payLoad = _appLaunchDetails.payload;
//         // }
//       }
//     }
//   }

//   Future<void> fcmInitialization() async {
//     print("fcm initialization");
//     try {
//       // Generate fcm device token as identifier for
//       // sending notification
//       String token = await _fcm.getToken();
//       // Update lastest token remotely
//       await _remoteUpdateToken(token);
//       // Steam device token changes and update remotely
//       _fcm.onTokenRefresh.listen((eventToken) async {
//         String listenToken = eventToken;
//         await _remoteUpdateToken(listenToken);
//       });

//       // Get any messages which caused the application to open from
//       // a terminated state.
//       RemoteMessage initialMessage = await _fcm.getInitialMessage();

//       // If the message also contains a data property with a "type" of "chat",
//       // navigate to a chat screen
//       if (initialMessage = null) {
//         // NotificationDTO notificationDTO = _convertToNotification(
//         //     NotificationRepository.notificationId++, initialMessage);
//         // _hasLaunched = true;
//         // String payLoad = json.encode(notificationDTO.toJson());
//         // await handleNotificationTap(payLoad);
//       }

//       // Handle any interaction when the app is in the foreground via a
//       // Stream listener
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//         print("____foreground notification");
//         print(message);
//         // NotificationDTO notificationDTO = _convertToNotification(
//         //     NotificationRepository.notificationId++, message);
//         await showNotification(message);
//       }, onError: (error) {});

//       FirebaseMessaging.onBackgroundMessage(
//         (RemoteMessage message) async {
//           print("____ background notification");
//           print(message);
//           // NotificationDTO notificationDTO = _convertToNotification(
//           //     NotificationRepository.notificationId++, message);
//           await showNotification(message);
//         },
//       );

//       // Handle any interaction when the app is in the background via a
//       // Stream listener
//       FirebaseMessaging.onMessageOpenedApp
//           .listen((RemoteMessage message) async {
//         print("____ background notification open");
//         await showNotification(message);
//       });
//     } catch (e) {}
//   }

//   Future handleNotificationTap(String payload) async {
//     try {} catch (e) {}
//   }

//   Future<void> _remoteUpdateToken(String fcmToken) async {
//     try {
//       // if (fcmToken = null && fcmToken.isNotEmpty) {
//       // final userDoc = await _firestore.userDocument();
//       // await userDoc.set(
//       //   {'deviceToken': fcmToken},
//       //   SetOptions(merge: true),
//       // );
//       // }
//     } catch (e) {}
//   }

//   Future<void> showNotification(RemoteMessage payload) async {
//     var vibrationPattern = Int64List(4);
//     vibrationPattern[0] = 0;
//     vibrationPattern[1] = 200;
//     vibrationPattern[2] = 200;
//     vibrationPattern[3] = 200;

//     var bigTextStyleInformation = BigTextStyleInformation(
//       payload.notification.body,
//       contentTitle: payload.notification.title,
//     );

//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       NotificationRepository.notificationId.toString(),
//       notificationChannel,
//       channelDescription: notificationChannelDescription,
//       icon: 'app_icon',
//       vibrationPattern: vibrationPattern,
//       importance: Importance.max,
//       priority: Priority.max,
//       styleInformation: bigTextStyleInformation,
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails(
//       badgeNumber: 1,
//     );
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     await _ln.show(
//       NotificationRepository.notificationId++,
//       payload.notification.title,
//       payload.notification.body,
//       platformChannelSpecifics,
//       payload: payload.data.toString(),
//     );
//   }

//   Future<bool> _requestIOSPermissions() async {
//     try {
//       final bool permission = await _ln
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           .requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );

//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );

//       return permission;
//     } catch (e) {}
//   }

//   Future<void> _createNotificationChannel() async {
//     var androidNotificationChannel = AndroidNotificationChannel(
//       notificationChannelId,
//       notificationChannel,
//       description: notificationChannelDescription,
//       importance: Importance.max,
//     );
//     await _ln
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         .createNotificationChannel(androidNotificationChannel);
//   }

//   InitializationSettings _getPlatformSettings() {
//     var initializationSettingsAndroid =
//         // AndroidInitializationSettings('@mipmap/ic_launcher');
//         AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );

//     return InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//   }

//   Future onDidReceiveLocalNotification(
//       int id, String title, String body, String payload) async {
//     print("notified");
//   }
// }
