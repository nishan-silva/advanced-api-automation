*** Settings ***
Documentation       Test Genie Onboarding API's

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Library    DatabaseLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

*** Variables ***

*** Test Cases ***
POST /api/tokenization/qr/sof
    [Tags]    ScanQR    Regression
    
    #    1. Send request: GET /api/tokenization/qr/sof
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/tokenization/qr/sof    200    ${SCAN_QR}    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

    # eZ Cash
POST /api/ezcash/lankaqr/payment
    [Tags]    ScanQR    Regression

    #    1. Generate Request ID from RequestIDLibrary.py

    Backend_CommonKeywords.Generate_Request_ID_And_Set_Variable    ${SCAN_QR_EZCASH}    requestId
    
    #    2. Send request: POST /api/ezcash/lankaqr/payment
	#    3. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/ezcash/lankaqr/payment    200    ${SCAN_QR_EZCASH}    ${request_headers}    ${timeout}

    #    4. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS
