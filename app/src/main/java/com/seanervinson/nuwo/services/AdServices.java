package com.seanervinson.nuwo.services;

import android.content.Context;
import android.view.ViewGroup;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.MobileAds;
import com.seanervinson.nuwo.R;

public class AdServices {
    private boolean mIsAdShown = true;
    private Context mContext;
    private AdView mAdView;
    private ViewGroup mParentGroup;

    public AdServices(Context context, ViewGroup parent) {
        mContext = context;
        mParentGroup = parent;
    }

    public void initializeAds(String appId) {
        MobileAds.initialize(mContext, appId);
        mAdView = mParentGroup.findViewById(R.id.adView);
        if (mIsAdShown) {
            AdRequest adRequest = new AdRequest.Builder().build();
            mAdView.loadAd(adRequest);
        }
    }

    private void updateAdVisibility() {
        if (!mIsAdShown) {
            if (mAdView != null) {
                mParentGroup.removeView(mAdView);
                mParentGroup.invalidate();
            }
        } else {
            if (mAdView != null) {
                AdRequest adRequest = new AdRequest.Builder().build();
                mAdView.loadAd(adRequest);
                if (mParentGroup.findViewById(R.id.adView) == null) {
                    mParentGroup.addView(mAdView);
                    mParentGroup.invalidate();
                }
            }
        }
    }

    public void setIsAdShown(boolean isAdShown) {
        mIsAdShown = isAdShown;
        updateAdVisibility();
    }
}
