import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/collection/routes.dart';
import 'package:smilarm/providers/preferences/preferences.dart';
import 'package:smilarm/stores/kv/kv.dart';
import 'package:smilarm/utils/hooks/use_disable_battery_optimizations.dart';

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
      if (KVStore.ringing) {
        FlutterOverlayWindow.showOverlay(
          overlayTitle: 'Wake up!',
          overlayContent: 'Bruv wake up!',
        );
      }

      return () {
        FlutterOverlayWindow.closeOverlay();
      };
    }, []);

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

          final hasOverlayPermission =
              await FlutterOverlayWindow.isPermissionGranted();
          if (hasOverlayPermission != true) {
            final granted = await FlutterOverlayWindow.requestPermission();
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
