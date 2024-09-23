import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skin_sense/view/screens/camera_screen.dart';
import 'package:skin_sense/view/screens/history_screen.dart';
import 'package:skin_sense/view/widgets/image_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  //For changing the screen
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //This is a screens list which you want to navigate through BottomNavigationBar
  final List<Widget> _children = [
    const ImageCarousel(),
    const HistoryScreen(),
  ];
  void _wow() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreen()),
        ModalRoute.withName('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: ElevatedButton(
          onPressed: _wow,
          child: const SizedBox(
            height: 60,
            width: 30,
            child: Icon(
              Icons.photo_camera_outlined,
              color: Colors.black,
            ),
          )),
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
        ),
        leadingWidth: 100,
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        title: Text(
          'Skin Sense',
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 50,
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32.0,
        backgroundColor: const Color.fromRGBO(223, 211, 195, 1),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black12,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(label: "", icon: Icon(Icons.home_rounded)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.history)),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
