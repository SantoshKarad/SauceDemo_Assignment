*** Settings ***
Documentation     A test suite with tests for cart functionality.
Library           SeleniumLibrary
Resource          ../keywords/app_keywords.robot
Variables         ../variables/user_credentials.py
Variables         ../variables/settings.py
Variables         ../variables/locators.py

Test Setup        Setup Test For Cart
Test Teardown     Run Keywords    Capture Screenshot If Failed    AND    Close Application

*** Test Cases ***

Verify a product can be added to the cart
    [Documentation]    Test adding a product to the cart (TC101.1).
    [Tags]    cart    TS101    TC101.1
    Log Message    Test adding a product to the cart started
    Wait Until Page Contains Element    ${product_1}    timeout=10s
    Select Product    ${product_1}
    Add Product To Cart    ${Add_to_cart_product_1}
    ${cart_count}=    Get Cart Count
    Should Be Equal As Integers    ${cart_count}    1
    Log Message    Test adding a product to the cart finished

Verify a product can be removed from the cart
    [Documentation]    Test removing a product from the cart (TC102.1).
    [Tags]    cart    TS102    TC102.1
    Log Message    Test removing a product from the cart started
    Select Product    ${product_1}
    Add Product To Cart    ${Add_to_cart_product_1}
    Go To Cart Page
    Remove Product From Cart    ${Remove_from_cart_product_1}
    ${product_in_cart}=    Is Product In Cart    ${product_1}
    Should Not Be True    ${product_in_cart}
    Log Message    Test removing a product from the cart finished

Verify the cart count is updated when a product is added
    [Documentation]    Test updating cart count when a product is added (TC103.1).
    [Tags]    cart    TS103    TC103.1
    Log Message    Test updating cart count when a product is added started
    Select Product    ${product_1}
    Add Product To Cart    ${Add_to_cart_product_1}
    ${cart_count}=    Get Cart Count
    Should Be Equal As Integers    ${cart_count}    1
    Log Message    Test updating cart count when a product is added finished

Verify user can checkout with products in the cart
    [Documentation]    Test checking out with products in the cart (TC104.1).
    [Tags]    cart    TS104    TC104.1
    Log Message    Test checking out with products in the cart started
    Select Product    ${product_1}
    Add Product To Cart    ${Add_to_cart_product_1}
    Go To Cart Page
    Proceed To Checkout
    Fill In Checkout Info    Test    User    12345
    Continue Checkout
    Element Text Should Be    ${checkout_overview}    Checkout: Overview
    Log Message    Test checking out with products in the cart finished

Verify user can checkout when the cart is empty
    [Documentation]    Test checking out with an empty cart (TC105.1).
    [Tags]    cart    TS105    TC105.1
    Log Message    Test checking out with an empty cart started
    Go To Cart Page
    ${checkout_button_enabled}=    Is Checkout Button Enabled
    Should Be True    ${checkout_button_enabled}
    Log Message    Test checking out with an empty cart finished

Verify the cart is empty when no products are added
    [Documentation]    Test checking cart when no products are added (TC106.1).
    [Tags]    cart    TS106    TC106.1
    Log Message    Test checking cart when no products are added started
    Go To Cart Page
    ${product_in_cart}=    Is Product In Cart    ${product_1}
    Should Not Be True    ${product_in_cart}
    Log Message    Test checking cart when no products are added finished

Verify the cart retains products when user logs out and logs back in
    [Documentation]    Test retaining products in cart after logout and login (TC107.1).
    [Tags]    cart    TS107    TC107.1
    Log Message    Test retaining products in cart after logout and login started
    Add Product To Cart    ${Add_to_cart_product_1}
    Logout From Application
    Login       ${standard_user}    ${password}
    Go To Cart Page
    ${cart_count}=    Get Cart Count
    Should Be Equal As Integers    ${cart_count}    1
    Log Message    Test retaining products in cart after logout and login finished

Verify user can continue shopping from the cart
    [Documentation]    Test continuing shopping from the cart (TC108.1).
    [Tags]    cart    TS108    TC108.1
    Log Message    Test continuing shopping from the cart started
    Go To Cart Page
    Continue Shopping
    Wait Until Page Contains Element    ${logout_link_locator}    10
    Log Message    Test continuing shopping from the cart finished
