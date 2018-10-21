package com.seanervinson.numberstowords;

import android.os.Build;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
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


    private void initializeWidget() {
        mTextResult = findViewById(R.id.text_result);
        mInputNumber = findViewById(R.id.input_number);
        mSwitchCheque = findViewById(R.id.sw_cheque_mode);
    }

}
