import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:smilarm/pages/alarm/alarm.dart';
import 'package:smilarm/utils/hooks/use_camera_controller.dart';
import 'package:smilarm/utils/hooks/use_face_detector.dart';

class CameraPage extends HookWidget {
  const CameraPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCamera = useState(
      cameraDescriptions.length > 1
          ? cameraDescriptions[1]
          : cameraDescriptions.first,
    );
    final cameraController = useCameraController(
      selectedCamera.value,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    final faceDetector = useFaceDetector(
      options: FaceDetectorOptions(enableClassification: true),
    );

    useEffect(() {
      if (!cameraController.value.isInitialized) return null;
      cameraController.startImageStream(
        (image) async {
          final inputImage = InputImage.fromBytes(
            bytes: image.planes[0].bytes,
            metadata: InputImageMetadata(
              format: InputImageFormat.nv21,
              size: Size(
                image.width.toDouble(),
                image.height.toDouble(),
              ),
              rotation: switch (
                  cameraController.description.sensorOrientation) {
                90 => InputImageRotation.rotation90deg,
                180 => InputImageRotation.rotation180deg,
                270 => InputImageRotation.rotation270deg,
                _ => InputImageRotation.rotation0deg,
              },
              bytesPerRow: image.planes[0].bytesPerRow,
            ),
          );
          final faces = await faceDetector.processImage(inputImage);

          if (faces.any((face) =>
                  face.smilingProbability != null &&
                  face.smilingProbability! > 0.733) &&
              context.mounted) {
            context.pop(true);
          }
        },
      );

      return () {
        cameraController.stopImageStream();
      };
    }, [
      cameraController,
      cameraController.value,
      faceDetector,
    ]);

    return CupertinoPageScaffold(
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(child: CameraPreview(cameraController)),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Text(
                  "Smile to take a dismiss alarm",
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: CupertinoColors.black,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
