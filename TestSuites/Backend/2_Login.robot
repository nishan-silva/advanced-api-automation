*** Settings ***
Documentation       Test Genie Onboarding API's

Suite Setup         DatabaseKeywords.Connecting_To_Database
Suite Teardown      Disconnect From Database

Library    RequestsLibrary    #https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#library-documentation-top
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot
Resource    ../../KeywordLibraries/Backend/DatabaseKeywords.robot

*** Keywords ***

POST /api/auth/otp/request
    [Documentation]    This API will be used to call OTP
    
    Set Log Level    TRACE

    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200

        ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
	    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/otp/request    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
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
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/otp/verify     ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
    ${DATA_OTP_VERIFY}=    Capture_DATA_If_Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${DATA_OTP_VERIFY}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

POST /api/auth/nic/validate
    [Documentation]    This API will be used to validate NIC

    Set Log Level    TRACE

    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/verify
	#    2. Verify response status code: 200

    Run Keyword If    "${DATA_OTP_VERIFY}" != "None"    Set To Dictionary    ${data}    request_token=${DATA_OTP_VERIFY}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/nic/validate    ${expected_status_code}    ${data}       ${request_headers}    ${TIMEOUT}
    ${DATA_NIC_VERIFY}=    Capture DATA If Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${DATA_NIC_VERIFY}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}
    

POST /api/auth/oauth/token
    [Documentation]    This API will be used to validate PIN and retrieve app token

    Set Log Level    TRACE

    [Tags]    Login    Dashboard    Regression
    [Arguments]    ${data}    ${expected_status_code}    ${parameter_name}    ${expected_value}    @{expected_values}

    #    1. Send request: POST /api/auth/otp/verify
	#    2. Verify response status code: 200

    Run Keyword If    "${DATA_NIC_VERIFY}" != "None"    Set To Dictionary    ${data}    request_token=${DATA_NIC_VERIFY}
    ${request_headers}=    Backend_CommonKeywords.Onboarding_Headers
    ${response}=    Backend_CommonKeywords.Calling_API_POST    POST    ${BACKEND_URL}/api/auth/oauth/token    ${expected_status_code}    ${data}    ${request_headers}    ${TIMEOUT}
    ${APP_TOKEN}=    Capture access token If Available    ${response}  # Capture OTP data from the response if available
    Set Global Variable    ${APP_TOKEN}

    #    3. Call the keyword to validate the response parameter and its expected value

    Backend_CommonKeywords.Response_Validation_Parameters    ${response.content}    ${expected_values}

*** Test Cases ***

Resetting_User_Status
    [Documentation]    
    ...    Reset the user before starting the test.
    ...    Set fintech user status to 5
    ...    Set pin attempt count to 0
    ...    Update created date in to old date
    ...    Set pin otp request count to 0
    
    [Tags]    Login    Dashboard    Regression    DB
    Execute SQL String    UPDATE fintech_user_status SET status = '5' WHERE mobile_number = '${LOGIN_MOBILE_NUMBER}'
    Execute SQL String    UPDATE pins SET pin_attempt_count = '0' WHERE nic = '${LOGIN_NIC}'
    Execute SQL String    UPDATE otp_requests SET request_count = '0' WHERE mobile_number = '${LOGIN_MOBILE_NUMBER}' AND device_id = '${LOGIN_DEVICE_ID}'
    Execute SQL String    UPDATE otp_requests SET created_date = '2024-01-12 18:53:21.561' WHERE mobile_number = '${LOGIN_MOBILE_NUMBER}' AND device_id = '${LOGIN_DEVICE_ID}'
    Execute SQL String    UPDATE pin_otp_requests SET otp_request_count = '0' WHERE mobile_number = '${LOGIN_MOBILE_NUMBER}'

POST /api/auth/otp/request - Fail - Invalid mandatory parameters
    [Documentation]    Send request with invalid mobile number and verifing response
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request
    
    ${LOGIN_OTP_REQUEST_INVALID_MOBILE_NUMBER}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        INVALID_MOBILE_NUMBER
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              Invalid mobile number

POST /api/auth/otp/request - Success
    [Documentation]    Send request with correct data and verify response and status code
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request

   ${LOGIN_OTP_REQUEST}    200
   ...    Mention_actual_param           Mention_param_value
   ...    MESSAGE                        OTP_SEND_SUCCESS
   ...    STATUS                         SUCCESS

POST /api/auth/otp/verify - Fail
    [Documentation]
    ...    Send request with 1st invalid OTP request and status code
    ...    Send request with 2nd invalid OTP request and status code
    ...    Send request with 3rd invalid OTP request and status code
    ...    Send request with invalid mobile number and status code
    ...    Send request with different device ID and status code

    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/verify

    ${LOGIN_OTP_VALIDATE_INVALID_OTP}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_INVALID
    ...    STATUS                         FAILED
    ...    REMAINING_COUNT                2
    ...    ERROR_DESCRIPTION              Invalid OTP
 
    ${LOGIN_OTP_VALIDATE_INVALID_OTP}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_INVALID
    ...    STATUS                         FAILED
    ...    REMAINING_COUNT                1
    ...    ERROR_DESCRIPTION              Invalid OTP
 
    ${LOGIN_OTP_VALIDATE_INVALID_OTP}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_VERIFY_ATTEMPT_EXCEEDED
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              OTP tries exceeded. Try again after some time.
    
    ${LOGIN_OTP_VALIDATE_INVALID_MOBILE_NUMBER}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        INVALID_MOBILE_NUMBER
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              Invalid mobile number

    ${LOGIN_OTP_VALIDATE_OTP_NOT_REQUESTED}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_NOT_REQUESTED
    ...    STATUS                         FAILED
    
POST /api/auth/otp/request - Fail - OTP already requested
    [Documentation]    Send request again during the 1 minuite
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request
    
    ${LOGIN_OTP_REQUEST}    200
    ...    Mention_actual_param           Mention_param_value
    ...    STATUS                         FAILED
    
POST /api/auth/otp/verify - Fail - OTP Expired
    [Documentation]    Send request after one minuite
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/verify

    ${LOGIN_OTP_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_EXPIRED
    
Resend POST /api/auth/otp/request
    [Documentation]    Resend request after one minuite
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request

    ${LOGIN_OTP_REQUEST}    200
    ...    Mention_actual_param           Mention_param_value  
    ...    MESSAGE                        OTP_SEND_SUCCESS

POST /api/auth/otp/verify - Success
    [Documentation]    Send request with correct data
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/verify

    ${LOGIN_OTP_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_VERIFICATION_SUCCESS
    ...    STATUS                         SUCCESS

POST /api/auth/nic/validate - Fail
    [Documentation]    
    ...    Send request with and NIC which has been tagged with other mobile number
    ...    Send request with different device ID
    ...    Send request with invalid NIC number
    
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/nic/validate

    ${LOGIN_NIC_VALIDATE_NIC_USED}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        NIC_USED
    ...    STATUS                         FAILED

    ${LOGIN_NIC_VALIDATE_OTP_NOT_REQUESTED}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_NOT_REQUESTED
    ...    STATUS                         FAILED

    ${LOGIN_NIC_VALIDATE_OTP_INVALID_NIC}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        INVALID_NIC
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              Invalid NIC number

POST /api/auth/nic/validate - Success
    [Documentation]    Send request with correct data
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/nic/validate

    ${LOGIN_NIC_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        FINTECH_USER_AVAILABLE
    ...    STATUS                         SUCCESS
    ...    IS_CUSTOMER_NAME_AVAILABLE     False
    ...    IS_CUSTOMER_EMAIL_AVAILABLE    False

POST /api/auth/oauth/token - Fail
    [Documentation]    
    ...    Send request with incorrect grant type
    ...    Send request with incorrect client credentials
    ...    Send request with incorrect 1st PIN
    ...    Send request with incorrect 2nd PIN
    ...    Send request with incorrect 3rd PIN
    
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/oauth/token

    ${LOGIN_ACCESS_TOKEN_UNSUPPORTED_GRANT_TYPE}    401
    ...    Mention_actual_param           Mention_param_value
    ...    error                          invalid_request
    ...    error_description              Invalid request

    ${LOGIN_ACCESS_TOKEN_INVALID_BAD_CLIENT_CREDENTIALS}    401
    ...    Mention_actual_param           Mention_param_value
    ...    error                          invalid_client
    ...    error_description              Bad client credentials

    ${LOGIN_ACCESS_TOKEN_INVALID_PIN}    401
    ...    Mention_actual_param           Mention_param_value
    ...    error                          invalid_request
    ...    error_description              Invalid PIN. 02 more attempts remaining

    ${LOGIN_ACCESS_TOKEN_INVALID_PIN}    401
    ...    Mention_actual_param           Mention_param_value
    ...    error                          invalid_request
    ...    error_description              Invalid PIN. Next invalid attempt will block you.

    ${LOGIN_ACCESS_TOKEN_INVALID_PIN}    401
    ...    error                          invalid_request
    ...    error_description              Your account has been blocked due to multiple failed attempts.|60

Resetting_User_Status_After_PIN_Block
    [Documentation]    Reset user status after pin block
    [Tags]    Login    Dashboard    Regression    DB
    Query    SELECT * FROM fintech_user_status WHERE mobile_number = '${LOGIN_MOBILE_NUMBER}';
    Execute SQL String    UPDATE fintech_user_status SET status = '5' WHERE mobile_number = '${LOGIN_MOBILE_NUMBER}'
    Execute SQL String    UPDATE pins SET pin_attempt_count = '0' WHERE nic = '${LOGIN_NIC}'

POST /api/auth/oauth/token - Success
    [Documentation]    FailureSend request with correct data
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/oauth/token

    ${LOGIN_ACCESS_TOKEN}    200
    ...    Mention_actual_param           Mention_param_value
    ...    token_type                     bearer
    ...    scope                          read
