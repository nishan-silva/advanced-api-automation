*** Settings ***
Documentation       Test Genie Onboarding API's

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    JSONLibrary
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot
Resource    ../../KeywordLibraries/Backend/Backend_CommonKeywords.robot

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

     Backend_CommonKeywords.Response_Validation_Parameters    ${response}

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

     Backend_CommonKeywords.Response_Validation_Parameters    ${response}

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

     Backend_CommonKeywords.Response_Validation_Parameters    ${response}
    

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

     Backend_CommonKeywords.Response_Validation_Parameters    ${response}

*** Test Cases ***
POST /api/auth/otp/request - Fail - Invalid mandatory parameters
    [Documentation]    Failure
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request
    
    ${LOGIN_OTP_REQUEST_INVALID_MOBILE_NUMBER}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        INVALID_MOBILE_NUMBER
    ...    STATUS                         FAILED
    ...    ERROR_DESCRIPTION              Invalid mobile number

POST /api/auth/otp/request - Success
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request

   ${LOGIN_OTP_REQUEST}    200
   ...    Mention_actual_param           Mention_param_value
   ...    MESSAGE                        OTP_SEND_SUCCESS
   ...    STATUS                         SUCCESS

POST /api/auth/otp/verify - Fail
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
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request

    #    1. Send request: POST /api/auth/otp/request
	#    2. Verify response status code: 200
    #    3. Verify MESSAGE value OTP_ALREADY_REQUESTED
    
    ${LOGIN_OTP_REQUEST}    200
    ...    Mention_actual_param           Mention_param_value
    ...    STATUS                         FAILED
    
POST /api/auth/otp/verify - Fail - OTP Expired
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/verify

    ${LOGIN_OTP_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_EXPIRED
    
Resend POST /api/auth/otp/request
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/request

    ${LOGIN_OTP_REQUEST}    200
    ...    Mention_actual_param           Mention_param_value  
    ...    MESSAGE                        OTP_SEND_SUCCESS

POST /api/auth/otp/verify - Success
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/otp/verify

    ${LOGIN_OTP_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        OTP_VERIFICATION_SUCCESS
    ...    STATUS                         SUCCESS

POST /api/auth/nic/validate - Fail
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
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/nic/validate

    ${LOGIN_NIC_VALIDATE}    200
    ...    Mention_actual_param           Mention_param_value
    ...    MESSAGE                        FINTECH_USER_AVAILABLE
    ...    STATUS                         SUCCESS
    ...    IS_CUSTOMER_NAME_AVAILABLE     False
    ...    IS_CUSTOMER_EMAIL_AVAILABLE    False

POST /api/auth/oauth/token - Fail
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

        #${LOGIN_ACCESS_TOKEN_INVALID_PIN}    401
    #...    error    invalid_request
    #...    error_description        Your account has been blocked due to multiple failed attempts.
   
POST /api/auth/oauth/token - Success
    [Tags]    Login    Dashboard    Regression
    [Template]    POST /api/auth/oauth/token

    ${LOGIN_ACCESS_TOKEN}    200
    ...    Mention_actual_param           Mention_param_value
    ...    token_type                     bearer
    ...    scope                          read
