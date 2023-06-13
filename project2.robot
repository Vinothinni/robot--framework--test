*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary
Library             XML


*** Variables ***
${deposit_btn}      //*[text()="Deposit"]//parent::button
${userpass}         dummy
${dropdown}         //*[@id="dropdown-display"]
${real}             //*[@id="real"]
${demo}             //*[@id="demo"]
${trade}            //*[@name="trade"]//parent::label
${payment}          //*[@name="payments"]//parent::label
${tradeinfo}        //*[@name="trading_information"]//parent::label
${admin}            //*[@name="admin"]//parent::label
${checkbox1}        //*[@name="financial-priorities"]//parent::label
${checkbox2}        //*[@name="not-user-friendly"]//parent::label
${checkbox3}        //*[@name="unsatisfactory-service"]//parent::label
${checkbox4}        //*[@name="name="another-website]//parent::label

*** Test Cases ***
Closing Account Page
    login
    Click Element    (//*[@class="dc-icon"])[3]
    Wait Until Page Contains Element    //*[@class="dc-page-overlay__header-title"]    10
    Wait Until Page Contains Element    //*[@class="dc-vertical-tab__tab dc-vertical-tab__tab--floating"]    10
    Click Element    //*[@id="dc_close-your-account_link"]
    Reload Page
    Wait Until Page Contains Element    //*[@class="closing-account__information"]
    Click Element    //*[@class="dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account"]
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__title"]    10

No Check
    No Checkbox Selected + reason
Special Input
    Special Characters
One Check
    Select 1 Checkbox + reason

Three Check
    Select 3 Checkbox + reason
Checkbox Only
    Select Checkbox With No reason
Closing the account
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
    Wait Until Page Contains Element    //*[@class="account-closure-warning-modal"]
    Click Element    (//*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"])[2]
    Wait Until Page Contains Element     //*[@class="dc-text account-closed"]    25
Reactivate The Account
    Reload Page
    Wait Until Page Contains Element    dt_login_button    20
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    vinothinni+7@besquare.com.my
    Click Element    //input[@id="txtPass"]
    Input Text    //input[@id="txtPass"]    ${userpass}
    Click Element    //button[@name="login"]
    Page Should Contain    Want to start trading on Deriv again?
    Click Element    //*[@id="btnGrant"]
    Wait Until Page Contains Element    ${deposit_btn}    10


    
*** Keywords ***
login
    Open Browser    https://app.deriv.com    chrome
    Set Selenium Speed    0.5 seconds
    Set Window Size    1200    1024
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    dummy
    Click Element    //input[@id="txtPass"]
    Input Text    //input[@id="txtPass"]    ${userpass}
    Click Element    //button[@name="login"]
    Wait Until Page Contains Element    ${deposit_btn}    10

Special Characters 
    Click Element    ${checkbox2}
    Click Element    ${checkbox3}
    Press Keys
    ...    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]
    ...    CTRL+a+BACKSPACE
    Input Text    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]    /?
    Element Should Be disabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]

Select Checkbox With No reason
     Press Keys
    ...    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]
    ...    CTRL+a+BACKSPACE
     Element Should Be Enabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
Select 3 Checkbox + reason
    Click Element    ${checkbox2}
    Click Element    ${checkbox3}
    Press Keys
    ...    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]
    ...    CTRL+a+BACKSPACE
    Input Text    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]    Hello1
    Element Should Be Enabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]

    

Select 1 Checkbox + reason
    Click Element    ${checkbox1}
    Press Keys
    ...    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]
    ...    CTRL+a+BACKSPACE
    Input Text    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]    Hello2
    Element Should Be Enabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]

No Checkbox Selected + reason
    Checkbox Should Not Be Selected    //*[@class="dc-checkbox__input"]
    Press Keys
    ...    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]
    ...    CTRL+a+BACKSPACE
    Input Text    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]    Hello3
    Element Should Be Disabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
