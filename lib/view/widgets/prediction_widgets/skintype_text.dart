import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SkinTypeText extends StatelessWidget {
  final String skin;
  final String type;

  const SkinTypeText({super.key, required this.skin, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(color: Color.fromRGBO(197, 112, 93, 1)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(skin,
                      style: GoogleFonts.montserrat(
                        fontSize: 29,
                        color: Colors.white,
                      )),
                ),
                Text(type,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.camera_alt_rounded,
              color: Color.fromARGB(255, 55, 60, 79),
            ),
            label: const Text(
              'Retake',
              style: TextStyle(
                color: Color.fromARGB(255, 55, 60, 79),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
