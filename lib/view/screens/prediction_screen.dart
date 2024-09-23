import 'package:flutter/material.dart';
import '../widgets/bottom_text.dart';
import '../widgets/image_view.dart';
import '../widgets/skintype_text.dart';

class PredictionScreen extends StatefulWidget {
  final String imagePath;
  final List? predictionResult;

  const PredictionScreen({
    super.key,
    required this.imagePath,
    required this.predictionResult,
  });
  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String predictedSkinType = widget.predictionResult?[0]['label'];
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  right: 20), // Adjust the right margin as needed
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/home");
                  dispose();
                },
              ),
            ),
          ],
          leading: GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, "/camera");
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
        body: Scaffold(
          backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
          body: Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: [
                ImageView(imagePath: widget.imagePath),
                SkinTypeText(skin: predictedSkinType, type: "Skin Type"),
                BottomText(
                  predictedSkinType: predictedSkinType,
                  predictions: widget.predictionResult,
                ),
              ],
            ),
          ),
        ));
  }
}
