import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skin_sense/view/screens/recommendation_screen.dart';
import 'package:skin_sense/view/widgets/circle_container.dart';

class BottomText extends StatelessWidget {
  final String predictedSkinType;
  final List? predictions;

  const BottomText({
    super.key,
    required this.predictedSkinType,
    required this.predictions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 100),
      child: Container(
        // Remove fixed height
        width: double.infinity,
        alignment: AlignmentDirectional.topStart,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(42),
            topRight: Radius.circular(42),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use min to size based on children
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            CircleContainer(predictions: predictions),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromRGBO(208, 191, 191, 1),
                minimumSize: const Size(350, 50),
                textStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecommendationScreen(storedResult: predictedSkinType),
                  ),
                );
              },
              child: const Text('Recommendations'),
            ),
            const SizedBox(
              height: 11,
            )
          ],
        ),
      ),
    );
  }
}
