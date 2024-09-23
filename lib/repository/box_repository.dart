import 'package:hive_flutter/hive_flutter.dart';
import 'package:skin_sense/model/history.dart';

class BoxRepository {
  static const String boxName = 'SkinType';

  static openBox() async => await Hive.openBox<History>(boxName);

  static Box getBox() => Hive.box<History>(boxName);

  static closeBox() async => await Hive.box(boxName).close();
}
