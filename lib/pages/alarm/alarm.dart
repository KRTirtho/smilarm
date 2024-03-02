import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:gap/gap.dart';
import 'package:smilarm/main.dart';
import 'package:smilarm/stores/kv/kv.dart';

class AlarmPage extends HookWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      width: mediaQuery.size.width * mediaQuery.devicePixelRatio,
      height: mediaQuery.size.height * mediaQuery.devicePixelRatio,
      child: SafeArea(
        child: CupertinoPopupSurface(
          isSurfacePainted: true,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Bruv wake up!'),
                const Gap(20),
                CupertinoButton(
                  child: const Text('Dismiss'),
                  onPressed: () async {
                    final alarmCbSendPort = IsolateNameServer.lookupPortByName(
                      alarmIsolatePortName,
                    );
                    alarmCbSendPort?.send("stop");
                    await FlutterOverlayWindow.closeOverlay();
                    await KVStore.setRinging(false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
