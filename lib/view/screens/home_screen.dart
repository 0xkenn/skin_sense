import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_sense/controller/home_controller.dart';
import 'package:skin_sense/view/screens/history_screen.dart';
import 'package:skin_sense/view/screens/settings_screen.dart';
import 'package:skin_sense/view/widgets/image_carousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {
    Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.toNamed('/camera');
        },
        child: const SizedBox(
          height: 60,
          width: 30,
          child: Icon(
            Icons.photo_camera_outlined,
            color: Colors.black,
          ),
        ),
      ),
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
        ),
        leadingWidth: 100,
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        title: const Text(
          'Skin Sense',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 50,
      ),
      body: Obx(() =>
          _children[homeController.selectedIndex.value]), // Observe changes
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            iconSize: 32.0,
            backgroundColor: const Color.fromRGBO(223, 211, 195, 1),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black12,
            currentIndex: homeController.selectedIndex.value, // Observe changes
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  label: "", icon: Icon(Icons.home_rounded)),
              BottomNavigationBarItem(label: "", icon: Icon(Icons.history)),
              BottomNavigationBarItem(label: "", icon: Icon(Icons.settings)),
            ],
            onTap: (index) => homeController.changeIndex(index), // Change index
          )),
    );
  }

  final List<Widget> _children = [
    const ImageCarousel(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];
}
