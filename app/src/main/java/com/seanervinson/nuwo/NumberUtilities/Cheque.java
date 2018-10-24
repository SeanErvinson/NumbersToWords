package com.seanervinson.nuwo.NumberUtilities;

import static com.seanervinson.nuwo.NumberUtilities.EnglishNumerals.LARGE_NUMBERS;

public class Cheque {
    public static String toChequeFormat(String content) {
        if (content.trim().length() <= 0) {
            return null;
        }

        StringBuilder sb = new StringBuilder();
        int largeNumberIndex = LARGE_NUMBERS.length - 1;

        String[] words = content.trim().split(" ");
        for (int i = 0; i < words.length; i++) {
            boolean betweenUnit = false;
            sb.append(words[i]).append(" ");
            if (words[i].equals("Hundred") && i != words.length - 1) {
                for (int j = largeNumberIndex; j >= 0; j--) {
                    if (words[i + 1].equals(LARGE_NUMBERS[j])) {
                        betweenUnit = true;
                        break;
                    }
                }
                if (!betweenUnit)
                    sb.append("And ");
            }
        }
        return sb.append("Only").toString();
    }

    public static String toNormalFormat(String content) {
        if (content.length() <= 0) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        String[] words = content.trim().split(" ");
        for (int i = 0; i < words.length - 1; i++) {
            if (!words[i].equals("And")) {
                sb.append(words[i]).append(" ");
            }
        }
        return sb.toString();
    }
}
