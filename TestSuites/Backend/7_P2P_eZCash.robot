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

POST /api/beneficiary/p2p/beneficiary
    [Tags]    P2P_eZCash    Regression

    #    1. Send request: GET /api/beneficiary/p2p/beneficiary
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/beneficiary/p2p/beneficiary    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST /api/tokenization/p2p/sof
    [Tags]    P2P_eZCash    Regression

    #    1. Send request: GET /api/tokenization/p2p/sof
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/tokenization/p2p/sof    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST /api/tokenization/p2p/txn/request
    [Tags]    P2P_eZCash    Regression

    #    1. Generate Request ID from RequestIDLibrary.py

    Backend_CommonKeywords.Generate_Request_ID_And_Set_Variable    ${P2P_EZCASH_TXN_REQUEST}    requestId
    
    #    1. Send request: POST /api/tokenization/p2p/txn/request
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/tokenization/p2p/txn/request   200    ${P2P_EZCASH_TXN_REQUEST}    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

    #    4. Parse JSON response for ${response.content} into a Python dictionary
    #    5. Extract the DATA value

    ${json_data}=    Evaluate    json.loads('''${response.content}''')
    ${DATA}=    Set Variable    ${json_data['DATA']['txnToken']}

    #    6. Set ${Transaction Token} as a global variable

    Set Global Variable    ${P2P_TXN_TOKEN}    ${DATA}
    Log    ${P2P_TXN_TOKEN}

    #    7. Update the request_token field in the NIC_VALIDATE dictionary with the value of ${P2P_EZCASH_TXN}
        
    Set To Dictionary    ${P2P_EZCASH_TXN}    requestId=${request_id_new}    txnToken=${P2P_TXN_TOKEN}

POST /api/ezcash/p2p/payment
    [Tags]    P2P_eZCash    Regression

    #    1. Send request: POST /api/ezcash/p2p/payment
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/ezcash/p2p/payment   200    ${P2P_EZCASH_TXN}    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

