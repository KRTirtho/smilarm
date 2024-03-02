import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smilarm/pages/alarm/alarm.dart';
import 'package:smilarm/pages/alarm/camera.dart';

import 'package:smilarm/pages/home/home.dart';
import 'package:smilarm/pages/settings/settings.dart';
import 'package:smilarm/pages/root.dart';
import 'package:smilarm/stores/kv/kv.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: KVStore.alarmId != null ? "/alarm" : "/",
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        builder: (context, state, child) => RootApp(child: child),
        navigatorKey: shellNavigatorKey,
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: "/settings",
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: "/alarm",
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AlarmPage(),
        routes: [
          GoRoute(
            path: "camera",
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) => const CameraPage(),
          ),
        ],
      )
    ],
  );
});
