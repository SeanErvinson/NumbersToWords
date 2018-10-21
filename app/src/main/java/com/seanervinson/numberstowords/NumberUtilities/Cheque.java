package com.seanervinson.numberstowords.NumberUtilities;

public class Cheque {
    public static String toChequeFormat(String content) {
        StringBuilder sb = new StringBuilder();
        String[] words = content.trim().split(" ");
        for (int i = 0; i < words.length; i++) {
            sb.append(words[i]).append(" ");
            if (words[i].equals("Hundred") && i != words.length - 1) {
                sb.append("And ");
            }
        }
        return sb.append("Only").toString();
    }
}
