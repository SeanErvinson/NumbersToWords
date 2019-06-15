import 'package:nuwo/src/models/english_numerals.dart';

class Conversion {
  static String _getMask(String content) {
    int length = content.length;
    String resultMask = "";
    if (content.length % 3 == 0) return null;
    length = (content.length + 3 - (length % 3)) - content.length;
    for (var i = 0; i < length; i++) {
      resultMask += '0';
    }
    return resultMask;
  }

  static String parseWord(String content) {
    String maskedContent = _getMask(content);
    String value = maskedContent == null ? content : maskedContent + content;
    StringBuffer sb = new StringBuffer();
    for (int i = 0, j = 3; i < value.length; i += 3, j += 3) {
      int thirdOctet = int.parse(value.substring(i, j));
      sb.write(_convertLessThousand(thirdOctet));
      sb.write(" ");
      if (thirdOctet != 0)
        sb.write(
            EnglishNumerals.largeNumbers[((value.length - j) / 3).floor()]);
      sb.write(" ");
    }
    return sb.toString();
  }

  static String _convertLessThousand(int value) {
    List<String> words = new List<String>();
    if (value % 100 < 20) {
      words.add(EnglishNumerals.tens[value % 100]);
      value = (value / 100).floor();
    } else {
      words.add(EnglishNumerals.tens[value % 10]);
      value = (value / 10).floor();
      words.add(EnglishNumerals.tys[value % 10]);
      value = (value / 10).floor();
    }
    if (value == 0) return _getFormattedWord(words).trim();
    words.add("${EnglishNumerals.tens[value]} Hundred");
    return _getFormattedWord(words).trim();
  }

  static String _getFormattedWord(List<String> words) {
    StringBuffer sb = new StringBuffer();
    while (words.isNotEmpty) {
      sb.write(words.removeLast());
      sb.write(" ");
    }
    return sb.toString();
  }
}
