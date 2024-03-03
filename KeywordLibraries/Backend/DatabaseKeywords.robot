*** Settings ***
Library             DatabaseLibrary    #https://docs.robotframework.org/docs/different_libraries/database
Library             OperatingSystem
Library             Collections
Library             psycopg2    #https://docs.robotframework.org/docs/different_libraries/database
Library             cx_Oracle

*** Variables ***


*** Keywords ***
Connecting_To_Genie_Database
    DatabaseLibrary.Connect To Database    dbConfigFile=${ENV_GENIE_DB_CONFIG_FILE}

Connecting_To_eZCash_Database
    DatabaseLibrary.Connect To Database    dbConfigFile=${ENV_EZCASH_DB_CONFIG_FILE}
