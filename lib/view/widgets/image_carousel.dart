import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_sense/controller/carousel_controller.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final carouselController = Get.put(CarouselControllerClass());

    List<String> textList = [
      "Detects skin type.",
      "Provides skin type recommendations.",
      "Recommends skincare ingredients."
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                Image.asset('assets/images/photo1.png'),
                Image.asset('assets/images/photo2.png'),
                Image.asset('assets/images/photo3.png'),
              ],
              options: CarouselOptions(
                autoPlay: true,
                height: 200,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  carouselController.updateSlide(index); // Update current slide
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                textList[carouselController.currentSlide.value],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              );
            }),
            const SizedBox(height: 10), // Add spacing between text and dots
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: textList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.updateSlide(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            carouselController.currentSlide.value == entry.key
                                ? Colors.black.withOpacity(0.9)
                                : Colors.black.withOpacity(0.4),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
