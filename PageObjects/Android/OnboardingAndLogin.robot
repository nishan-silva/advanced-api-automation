*** Variables ***
${button_text_permisson_allow}    Allow
${button_text_permisson_deny}    Don't allow
${button_text_language_english}    English
${button_text_language_sinhala}    සිංහල
${button_text_language_tamil}    தமிழ்
${button_text_skip}    Skip
${button_text_proceed}    Proceed
${button_text_continue}    Continue

# Add other button texts as needed
*** Keywords ***
##########################
#General Permission Popup
##########################

ANDROID_GET_PERMISSION_ALLOW_XPATH
    [Arguments]    ${permission_button_text}
    ${xpath}    Set Variable    //android.widget.Button[@text="${permission_button_text}"]
    [Return]    ${xpath}

##########################
#Language Selection Screen
##########################

ANDROID_GET_LANGUAGE_SELECTION_XPATH
    [Arguments]    ${language_button_text}
    ${xpath}    Set Variable    //android.widget.TextView[@text="${language_button_text}"]
    [Return]    ${xpath}

##################
#Referral Screen
##################

ANDROID_GET_REFERRAL_SCREEN_HEADING
    ${xpath}    Set Variable    //android.widget.TextView[@text="Did Someone Refer You to genie?"]
    [Return]    ${xpath}

ANDROID_GET_SKIP_PROCEED_CONTINUE_BUTTON_XPATH
    [Arguments]    ${skip_proceed_continue_button_text}
    ${xpath}    Set Variable    //android.widget.TextView[@text="${skip_proceed_continue_button_text}"]
    [Return]    ${xpath}

################################
#Welcome Screen
################################

ANDROID_GET_WELCOME_SCREEN_XPATH
    ${xpath}    Set Variable    //android.widget.TextView[@text="Welcome to genie, Where Dreams Grow Together"]
    [Return]    ${xpath}

################################
#Mobile Number Enter Screen
################################

ANDROID_GET_GENERAL_TEXT_FIELD_XPATH
    ${xpath}    Set Variable    //android.widget.EditText
    [Return]    ${xpath}

ANDROID_GET_TERMS_AND_CONDITION_CHECK_BOX_XPATH
    ${xpath}    Set Variable    xpath=(//android.widget.ImageView)[4]
    [Return]    ${xpath}

################################
#OTP Enter Screen
################################
ANDROID_GET_OTP_ENTER_LABLE_XPATH
    ${xpath}    Set Variable    //android.widget.TextView[@text="Enter the code *"]
    [Return]    ${xpath}

################################
#NIC Enter Screen
################################
ANDROID_GET_NIC_ENTER_LABLE_XPATH
    ${xpath}    Set Variable    //android.widget.TextView[@text="Enter the NIC number *"]
    [Return]    ${xpath}


################################
#PIN Enter Screen
################################
ANDROID_GET_PIN_ENTER_HEADING_XPATH
    ${xpath}    Set Variable    //android.widget.TextView[@text="Enter PIN"]
    [Return]    ${xpath}
