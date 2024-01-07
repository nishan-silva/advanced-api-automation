*** Settings ***
Documentation       Test Genie Onboarding API's

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Library    Process
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

*** Variables ***

*** Test Cases ***
POST /api/auth/otp/request - Success
    [Tags]    Onboarding    Dashboard    Regression

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200
    
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/otp/request    200    ${ONBOARDING_OTP_REQUEST}    ${request_headers}   ${TIMEOUT}
    Response Logs    ${response.status_code}    ${response.content}

    #    3. Verify json response body message: MESSAGE: OTP_SEND_SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    MESSAGE    OTP_SEND_SUCCESS

POST /api/auth/otp/verify - Success
    [Tags]    Onboarding    Dashboard    Regression

    #    1. Send request: POST /api/auth/otp/verify
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/otp/verify    200    ${ONBOARDING_OTP_VALIDATE}    ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: MESSAGE: OTP_VERIFICATION_SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    MESSAGE    OTP_VERIFICATION_SUCCESS

    #    4. Parse JSON response for ${response.content} into a Python dictionary
    #    5. Extract the DATA value

    ${json_data}=    Evaluate    json.loads('''${response.content}''')
    ${DATA}=    Set Variable    ${json_data["DATA"]}

    #    6. Set ${DATA_OTP_VERIFY} as a global variable

    Set Global Variable    ${DATA_OTP_VERIFY}    ${DATA}
    Log    ${DATA_OTP_VERIFY}

    #    7. Update the request_token field in the NIC_VALIDATE dictionary with the value of ${DATA_OTP_VERIFY}
        
    Set To Dictionary    ${ONBOARDING_NIC_VALIDATE}    request_token=${DATA_OTP_VERIFY}

POST /api/auth/nic/validate - Success
    [Tags]    Onboarding    Dashboard    Regression

    #    1. Send request: POST /api/auth/nic/validate
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/nic/validate    200    ${ONBOARDING_NIC_VALIDATE}       ${request_headers}    ${TIMEOUT}

    #    3. Verify json response body message: MESSAGE: PIN_GENERATE_SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

    #    4. Parse JSON response for ${response.content} into a Python dictionary
    #    5. Extract the DATA value

    ${json_data}=    Evaluate    json.loads('''${response.content}''')
    ${DATA}=    Set Variable    ${json_data["DATA"]}

    #    6. Set ${DATA_OTP_VERIFY} as a global variable

    Set Global Variable    ${DATA_NIC_VERIFY}    ${DATA}
    Log    ${DATA_NIC_VERIFY}

    #    7. Update the request_token field in the NIC_VALIDATE dictionary with the value of ${DATA_NIC_VERIFY}

    Set To Dictionary    ${ONBOARDING_ACCESS_TOKEN}        request_token=${DATA_NIC_VERIFY}
    Set To Dictionary    ${ONBOARDING_PIN_CREATE}          request_token=${DATA_NIC_VERIFY}

POST /api/auth/pin
    [Tags]    Onboarding    Regression

    #    1. Send request: POST /api/auth/pin
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/pin    200    ${ONBOARDING_PIN_CREATE}    ${request_headers}    ${TIMEOUT}
    Response Logs    ${response.status_code}    ${response.content}

    #    3. Verify json response body message: MESSAGE: PIN_GENERATE_SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    MESSAGE    PIN_GENERATE_SUCCESS

POST /api/auth/app/version?installedVersion=0.3.40
    [Tags]    Onboarding    Regression

    #    1. Send request: POST /api/auth/app/version?installedVersion=0.3.40
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_GET    GET    ${BACKEND_URL}/api/auth/app/version?installedVersion=0.3.40    200    ${request_headers}    ${timeout}
    
    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

POST /api/auth/oauth/token
    [Tags]    Onboarding    Regression

    #    1. Send request: POST /api/auth/oauth/token
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/oauth/token    200     ${ONBOARDING_CRM_ACCESS_TOKEN}    ${request_headers}    ${timeout}

        #    3. Verify json response body message: scope: scope

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    scope    read

    #    4. Parse JSON response for ${response.content} into a Python dictionary
    #    5. Extract the access_token value

    ${json_data}=    Evaluate    json.loads('''${response.content}''')
    ${DATA}=    Set Variable    ${json_data["access_token"]}

    #    6. Set ${APP_TOKEN} as a global variable

    Set Global Variable    ${CRM_TOKEN}    ${DATA}
    Log    ${CRM_TOKEN}


POST /api/auth/admin/delete/basic/customer
    [Tags]    Onboarding    Regression

    #    1. Send request: POST /api/auth/crm/delete/basic/customer
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.CRM_Token_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/admin/delete/basic/customer    200     ${ONBOARDING_DELETE_USER}    ${request_headers}    ${timeout}
    
    #    3. Verify json response body message: STATUS: SUCCESS

    Backend_CommonKeywords.Validating_Response_Message    ${response.content}    STATUS    SUCCESS

    