*** Variables ***
${button_text_home}    Home
${button_text_transactions}     Transactions
${button_text_menu}     Menu

# Add other button texts as needed
*** Keywords ***
ANDROID_GET_BOTTOM_SHEET_XPATH
    [Arguments]    ${bottom_sheet_button_text}
    ${xpath}    Set Variable    xpath=//android.widget.TextView[@text="${bottom_sheet_button_text}"]
    [Return]    ${xpath}