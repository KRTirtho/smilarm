import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide NotificationVisibility;

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/app.dart';
import 'package:smilarm/pages/alarm/alarm.dart';
import 'package:smilarm/providers/alarm/model.dart';
import 'package:smilarm/stores/kv/kv.dart';

const mainIsolatePortName = 'mainIsolate';
const alarmIsolatePortName = 'alarmIsolate';

@pragma('vm:entry-point')
void fireAlarm(int processId, Map<String, dynamic> rawData) async {
  print('Alarm fired');

  await KVStore.initialize();

  final audioPlayer = AudioPlayer();

  final receivePort = ReceivePort();
  IsolateNameServer.registerPortWithName(
    receivePort.sendPort,
    alarmIsolatePortName,
  );

  final mainIsolateSendPort =
      IsolateNameServer.lookupPortByName(mainIsolatePortName);

  await audioPlayer.setReleaseMode(ReleaseMode.loop);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'com.example.smilarm.channel',
    'Smilarm Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    showBadge: true,
    enableVibration: true,
    playSound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // config
  final alarm = AlarmConfig.fromJson(rawData);
  const androidNotificationDetails = AndroidNotificationDetails(
    'smilarm_id_1',
    'com.example.smilarm.channel',
    channelDescription: 'Stupid Channel',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    fullScreenIntent: true,
    actions: [
      AndroidNotificationAction(
        "dismiss",
        "Dismiss",
      ),
    ],
  );

  await audioPlayer.play(
    AssetSource('spiderman.mp3'),
  );

  KVStore.setRinging(true);

  await flutterLocalNotificationsPlugin.show(
    alarm.id,
    alarm.name,
    alarm.message,
    const NotificationDetails(android: androidNotificationDetails),
    payload: jsonEncode(rawData), // to stop the alarm from playing sounds
  );

  mainIsolateSendPort?.send("ringing");

  receivePort.listen((v) {
    if (v == "stop") {
      audioPlayer.stop();
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KVStore.initialize();

  await AndroidAlarmManager.initialize();

  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  final receivePort = ReceivePort();
  IsolateNameServer.registerPortWithName(
    receivePort.sendPort,
    mainIsolatePortName,
  );

  receivePort.listen((message) {
    FlutterOverlayWindow.showOverlay();
  });

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

@pragma("vm:entry-point")
void overlayMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KVStore.initialize();

  // ignore: missing_provider_scope
  runApp(
    const CupertinoApp(
      debugShowCheckedModeBanner: true,
      title: "Wake up!",
      home: AlarmPage(),
    ),
  );
}
