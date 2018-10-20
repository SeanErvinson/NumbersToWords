package com.seanervinson.numberstowords;

import android.os.Build;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.TextView;

import com.seanervinson.numberstowords.NumberUtilities.NumberConversion;

import java.util.Stack;

public class MainActivity extends AppCompatActivity {

    private TextView mTextResult;
    private EditText mInputNumber;
    private Switch mSwitchCheque;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initializeWidget();

        mInputNumber.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @RequiresApi(api = Build.VERSION_CODES.O)
            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                String currentNumber = charSequence.toString();
                String resultWord;
                if (currentNumber.length() <= 0) {
                    mTextResult.setText("");
                    return;
                }
                try {
                    resultWord = NumberConversion.convertNumber(Long.valueOf(currentNumber));
                } catch (NumberFormatException ex) {
                    return;
                }
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
