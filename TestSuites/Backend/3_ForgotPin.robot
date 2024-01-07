*** Settings ***
Documentation       Test Genie ForgotPin API's

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

*** Variables ***
${DATA_NIC_VERIFY}


*** Test Cases ***
POST /api/auth/pin/forget
    [Tags]    ForgotPin    Regression

    #    1. Send request: POST /api/auth/pin/forget
	#    2. Verify response status code: 200
    Set To Dictionary    ${FORGOT_PIN}        request_token=${DATA_NIC_VERIFY}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/pin/forget    200    ${FORGOT_PIN}    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST /api/auth/question/verify
    [Tags]    ForgotPin    Regression

    #    1. Send request: POST /api/auth/question/verify
	#    2. Verify response status code: 200
    Set To Dictionary    ${QUESTION_VERIFY}        request_token=${DATA_NIC_VERIFY}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/question/verify    200    ${QUESTION_VERIFY}    ${request_headers}    ${TIMEOUT}

   #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST api/auth/pin/verify
    [Tags]    ForgotPin    Regression

    #    1. Send request: POST api/auth/pin/verify
	#    2. Verify response status code: 200
    Set To Dictionary    ${VERIFY_FORGOT_PIN_OTP}        request_token=${DATA_NIC_VERIFY}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/pin/verify    200    ${VERIFY_FORGOT_PIN_OTP}    ${request_headers}    ${TIMEOUT}

   #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST /api/auth/pin/reset
    [Tags]    ForgotPin    Regression

    #    1. Send request: POST api/auth/pin/verify
	#    2. Verify response status code: 200

    Set To Dictionary    ${PIN_RESET}        request_token=${DATA_NIC_VERIFY}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/pin/reset    200    ${PIN_RESET}    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS


