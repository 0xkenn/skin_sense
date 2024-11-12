import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropperController {
  Future<CroppedFile?> cropImage({
    required XFile image,
    required CropAspectRatio cropAspectRatio,
  }) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: cropAspectRatio,
      compressQuality: 98,
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Specific Part of Skin",
          initAspectRatio: CropAspectRatioPreset.original,
        ),
      ],
    );

    return croppedFile;
  }
}
