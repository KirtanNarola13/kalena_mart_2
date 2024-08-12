import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool _isLoading = false.obs; // Use RxBool for reactivity

  bool get isLoading => _isLoading.value;

  void showLoading() {
    _isLoading.value = true;
    update();
  }

  void hideLoading() {
    _isLoading.value = false;
    update();
  }
}
