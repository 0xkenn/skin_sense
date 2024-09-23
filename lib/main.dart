import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skin_sense/model/history.dart';
import 'package:skin_sense/repository/box_repository.dart';
import 'package:skin_sense/view/screens/camera_screen.dart';
import 'package:skin_sense/view/screens/home_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initialize();
  runApp(const MyApp());
}

void initialize() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  await BoxRepository.openBox();
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/camera': (context) => const CameraScreen(),
      },
      title: 'Skin Sense',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
