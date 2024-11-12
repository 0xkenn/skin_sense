import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_sense/controller/home_controller.dart';
import 'package:skin_sense/view/screens/camera_screen.dart';
import 'package:skin_sense/view/screens/history_screen.dart';
import 'package:skin_sense/view/screens/settings_screen.dart';
import 'package:skin_sense/view/widgets/image_carousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {
    Get.put(HomeController());
  }

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _showGuidelinesDialog(context); // Show confirmation dialog
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                right: 20), // Adjust the right margin as needed
            child: IconButton(
              icon: Image.asset('assets/images/bulb.png'),
              onPressed: () {
                //modal here
                showRandomModal(context);
              },
            ),
          ),
        ],
      ),
      body: Obx(() => _children[homeController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: homeController.selectedIndex.value,
            items: const <Widget>[
              Icon(Icons.home_rounded, size: 30),
              Icon(Icons.history, size: 30),
              Icon(Icons.settings, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(223, 211, 195, 1),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              homeController.changeIndex(index); // Update selected index
            },
            letIndexChange: (index) => true,
          )),
    );
  }

  final List<Widget> _children = [
    const ImageCarousel(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  // Show confirmation dialog
  Future<void> _showGuidelinesDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          title: const Text(
            "For better detection...",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Please follow these guidelines before capturing your face:",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "• Ensure proper lighting, preferably natural light, to avoid shadows.\n\n"
                  "• Make sure the specific skin area (not the whole face) is clearly visible and unobstructed.\n\n"
                  "• Avoid wearing makeup, accessories, or anything that may cover the skin.",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.5),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Get.to(
                      () => const CameraScreen()); // Navigate to CameraScreen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD08D73), // Button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "Got it !",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showRandomModal(BuildContext context) {
    // List of modal content
    final modalData = [
      {
        'title': 'Did you know?',
        'content':
            'Farnesol ingredient has the potential to cause a skin reaction (such as red, bumpy, or itchy skin).',
      },
      {
        'title': 'Did you know?',
        'content':
            'You can check a product if it’s reliable by verifying on the FDA Verification Portal.',
      },
    ];

    // Randomly select one item
    final randomIndex = Random().nextInt(modalData.length);
    final selectedData = modalData[randomIndex];

    // Show modal
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedData['title']!),
          content: Text(selectedData['content']!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
