import 'package:hive_flutter/adapters.dart';

part 'history.g.dart';

@HiveType(typeId: 0)
class History {
  @HiveField(0)
  final String? skinTypeName;
  @HiveField(1)
  final DateTime? dateTime;

  History({required this.skinTypeName, required this.dateTime});
}

// Generate the hive db
// flutter pub add hive hive_flutter hive_generator build_runner
