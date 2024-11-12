import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleContainer extends StatelessWidget {
  final List? predictions;

  const CircleContainer({
    super.key,
    required this.predictions,
  });

  @override
  Widget build(BuildContext context) {
    var color = const Color.fromRGBO(248, 237, 227, 1);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(predictions?.length ?? 0, (index) {
        return Column(
          children: [
            Container(
              height: 56,
              width: 59,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Center(
                child: Text(((predictions![index]['confidence'] ?? 0) * 100)
                        .toStringAsFixed(2) +
                    "%"),
              ),
            ),
            Text(
              predictions?[index]['label'] ?? 'N/A',
              style: GoogleFonts.montserrat(color: Colors.black),
            )
          ],
        );
      }),
    );
  }
}
