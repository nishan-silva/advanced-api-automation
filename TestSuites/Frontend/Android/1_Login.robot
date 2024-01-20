*** Settings ***
Documentation    Test Genie Login Frontend Scenario
Library    AppiumLibrary
Resource    ../../../KeywordLibraries/Frontend/OnboardingAndLogin.robot

Suite Setup    Set Appium Timeout    20    # Set Appium timeout to 10 seconds


*** Test Cases ***
Genie_Login - Success
    [Tags]    Login    Regression
    Open_Genie_App_Device_1
    Permission_Can_Be_Allowed_Or_Denied    ${button_text_permisson_allow}
    Language_Can_Be_Selected    ${button_text_language_english}
    Skip_Button_Can_Be_Selected_in_Referral_Screen    ${button_text_skip}
    Welcome_Screen_Should_Be_Visible    ${button_text_skip}
    Mobile_Number_Can_Be_Entered_In_The_Mobile_Number_Enter_Screen    ${MOBILE_NUMBER} 
    Check_Box_Can_Be_Selected_In_The_Mobile_Number_Enter_Screen
    Continue_Button_Can_Be_Selected_In_The_Mobile_Number_Enter_Screen    ${button_text_continue}
    OTP_Can_Be_Enterd_In_OTP_Enter_Screen    ${OTP}
    NIC_Can_Be_Enterd_In_NIC_Enter_Screen    ${NIC}    ${button_text_continue}
    PIN_Can_Be_Enterd_In_PIN_Enter_Screen
    Dashboard_Should_Be_Visible
