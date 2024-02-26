import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const routes = {
  "/": BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.home),
    label: 'Home',
  ),
  "/settings": BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.settings),
    label: 'Settings',
  ),
};

class RootApp extends HookConsumerWidget {
  final Widget child;

  const RootApp({super.key, required this.child});

  @override
  Widget build(BuildContext context, ref) {
    final routeState = GoRouterState.of(context);

    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(child: child),
          CupertinoTabBar(
            items: routes.values.toList(),
            currentIndex:
                routes.keys.toList().indexOf(routeState.matchedLocation),
            onTap: (index) {
              context.go(routes.keys.toList()[index]);
            },
          ),
        ],
      ),
    );
  }
}
