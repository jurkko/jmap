class DoubleParser {
  double parseStringToDouble(String string) {
    try {
      double parsedDouble = double.parse(string);
      return parsedDouble;
    } catch (e) {
      print(e.toString());
    }
  }
}
