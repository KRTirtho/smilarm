import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/collection/routes.dart';
import 'package:smilarm/providers/alarm/model.dart';
import 'package:smilarm/providers/preferences/preferences.dart';
import 'package:smilarm/utils/hooks/use_disable_battery_optimizations.dart';

@pragma('vm:entry-point')
void fireAlarm(int processId, Map<String, dynamic> rawData) async {
  print('Alarm fired');

  // Initialize plugins

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
  );

  await flutterLocalNotificationsPlugin.show(
    alarm.id,
    alarm.name,
    'You gotta wake up buddy!!!!',
    const NotificationDetails(android: androidNotificationDetails),
    payload: jsonEncode(rawData), // to stop the alarm from playing sounds
  );

  print('Alarm fired: ${alarm.name}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

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

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(
      preferencesProvider.select((state) => state.themeMode),
    );

    final brightness = switch (themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      _ => MediaQuery.platformBrightnessOf(context),
    };

    useDisableBatteryOptimizations();

    useEffect(() {
      () async {
        if (Platform.isAndroid) {
          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();

          final hasPermission = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.canScheduleExactNotifications();
          if (hasPermission != true) {
            final granted = await flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestNotificationsPermission();
            if (granted != true) {
              exit(0);
            }
          }
        }
      }();
      return null;
    }, []);

    useEffect(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: brightness,
          statusBarIconBrightness: brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        ),
      );

      return null;
    }, [themeMode]);

    return CupertinoApp.router(
      title: 'Smilarm',
      theme: CupertinoThemeData(
        primaryColor: Colors.deepOrange,
        applyThemeToAll: true,
        brightness: brightness,
      ),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
