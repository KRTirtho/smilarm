import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smilarm/modules/home/create_alarm.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final mediaQuery = MediaQuery.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Smilarm'),
        trailing: CupertinoButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () => showCupertinoModalPopup(
            context: context,
            builder: (context) => SizedBox(
              width: double.infinity,
              height: mediaQuery.size.height,
              child: const CreateAlarmDialog(),
            ),
          ),
        ),
      ),
      child: const SafeArea(
        child: Text('Home'),
      ),
    );
  }
}
