import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

FaceDetector useFaceDetector({
  required FaceDetectorOptions options,
}) {
  return use(
    UseFaceDetector(
      options: options,
    ),
  );
}

class UseFaceDetector extends Hook<FaceDetector> {
  final FaceDetectorOptions options;
  const UseFaceDetector({super.keys, required this.options});

  @override
  HookState<FaceDetector, UseFaceDetector> createState() =>
      _UseFaceDetectorState();
}

class _UseFaceDetectorState extends HookState<FaceDetector, UseFaceDetector> {
  late FaceDetector _faceDetector;

  void init() {
    _faceDetector = FaceDetector(
      options: hook.options,
    );
  }

  @override
  void initHook() {
    super.initHook();
    init();
  }

  @override
  void didUpdateHook(UseFaceDetector oldHook) {
    if (hook.options.enableClassification !=
            oldHook.options.enableClassification ||
        hook.options.enableContours != oldHook.options.enableContours ||
        hook.options.enableLandmarks != oldHook.options.enableLandmarks ||
        hook.options.enableTracking != oldHook.options.enableTracking ||
        hook.options.minFaceSize != oldHook.options.minFaceSize ||
        hook.options.performanceMode != oldHook.options.performanceMode) {
      _faceDetector.close();
      init();
    }
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return _faceDetector;
  }
}
