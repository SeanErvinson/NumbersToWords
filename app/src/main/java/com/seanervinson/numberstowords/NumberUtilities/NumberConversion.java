package com.seanervinson.numberstowords.NumberUtilities;

import java.text.DecimalFormat;
import java.util.Stack;

import static com.seanervinson.numberstowords.NumberUtilities.EnglishNumerals.LARGE_NUMBERS;
import static com.seanervinson.numberstowords.NumberUtilities.EnglishNumerals.TENS;
import static com.seanervinson.numberstowords.NumberUtilities.EnglishNumerals.TYS;

public class NumberConversion {
    private static boolean mChequeMode;

    public static String parseWord(long value, boolean chequeMode) {
        mChequeMode = chequeMode;
        String result;
        String mask = getMask(value);
        DecimalFormat df = new DecimalFormat(mask);
        String valueText = df.format(value);
        StringBuilder sb = new StringBuilder();
        for (int i = 0, j = 3; i < valueText.length(); i += 3, j += 3) {
            int thirdOctet = Integer.valueOf(valueText.substring(i, j));
            sb.append(convertLessThousand(thirdOctet)).append(" ");
            if (thirdOctet != 0)
                sb.append(LARGE_NUMBERS[(valueText.length() - j) / 3]).append(" ");
        }
        result = sb.toString();
        if(chequeMode){
            result = result.trim() + " Only";
        }
        return result;
    }

    private static String getMask(long value) {
        String valueText = String.valueOf(value);
        StringBuilder sb = new StringBuilder();
        int totalMask = valueText.length();
        if (valueText.length() % 3 != 0) {
            totalMask = valueText.length() + 3 - (valueText.length() % 3);
        }
        for (int i = 0; i < totalMask; i++) {
            sb.append("0");
        }
        return sb.toString();
    }

    private static String convertLessThousand(long value) {
        Stack<String> words = new Stack<>();
        if (value % 100 < 20) {
            words.push(TENS[(int) value % 100]);
            value /= 100;
        } else {
            words.push(TENS[(int) value % 10]);
            value /= 10;
            words.push(TYS[(int) value % 10]);
            value /= 10;
        }
        if (value == 0)
            return getFormattedWord(words).trim();
        if(mChequeMode)
            words.push(String.format("%s Hundred And", TENS[(int) value]));
        else
            words.push(String.format("%s Hundred", TENS[(int) value]));
        return getFormattedWord(words).trim();
    }

    private static String getFormattedWord(Stack<String> words) {
        StringBuilder sb = new StringBuilder();
        while (!words.isEmpty()) {
            sb.append(words.pop()).append(" ");
        }
        return sb.toString();
    }
}
