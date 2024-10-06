import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkinTypeScreen extends StatelessWidget {
  SkinTypeScreen({super.key});
  final List<SkinType> skinTypes = [
    SkinType(
      title: 'Normal Skin type',
      description:
          'Normal skin appears visibly balanced and healthy, exhibiting an even tone, smooth texture, and barely visible pores.',
      imagePath:
          'assets/images/normal_skin.png', // Update this with your image path
    ),
    SkinType(
      title: 'Oily Skin type',
      description:
          'When the skin produces too much sebum, it can cause the face to appear shiny and feel greasy, especially throughout the T-zone (forehead, nose, and chin). Excess sebum can also clog pores, which is why oily skin tends to be prone to larger pores and blackheads.',
      imagePath:
          'assets/images/oily_skin.png', // Update this with your image path
    ),
    SkinType(
      title: 'Dry Skin type',
      description:
          'Dry skin feels tight and noticeably often looks rough, flaky, or scaly. This is due to a lack of moisture and natural oils.',
      imagePath:
          'assets/images/dry_skin.png', // Update this with your image path
    ),
    SkinType(
      title: 'Acne prone skin',
      description:
          'Acne prone skin is predisposed to various acne lesions like blackheads, whiteheads, pimples, cysts, and comedones. Small, skin-colored bumps often on the forehead and chin.',
      imagePath:
          'assets/images/acne_skin.png', // Update this with your image path
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        title: const Text('Skin types'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: skinTypes.length,
        itemBuilder: (context, index) {
          return SkinTypeCard(skinType: skinTypes[index]);
        },
      ),
    );
  }
}

class SkinTypeCard extends StatelessWidget {
  final SkinType skinType;

  const SkinTypeCard({required this.skinType, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(
        skinType.imagePath,
        height: 120,
        width: 120,
      ),
      Expanded(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(skinType.title, style: const TextStyle(fontSize: 18)),
              Text(skinType.description, style: const TextStyle(fontSize: 14))
            ],
          ),
        ),
      )
    ]);
  }
}

class SkinType {
  final String title;
  final String description;
  final String imagePath;

  SkinType({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

void main() {
  runApp(MaterialApp(
    home: SkinTypeScreen(),
  ));
}
