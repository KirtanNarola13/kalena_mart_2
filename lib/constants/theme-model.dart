import 'package:get/get.dart';

class ThemeModel {
  RxString currentTheme;
  RxString currentName;

  ThemeModel({required this.currentTheme, required this.currentName});

  factory ThemeModel.fromMap({required Map<String, dynamic> data}) {
    return ThemeModel(
      currentTheme: data['img'],
      currentName: data['name'],
    );
  }
}
