*** Settings ***
Documentation       Test Genie Onboarding API's

Suite Setup         DatabaseKeywords.Connecting_To_Database
Suite Teardown      Disconnect From Database

Library    RequestsLibrary    #https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#library-documentation-top
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Library    Process
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot
Resource    ../../KeywordLibraries/Backend/DatabaseKeywords.robot

*** Variables ***

*** Keywords ***

POST /api/auth/otp/request
    [Documentation]    This API will be used to call OTP
    
    Set Log Level    TRACE

    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200

        ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
	    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/otp/request    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
        Response Logs    ${response.status_code}    ${response.content}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

    #    5. Evaluate the response content as JSON

        ${json_data}=    Evaluate    json.loads('''${response.content}''')

    #    6. If 'REMAINING_TIME' is present in the JSON data, execute the following keywords

        Run Keyword If    'REMAINING_TIME' in ${json_data}    Set_Remaining_Time_Variable    ${json_data}
        Run Keyword If    'REMAINING_TIME' in ${json_data}    Wait_For_Remaining_Time    ${json_data["REMAINING_TIME"]}

POST /api/auth/otp/verify
    [Documentation]    This API will be used to validate OTP

    Set Log Level    TRACE

    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}     ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/verify
	#    2. Verify response status code: 200

    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/otp/verify     ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
    ${DATA_OTP_VERIFY_ONBOARDING}=    Capture_DATA_If_Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${DATA_OTP_VERIFY_ONBOARDING}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST /api/auth/nic/validate
    [Documentation]    This API will be used to validate NIC

    Set Log Level    TRACE

    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/verify
	#    2. Verify response status code: 200

    Run Keyword If    "${DATA_OTP_VERIFY_ONBOARDING}" != "None"    Set To Dictionary    ${data}    request_token=${DATA_OTP_VERIFY_ONBOARDING}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/nic/validate    ${expected_status_code}    ${data}       ${request_headers}    ${TIMEOUT}
    ${DATA_NIC_VERIFY_ONBOARDING}=    Capture DATA If Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${DATA_NIC_VERIFY_ONBOARDING}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}
    
POST /api/auth/pin
    [Documentation]    This API will be used to create app PIN

    Set Log Level    TRACE

    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/verify
	#    2. Verify response status code: 200

    Run Keyword If    "${DATA_NIC_VERIFY_ONBOARDING}" != "None"    Set To Dictionary    ${data}    request_token=${DATA_NIC_VERIFY_ONBOARDING}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/pin    ${expected_status_code}    ${data}       ${request_headers}    ${TIMEOUT}
    ${DATA_PIN_VERIFY}=    Capture DATA If Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${DATA_PIN_VERIFY}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST /api/auth/oauth/token
    [Documentation]    This API will be used to validate PIN and retrieve app token

    Set Log Level    TRACE

    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/verify
	#    2. Verify response status code: 200

    Run Keyword If    "${DATA_NIC_VERIFY_ONBOARDING}" != "None"    Set To Dictionary    ${data}    request_token=${DATA_NIC_VERIFY_ONBOARDING}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    ${BACKEND_URL}/api/auth/oauth/token    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
    ${APP_TOKEN_ONBOARDING}=    Capture access token If Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${APP_TOKEN_ONBOARDING}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

*** Test Cases ***

Deleting_user_if_available
    [Documentation]    
    ...    Removing data from fintech_user_status table
    ...    Removing data from fintech_users table
    ...    Removing data from otp_requests table
    ...    Removing data from pin_otp_requests table
    ...    Removing data from user_token table
    ...    Removing data from pins table

    [Tags]    Login    Dashboard    Regression    DB

    Execute SQL String    DELETE FROM fintech_user_status WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM fintech_users WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM otp_requests WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM pin_otp_requests WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM user_token WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM pins WHERE nic = '${ONBOARDING_NIC}'

POST /api/auth/otp/request - Success
    [Documentation]    Send request with correct data and verify response and status code
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request

   ${ONBOARDING_OTP_REQUEST}    200
   ...    Mention_actual_param           Mention_param_value
   ...    MESSAGE                        OTP_SEND_SUCCESS
   ...    STATUS                         SUCCESS

POST /api/auth/otp/verify - Success
    [Documentation]    Send request with correct data and verify response and status code
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/verify

    ${ONBOARDING_OTP_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_VERIFICATION_SUCCESS
    ...    STATUS                         SUCCESS

POST /api/auth/nic/validate - Success
    [Documentation]    Send request with correct data and verify response and status code
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/nic/validate

    ${ONBOARDING_NIC_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        FINTECH_USER_NOT_FOUND
    ...    STATUS                         SUCCESS

POST /api/auth/pin - Fail
    [Documentation]    Send request with pin mismatch
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/pin

    ${ONBOARDING_PIN_CREATE_PIN_MISMATCHING}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        PIN_MISMATCHING
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              PINs do not match

POST /api/auth/pin - Success
    [Documentation]    Send request with correct data and verify response and status code
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/pin

    ${ONBOARDING_PIN_CREATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        PIN_GENERATE_SUCCESS
    ...    STATUS                         SUCCESS

POST /api/auth/oauth/token - Success
    [Documentation]    Send request with correct data and verify response and status code
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/oauth/token

    ${ONBOARDING_ACCESS_TOKEN}    200
    ...    Mention_actual_param           Mention_param_value
    ...    token_type                     bearer
    ...    scope                          read

Deleting_user_from DB_after_user_creation
    [Documentation]    
    ...    Removing data from fintech_user_status table
    ...    Removing data from fintech_users table
    ...    Removing data from otp_requests table
    ...    Removing data from pin_otp_requests table
    ...    Removing data from user_token table
    ...    Removing data from pins table

    [Tags]    Login    Dashboard    Regression    DB

    Execute SQL String    DELETE FROM fintech_user_status WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM fintech_users WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM otp_requests WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM pin_otp_requests WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM user_token WHERE mobile_number = '${ONBOARDING_MOBILE_NUMBER}'
    Execute SQL String    DELETE FROM pins WHERE nic = '${ONBOARDING_NIC}'
