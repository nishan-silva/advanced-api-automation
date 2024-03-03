*** Settings ***
Documentation       Test Genie ForgotPin API's

Suite Setup         DatabaseKeywords.Connecting_To_Genie_Database
Suite Teardown      Disconnect From Database

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot
Resource    ../../KeywordLibraries/Backend/DatabaseKeywords.robot

*** Variables ***
${DATA_NIC_VERIFY}

*** Keywords ***
POST /api/auth/pin/forget
    [Documentation]    This API will be used to call OTP
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200
        Set To Dictionary    ${data}    request_token=${DATA_NIC_VERIFY}
        ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
	    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/pin/forget   ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
        Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST /api/auth/question/verify
    [Documentation]    This API will be used to call OTP
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200
        Set To Dictionary    ${data}    request_token=${DATA_NIC_VERIFY}
        ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
	    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/question/verify   ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
        Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST api/auth/pin/verify
    [Documentation]    This API will be used to call OTP
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200
        Set To Dictionary    ${data}    request_token=${DATA_NIC_VERIFY}
        ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
	    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/pin/verify   ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
        Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST /api/auth/pin/reset
    [Documentation]    This API will be used to call OTP
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200
        Set To Dictionary    ${data}    request_token=${DATA_NIC_VERIFY}
        ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
	    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/pin/reset  ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
        Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

*** Test Cases ***
POST /api/auth/pin/forget - Fail - Invalid mandatory parameters
    [Documentation]    Failure
    [Tags]    ForgotPin    Regression
    [Template]    POST /api/auth/pin/forget

    ${FORGOT_PIN_FAIL}    400
    ...    Mention_actual_param           Mention_param_value
    ...    error                          Bad Request
    ...    message                        INVALID_REQUEST

POST /api/auth/pin/forget - Success
    [Documentation]    Success
    [Tags]    ForgotPin    Regression
    [Template]    POST /api/auth/pin/forget

    ${FORGOT_PIN}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        ASK_QUESTION_SUCCESS
    ...    STATUS                         SUCCESS

POST /api/auth/question/verify - Fail - Invalid mandatory parameters
    [Documentation]    Success
    [Tags]    ForgotPin    Regression
    [Template]    POST /api/auth/question/verify

    ${QUESTION_VERIFY_INVALID_NIC}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        INVALID_NIC
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              Sorry! Something went wrong please try again.

    ${QUESTION_VERIFY_INCORRECT_NIC}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        TEMPORARY_PIN_BLOCKED
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              Your account has been blocked due to incorrect NIC attempt.

Resetting_User_Status
    [Documentation]    Resetting User Status after PIN block by calling Backednd_CommonKeywords.robot file Keyword
    [Tags]    ForgotPin    Regression

    Resetting_User_Status

POST /api/auth/question/verify - Success
    [Documentation]    Success
    [Tags]    ForgotPin    Regression
    [Template]    POST /api/auth/question/verify
    
    ${QUESTION_VERIFY}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        PIN_OTP_SEND_SUCCESS
    ...    STATUS                         SUCCESS

POST api/auth/pin/verify
    [Documentation]    Success
    [Tags]    ForgotPin    Regression
    [Template]    POST api/auth/pin/verify

    ${VERIFY_FORGOT_PIN_OTP}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        PIN_OTP_VALIDATE_SUCCESS
    ...    STATUS                         SUCCESS

POST /api/auth/pin/reset - Fail
    [Documentation]    Success
    [Tags]    ForgotPin    Regression
    [Template]    POST /api/auth/pin/reset

    ${PIN_RESET_PIN_RESET_FAILED}    400
    ...    Mention_actual_param           Mention_param_value
    ...    error                          Bad Request
    ...    message                        INVALID_REQUEST

    ${PIN_RESET_PIN_MISMATCH}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        PIN_MISMATCHING
    ...    STATUS                         FAILED

POST /api/auth/pin/reset
    [Documentation]    Success
    [Tags]    ForgotPin    Regression
    [Template]    POST /api/auth/pin/reset

    ${PIN_RESET}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        PIN_RESET_SUCCESS
    ...    STATUS                         SUCCESS

