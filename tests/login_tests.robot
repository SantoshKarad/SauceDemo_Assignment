*** Settings ***
Documentation     A test suite with tests for login functionality.
Library           SeleniumLibrary
Resource          ../keywords/app_keywords.robot
Variables         ../variables/user_credentials.py
Variables         ../variables/settings.py
Variables         ../variables/locators.py

Test Setup        Open Application
Test Teardown     Run Keywords    Capture Screenshot If Failed    AND    Close Application

*** Test Cases ***

Successful Login with Valid Credentials
    [Documentation]    Test successful login with valid credentials (TC001.1).
    [Tags]    login_valid    TS001    TC001.1
    Log Message     Test successful login with valid credentials started
    Login    ${standard_user}    ${password}
    Wait Until Page Contains Element    ${logout_link_locator}    10
    Log Message     Test successful login with valid credentials finished

Successful Login with Problem User
    [Documentation]    Test successful login with problem user (TC001.2).
    [Tags]    login_valid    TS001    TC001.2
    Log Message     Test successful login with problem user started
    Login    ${problem_user}    ${password}
    Wait Until Page Contains Element    ${logout_link_locator}    10
    Log Message     Test successful login with problem user finished

Successful Login with Performance Glitch User
    [Documentation]    Test successful login with performance glitch user (TC001.3).
    [Tags]    login_valid    TS001    TC001.3
    Log Message     Test successful login with performance glitch user started
    Login    ${performance_glitch_user}    ${password}
    Wait Until Page Contains Element    ${logout_link_locator}    10
    Log Message     Test successful login with performance glitch user finished

Unsuccessful Login with Invalid Username
    [Documentation]    Test unsuccessful login with invalid username (TC001.4).
    [Tags]    login_invalid    TS002    TC001.4
    Log Message     Test unsuccessful login with invalid username started
    Login    invalid_username    ${password}
    Wait Until Page Contains    Epic sadface: Username and password do not match any user in this service    10
    Log Message     Test unsuccessful login with invalid username finished

Unsuccessful Login with Invalid Password
    [Documentation]    Test unsuccessful login with invalid password (TC001.5).
    [Tags]    login_invalid    TS003    TC001.5
    Log Message     Test unsuccessful login with invalid password started
    Login    ${standard_user}    invalid_password
    Wait Until Page Contains    Epic sadface: Username and password do not match any user in this service    10
    Log Message     Test unsuccessful login with invalid password finished

Unsuccessful Login with Empty Username
    [Documentation]    Test unsuccessful login with empty username (TC001.6).
    [Tags]    login_invalid    TS004    TC001.6
    Log Message     Test unsuccessful login with empty username started
    Login    ${EMPTY}    ${password}
    Wait Until Page Contains    Epic sadface: Username is required    10
    Log Message     Test unsuccessful login with empty username finished

Unsuccessful Login with Empty Password
    [Documentation]    Test unsuccessful login with empty password (TC001.7).
    [Tags]    login_invalid    TS005    TC001.7
    Log Message     Test unsuccessful login with empty password started
    Login    ${standard_user}    ${EMPTY}
    Wait Until Page Contains    Epic sadface: Password is required    10
    Log Message     Test unsuccessful login with empty password finished

Unsuccessful Login with Locked User
    [Documentation]    Test unsuccessful login with locked user (TC001.8).
    [Tags]    login_invalid    TS006    TC001.8
    Log Message     Test unsuccessful login with locked user started
    Login    ${locked_out_user}    ${password}
    Wait Until Page Contains    Epic sadface: Sorry, this user has been locked out.    10
    Log Message     Test unsuccessful login with locked user finished

Unsuccessful Login with Case Insensitive Username
    [Documentation]    Test unsuccessful login with case insensitive username (TC001.9).
    [Tags]    login_valid    TS007    TC001.9
    Log Message     Test unsuccessful login with case insensitive username started
    ${username_uppercase}=    Convert To Uppercase    ${standard_user}    # Converting the username to uppercase to test case insensitivity
    Login    ${username_uppercase}    ${password}
    Wait Until Page Contains    Epic sadface: Username and password do not match any user in this service    10
    Log Message     Test unsuccessful login with case insensitive username finished

Login Resilient to SQL Injection Attacks
    [Documentation]    Test login feature is resilient to SQL Injection attacks (TC001.10).
    [Tags]    security    TS008    TC001.10
    Log Message     Test login feature is resilient to SQL Injection attacks started
    Login    'DROP TABLE tablename; --    'DROP TABLE tablename; --
    Wait Until Page Contains     Epic sadface: Username and password do not match any user in this service    10
    Log Message     Test login feature is resilient to SQL Injection attacks finished

Login Session Timeout
    [Documentation]    Test login session timeout after a period of inactivity (TC001.11).
    [Tags]    login_session    TS009    TC001.11
    Log Message     Test login session timeout after a period of inactivity started
    Login    ${standard_user}    ${password}
    Sleep    ${SESSION_TIMEOUT} minutes
    Reload Page    # Reloading the page to trigger the session timeout
    Wait Until Page Contains Element    ${LOGIN_BUTTON_LOCATOR}    10
    Log Message     Test login session timeout after a period of inactivity finished

Unsuccessful Login with Whitespace in Username and Password
    [Documentation]    Test unsuccessful login with leading and trailing whitespaces in username and password (TC001.12).
    [Tags]    login_invalid    TS010    TC001.12
    Log Message     Test unsuccessful login with leading and trailing whitespaces in username and password started
    Login    ${SPACE}${standard_user}${SPACE}    ${SPACE}${password}${SPACE}
    Wait Until Page Contains     Epic sadface: Username and password do not match any user in this service    10
    Log Message     Test unsuccessful login with leading and trailing whitespaces in username and password finished