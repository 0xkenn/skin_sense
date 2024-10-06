import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs; // Reactive variable to hold the selected index

  void changeIndex(int index) {
    selectedIndex.value = index; // Update the selected index
  }
}
