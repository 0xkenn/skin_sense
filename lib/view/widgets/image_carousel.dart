import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentSlide = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  List textList = [
    "Detects skin type.",
    "Provide skin type recommendations.",
    "Recommend skincare ingredients ."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CarouselSlider(
              items: [
                Image.asset('assets/images/photo1.png'),
                Image.asset('assets/images/photo2.png'),
                Image.asset('assets/images/photo3.png'),
              ],
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentSlide = index;
                    });
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textList[_currentSlide],
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: textList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                                _currentSlide == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            )
          ]),
        ));
  }
}
