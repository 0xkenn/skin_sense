import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract interface class ICameraController {
  Future<void> initialize();
  Future<XFile?> takePicture();
  Widget getCameraPreview();
  void rotateCamera();
  void dispose();
  CameraLensDirection get currentDirection;
}

class CameraControllerClass implements ICameraController {
  late CameraController _cameraController;
  CameraLensDirection _direction = CameraLensDirection.back;
  final Logger _logger = Logger(printer: LogfmtPrinter());

  @override
  CameraLensDirection get currentDirection => _direction;

  @override
  Future<void> rotateCamera() async {
    try {
      _direction = _direction == CameraLensDirection.front
          ? CameraLensDirection.back
          : CameraLensDirection.front;
      await initialize(); // Re-initialize the camera with the new direction
    } catch (e) {
      _logger.e('Error rotating camera: $e');
      rethrow; // Rethrow to catch elsewhere if needed
    }
  }

  @override
  Future<void> initialize() async {
    try {
      final cameras = await availableCameras();
      final camera =
          cameras.firstWhere((camera) => camera.lensDirection == _direction);

      _cameraController = CameraController(
        camera,
        ResolutionPreset.ultraHigh,
        enableAudio: false,
      );

      await _cameraController.initialize();
    } catch (e) {
      _logger.e('Error initializing camera: $e');
      rethrow; // Rethrow to allow higher-level error handling
    }
  }

  @override
  Future<XFile?> takePicture() async {
    if (_cameraController.value.isInitialized) {
      try {
        return await _cameraController.takePicture();
      } catch (e) {
        _logger.e('Error taking picture: $e');
        return null; // Handle failure and return null
      }
    } else {
      _logger.e('Camera not initialized');
      return null;
    }
  }

  @override
  Widget getCameraPreview() {
    if (!_cameraController.value.isInitialized) {
      return const Center(
          child: CircularProgressIndicator()); // Display loading indicator
    }

    final isFrontCamera = _direction == CameraLensDirection.front;
    return Center(
      child: SizedBox(
        width: 400, // Larger preview
        height: 600,
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
    _logger.i('Camera disposed');
  }
}
