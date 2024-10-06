import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as imgp;

class UtilsScanner {
  UtilsScanner._();

  static InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      default:
        assert(rotation == 270);
        return InputImageRotation.rotation270deg;
    }
  }

  static Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();

    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static InputImageMetadata buildMetaData(
      imgp.Image? image, InputImageRotation rotation) {
    return InputImageMetadata(
        size: Size(image!.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: InputImageFormat.nv21,
        bytesPerRow: bytesPerRow(image));
  }

// Your function
  static Future<Uint8List> detectContours(File image) async {
    // Convert image to bytes
    final Uint8List imgByte = await image.readAsBytes();
    // Decode image bytes into an image object used for metadata creation
    final imgp.Image? imageObject = imgp.decodeImage(imgByte);

    // Check if imageObject is null
    if (imageObject == null) {
      throw Exception("Failed to decode image.");
    }

    final width = imageObject.width;
    final height = imageObject.height;

    // Create metadata for the image
    final metadata = buildMetaData(imageObject, rotationIntToImageRotation(0));

    // Initialize face detector with contour detection enabled
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );

    try {
      final faces = await faceDetector.processImage(InputImage.fromBytes(
        bytes: imgByte,
        metadata: metadata,
      ));

      // Check if faces were detected
      if (faces.isEmpty) {
        throw Exception("No faces detected in the image.");
      }

      for (final Face face in faces) {
        // Get left cheek contour
        final FaceContour? leftCheekContours =
            face.contours[FaceContourType.leftCheek];

        if (leftCheekContours != null && leftCheekContours.points.isNotEmpty) {
          // Get min/max x and y coordinates of the contour
          final minX =
              leftCheekContours.points.map((point) => point.x).reduce(min);
          final minY =
              leftCheekContours.points.map((point) => point.y).reduce(min);
          final maxX =
              leftCheekContours.points.map((point) => point.x).reduce(max);
          final maxY =
              leftCheekContours.points.map((point) => point.y).reduce(max);

          // Crop the image to the left cheek region
          final croppedImage = imgp.copyCrop(
            imageObject,
            x: minX.clamp(0, width),
            y: minY.clamp(0, height),
            width: (maxX - minX).clamp(0, width),
            height: (maxY - minY).clamp(0, height),
          );
          // Encode the cropped image back to bytes (PNG format)
          final Uint8List croppedImageBytes = imgp.encodePng(croppedImage);

          return croppedImageBytes; // Return the cropped image as Uint8List
        }
      }

      // If no left cheek contour is found, provide an appropriate response
      throw Exception("No left cheek contour detected.");
    } finally {
      // Close the face detector to free up resources
      faceDetector.close();
    }
  }

  static int bytesPerRow(imgp.Image image) {
    return image.width * 3;
  }

  Future<File> imageCropper(File image, x, y, h, w) async {
    return await FlutterNativeImage.cropImage(image.path, x, y, h, w);
    // return await ImageCropper().cropImage(
    //     sourcePath: image.path,
    //     maxHeight: h,
    //     maxWidth: w,
    //     uiSettings: [
    //       AndroidUiSettings(
    //         cropGridColumnCount: x,
    //         cropGridRowCount: y,
    //       )
    //     ]);
  }
}
