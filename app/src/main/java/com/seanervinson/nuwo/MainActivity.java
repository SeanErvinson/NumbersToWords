package com.seanervinson.nuwo;

import android.content.Intent;
import android.os.Build;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.TextView;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.MobileAds;
import com.seanervinson.nuwo.NumberUtilities.Cheque;
import com.seanervinson.nuwo.NumberUtilities.NumberConversion;


public class MainActivity extends AppCompatActivity {

    private TextView mTextResult;
    private EditText mInputNumber;
    private Switch mSwitchCheque;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initializeWidget();
        initializeAdMob();

        mSwitchCheque.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean isChecked) {
                String currentText = mTextResult.getText().toString();
                String resultText;
                if (isChecked) {
                    resultText = Cheque.toChequeFormat(currentText);
                } else {
                    resultText = Cheque.toNormalFormat(currentText);
                }
                mTextResult.setText(resultText);
            }
        });
        mInputNumber.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @RequiresApi(api = Build.VERSION_CODES.O)
            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                String valueText = charSequence.toString();
                String resultWord;
                if (valueText.length() <= 0) {
                    resultWord = "";
                } else if (valueText.length() > 19) {
                    resultWord = getResources().getString(R.string.error_too_large);
                } else {
                    try {
                        resultWord = NumberConversion.parseWord(Long.valueOf(valueText));
                        if (mSwitchCheque.isChecked())
                            resultWord = Cheque.toChequeFormat(resultWord);
                    } catch (NumberFormatException ex) {
                        return;
                    }
                }

                mTextResult.setText(resultWord);
            }

            @Override
            public void afterTextChanged(Editable editable) {
            }
        });
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int optionId = item.getItemId();
        switch (optionId) {
            case R.id.action_about:
                openActivity(AboutActivity.class);
            case R.id.action_settings:
                openActivity(SettingsActivity.class);
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main_settings, menu);
        return super.onCreateOptionsMenu(menu);
    }

    private void initializeAdMob() {
        MobileAds.initialize(this, getResources().getString(R.string.nuwo_APP_ID));
        AdView mAdView = findViewById(R.id.adView);
        AdRequest adRequest = new AdRequest.Builder().build();
        mAdView.loadAd(adRequest);
    }

    private void initializeWidget() {
        mTextResult = findViewById(R.id.text_result);
        mInputNumber = findViewById(R.id.input_number);
        mSwitchCheque = findViewById(R.id.sw_cheque_mode);
    }

    private void openActivity(Class<?> targetClass) {
        Intent intent = new Intent(this, targetClass);
        startActivity(intent);
    }

}
