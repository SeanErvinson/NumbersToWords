package com.seanervinson.numberstowords.NumberUtilities;
import java.util.Stack;

import static com.seanervinson.numberstowords.NumberUtilities.EnglishNumerals.LARGE_NUMBERS;
import static com.seanervinson.numberstowords.NumberUtilities.EnglishNumerals.TENS;
import static com.seanervinson.numberstowords.NumberUtilities.EnglishNumerals.TYS;

public class NumberConversion {
    private static final int TEN = 10;
    private static final int HUNDRED = 100;

    public static String convertNumber(long value) {
        int tensCounter = 3;
        Stack<String> words = new Stack<>();
        while (value != 0) {
            long dividend = value % 1000;
            value /= 1000;
            words.push(convertLessThousand(dividend));
            if (value == 0)
                break;
            words.push(LARGE_NUMBERS[tensCounter / 3 - 1]);
            tensCounter += 3;
        }
        return getFormattedWord(words);
    }

    private static String convertLessThousand(long value) {
        Stack<String> words = new Stack<>();
        if (value % 100 < 20) {
            words.push(TENS[(int) value % HUNDRED]);
            value /= 100;
        } else {
            words.push(TENS[(int) value % TEN]);
            value /= 10;
            words.push(TYS[(int) value % TEN]);
            value /= 10;
        }
        if (value == 0)
            return getFormattedWord(words).trim();
        words.push(String.format("%s Hundred", TENS[(int) value]));
        return getFormattedWord(words).trim();
    }

    private static String getFormattedWord(Stack<String> words) {
        StringBuilder sb = new StringBuilder();
        while (!words.isEmpty()) {
            sb.append(words.pop() + " ");
        }
        return sb.toString();
    }
}
