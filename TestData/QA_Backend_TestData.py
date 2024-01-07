# Common Parameters
OTP = "123456"
CLIENT_SECRET = "6f6b8a16-e356-4850-bdde-423d36321940"

# Login Parameters
LOGIN_MOBILE_NUMBER = "790010110"
LOGIN_DEVICE_ID = "1989nishans1989"
LOGIN_NIC = "890093210V"
LOGIN_MOBILE_APP_PIN = "9113b98df80f877c7a2ee5d865a04c9514b4e9bf25a49d315b0b15f115d2f0d2"

# Onboarding Parameters
ONBOARDING_MOBILE_NUMBER = "790010115"
ONBOARDING_DEVICE_ID = "1989nishans19892"
ONBOARDING_NIC = "890093215V"
ONBOARDING_MOBILE_APP_PIN = "9113b98df80f877c7a2ee5d865a04c9514b4e9bf25a49d315b0b15f115d2f0d2"

# Login Headers
APP_VERSION= "2.2.1"
CHECK_SUM= "fdfe13d50cc583494b0bcd54861b89449ecc2337b3f763041f8334ccbd57d167"
CONTENT_TYPE= "application/json "

# Success Scenario Test Data 
    # Login
LOGIN_OTP_REQUEST=  {"mobile_number": LOGIN_MOBILE_NUMBER, "device_id": LOGIN_DEVICE_ID, "language": "English", "country_code": "94", "device_details": "Android"}
LOGIN_OTP_VALIDATE= {"mobile_number": LOGIN_MOBILE_NUMBER, "device_id": LOGIN_DEVICE_ID, "otp_code": OTP, "country_code": "94"}
LOGIN_NIC_VALIDATE= {"nic": LOGIN_NIC, "device_id": LOGIN_DEVICE_ID, "request_token": ""}
LOGIN_ACCESS_TOKEN= {"grant_type": "password", "client_id": "mobile_api_client", "auth_type": "pin", "one_signal_id": "dnKv2Qu8iSo:APA91bGQNZG_XqPA9fOFMYo2yQNMeU4IUENlC2PSx0HgLJh8VK4TTNfy5dq4cDscWjLH0E1OufykSZTgli9JJTbYjiPydZhI_swQLVhmOj0AB1ZMKBi5etsJoKt3R3UBwWL6rdiPaZBD", "request_token": "", "pin": LOGIN_MOBILE_APP_PIN, "client_secret": CLIENT_SECRET, "device_id": LOGIN_DEVICE_ID, "platform": "android", "language": "English"}

    # Onboarding
ONBOARDING_OTP_REQUEST=  {"mobile_number": ONBOARDING_MOBILE_NUMBER, "device_id": ONBOARDING_DEVICE_ID, "language": "English", "country_code": "94", "device_details": "Android"}
ONBOARDING_OTP_VALIDATE= {"mobile_number": ONBOARDING_MOBILE_NUMBER, "device_id": ONBOARDING_DEVICE_ID, "otp_code": OTP, "country_code": "94"}
ONBOARDING_NIC_VALIDATE= {"nic": ONBOARDING_NIC, "device_id": ONBOARDING_DEVICE_ID, "request_token": ""}
ONBOARDING_PIN_CREATE= {"pin_code":"1989", "request_token":"", "confirm_code":"1989"}
ONBOARDING_ACCESS_TOKEN= {"grant_type": "password", "client_id": "mobile_api_client", "auth_type": "pin", "one_signal_id": "dnKv2Qu8iSo:APA91bGQNZG_XqPA9fOFMYo2yQNMeU4IUENlC2PSx0HgLJh8VK4TTNfy5dq4cDscWjLH0E1OufykSZTgli9JJTbYjiPydZhI_swQLVhmOj0AB1ZMKBi5etsJoKt3R3UBwWL6rdiPaZBD", "request_token": "", "pin": ONBOARDING_MOBILE_APP_PIN, "client_secret": CLIENT_SECRET, "device_id": ONBOARDING_DEVICE_ID, "platform": "android", "language": "English"}

    # Dashboard 
GET_NOTIFICATIONS= {"count":5}

    #Forgot PIN
FORGOT_PIN= {"request_token":""}
QUESTION_VERIFY= {"request_token":"", "nic":LOGIN_NIC}
VERIFY_FORGOT_PIN_OTP= {"request_token":"", "otp":OTP}
PIN_RESET= {"pin_code":"1989", "confirm_code":"1989", "request_token":""}

# Negative Scenario Test Data