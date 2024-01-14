*** Settings ***
Library             DatabaseLibrary    #https://docs.robotframework.org/docs/different_libraries/database
Library             OperatingSystem
Library             Collections
Library             psycopg2    #https://docs.robotframework.org/docs/different_libraries/database

*** Variables ***
${DBHost}       localhost
${DBName}       test
${DBPass}       admin
${DBPort}       5432
${DBUser}       nishan

*** Keywords ***
Connecting_To_Database
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}