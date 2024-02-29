import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide NotificationVisibility;

import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/collection/routes.dart';
import 'package:smilarm/pages/alarm/alarm.dart';
import 'package:smilarm/providers/alarm/model.dart';
import 'package:smilarm/providers/preferences/preferences.dart';
import 'package:smilarm/utils/hooks/use_disable_battery_optimizations.dart';

@pragma('vm:entry-point')
void fireAlarm(int processId, Map<String, dynamic> rawData) async {
  print('Alarm fired');

  // Initialize plugins

  final alarm = AlarmConfig.fromJson(rawData);
  print('Alarm fired ${alarm.name}');

  await FlutterOverlayWindow.showOverlay(
    visibility: NotificationVisibility.visibilityPublic,
    overlayTitle: 'Wake up!',
    overlayContent: 'Bruv wake up!',
  );
  await FlutterOverlayWindow.shareData("fire");
}

@pragma("vm:entry-point")
void overlayMain() async {
  // ignore: missing_provider_scope
  runApp(
    const CupertinoApp(
      debugShowCheckedModeBanner: true,
      title: "Wake up!",
      home: AlarmScreen(),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

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

          /// check if overlay permission is granted
          final overlayPermission =
              await FlutterOverlayWindow.isPermissionGranted();

          if (!overlayPermission) {
            final hasGranted = await FlutterOverlayWindow.requestPermission();
            if (hasGranted != true) {
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
