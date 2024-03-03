*** Settings ***
Documentation       Test Genie Onboarding API's

Suite Setup         DatabaseKeywords.Connecting_To_eZCash_Database
Suite Teardown      Disconnect From Database

Library             RequestsLibrary
Library             Collections
Library             OperatingSystem
Library             String
Library             JSONLibrary
Library             DatabaseLibrary
Resource            ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

*** Keywords ***
POST /api/tokenization/qr/sof
    [Documentation]    This API will be used to retrieve sof
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    Set Log Level    TRACE

    #    1. Send request: POST /api/auth/otp/request
    #    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/tokenization/qr/sof    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
    Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST /api/ezcash/lankaqr/payment
    [Documentation]    This API will be used to retrieve sof
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    Set Log Level    TRACE

    #    1. Generate Request ID from RequestIDLibrary.py

    Backend_CommonKeywords.Generate_Request_ID_And_Set_Variable    ${data}    requestId

    #    1. Send request: POST /api/auth/otp/request
    #    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/ezcash/lankaqr/payment    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
    Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

*** Test Cases ***
Resetting_eZCash_User_Status
    [Tags]    ScanQR    Regression    DB
    Resetting_eZCash_User

POST /api/tokenization/qr/sof - Fail
    [Documentation]    Send request with invalid mobile number and verifing response
    [Tags]    ScanQR    Regression
    [Template]    POST /api/tokenization/qr/sof

    ${SCAN_QR_INVALID_QR}    200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE    GET_QR_SOF_FAILED
    ...    STATUS    FAILED

POST /api/tokenization/qr/sof - Success
    [Documentation]    Send request with invalid mobile number and verifing response
    [Tags]    ScanQR    Regression
    [Template]    POST /api/tokenization/qr/sof

    ${SCAN_QR}    200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE    GET_QR_SOF_SUCCESS
    ...    STATUS    SUCCESS

    # eZ Cash
POST /api/ezcash/lankaqr/payment - Fail
    [Documentation]    Verify negative scenarios
...
...    = Descritpion =
...    - 1. Send request with invalid QR
...    - 2. Send request with invalid eZCash PIN (1st Incorrect eZCash PIN)
...    - 3. Send request with invalid eZCash PIN (2nd Incorrect eZCash PIN)
...    - 4. Send request with invalid eZCash PIN (PIN Block)

    [Tags]    ScanQR    Regression
    [Template]    POST /api/ezcash/lankaqr/payment
    
    ${SCAN_QR_INCORRECT_EZCASH_PIN}    200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE                PIN_ERROR
    ...    STATUS                 FAILED
    ...    ERROR_TYPE             INLINE
    ...    HEADER                 Sorry,
    ...    ERROR_DESCRIPTION      Invalid PIN
    
    ${SCAN_QR_INCORRECT_EZCASH_PIN}    200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE                PIN_ERROR
    ...    STATUS                 FAILED
    ...    ERROR_TYPE             INLINE
    ...    HEADER                 Sorry,
    ...    ERROR_DESCRIPTION      Invalid PIN
    
    ${SCAN_QR_INCORRECT_EZCASH_PIN}    200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE                PIN_ERROR
    ...    STATUS                 FAILED
    ...    ERROR_TYPE             POPUP
    ...    HEADER                 Sorry,
    ...    ERROR_DESCRIPTION      Your account has been blocked due to multiple failed attempts.

Resetting_eZCash_User_Status_After_PIN_Block
    [Tags]    ScanQR    Regression    DB
    Resetting_eZCash_User

POST /api/ezcash/lankaqr/payment - Success
    [Documentation]    Send request with valid mobile number and verifing response
    [Tags]    ScanQR    Regression
    [Template]    POST /api/ezcash/lankaqr/payment

    ${SCAN_QR_EZCASH}    200
    ...    Mention_actual_param    Mention_param_value
    ...    STATUS    SUCCESS
