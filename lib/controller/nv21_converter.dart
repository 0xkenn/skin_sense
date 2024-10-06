// import 'package:image/image.dart' as imgP;
// import 'dart:typed_data';

// Uint8List convertToNV21(imgP.Image image) {
//   final width = image.width;
//   final height = image.height;

//   // Create the NV21 byte buffer
//   final Uint8List nv21 = Uint8List(width * height + (width * height ~/ 2));

//   // Fill the Y plane
//   for (int y = 0; y < height; y++) {
//     for (int x = 0; x < width; x++) {
//       final pixel = image.getPixel(x, y);
//       final r = (pixel >> 16) & 0xFF; // Get the red value
//       final g = imgP.getGreen(pixel);
//       final b = imgP.getBlue(pixel);

//       // Convert to YUV
//       final yValue = (0.299 * r + 0.587 * g + 0.114 * b).round();
//       nv21[y * width + x] = yValue.clamp(0, 255).toInt();
//     }
//   }

//   // Fill the V and U planes
//   int uvIndex = width * height;
//   for (int y = 0; y < height; y += 2) {
//     for (int x = 0; x < width; x += 2) {
//       final p1 = image.getPixel(x, y);
//       final p2 = image.getPixel(x + 1, y);
//       final p3 = image.getPixel(x, y + 1);
//       final p4 = image.getPixel(x + 1, y + 1);

//       // Convert to VU
//       final r1 = imgP.getRed(p1);
//       final g1 = imgP.getGreen(p1);
//       final b1 = imgP.getBlue(p1);
//       final r2 = imgP.getRed(p2);
//       final g2 = imgP.getGreen(p2);
//       final b2 = imgP.getBlue(p2);
//       final r3 = imgP.getRed(p3);
//       final g3 = imgP.getGreen(p3);
//       final b3 = imgP.getBlue(p3);
//       final r4 = imgP.getRed(p4);
//       final g4 = imgP.getGreen(p4);
//       final b4 = imgP.getBlue(p4);

//       final uValue = (-0.14713 * r1 - 0.288862 * g1 + 0.436 * b1).round();
//       final vValue = (0.615 * r1 - 0.51498 * g1 - 0.10001 * b1).round();
//       nv21[uvIndex++] = vValue.clamp(0, 255).toInt();
//       nv21[uvIndex++] = uValue.clamp(0, 255).toInt();
//     }
//   }

//   return nv21;
// }
