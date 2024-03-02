import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide NotificationVisibility;

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:smilarm/app.dart';
import 'package:smilarm/providers/alarm/model.dart';
import 'package:smilarm/stores/kv/kv.dart';

const mainIsolatePortName = 'mainIsolate';
const alarmIsolatePortName = 'alarmIsolate';

@pragma('vm:entry-point')
void fireAlarm(int processId, Map<String, dynamic> rawData) async {
  print('Alarm fired');

  await KVStore.initialize();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.smilarm.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  final audioPlayer = AudioPlayer();

  final alarmIsolateReceivePort = ReceivePort();
  IsolateNameServer.registerPortWithName(
    alarmIsolateReceivePort.sendPort,
    alarmIsolatePortName,
  );

  final mainIsolateSendPort =
      IsolateNameServer.lookupPortByName(mainIsolatePortName);

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

  KVStore.setAlarmId(alarm.id);

  await flutterLocalNotificationsPlugin.show(
    alarm.id,
    alarm.name,
    alarm.message,
    const NotificationDetails(android: androidNotificationDetails),
  );

  mainIsolateSendPort?.send(jsonEncode(rawData));

  alarmIsolateReceivePort.listen((v) {
    if (v == "stop") {
      audioPlayer.stop();
    }
  });

  await audioPlayer.setAudioSource(
    ProgressiveAudioSource(
      Uri.parse("asset:///assets/spiderman.mp3"),
      tag: const MediaItem(
        id: "alarm",
        title: "Alarm",
      ),
    ),
  );
  await audioPlayer.play();
  await audioPlayer.setLoopMode(LoopMode.one);
}

List<CameraDescription> cameraDescriptions = [];
final mainIsolateReceivePort = ReceivePort();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KVStore.initialize();

  await AndroidAlarmManager.initialize();

  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  IsolateNameServer.registerPortWithName(
    mainIsolateReceivePort.sendPort,
    mainIsolatePortName,
  );

  cameraDescriptions = await availableCameras();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}
