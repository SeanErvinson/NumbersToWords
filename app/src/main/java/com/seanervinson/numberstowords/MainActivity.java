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
                int tensCounter = 1;
                int hundredCounter = 2;
                int powerTensCounter = 3;
                int counter = -1;
                String currentNumber = charSequence.toString();
                String resultWord;
                Stack<String> supposedWords = new Stack<>();
                try {
                    for (int index = currentNumber.length() - 1; index >= 0; index--) {
                        int currentValue = Character.getNumericValue(currentNumber.charAt(index));
                        if(currentValue == 0)
                            counter++;
                        if (currentNumber.length() - 1 - index == hundredCounter) {
                            if (currentValue != 0)
                                supposedWords.push(Number.TENS[0]);
                            hundredCounter += 3;
                        }
                        if (currentNumber.length() - 1 - index == tensCounter) {
                            if (currentValue == 1) {
                                if (!supposedWords.isEmpty())
                                    supposedWords.pop();
                                int onesIndex = Character.getNumericValue(currentNumber.charAt(index + 1));
                                if (onesIndex >= 0) {
                                    String teenNumber = Number.TEENS[onesIndex];
                                    supposedWords.push(teenNumber);
                                }
                            } else {
                                if (currentValue >= 0)
                                    supposedWords.push(Number.TYS[currentValue]);
                            }
                            tensCounter += 3;
                        } else {
                            if (currentValue >= 0) {
                                if (currentNumber.length() - 1 - index == powerTensCounter) {
                                    if(counter % 3 == 0){
                                        supposedWords.pop();
                                        supposedWords.pop();
                                        supposedWords.pop();
                                    }
                                    counter = 0;
                                    supposedWords.push(Number.TENS[powerTensCounter / 3]);
                                    powerTensCounter += 3;
                                }
                                supposedWords.push(Number.ONES[currentValue]);
                            }
                        }
                    }
                } catch (NumberFormatException ex) {
                    return;
                }


                //mTextResult.setText(String.join("", supposedWords.toArray(new String[supposedWords.size()])));
                resultWord = getFormattedWord(supposedWords);
                mTextResult.setText(resultWord);

            }

            private String getFormattedWord(Stack<String> words) {
                StringBuilder sb = new StringBuilder();
                while (!words.isEmpty()) {
                    sb.append(words.pop());
                }
                return sb.toString();
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
