package com.seanervinson.numberstowords.models;

import android.graphics.Bitmap;

public class SocialMedia {
    private String mTitle;
    private Bitmap mImage;

    public Bitmap getImage() {
        return mImage;
    }

    public void setImage(Bitmap image) {
        this.mImage = image;
    }

    public String getTitle() {
        return mTitle;
    }

    public void setTitle(String title) {
        this.mTitle = title;
    }
}
