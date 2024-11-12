import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_sense/view/widgets/prediction_widgets/bottom_text.dart';
import '../widgets/prediction_widgets/image_view.dart';
import '../widgets/prediction_widgets/skintype_text.dart';

class PredictionScreen extends StatelessWidget {
  final String? imagePath;
  final List? predictionResult;
  const PredictionScreen({
    required this.imagePath,
    required this.predictionResult,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String predictedSkinType = predictionResult?[0]['label'] ?? 'unknown';
    return SafeArea(
      child: Scaffold(
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
                    Get.toNamed('/home');
                  },
                ),
              ),
            ],
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
                )),
          ),
          body: Scaffold(
            backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
            body: Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                children: [
                  ImageView(imagePath: imagePath),
                  SkinTypeText(skin: predictedSkinType, type: "Skin Type"),
                  if (predictedSkinType != 'unknown') ...[
                    BottomText(
                      predictedSkinType: predictedSkinType,
                      predictions: predictionResult,
                    ),
                  ],
                ],
              ),
            ),
          )),
    );
  }
}
