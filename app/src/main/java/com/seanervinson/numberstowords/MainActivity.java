package com.seanervinson.numberstowords;

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

import com.seanervinson.numberstowords.NumberUtilities.Cheque;
import com.seanervinson.numberstowords.NumberUtilities.NumberConversion;


public class MainActivity extends AppCompatActivity {

    private TextView mTextResult;
    private EditText mInputNumber;
    private Switch mSwitchCheque;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initializeWidget();

        mSwitchCheque.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            String currentText;

            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean isChecked) {
                if (isChecked) {
                    currentText = mTextResult.getText().toString();
                    mTextResult.setText(Cheque.toChequeFormat(currentText));
                } else
                    mTextResult.setText(currentText);
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
                    } catch (NumberFormatException ex) {
                        return;
                    }
                }
                if (mSwitchCheque.isChecked())
                    resultWord = Cheque.toChequeFormat(resultWord);
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
                return openActivity(AboutActivity.class);
            case R.id.action_settings:
                return openActivity(SettingsActivity.class);
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main_settings, menu);
        return super.onCreateOptionsMenu(menu);
    }

    private void initializeWidget() {
        mTextResult = findViewById(R.id.text_result);
        mInputNumber = findViewById(R.id.input_number);
        mSwitchCheque = findViewById(R.id.sw_cheque_mode);
    }

    private boolean openActivity(Class<?> targetClass) {
        Intent intent = new Intent(this, targetClass);
        startActivity(intent);
        return true;
    }
}
