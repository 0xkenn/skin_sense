import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await _cameraController.initialize();
    await _modelController.loadModel();
    if (mounted) {
      setState(() {
        _initialized = true;
      });
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
        final CroppedFile croppedImage = await ImageCropperController.cropImage(
            image: img,
            cropAspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9));

        List? prediction = await _modelController.predict(croppedImage.path);

        _navigate(croppedImage.path, prediction);
      } else {
        Get.snackbar('error', 'No image captured. Please try again.');
      }
    } catch (e) {
      Get.snackbar('error', 'Error capturing image $e');
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

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final CroppedFile croppedImage = await ImageCropperController.cropImage(
          image: pickedFile,
          cropAspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9));
      List? prediction = await _modelController.predict(croppedImage.path);
      _navigate(croppedImage.path, prediction);
    } else {
      Get.snackbar('error', 'No image selected.');
    }
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.photo_library_outlined,
                size: 50.0,
                color: Colors.grey,
              ), // Add an icon for the gallery button
              onPressed: _pickImageFromGallery,
              splashColor: Colors.red,
            ),
            IconButton(
              icon: Image.asset('assets/images/capture.png'),
              onPressed: () => predict(),
            ),
            IconButton(
              icon: Image.asset('assets/images/rotate-camera.png'),
              onPressed: () => _cameraController.rotateCamera(),
            ),
          ],
        ),
      ),
    );
  }
}
