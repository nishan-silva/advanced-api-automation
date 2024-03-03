# Robot Framework for Rest API and Frontend Testing

Robot Framework is a generic open source test automation framework. In addition to introducing Robot Framework test data syntax, this demo shows how to execute test cases, how generated reports and logs look like, and how to extend the framework with custom test libraries.

# Environment Setup

**Installing Python:**

    https://www.python.org/downloads/

**Checking python version:**

    Windows: python --version
    Mac: python3 --version

**Downloading get-pip.py:**

    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

**Installing pip for Python 3:**

    python3 get-pip.py

**Checking pip version:**

    pip --version

**Installing VS code**

    https://code.visualstudio.com/download

**Installing Android Studio**

    https://developer.android.com/studio

**SDK Platform and Tools Settings**

![SDK Platforms Settings](https://github.com/nishan-silva/advanced-api-automation/blob/main/Images/SDK_Platforms_Settings.jpg)

![SDK Tools Settings](https://github.com/nishan-silva/advanced-api-automation/blob/main/Images/SDK_Tools_Settings.jpg)

**Installing the below libraries using CMD**

    pip install robotframework
    pip install requests
    pip install robotframework-requests
    pip install robotframework-jsonlibrary
    pip install robotframework-seleniumlibrary
    pip install robotframework-appiumlibrary
    pip install robotframework-databaselibrary
    pip install psycopg2
    pip install cx_Oracle

**Settingup python environment variables**

    JAVA_HOME: C:\Program Files (x86)\Java\jre-1.8

    ANDROID_HOME: C:\Users\dj_pl\AppData\Local\Android\Sdk

    PATH Variable:
    %JAVA_HOME%\bin
    %ANDROID_HOME%\platform-tools
    %ANDROID_HOME%\tools
    %ANDROID_HOME%\emulator
    %ANDROID_HOME%\build-tools
    %ANDROID_HOME%\tools\bin

**Installing appium drivers**

    Android:     npm install -g appium

    iOS:     appium driver install xcuitest
    
    Check installed drivers:    appium driver list

**How to Start Default Appium Server**

    appium server -p 4723 -a 127.0.0.1 -pa /wd/hub

**How to Start 1st Appium Instance**

    appium -pa /wd/hub --default-capabilities '{"appium:adbPort":5037, "appium:systemPort":8201, "appium:newCommandTimeout":0, "appium:automationName":"uiAutomator2", "appium:udid":"emulator-5554"}'

**How to Start 2nd Appium Instance**

    appium -pa /wd/hub --port 4725 --default-capabilities '{"appium:adbPort":5038, "appium:systemPort":8202, "appium:newCommandTimeout":0, "appium:automationName":"uiAutomator2", "appium:udid":"emulator-5556"}'

**Running testcases**

    robot -A "ArgumentFiles/staging.args" "TestSuites/Backend/2_Login.robot"
    robot -A ArgumentFiles/staging.args --include=Onboarding TestSuites/Backend/API_Testcases.robot
    robot -A "ArgumentFiles/staging.args" "TestSuites/Backend/*.robot"
    robot -A "ArgumentFiles/staging.args" --variablefile TestData/Staging_Backend_TestData.py TestSuites/Backend/2_Login.robot
    robot -A "ArgumentFiles/staging.args" --variablefile TestData/Staging_Backend_TestData.py TestSuites/Backend/*.robot
    
