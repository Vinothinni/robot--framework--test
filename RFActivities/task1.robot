*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary


*** Variables ***
${deposit_btn}      //*[text()="Deposit"]//parent::button
${check_trading}    //*[text()="Check trading specs"]
${trade}            //*[text()="Trade now"]
${userpass}         dummy
${dropdown}         //*[@id="dropdown-display"]
${real}             //*[@id="real"]
${demo}             //*[@id="demo"]
${risefall}         //*[@id="dt_contract_rise_fall_item"]



*** Test Cases ***
Task1
   
    Open Browser    https://app.deriv.com     chrome
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
    Click Element    ${dropdown}
    Wait Until Page Contains Element     //*[@class="dc-dropdown__list dc-dropdown__list--enter-done"]   15
    Click Element    ${demo} 
    Wait Until Page Contains Element    //*[@class="dc-text demo-account-card__title"]    20




