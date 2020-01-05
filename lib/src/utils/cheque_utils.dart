import 'package:nuwo/src/models/english_numerals.dart';

class ChequeUtils {
  static String toChequeFormat(String content) {
    if (content.trim().length <= 0) return "";

    StringBuffer sb = new StringBuffer();
    int largeNumberIndex = EnglishNumerals.largeNumbers.length - 1;

    List<String> words = content.trim().split(" ");
    for (int i = 0; i < words.length; i++) {
      bool betweenUnit = false;
      sb.write(words[i]);
      sb.write(" ");
      if (words[i].toLowerCase() == "hundred" && i != words.length - 1) {
        for (int j = largeNumberIndex; j >= 0; j--) {
          if (words[i + 1] == EnglishNumerals.largeNumbers[j]) {
            betweenUnit = true;
            break;
          }
        }
        if (!betweenUnit) sb.write("And ");
      }
    }
    sb.write("Only");
    return sb.toString();
  }

  static String toNormalFormat(String content) {
    if (content.trim().length <= 0) return "";

    StringBuffer sb = new StringBuffer();
    List<String> words = content.trim().split(" ");
    for (int i = 0; i < words.length; i++) {
      if (!(words[i].toLowerCase() == "and")) {
        sb.write(words[i]);
        sb.write(" ");
      }
    }
    return sb.toString();
  }
}
