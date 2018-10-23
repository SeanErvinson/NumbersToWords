package com.seanervinson.nuwo;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.seanervinson.nuwo.models.SocialMedia;

import java.util.ArrayList;

public class SocialMediaAdapter extends ArrayAdapter<SocialMedia> {

    public SocialMediaAdapter(Context context, int resource,ArrayList<SocialMedia> objects) {
        super(context, resource, objects);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        SocialMediaViewHolder socialMediaViewHolder = new SocialMediaViewHolder();
        SocialMedia currentSocialMedia = getItem(position);

        View listItemView = convertView;
        if(listItemView != null)
            listItemView = LayoutInflater.from(getContext()).inflate(R.layout.list_item_social_media_link, parent, false);
        socialMediaViewHolder.socialMediaImage = listItemView.findViewById(R.id.img_social_media);
        socialMediaViewHolder.socialMediaTitle = listItemView.findViewById(R.id.text_view_social_media_title);
        listItemView.setTag(socialMediaViewHolder);
        socialMediaViewHolder.socialMediaTitle.setText(currentSocialMedia.getTitle());
        socialMediaViewHolder.socialMediaImage.setImageBitmap(currentSocialMedia.getImage());

        return listItemView;
    }

    public class SocialMediaViewHolder{
        ImageView socialMediaImage;
        TextView socialMediaTitle;
    }
}
