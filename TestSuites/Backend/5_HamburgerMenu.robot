*** Settings ***
Documentation       Test Genie Onboarding API's

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

*** Keywords ***

POST /api/auth/change/language
    [Documentation]    This API will be used to call OTP
    
    Set Log Level    TRACE

    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200

        ${request_headers}=    Backend_CommonKeywords.Token_Headers
	    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/change/language    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
        Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}



*** Test Cases ***
# Payment options
GET /api/genie/profile/check - Success
    [Tags]    HamburgerMenu    Regression

    #    1. Send request: GET /api/genie/profile/check
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/genie/profile/check    200    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/justpay/eligibility - Success
    [Tags]    HamburgerMenu    Regression

    #    1. Send request: GET /api/justpay/eligibility
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/justpay/eligibility   200    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

# Location
GET /api/ezcash/payout/centers?longitude=0.0&latitude=0.0&distance=0 - Success
    [Tags]    HamburgerMenu    Regression

    #    1. Send request: GET /api/ezcash/payout/centers?longitude=0.0&latitude=0.0&distance=0
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/ezcash/payout/centers?longitude=0.0&latitude=0.0&distance=0   200    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

# Default payment option
GET /api/tokenization/all/sof - Success
    [Tags]    HamburgerMenu    Regression

    #    1. Send request: GET /api/tokenization/all/sof
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/tokenization/all/sof   200    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

# App settings
# Change Language

POST /api/auth/change/language - Fail
    [Documentation]    Send request with invalid mobile number and verifing response
    [Tags]    HamburgerMenu    Regression
    [Template]    POST /api/auth/change/language
    
    ${LANGUAGE_CHANGE_INCORRECT_LANGUAGE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        LANGUAGE_UPDATED_FAILED
    ...    STATUS                         FAILED

POST /api/auth/change/language - Success
    [Documentation]    Send request with invalid mobile number and verifing response
    [Tags]    HamburgerMenu    Regression
    [Template]    POST /api/auth/change/language
    
    ${LANGUAGE_CHANGE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        LANGUAGE_UPDATED_SUCCESSFULLY
    ...    STATUS                         SUCCESS

