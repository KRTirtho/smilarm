import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smilarm/pages/home/home.dart';
import 'package:smilarm/pages/settings/settings.dart';
import 'package:smilarm/pages/root.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: '/',
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
      ],
    );
  },
);
