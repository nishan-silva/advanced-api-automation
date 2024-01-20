*** Settings ***
Documentation       Test Genie Dashboard API's

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

*** Keywords ***



*** Test Cases ***
# Main APIs
GET /api/auth/product/list/v3 - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/auth/product/list/v3
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/auth/product/list/v3    200    ${request_headers}    ${timeout}
    
    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST /api/auth/notifications - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: POST /api/auth/notifications
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/notifications    200    ${GET_NOTIFICATIONS}    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST /api/auth/notifications - Incrrect type for count
    [Tags]    Dashboard    Regression

    #    1. Send request: POST /api/auth/notifications
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Run Keyword    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/notifications    200    ${GET_NOTIFICATIONS_INCORRECT_TYPE_COUNT}    ${request_headers}    ${TIMEOUT}

    


GET /api/auth/carousel/v2 - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/auth/carousel/v2
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/auth/carousel/v2    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

# Product APIs
GET /api/savings/v2/availability - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/savings/v2/availability
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/savings/v2/availability    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/ezloan/availability/v2 - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/ezloan/availability/v2
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/ezloan/availability/v2    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/auth/fd/availability
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/auth/fd/availability
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/auth/fd/availability    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/ezcash/profile/check/v3 - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/ezcash/profile/check/v3
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/ezcash/profile/check/v3    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/auth/starpoints/availability - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/auth/starpoints/availability
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/auth/starpoints/availability    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/auth/stocks/availability - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/auth/stocks/availability
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/auth/stocks/availability    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/auth/insureme/availability - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/auth/insureme/availability
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/auth/insureme/availability    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

GET /api/auth/mutualfunds/availability - Success
    [Tags]    Dashboard    Regression

    #    1. Send request: GET /api/auth/insureme/availability
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    ${BACKEND_URL}/api/auth/mutualfunds/availability    200    ${request_headers}    ${timeout}

    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS
