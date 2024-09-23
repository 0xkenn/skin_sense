import 'package:flutter/material.dart';
import 'package:skin_sense/controller/camera_controller.dart';
import 'package:skin_sense/controller/model_controller.dart';
import 'package:skin_sense/view/screens/prediction_screen.dart';

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
    // initialize camera and model controllers
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await _cameraController.initialize();
    await _modelController.loadModel();
    setState(() {
      // re render if the value change ;)
      _initialized = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _modelController.dispose();
    _cameraController.dispose();
  }

  Future<void> predict() async {
    var img = await _cameraController.takePicture();
    var prediction = await _modelController.predict(img!.path);
    _navigator(img.path, prediction);
    dispose();
  }

  void _navigator(img, prediction) {
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
              Navigator.popAndPushNamed(context, "/home");
              dispose();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
      ),
      body: _initialized
          ? _cameraController.getCameraPreview(context)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: const Color.fromRGBO(
            248, 237, 221, 1), // Match the background color
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between the buttons
          children: [
            Expanded(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                ),
                child: IconButton(
                  icon: Image.asset('assets/images/capture.png'),
                  onPressed: () => predict(),
                ),
              )),
            ),
            IconButton(
              onPressed: () {
                _cameraController.takePicture();
              },
              icon: Image.asset('assets/images/rotate-camera.png'),
            ),
          ],
        ),
      ),
    );
  }
}
