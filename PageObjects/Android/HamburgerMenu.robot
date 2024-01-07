*** Variables ***
${button_text_yes}    Payment options
${button_text_transaction_history}     Transaction history
${button_text_Locations}     Locations
${button_text_default_payment_option}     Default payment option
${button_text_no_faq}     FAQ
${button_text_contact}     Contact
${button_text_app_settings}     App settings
${button_text_about_us}     About us
${button_text_terms_and_conditions}     Terms & Conditions
${button_text_privacy_policy}     Privacy policy
${button_text_logout}     Logout

# Add other button texts as needed
*** Keywords ***
ANDROID_GET_HAMBURGER_MENU_XPATH
    [Arguments]    ${hamburger_button_text}
    ${xpath}    Set Variable    xpath=//android.widget.TextView[@text="${hamburger_button_text}"]
    [Return]    ${xpath}