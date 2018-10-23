package com.seanervinson.nuwo.NumberUtilities;

public class Cheque {
    public static String toChequeFormat(String content) {
        if (content.length() <= 0) {
            return null;
        }
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
