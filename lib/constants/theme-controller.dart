import 'package:get/get.dart';
import 'package:kalena_mart/constants/theme-model.dart';

class ThemeController extends GetxController {
  ThemeModel themeModel = ThemeModel(
      currentTheme:
          'https://i.pinimg.com/736x/c3/48/c2/c348c2ec2d5c012fd80759195a2aea50.jpg'
              .obs,
      currentName: 'Brown'.obs);

  changeTheme({required RxString theme, required RxString name}) {
    themeModel.currentTheme.value = theme.value;
    themeModel.currentName.value = name.value;
  }
}
