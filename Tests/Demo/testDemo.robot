*** Settings ***
Force Tags       demo
Library          SeleniumLibrary
Suite Setup      Run Keywords
...                 Create Webdriver    Chrome
...                 AND     Set Selenium Speed  1s
Suite Teardown     Close All Browsers

*** Test Cases ***
Validate Unsuccessful Authentification
    Open the login page

Open Google page
    Open the google page

*** Keywords ***
Open the login page
    go to   https://www.bstackdemo.com/signin
    Element Text Should Be    id:login-btn    Sign

Open the google page
    go to   https://google.fr
    Title Should Be    Google

