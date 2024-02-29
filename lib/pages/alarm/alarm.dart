import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:gap/gap.dart';

class AlarmScreen extends HookWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final player = useMemoized(() => AudioPlayer(), []);

    useEffect(() {
      if (!context.mounted) return null;
      final subscription =
          FlutterOverlayWindow.overlayListener.listen((data) async {
        if (data != "fire") return;
        await player.setReleaseMode(ReleaseMode.loop);
        await player.play(
          AssetSource("spiderman.mp3"),
          volume: 1,
        );
      });
      return () async {
        await player.dispose();
        subscription.cancel();
      };
    }, []);

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
                    await player.stop();
                    await FlutterOverlayWindow.closeOverlay();
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
