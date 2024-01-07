# Common Parameters
OTP = "123456"
CLIENT_SECRET = "7586c612-8f4b-4823-978b-2554ce8e20b3"

# Onboarding Parameters
ONBOARDING_MOBILE_NUMBER = "790010157"
ONBOARDING_DEVICE_ID = "1989nishans19892"
ONBOARDING_NIC = "198900903257"
ONBOARDING_MOBILE_APP_PIN = "9113b98df80f877c7a2ee5d865a04c9514b4e9bf25a49d315b0b15f115d2f0d2"

# Login Headers
APP_VERSION= "0.1.14"
CHECK_SUM= "eyG2XYD8OGGR7LaJmyyw0Rz1Te8="
CONTENT_TYPE= "application/json "

# Login Parameters
LOGIN_MOBILE_NUMBER = "773330123"
LOGIN_DEVICE_ID = "1989nishans1989"
LOGIN_NIC = "890093194V"
LOGIN_MOBILE_APP_PIN = "9113b98df80f877c7a2ee5d865a04c9514b4e9bf25a49d315b0b15f115d2f0d2"

# QR
EZCASH_QR= "0002010102122632002816995001401000077733260800005204481454072763.7653031445802LK5913Dialog Mobile6007Colombo621605120007773326086304B2AB"

# P2P
RECEPIENT_MOBILE_NO= "769144852"


##########################################################################################################
# Don't change  below requests
##########################################################################################################
# Success Scenario Test Data 
    # Login
LOGIN_OTP_REQUEST=  {"mobile_number": LOGIN_MOBILE_NUMBER, "device_id": LOGIN_DEVICE_ID, "language": "English", "country_code": "94", "device_details": "Android"}
LOGIN_OTP_REQUEST_INVALID_MOBILE_NUMBER=  {"mobile_number": "7733301234", "device_id": LOGIN_DEVICE_ID, "language": "English", "country_code": "94", "device_details": "Android"}
LOGIN_OTP_REQUEST_NULL_MOBILE_NUMBER=  {"mobile_number": "", "device_id": LOGIN_DEVICE_ID, "language": "English", "country_code": "94", "device_details": "Android"}

LOGIN_OTP_VALIDATE= {"mobile_number": LOGIN_MOBILE_NUMBER, "device_id": LOGIN_DEVICE_ID, "otp_code": OTP, "country_code": "94"}
LOGIN_OTP_VALIDATE_INVALID_OTP= {"mobile_number": LOGIN_MOBILE_NUMBER, "device_id": LOGIN_DEVICE_ID, "otp_code": 123475, "country_code": "94"}
LOGIN_OTP_VALIDATE_INVALID_MOBILE_NUMBER= {"mobile_number": "7733301234", "device_id": LOGIN_DEVICE_ID, "otp_code": OTP, "country_code": "94"}
LOGIN_OTP_VALIDATE_OTP_NOT_REQUESTED= {"mobile_number": LOGIN_MOBILE_NUMBER, "device_id": "abc123", "otp_code": OTP, "country_code": "94"}


LOGIN_NIC_VALIDATE= {"nic": LOGIN_NIC, "device_id": LOGIN_DEVICE_ID, "request_token": ""}
LOGIN_NIC_VALIDATE_NIC_USED= {"nic": "890093195V", "device_id": LOGIN_DEVICE_ID, "request_token": ""}
LOGIN_NIC_VALIDATE_OTP_NOT_REQUESTED= {"nic": LOGIN_NIC, "device_id": "defferentDID", "request_token": ""}
LOGIN_NIC_VALIDATE_OTP_INVALID_NIC= {"nic": "890093194G", "device_id": LOGIN_DEVICE_ID, "request_token": ""}


LOGIN_ACCESS_TOKEN= {"grant_type": "password", "client_id": "mobile_api_client", "auth_type": "pin", "one_signal_id": "dnKv2Qu8iSo:APA91bGQNZG_XqPA9fOFMYo2yQNMeU4IUENlC2PSx0HgLJh8VK4TTNfy5dq4cDscWjLH0E1OufykSZTgli9JJTbYjiPydZhI_swQLVhmOj0AB1ZMKBi5etsJoKt3R3UBwWL6rdiPaZBD", "request_token": "", "pin": LOGIN_MOBILE_APP_PIN, "client_secret": CLIENT_SECRET, "device_id": LOGIN_DEVICE_ID, "platform": "android", "language": "English"}
LOGIN_ACCESS_TOKEN_UNSUPPORTED_GRANT_TYPE= {"grant_type": "passwor", "client_id": "mobile_api_client", "auth_type": "pin", "one_signal_id": "dnKv2Qu8iSo:APA91bGQNZG_XqPA9fOFMYo2yQNMeU4IUENlC2PSx0HgLJh8VK4TTNfy5dq4cDscWjLH0E1OufykSZTgli9JJTbYjiPydZhI_swQLVhmOj0AB1ZMKBi5etsJoKt3R3UBwWL6rdiPaZBD", "request_token": "", "pin": LOGIN_MOBILE_APP_PIN, "client_secret": CLIENT_SECRET, "device_id": LOGIN_DEVICE_ID, "platform": "android", "language": "English"}
LOGIN_ACCESS_TOKEN_INVALID_BAD_CLIENT_CREDENTIALS= {"grant_type": "password", "client_id": "mobile_api_clien", "auth_type": "pin", "one_signal_id": "dnKv2Qu8iSo:APA91bGQNZG_XqPA9fOFMYo2yQNMeU4IUENlC2PSx0HgLJh8VK4TTNfy5dq4cDscWjLH0E1OufykSZTgli9JJTbYjiPydZhI_swQLVhmOj0AB1ZMKBi5etsJoKt3R3UBwWL6rdiPaZBD", "request_token": "", "pin": LOGIN_MOBILE_APP_PIN, "client_secret": CLIENT_SECRET, "device_id": LOGIN_DEVICE_ID, "platform": "android", "language": "English"}
LOGIN_ACCESS_TOKEN_INVALID_PIN= {"grant_type": "password", "client_id": "mobile_api_client", "auth_type": "pin", "one_signal_id": "dnKv2Qu8iSo:APA91bGQNZG_XqPA9fOFMYo2yQNMeU4IUENlC2PSx0HgLJh8VK4TTNfy5dq4cDscWjLH0E1OufykSZTgli9JJTbYjiPydZhI_swQLVhmOj0AB1ZMKBi5etsJoKt3R3UBwWL6rdiPaZBD", "request_token": "", "pin": "b7768fbb1847758d75c3ee28c3e2391e70c6ee29f7ce19847822bd5a7381ac67", "client_secret": CLIENT_SECRET, "device_id": LOGIN_DEVICE_ID, "platform": "android", "language": "English"}



    # Onboarding
ONBOARDING_OTP_REQUEST=  {"mobile_number": ONBOARDING_MOBILE_NUMBER, "device_id": ONBOARDING_DEVICE_ID, "language": "English", "country_code": "94", "device_details": "Android"}
ONBOARDING_OTP_VALIDATE= {"mobile_number": ONBOARDING_MOBILE_NUMBER, "device_id": ONBOARDING_DEVICE_ID, "otp_code": OTP, "country_code": "94"}
ONBOARDING_NIC_VALIDATE= {"nic": ONBOARDING_NIC, "device_id": ONBOARDING_DEVICE_ID, "request_token": ""}
ONBOARDING_PIN_CREATE= {"pin_code":"1989", "request_token":"", "confirm_code":"1989"}
ONBOARDING_ACCESS_TOKEN= {"grant_type": "password", "client_id": "mobile_api_client", "auth_type": "pin", "one_signal_id": "dnKv2Qu8iSo:APA91bGQNZG_XqPA9fOFMYo2yQNMeU4IUENlC2PSx0HgLJh8VK4TTNfy5dq4cDscWjLH0E1OufykSZTgli9JJTbYjiPydZhI_swQLVhmOj0AB1ZMKBi5etsJoKt3R3UBwWL6rdiPaZBD", "request_token": "", "pin": ONBOARDING_MOBILE_APP_PIN, "client_secret": CLIENT_SECRET, "device_id": ONBOARDING_DEVICE_ID, "platform": "android", "language": "English"}
ONBOARDING_CRM_ACCESS_TOKEN= {"grant_type": "password", "client_id": "information_client", "auth_type": "crm_agent", "secret": "0c359af8-e2a7-11ea-87d0-0242ac130003","client_secret":"e4cba758-9feb-11ea-bb37-0242ac130002"}
ONBOARDING_DELETE_USER= {"mobileNumber": ONBOARDING_MOBILE_NUMBER,"nic": ONBOARDING_NIC}

    # Dashboard 
GET_NOTIFICATIONS= {"count":5}
GET_NOTIFICATIONS_MISSING_MANDATORY_PARAMETER_NAME= {"count": None}
GET_NOTIFICATIONS_INCORRECT_TYPE_COUNT= {"count": ""}

    # Forgot PIN
FORGOT_PIN= {"request_token":""}
QUESTION_VERIFY= {"request_token":"", "nic": LOGIN_NIC}
VERIFY_FORGOT_PIN_OTP= {"request_token":"", "otp": OTP}
PIN_RESET= {"pin_code": "1989", "confirm_code": "1989", "request_token":""}

    # Change Language
LANGUAGE_CHANGE= {"language": "Sinhala"}

    #Scan QR
SCAN_QR= {"payload": EZCASH_QR}

    # Scan QR - eZ Cash Payment
SCAN_QR_EZCASH= {"customerPin": "1234", "payload": EZCASH_QR, "requestId": "", "txAmount": "10.37", "txReference": "reference"}

    #P2P eZCash
P2P_EZCASH_TXN_REQUEST= {"recepientMobile": RECEPIENT_MOBILE_NO, "recepientName": "Nishan adl", "requestId": "", "senderName": "siddika", "sofType": "ezcash", "txAmount": "10.00", "txnReference": "reference"}
P2P_EZCASH_TXN= {"customerPin": "1234", "requestId": "", "txnToken": "579fe381b148d1c7cc71659eb0cb59065a401a5dc14ffee34430a9cddf51c775"}

    #P2P eZSavings
P2P_EZSAVINGS_WITHOUT_OTP_TXN_REQUEST= {"txnToken":"00020101021126320028169950", "maskedAccountNumber":"", "requestId":"20190924080", "txReference":"txReference"}


# Negative Scenario Test Data