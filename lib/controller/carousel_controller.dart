// carousel_controller.dart
import 'package:get/get.dart';

class CarouselControllerClass extends GetxController {
  RxInt currentSlide = 0.obs; // Observable for the current slide index

  void updateSlide(int index) {
    currentSlide.value = index; // Update the current slide index
  }
}
