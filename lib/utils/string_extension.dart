// lib/utils/string_extension.dart
extension StringExtension on String {
  String get capitalizeFirstCustom {
    if (this == null || this.isEmpty) {
      return "";
    }
    return this[0].toUpperCase() + this.substring(1);
  }
}
