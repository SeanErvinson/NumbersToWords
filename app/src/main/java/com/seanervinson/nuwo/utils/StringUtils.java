package com.seanervinson.nuwo.utils;

public class StringUtils {
    public static String toTitleCase(String content) {
        StringBuilder sb = new StringBuilder();
        boolean startingLetter = true;

        for (char character : content.toCharArray()) {
            if (Character.isSpaceChar(character)) {
                startingLetter = true;
            } else if (startingLetter) {
                character = Character.toTitleCase(character);
                startingLetter = false;
            }
            sb.append(character);
        }
        return sb.toString();
    }
}
