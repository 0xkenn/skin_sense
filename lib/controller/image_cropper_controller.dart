import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropperController {
  static Future cropImage(
      {required XFile? image, required CropAspectRatio cropAspectRatio}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatio: cropAspectRatio,
      compressQuality: 98,
      compressFormat: ImageCompressFormat.png,
    );

    return croppedFile;
  }
}
