*** Settings ***
Library           SeleniumLibrary
Library           String
Library           DateTime
Library           OperatingSystem
Library           Collections
Variables         ../variables/settings.py
Variables         ../variables/locators.py
Variables         ../variables/user_credentials.py

*** Keywords ***
Open Application
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

Close Application
    Close Browser

Login
    [Arguments]    ${username}    ${password}
    Input Text    ${username_locator}    ${username}
    Input Text    ${password_locator}    ${password}
    Click Button    ${login_button_locator}

Logout From Application
    Wait Until Element Is Visible    ${open_menu_button_locator}
    Click Button    ${open_menu_button_locator}
    Wait Until Element Is Visible    ${logout_link_locator}
    Click Link    ${logout_link_locator}


Capture Screenshot If Failed
    Run Keyword If Test Failed    Capture Page Screenshot    filename=screenshots/${SUITE NAME}_${TEST NAME}_fail.png

Log Message
    [Arguments]    ${message}    ${level}=INFO
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log    ${timestamp} - ${level} - ${message}
    ${status}=    Run Keyword And Return Status    Write Log To File    C:/Users/Admin/PycharmProjects/SauceDemoAssignment/utils/log.txt    ${timestamp} - ${level} - ${message}
    Run Keyword If    '${status}'=='FAIL'    Log    Writing log to file failed

Write Log To File
    [Arguments]    ${file_path}    ${message}
    Append To File    ${file_path}    ${message}\n

Check Element Presence
    [Arguments]    ${locator}
    Page Should Contain Element     ${locator}

Select Product
    [Arguments]    ${product_locator}
    Wait Until Element Is Visible    ${product_locator}
    Click Element    ${product_locator}

Select Products
    [Arguments]    @{products}
    FOR    ${product}    IN    @{products}
        Select Product    ${product}
        Go To Products Page
    END

Add Product To Cart
    [Arguments]    ${add_to_cart_button_locator}
    Wait Until Element Is Visible    ${add_to_cart_button_locator}
    Click Element    ${add_to_cart_button_locator}

Add Products To Cart
    [Arguments]    @{products}
    FOR    ${product}    IN    @{products}
        Select Product    ${product}
        Add Product To Cart    ${product}
        Go To Products Page
    END

Go To Cart Page
    ${cart_button_locator}=    Set Variable    ${cart_button_locator}
    Wait Until Element Is Visible    ${cart_button_locator}
    Click Element    ${cart_button_locator}

Get Cart Count
    ${cart_count}=    Get Text    ${cart_count_locator}
    [Return]    ${cart_count}

Remove Product From Cart
    [Arguments]    ${remove_button_locator}
    Click Element    ${remove_button_locator}

Clear Cart
    ${clear_cart_locator}=    Set Variable    ${clear_cart}
    Click Element    ${clear_cart_locator}

Proceed To Checkout
    ${checkout_button_locator}=    Set Variable    ${checkout_button}
    Wait Until Element Is Visible    ${checkout_button_locator}
    Click Element    ${checkout_button_locator}

Fill In Checkout Info
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Input Text    ${first_name_locator}    ${first_name}
    Input Text    ${last_name_locator}    ${last_name}
    Input Text    ${postal_code_locator}    ${postal_code}

Is Checkout Overview Page Displayed
    Page Should Contain Element    ${checkout_overview}

Is Error Message Displayed
    Wait Until Element Is Visible    ${error_message_locator}    timeout=10s
    Page Should Contain Element    ${error_message_locator}

Get Error Message Text
    ${error_message_text}=    Get Text    ${error_message_locator}
    [Return]    ${error_message_text}

Is Checkout Complete Page Displayed
    ${confirmation_message_locator}=    Set Variable    ${confirmation_message}
    ${confirmation_message_displayed}=    Run Keyword And Return Status    Page Should Contain Element    ${confirmation_message_locator}
    [Return]    ${confirmation_message_displayed}

Is Cart Empty
    ${cart_empty}=    Run Keyword And Return Status    Element Should Not Be Visible    ${cart_item_locator}
    [Return]    ${cart_empty}

Does Cart Contain Products
    ${cart_contains_products}=    Run Keyword And Return Status    Element Should Be Visible    ${cart_item_locator}
    [Return]    ${cart_contains_products}

Continue Shopping
    Click Button    ${continue_shopping_button_locator}

Is Shopping Page Displayed
    Wait Until Page Contains Element    ${logout_link_locator}    10

Setup Test For Cart
    Open Application
    Login    ${standard_user}    ${password}

Setup Test For Checkout
    Open Application
    Login    ${standard_user}    ${password}
    Select Products    ${Add_to_cart_product_1}
    Add Products To Cart
    Go To Cart Page
    Go To Checkout

Enter Shipping Info
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Input Text    ${first_name_locator}    ${first_name}
    Input Text    ${last_name_locator}    ${last_name}
    Input Text    ${postal_code_locator}    ${postal_code}

Go To Checkout
    Click Button    ${checkout_button}

Continue Checkout
    Click Button    ${Continue_button}

Finish Checkout
    Click Button    ${finish_button}

Is Order Confirmation Message Displayed
    ${confirmation_message_locator}=    Set Variable    ${confirmation_message}  # replace with actual locator
    ${confirmation_message_displayed}=    Run Keyword And Return Status    Page Should Contain Element    ${confirmation_message_locator}
    [Return]    ${confirmation_message_displayed}

Go To Products Page
    Click Button    ${back_to_products_button}

Is Product In Cart
    [Arguments]    ${product_locator}
    ${product_in_cart}=    Run Keyword And Return Status    Element Should Be Visible    ${product_locator}
    [Return]    ${product_in_cart}

Is Checkout Button Enabled
    ${checkout_button_locator}=    Set Variable    ${checkout_button}
    ${checkout_button_enabled}=    Run Keyword And Return Status    Element Should Be Visible    ${checkout_button_locator}
    [Return]    ${checkout_button_enabled}

Is Checkout Error Not Displayed
    ${error_message_locator}=    Set Variable    ${error_message}
    ${checkout_error_not_displayed}=    Run Keyword And Return Status    Element Should Not Be Visible    ${error_message_locator}
    [Return]    ${checkout_error_not_displayed}