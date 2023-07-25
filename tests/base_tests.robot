*** Settings ***
Documentation     A test suite with common setup and teardown operations.
Library           SeleniumLibrary
Variables         ../variables/user_credentials.py
Variables         ../variables/settings.py
Variables         ../variables/locators.py

*** Keywords ***
Open Application
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

Close Application
    Close Browser
