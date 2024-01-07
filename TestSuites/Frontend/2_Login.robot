*** Settings ***
Documentation    Test Genie Login Frontend Scenario
Library    AppiumLibrary
Resource    ../../KeywordLibraries/Frontend/OnboardingAndLogin.robot

Suite Setup    Set Appium Timeout    20    # Set Appium timeout to 10 seconds


*** Test Cases ***
Genie_Login
    [Tags]    Login    Regression
    Open_Genie_App_Device_1
    Select_permission    $permission_button_text    
    Select_language    
    Select_skip_button_in_Referral_page    
    Welcome_Screen    
    Enter_Mobile_Number    
    Check_Terms_And_Conditions
    Cilck_Continue_Button  
    Enter_OTP   
    Enter_NIC
    Enter_PIN

    Open_Genie_App_Device_2
    Select_Language
    Select_skip_button_in__Referral_page
    Welcome_Screen
    Enter_Mobile_Number
    Enter_OTP
    Enter_NIC
    Enter_PIN