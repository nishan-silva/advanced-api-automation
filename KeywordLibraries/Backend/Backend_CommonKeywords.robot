*** Settings ***
Documentation    Keywords that can be used in all suites are stored here.
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    random
Library    String
Library      ../../CustomLibraries/RequestIDLibrary.py    WITH NAME    RequestIDLibrary
Variables    ../../TestData/Staging_Backend_TestData.py
Variables    ../../TestData/QA_Backend_TestData.py

*** Variables ***
${BACKEND_URL}=         ${ENV_BACKEND_PROTOCOL}://${ENV_BACKEND_HOST}
${TIMEOUT}=     15
${APP_TOKEN}
${CRM_TOKEN}

*** Keywords ***

Calling_API_POST
    [Arguments]    ${endpoint}    ${expected_status_code}    ${data}    ${headers}    ${timeout}
    ${response}=    Run Keyword    RequestsLibrary.POST    ${endpoint}    json=${data}    expected_status=${expected_status_code}     headers=${headers}    timeout=${TIMEOUT}
    ${parsed_response}=     Set Variable    ${response.json()}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status_code}
    [Return]    ${response}

Calling_API_GET
    [Arguments]    ${endpoint}    ${expected_status_code}   ${headers}    ${timeout}
    ${response}=    Run Keyword    RequestsLibrary.GET    ${endpoint}   headers=${headers}    timeout=${TIMEOUT}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status_code}
    [Return]    ${response}

Onboarding_Headers
    ${request_headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}   app_version=${APP_VERSION}   check_sum=${CHECK_SUM}
    [Return]    ${request_headers}

Token_Headers
    ${request_headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${APP_TOKEN}
    [Return]    ${request_headers}

CRM_Token_Headers
    ${request_headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${CRM_TOKEN}
    [Return]    ${request_headers}
    
Response_Logs
    [Arguments]    ${status_code}    ${content}
    Log To Console    ${status_code}
    Log To Console    ${content}
    Log To Console    ${content.decode('utf-8')}

Generate_Mobile_No
    [Arguments]    ${mobile_No_file_path}    ${datasheet_parameter}    ${request_body_parameter}
    ${current_value}=    Get File    ${mobile_No_file_path}
    ${current_value}=    Convert To Integer    ${current_value}
    ${updated_value}=    Evaluate    ${current_value} + 1
    Backend_CommonKeywords.Replace File Content    ${mobile_No_file_path}    ${current_value}    ${updated_value}

    ${LATEST_NUMBER}=    Convert To String    ${updated_value}

    Set Global Variable    ${LATEST_NUMBER}

    Set To Dictionary    ${datasheet_parameter}    ${request_body_parameter}=${LATEST_NUMBER}

Replace File Content
    [Arguments]    ${file_path}    ${old_value}    ${new_value}
    ${file_contents}=    Get File    ${file_path}
    ${updated_contents}=    Set Variable    ${file_contents.replace(str(${old_value}), str(${new_value}))}
    Remove File    ${file_path}
    Create File    ${file_path}    ${updated_contents}

Generate_Request_ID_And_Set_Variable
    [Arguments]    ${datasheet_parameter}    ${request_body_parameter}
    ${request_id}=    RequestIDLibrary.Get Request ID
    ${request_id_new}=    Convert To String    ${request_id}
    
    Set Global Variable    ${request_id_new}
    
    ${datasheet_parameter}=    Set To Dictionary    ${datasheet_parameter}    ${request_body_parameter}=${request_id_new}

    Log    Generated Request ID: ${request_id_new}
    Log To Console    ${request_id_new}

SOF_Account_Numbers_Finder
    [Arguments]    ${response_content}    ${sof_name}    ${datasheet_parameter}    ${request_body_parameter}
    ${parsed}=    Evaluate    json.loads($response_content)
    ${filtered_responses}=    Evaluate    [response['accountNumber'] for response in $parsed['DATA']['sofResponses'] if response['sofName'] == '${sof_name}']
    ${sof_account_number}=    Evaluate    ', '.join($filtered_responses) if $filtered_responses else 'No matching sofName found'
    Log To Console    Account Number(s) for '${sof_name}': ${sof_account_number}
    Convert To String    ${sof_account_number}
    Set Global Variable    ${sof_account_number}
    ${datasheet_parameter}=    Set To Dictionary    ${datasheet_parameter}    ${request_body_parameter}=${sof_account_number}
    #${datasheet_parameter}=    Set Variable If    '${sof_account_number}' != 'No matching sofName found'    ${datasheet_parameter}    ${request_body_parameter}=${sof_account_number}

#################################
#Login
#################################

Wait_For_Remaining_Time
    [Arguments]    ${remaining_time}
    Sleep    ${remaining_time}

Set_Remaining_Time_Variable
    [Arguments]    ${json_data}
    ${remaining_time}=    Set Variable    ${json_data["REMAINING_TIME"]}
    [Return]    ${remaining_time}

Capture_DATA_If_Available
    [Arguments]    ${response}
    ${json_data}=    Evaluate    json.loads('''${response.content}''')
    ${data_otp_verify}=    Set Variable If    '${json_data.get("DATA")}' != 'None'    ${json_data["DATA"]}    None
    ${capture_access_token}=    Set Variable If    '${json_data.get("access_token")}' != 'None'    ${json_data["access_token"]}    None

    [Return]    ${data_otp_verify}

Capture_Access_Token_If_Available
    [Arguments]    ${response}
    ${json_data}=    Evaluate    json.loads('''${response.content}''')
    ${data_otp_verify}=    Set Variable If    '${json_data.get("access_token")}' != 'None'    ${json_data["access_token"]}    None
    [Return]    ${data_otp_verify}

Validating_Response_Message
    [Arguments]    ${actual_response}    ${parameter_name}    ${expected_value}
    ${response_dict}=    Evaluate    json.loads($actual_response)    json
    ${actual_parameter_value}=    Get From Dictionary    ${response_dict}    ${parameter_name}
    Should Be Equal As Strings    ${actual_parameter_value}    ${expected_value}

Response_Validation_Parameters
    [Arguments]    ${response_content}    @{expected_values}
    ${length}=    Get Length    ${expected_values}
        FOR    ${index}    IN RANGE    0    ${length}    2
        ${expected_param}=    Set Variable    ${expected_values}[${index}]
        ${expected_value}=    Set Variable    ${expected_values}[${index + 1}]
        Backend_CommonKeywords.Validating_Response_Message    ${response_content}    ${expected_param}    ${expected_value}
        END
    [Return]    ${response_content}