import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

CameraController useCameraController(
  CameraDescription description,
  ResolutionPreset resolutionPreset, {
  bool enableAudio = true,
  ImageFormatGroup? imageFormatGroup,
}) {
  return use(
    UseCameraController(
      description,
      resolutionPreset,
      enableAudio: enableAudio,
      imageFormatGroup: imageFormatGroup,
    ),
  );
}

class UseCameraController extends Hook<CameraController> {
  final ResolutionPreset resolutionPreset;
  final bool enableAudio;
  final ImageFormatGroup? imageFormatGroup;
  final CameraDescription description;

  const UseCameraController(
    this.description,
    this.resolutionPreset, {
    this.enableAudio = true,
    this.imageFormatGroup,
    super.keys,
  });

  @override
  HookState<CameraController, UseCameraController> createState() =>
      _UseCameraControllerState();
}

class _UseCameraControllerState
    extends HookState<CameraController, UseCameraController> {
  late CameraController controller;

  void _init() async {
    controller = CameraController(
      hook.description,
      hook.resolutionPreset,
      enableAudio: hook.enableAudio,
      imageFormatGroup: hook.imageFormatGroup,
    );

    await controller.initialize();
    setState(() {});
  }

  @override
  void initHook() {
    super.initHook();
    _init();
  }

  @override
  void didUpdateHook(UseCameraController oldHook) {
    if (hook.description != oldHook.description ||
        hook.resolutionPreset != oldHook.resolutionPreset ||
        hook.enableAudio != oldHook.enableAudio ||
        hook.imageFormatGroup != oldHook.imageFormatGroup) {
      controller.dispose();
      _init();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return controller;
  }
}
