import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skin_sense/model/history.dart';
import 'package:skin_sense/repository/box_repository.dart';

class HistoryController extends GetxController {
  final Box _observableBox = BoxRepository.getBox();

  Box get observalbeBox => _observableBox; //get the db

  int get historyLength => _observableBox.length; // get the length of history

  addSkinTypeHistory({required History addSkinType}) {
    _observableBox.add(addSkinType);
    update();
  }

  // updateSkinTypeHistory({required int index, required History addSkinType}) {
  //   _observableBox.putAt(index, addSkinType);
  //   update();
  // }

  // deleteSkinType({required int index}) {
  //   _observableBox.deleteAt(index);
  //   update();
  // }

  getSkinType({required int index}) {
    _observableBox.getAt(index);
    update();
    return _observableBox;
  }
}
