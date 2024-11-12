import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:skin_sense/controller/camera_controller.dart';
import 'package:skin_sense/controller/image_cropper_controller.dart';
import 'package:skin_sense/controller/model_controller.dart';
import 'package:skin_sense/view/screens/prediction_screen.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final IModelController _modelController = ModelController();
  final ICameraController _cameraController = CameraControllerClass();
  final ImageCropperController _imageCropperController =
      ImageCropperController(); // Create an instance
  late FaceDetector faceDetector;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initialize(); // Call your async method without await
  }

  Future<void> initialize() async {
    try {
      // Initialize the face detector once here
      faceDetector = GoogleVision.instance.faceDetector();
      await _cameraController.initialize(); // Initialize camera
      await _modelController.loadModel(); // Load model
      if (mounted) {
        setState(() {
          _initialized = true; // Set initialized to true
        });
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Failed to initialize: $e'); // Handle initialization error
    }
  }

  @override
  void dispose() {
    super.dispose();
    _modelController.dispose();
    _cameraController.dispose();
  }

  Future<void> predict() async {
    try {
      XFile? img = await _cameraController.takePicture();

      if (img != null) {
        final imgFile = File(img.path);
        final GoogleVisionImage visionImage =
            GoogleVisionImage.fromFile(imgFile);
        final List<Face> faces =
            await faceDetector.processImage(visionImage); // Detect faces

        if (faces.isNotEmpty && faces.length == 1) {
          final CroppedFile? croppedImage =
              await _imageCropperController.cropImage(
            // Use the instance
            image: img,
            cropAspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          );

          if (croppedImage != null) {
            final List? prediction =
                await _modelController.predict(croppedImage.path);

            if (prediction != null) {
              _navigate(croppedImage.path, prediction);
            } else {
              Get.snackbar('Error', 'Failed to predict skin type.');
            }
          }
        } else if (faces.length > 1) {
          Get.snackbar('Error',
              'Multiple faces detected. Please take a picture with just one face.');
        } else {
          Get.snackbar(
              'No Face Detected', 'Please take a picture with a visible face.');
        }
      } else {
        Get.snackbar('Error', 'No image captured. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error capturing image: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imgFile = File(pickedFile.path);
      final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(imgFile);

      final List<Face> faces =
          await faceDetector.processImage(visionImage); // Detect faces
      if (faces.isNotEmpty && faces.length == 1) {
        final CroppedFile? croppedImage =
            await _imageCropperController.cropImage(
          // Use the instance
          image: pickedFile,
          cropAspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        );
        if (croppedImage != null) {
          List? prediction = await _modelController.predict(croppedImage.path);
          _navigate(croppedImage.path, prediction);
        }
      } else if (faces.length > 1) {
        Get.snackbar(
            'Error', 'Multiple faces detected. Please select a single face.');
      } else {
        Get.snackbar('Error', 'No face detected. Please select a face.');
      }
    } else {
      Get.snackbar('Oops!', 'No image selected.');
    }
  }

  void _navigate(String? img, List? prediction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PredictionScreen(imagePath: img, predictionResult: prediction),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: _initialized
          ? _cameraController.getCameraPreview()
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomAppBar(
          height: 100,
          color: const Color.fromRGBO(248, 237, 221, 1),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.photo_library_outlined,
                    size: 50.0,
                    color: Colors.grey,
                  ),
                  onPressed: _pickImageFromGallery,
                  splashColor: Colors.red,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset('assets/images/capture.png'),
                  onPressed: () => predict(),
                ),
              ),
            ],
          )),
    );
  }
}
