*** Settings ***
Documentation    Test Genie Onboarding Frontend Scenario
Library    AppiumLibrary
Variables    ../../TestData/Staging_Frontend_TestData.py
Resource    ../../KeywordLibraries/Frontend/OnboardingAndLogin.robot
Resource    ../../KeywordLibraries/Frontend/Common.robot

Suite Setup    Set Appium Timeout    20    # Set Appium timeout to 10 seconds

*** Variables ***

*** Test Cases ***
Genie_Dashboard
    [Tags]    Login    Regression
    Login_Device_1    ${button_text_permisson_allow}    ${button_text_language_english}    ${button_text_skip}      ${button_text_skip}    ${MOBILE_NUMBER}    ${button_text_continue}     ${OTP}    ${NIC}    ${button_text_continue}
    Dashboard
    Logout    ${button_text_menu}     ${button_text_logout}    ${button_text_yes}
    Uninstall APK
    Login_Device_2    ${button_text_permisson_allow}    ${button_text_language_english}    ${button_text_skip}      ${button_text_skip}    ${MOBILE_NUMBER}    ${button_text_continue}     ${OTP}    ${NIC}    ${button_text_continue}
    Dashboard
    Logout    ${button_text_menu}     ${button_text_logout}    ${button_text_yes}
