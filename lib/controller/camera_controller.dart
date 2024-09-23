import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math; // For the math.pi

abstract interface class ICameraController {
  Future<void> initialize();
  Future<XFile?> takePicture();
  Widget getCameraPreview(context);
  void dispose();
}

class CameraControllerClass implements ICameraController {
  static late CameraController _cameraController;

  @override
  Future<void> initialize() async {
    final cameras = await availableCameras();

    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _cameraController = CameraController(
      backCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
  }

  @override
  Future<XFile?> takePicture() async {
    return await _cameraController.takePicture();
  }

  @override
  Widget getCameraPreview(context) {
    var camera = _cameraController.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio *
        camera
            .aspectRatio; //calculate scale depending on screen and camra ratio

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Transform(
        transform: Matrix4.rotationY(math.pi),
        alignment: Alignment.center,
        child: Container(
          color: Colors.black,
          child: CameraPreview(
            _cameraController,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
  }
}

// FACE DETECTOR 