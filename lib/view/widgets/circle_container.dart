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
    var color = const Color.fromRGBO(248, 237, 2277, 1);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              height: 56,
              width: 59,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Center(
                child: Text(
                    (predictions?[0]['confidence'] * 100).toStringAsFixed(2) +
                        "%"),
              ),
            ),
            Text(
              predictions?[0]['label'],
              style: GoogleFonts.montserrat(color: Colors.black),
            )
          ],
        ),
        Column(
          children: [
            Container(
              height: 56,
              width: 59,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: Text(
                    (predictions?[1]['confidence'] * 100).toStringAsFixed(2)),
              ),
            ),
            Text(
              predictions?[1]['label'],
              style: GoogleFonts.montserrat(color: Colors.black),
            )
          ],
        ),
        Column(
          children: [
            Container(
              height: 56,
              width: 59,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: Text(
                    (predictions?[2]['confidence'] * 100).toStringAsFixed(2)),
              ),
            ),
            Text(
              predictions?[2]['label'],
              style: GoogleFonts.montserrat(color: Colors.black),
            )
          ],
        ),
        Column(
          children: [
            Container(
              height: 56,
              width: 59,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: Text(
                    (predictions?[3]['confidence'] * 100).toStringAsFixed(2)),
              ),
            ),
            Text(
              predictions?[3]['label'],
              style: GoogleFonts.montserrat(color: Colors.black),
            )
          ],
        ),
        Column(
          children: [
            Container(
              height: 56,
              width: 59,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: Text(
                    (predictions?[4]['confidence'] * 100).toStringAsFixed(2)),
              ),
            ),
            Text(
              predictions?[4]['label'],
              style: GoogleFonts.montserrat(color: Colors.black),
            )
          ],
        ),
      ],
    );
  }
}
