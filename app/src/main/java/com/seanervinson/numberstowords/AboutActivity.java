package com.seanervinson.numberstowords;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ListView;

public class AboutActivity extends AppCompatActivity {

    private ListView mSocialMediaLinks;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);
        initializeWidget();
    }

    private void initializeWidget(){
        mSocialMediaLinks = findViewById(R.id.list_social_media_links);
    }

    private void initializeSocialMediaListView(){
//        mSocialMediaLinks.setAdapter(new SocialMediaAdapter(this, 0, ));
    }
}
