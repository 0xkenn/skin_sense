import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract interface class ICameraController {
  Future<void> initialize();
  Future<XFile?> takePicture();
  Widget getCameraPreview();
  void rotateCamera();
  void dispose();
  CameraLensDirection
      get currentDirection; // Add a getter for the current direction
}

class CameraControllerClass implements ICameraController {
  late CameraController _cameraController;
  CameraLensDirection _direction = CameraLensDirection.front;

  @override
  CameraLensDirection get currentDirection =>
      _direction; // Implement the getter

  @override
  Future<void> rotateCamera() async {
    _direction = _direction == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;

    await initialize(); // Ensure to initialize after rotation
  }

  @override
  Future<void> initialize() async {
    try {
      final cameras = await availableCameras();
      final camera =
          cameras.firstWhere((camera) => camera.lensDirection == _direction);

      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController.initialize();
    } catch (e) {
      Logger logger = Logger(printer: LogfmtPrinter());
      logger.e('Error initializing camera: $e');
    }
  }

  @override
  Future<XFile?> takePicture() async {
    if (_cameraController.value.isInitialized) {
      return await _cameraController.takePicture();
    }
    return null;
  }

  @override
  Widget getCameraPreview() {
    final isFrontCamera = _direction == CameraLensDirection.front;

    return Center(
      child: SizedBox(
        width: 400, // Increased width for larger preview
        height: 600, // Increased height for larger preview
        child: Transform(
          alignment: Alignment.center,
          transform:
              isFrontCamera ? Matrix4.rotationY(3.14159) : Matrix4.identity(),
          child: AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: CameraPreview(_cameraController),
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
