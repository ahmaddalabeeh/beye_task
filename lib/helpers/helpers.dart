class Helpers {
  String formatNumber(dynamic value) {
    if (value is num) {
      if (value >= 1000000) {
        return ('${(value / 1000000).toStringAsFixed(1)} Mn');
      } else if (value >= 1000) {
        return ('${(value / 1000).toStringAsFixed(1)} K');
      }
    }
    return value.toString();
  }
}
