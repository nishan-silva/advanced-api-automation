*** Settings ***
Documentation    Keywords that can be used in all suites are stored here.
Library    AppiumLibrary
Variables    ../../TestData/Staging_Frontend_TestData.py
Resource    ../../PageObjects/Android/OnboardingAndLogin.robot
Resource    ../../KeywordLibraries/Frontend/Common.robot

*** Keywords ***

####################################################################################################################
# *** Onboarding ***
####################################################################################################################

Open_Genie_App_Device_1
    Open_Android_Genie_App            ${APPIUM_PORT_DEVICE_1}

Open_Genie_App_Device_2
    Open_iOS_Genie_App            ${APPIUM_PORT_DEVICE_1}

Permission_Can_Be_Allowed_Or_Denied
    [Arguments]    ${permission_button_text}
    ${permission_allow_xpath}    ANDROID_GET_PERMISSION_ALLOW_XPATH    ${permission_button_text}
    Wait Until Element Is Visible    ${permission_allow_xpath}
    #Capture Screenshot
    Click Element    ${permission_allow_xpath}
    #Capture Screenshot

Language_Can_Be_Selected
    [Arguments]    ${language_button_text}
    ${language_selection_xpath}    ANDROID_GET_LANGUAGE_SELECTION_XPATH    ${language_button_text}
    Wait Until Element Is Visible    ${language_selection_xpath}
    Click Element    ${language_selection_xpath}

Skip_Button_Can_Be_Selected_in_Referral_Screen
    [Arguments]    ${skip_proceed_continue_button_text}
    ${skip_and_proceed_button_xpath}    ANDROID_GET_SKIP_PROCEED_CONTINUE_BUTTON_XPATH    ${skip_proceed_continue_button_text}
    Wait Until Element Is Visible    ${skip_and_proceed_button_xpath}
    Capture Screenshot
    Click Element    ${skip_and_proceed_button_xpath}

Welcome_Screen_Should_Be_Visible
    [Arguments]    ${skip_proceed_continue_button_text}
    ${onboarding_Welcome_Text_xpath}    ANDROID_GET_WELCOME_SCREEN_XPATH
    Wait Until Element Is Visible    ${onboarding_Welcome_Text_xpath}
    ${skip_button_xpath}    ANDROID_GET_SKIP_PROCEED_CONTINUE_BUTTON_XPATH    ${skip_proceed_continue_button_text}
    Wait Until Element Is Visible    ${skip_button_xpath}
    Capture Screenshot
    Click Element    ${skip_button_xpath}

Mobile_Number_Can_Be_Entered_In_The_Mobile_Number_Enter_Screen
    [Arguments]    ${mobile_no}
    ${mobile_no_text_field_xpath}    ANDROID_GET_GENERAL_TEXT_FIELD_XPATH
    Wait Until Element Is Visible    ${mobile_no_text_field_xpath}
    Capture Screenshot
    Input Text    ${mobile_no_text_field_xpath}    ${mobile_no}

Check_Box_Can_Be_Selected_In_The_Mobile_Number_Enter_Screen
    ${terms_and_conditions_xpath}    ANDROID_GET_TERMS_AND_CONDITION_CHECK_BOX_XPATH
    Wait Until Element Is Visible    ${terms_and_conditions_xpath}
    Click Element    ${terms_and_conditions_xpath}
    Capture Screenshot

Continue_Button_Can_Be_Selected_In_The_Mobile_Number_Enter_Screen
    [Arguments]    ${skip_proceed_continue_button_text}
    ${skip_proceed_continue_button_xpath}    ANDROID_GET_SKIP_PROCEED_CONTINUE_BUTTON_XPATH    ${skip_proceed_continue_button_text}
    Wait Until Element Is Visible    ${skip_proceed_continue_button_xpath}
    Capture Screenshot
    Click Element    ${skip_proceed_continue_button_xpath}

OTP_Can_Be_Enterd_In_OTP_Enter_Screen
    [Arguments]    ${enter_otp_value}
    ${otp_text_xpath}    ANDROID_GET_OTP_ENTER_LABLE_XPATH
    Wait Until Element Is Visible    ${otp_text_xpath}
    Capture Screenshot
    ${otp_text_field_xpath}    ANDROID_GET_GENERAL_TEXT_FIELD_XPATH
    Input Text    ${otp_text_field_xpath}    ${enter_otp_value}
    Capture Screenshot

NIC_Can_Be_Enterd_In_NIC_Enter_Screen
    [Arguments]    ${enter_nic_value}    ${skip_proceed_continue_button_text}
    ${nic_text_xpath}    ANDROID_GET_NIC_ENTER_LABLE_XPATH
    Wait Until Element Is Visible    ${nic_text_xpath}
    Capture Screenshot
    ${nic_text_field_xpath}        ANDROID_GET_GENERAL_TEXT_FIELD_XPATH
    Input Text    ${nic_text_field_xpath}    ${enter_nic_value}
    Capture Screenshot
    ${nic_continue_button}        ANDROID_GET_SKIP_PROCEED_CONTINUE_BUTTON_XPATH    ${skip_proceed_continue_button_text}
    Click Element    ${nic_continue_button}

PIN_Can_Be_Enterd_In_PIN_Enter_Screen
    ${pin_enter_text_xpath}    ANDROID_GET_PIN_ENTER_HEADING_XPATH
    Wait Until Element Is Visible    ${pin_enter_text_xpath}
    Capture Screenshot
    @{pin}    Create List    ${PIN_1}    ${PIN_2}    ${PIN_3}    ${PIN_4}
    FOR    ${i}    IN    @{pin}
    ${locator} =    Set Variable    //android.widget.TextView[@text="${i}"]
    Click Element    ${locator}
    END

Dashboard_Should_Be_Visible
    @{dashboard_icon_text}    Create List    ${DASHBOARD_PAY}    ${DASHBOARD_SCAN_QR}    ${DASHBOARD_SEND}    ${DASHBOARD_SAVINGS}    ${DASHBOARD_LOANS}    ${DASHBOARD_FIXED_DEPOSIT}    ${DASHBOARD_EZCASH}    ${DASHBOARD_STAR_REWARDS}    ${DASHBOARD_STOCKS}    ${DASHBOARD_MUTUAL_FUNDS}    ${DASHBOARD_GENIE_DEALS}    ${DASHBOARD_INSURANCE}    ${DASHBOARD_GENIE_COINS}    ${DASHBOARD_SAVINGS_POCKETS}    ${DASHBOARD_GOAL_BASED_FD}    ${DASHBOARD_FUEL_QR}    ${DASHBOARD_FUEL_QR}    ${DASHBOARD_COUPONS}    ${DASHBOARD_LOAN_AGAINST_FD}
    FOR    ${i}    IN    @{dashboard_icon_text}
    ${dashboard_Pay_Label} =    Set Variable    //android.widget.TextView[@text="${i}"]
    Scroll Element Into View If Not Visible    ${dashboard_Pay_Label}
    Wait Until Element Is Visible    ${dashboard_Pay_Label}
    END
    Capture Screenshot
    

####################################################################################################################
# *** Login ***
####################################################################################################################




####################################################################################################################
# *** Dashboard ***
####################################################################################################################

