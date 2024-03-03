*** Settings ***
Documentation       Test Genie Onboarding API's

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Library    DatabaseLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

*** Keywords ***

GET /api/tokenization/p2p/sof
    [Documentation]    This API will be used to retrieve sof
    [Arguments]    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    Set Log Level    TRACE

    #    1. Send request: POST /api/tokenization/p2p/sof
    #    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/tokenization/p2p/sof    ${expected_status_code}    ${request_headers}    ${TIMEOUT}
    ${account_number}=    Capture_SOF_If_Available    ${response}    ezsavings
    Set Global Variable    ${account_number}
    Log To Console    ${account_number}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST /api/tokenization/p2p/txn/request
    [Documentation]    This API will be used to validate PIN and retrieve app token
    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    Set Log Level    TRACE

    #    1. Generate Request ID from RequestIDLibrary.py

    Backend_CommonKeywords.Generate_Request_ID_And_Set_Variable    ${data}    requestId

    #    1. Send request: POST /api/tokenization/p2p/txn/request
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/tokenization/p2p/txn/request    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
    ${TRAN_TOKEN_P2P_EZSAVINGS}=    Capture_Transaction_Token_If_Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${TRAN_TOKEN_P2P_EZSAVINGS}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}
    
POST /api/savings/p2p/txn/submit
    [Documentation]    This API will be used to validate PIN and retrieve app token
    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    Set Log Level    TRACE

    #    1. Send request: POST /api/savings/p2p/txn/submit
	#    2. Verify response status code: 200
    Run Keyword If    "${TRAN_TOKEN_P2P_EZSAVINGS}" != "None"    Set To Dictionary    ${data}    txnToken=${TRAN_TOKEN_P2P_EZSAVINGS}    requestId=${request_id_new}    maskedAccountNumber=${account_number}
    
    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/savings/p2p/txn/submit    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

*** Test Cases ***

GET /api/tokenization/p2p/sof - Success
    [Documentation]    Send request with valid data
    [Tags]    P2P_eZSavings    Regression
    [Template]    GET /api/tokenization/p2p/sof

           200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE       GET_ALL_SOF_SUCCESS
    ...    STATUS        SUCCESS

POST /api/tokenization/p2p/txn/request
    [Documentation]    Send request with valid data
    [Tags]    P2P_eZSavings    Regression
    [Template]   POST /api/tokenization/p2p/txn/request

    ${P2P_EZSAVINGS_TXN_REQUEST}    200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE       P2P_TXN_FEE_REQUEST_SUCCESS
    ...    STATUS        SUCCESS

POST /api/savings/p2p/txn/submit
    [Documentation]    Send request with valid data
    [Tags]    P2P_eZSavings    Regression
    [Template]   POST /api/savings/p2p/txn/submit

    ${P2P_EZSAVINGS_WITHOUT_OTP_TXN_REQUEST}    200
    ...    Mention_actual_param    Mention_param_value
    ...    MESSAGE       PAYMENT_RECEIVED
    ...    STATUS        SUCCESS