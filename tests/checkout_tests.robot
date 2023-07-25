*** Settings ***
Documentation     A test suite with tests for checkout functionality.
Library           SeleniumLibrary
Resource          ../keywords/app_keywords.robot
Variables         ../variables/user_credentials.py
Variables         ../variables/settings.py
Variables         ../variables/locators.py

Test Setup        Setup Test For Checkout
Test Teardown     Run Keywords    Capture Screenshot If Failed    AND    Close Application

*** Test Cases ***

Checkout With Valid Inputs
    [Documentation]    Test checkout process with all valid inputs (TC201.1).
    [Tags]    checkout_valid    TS201    TC201.1
    Log Message     Test checkout with valid inputs started
    Enter Shipping Info    ${valid_first_name}     ${valid_last_name}    ${valid_postal_code}
    Continue Checkout
    Finish Checkout
    ${confirmation_message_displayed}=    Is Order Confirmation Message Displayed
    Should Be True    ${confirmation_message_displayed}    msg=Order confirmation message not displayed
    Log Message     Test checkout with valid inputs finished

Checkout With Missing First Name
    [Documentation]    Test checkout process with missing first name (TC202.1).
    [Tags]    checkout_invalid    TS202    TC202.1
    Log Message     Test checkout with missing first name started
    Enter Shipping Info    ${EMPTY}    ${valid_last_name}    ${valid_postal_code}
    Continue Checkout
    ${error_message_text}=    Get Error Message Text
    Should Be Equal    ${error_message_text}    Error: First Name is required
    Log Message     Test checkout with missing first name finished

Checkout With Missing Last Name
    [Documentation]    Test checkout process with missing last name (TC202.2).
    [Tags]    checkout_invalid    TS202    TC202.2
    Log Message     Test checkout with missing last name started
    Enter Shipping Info    ${valid_first_name}    ${EMPTY}    ${valid_postal_code}
    Continue Checkout
    ${error_message_text}=    Get Error Message Text
    Should Be Equal    ${error_message_text}    Error: Last Name is required
    Log Message     Test checkout with missing last name finished

Checkout With Missing Postal Code
    [Documentation]    Test checkout process with missing postal code (TC202.3).
    [Tags]    checkout_invalid    TS202    TC202.3
    Log Message     Test checkout with missing postal code started
    Enter Shipping Info    ${valid_first_name}    ${valid_last_name}    ${EMPTY}
    Continue Checkout
    ${error_message_text}=    Get Error Message Text
    Should Be Equal    ${error_message_text}    Error: Postal Code is required
    Log Message     Test checkout with missing postal code finished

Checkout With Empty Fields
    [Documentation]    Test checkout process with all fields left empty (TC205.1).
    [Tags]    checkout_invalid    TS205    TC205.1
    Log Message     Test checkout with all fields left empty started
    Enter Shipping Info    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Continue Checkout
    ${error_message_text}=    Get Error Message Text
    Should Be Equal    ${error_message_text}    Error: First Name is required
    Log Message     Test checkout with missing first name finished

Verify Order Confirmation After Final Checkout
    [Documentation]    Test order confirmation after final checkout (TC206.1).
    [Tags]    checkout_valid    TS206    TC206.1
    Log Message     Test order confirmation after final checkout started
    Enter Shipping Info    ${valid_first_name}    ${valid_last_name}    ${valid_postal_code}
    Continue Checkout
    Finish Checkout
    ${confirmation_message_displayed}=    Is Order Confirmation Message Displayed
    Should Be True    ${confirmation_message_displayed}    msg=Order confirmation message not displayed
    Log Message     Test order confirmation after final checkout finished

Checkout With Special Characters In FirstName
    [Documentation]    Test checkout process with special characters in first name (TC207.1).
    [Tags]    checkout_valid    TS207    TC207.1
    Log Message     Test checkout with special characters in first name started
    Enter Shipping Info    ${special_chars}    ${valid_last_name}    ${valid_postal_code}
    Continue Checkout
    Element Text Should Be    ${checkout_overview}    Checkout: Overview
    Page Should Contain Element     ${finish_button}
    Log Message     Test checkout with special characters in first name finished


Checkout With Special Characters In LastName
    [Documentation]    Test checkout process with special characters in last name (TC207.2).
    [Tags]    checkout_valid    TS207    TC207.2
    Log Message     Test checkout with special characters in last name started
    Enter Shipping Info    ${valid_first_name}    ${special_chars}    ${valid_postal_code}
    Continue Checkout
    Element Text Should Be    ${checkout_overview}    Checkout: Overview
    Page Should Contain Element     ${finish_button}
    Log Message     Test checkout with special characters in last name finished

Checkout With Special Characters In Postal Code
    [Documentation]    Test checkout process with special characters in postal code (TC207.3).
    [Tags]    checkout_valid    TS207    TC207.3
    Log Message     Test checkout with special characters in postal code started
    Enter Shipping Info    ${valid_first_name}    ${valid_last_name}    ${special_chars}
    Continue Checkout
    Element Text Should Be    ${checkout_overview}    Checkout: Overview
    Page Should Contain Element     ${finish_button}
    Log Message     Test checkout with special characters in postal code finished

Checkout With Numeric Values In FirstName
    [Documentation]    Test checkout process with numeric values in first name (TC208.1).
    [Tags]    checkout_valid    TS208    TC208.1
    Log Message     Test checkout with numeric values in first name started
    Enter Shipping Info    ${numeric_values}    ${valid_last_name}    ${valid_postal_code}
    Continue Checkout
    Element Text Should Be    ${checkout_overview}    Checkout: Overview
    Page Should Contain Element     ${finish_button}
    Log Message     Test checkout with numeric values in first name finished

Checkout With Numeric Values In LastName
    [Documentation]    Test checkout process with numeric values in last name (TC208.2).
    [Tags]    checkout_valid    TS208    TC208.2
    Log Message     Test checkout with numeric values in last name started
    Enter Shipping Info    ${valid_first_name}    ${numeric_values}    ${valid_postal_code}
    Continue Checkout
    Element Text Should Be    ${checkout_overview}    Checkout: Overview
    Page Should Contain Element     ${finish_button}
    Log Message     Test checkout with numeric values in last name finished

Checkout With Alphabetical Values In PostalCode
    [Documentation]    Test checkout process by entering alphabetical values in Zip/Postal Code (TC209.1).
    [Tags]    checkout_valid    TS209    TC209.1
    Log Message     Test checkout with alphabetical values in postal code started
    Enter Shipping Info    ${valid_first_name}    ${valid_last_name}    ${alphabetical_values}
    Continue Checkout
    Element Text Should Be    ${checkout_overview}    Checkout: Overview
    Page Should Contain Element     ${finish_button}
    Log Message     Test checkout with alphabetical values in postal code finished

