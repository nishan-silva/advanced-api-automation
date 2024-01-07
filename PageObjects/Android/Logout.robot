

*** Variables ***
${button_text_yes}    YES
${button_text_no}     NO

# Add other button texts as needed
*** Keywords ***

#Example Test
    # Detect platform (Android or iOS)
   # ${current_platform}    Set Variable    ${PLATFORM}  # For demonstration purposes

ANDROID_GET_LOGOUT_POPUP_XPATH
    [Arguments]    ${logout_popup_button_text}
    ${xpath}    Set Variable    xpath=//android.widget.TextView[@text=" ${logout_popup_button_text} "]
    [Return]    ${xpath}