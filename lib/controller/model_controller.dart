import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skin_sense/controller/history_controller.dart';
import 'package:skin_sense/model/history.dart';
import 'package:tflite_v2/tflite_v2.dart';

abstract interface class IModelController {
  Future<void> loadModel();
  Future<List?> predict(String imagePath);
  void dispose();
}

class ModelController implements IModelController {
  @override
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/model/skin_model.tflite',
        labels: 'assets/model/skin_model.txt',
      );
    } catch (e) {
      if (kDebugMode) {
        print("Failed to load model: $e");
      }
    }
  }

  @override
  Future<List?> predict(String image) async {
    final HistoryController historyController = Get.put(HistoryController());
    try {
      List? output = await Tflite.runModelOnImage(
          path: image, numResults: 4, threshold: 0.0, asynch: true);
//    double accuracy =
      // output != null && output.isNotEmpty ? output[0]['confidence'] : 0.0;

      if (output != null && output.isNotEmpty) {
        if (output[0]['label'] == 'dry' &&
            output[1]['label'] == 'oily' &&
            output[0]['confidence'] > 0.5 &&
            output[1]['confidence'] > 0.5) {
          // output.insert(
          //   0, {'confidence': 99.00, 'index': 4, 'label': 'combination'}
          // );
          historyController.addSkinTypeHistory(
              addSkinType: History(
                  skinTypeName: output[0]['label'], dateTime: DateTime.now()));

          return [
            {'confidence': 0.99, 'index': 4, 'label': 'combination'},
            output[0],
            output[1],
            output[2],
            output[3]
          ];
        } else {
          historyController.addSkinTypeHistory(
              addSkinType: History(
                  skinTypeName: output[0]['label'], dateTime: DateTime.now()));
          return [
            output[0],
            output[1],
            output[2],
            output[3],
            {'confidence': 0, 'index': 4, 'label': 'combination'}
          ];
        }
      }
      return null;
    } catch (e) {
      // ignore: avoid_print
      print("Error during Tflite prediction: $e");
      return null;
    }
  }

  @override
  void dispose() {
    Tflite.close();
  }
}
