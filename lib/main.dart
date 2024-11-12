import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skin_sense/model/history.dart';
import 'package:skin_sense/repository/box_repository.dart';
import 'package:skin_sense/view/screens/about.dart';
import 'package:skin_sense/view/screens/about_skin_type.dart';
import 'package:skin_sense/view/screens/camera_screen.dart';
import 'package:skin_sense/view/screens/home_screen.dart';
import 'package:skin_sense/view/screens/privacy.dart';

void main() async {
  // Ensure widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Preserve the splash screen until the initialization is done
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  // Initialize Hive and other resources
  await initialize();

  // Remove the splash screen
  FlutterNativeSplash.remove();

  // Run the app
  runApp(const MyApp());
}

Future<void> initialize() async {
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(HistoryAdapter()); // Register  adapter
  await BoxRepository.openBox(); // Open  Hive box
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/camera', page: () => const CameraScreen()),
        GetPage(name: '/about', page: () => const AboutScreen()),
        GetPage(name: '/skinTypeInfo', page: () => SkinTypeScreen()),
        GetPage(name: '/privacy', page: () => PrivacyPolicyScreen()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
