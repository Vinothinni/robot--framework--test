*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary

*** Variables ***
${deposit_btn}      //*[text()="Deposit"]//parent::button
${check_trading}    //*[text()="Check trading specs"]
${trade}            //*[text()="Trade now"]
${fType1}           //*[@name="CFDs"]
${fType2}           //*[@name="Options"]
${fType3}           //*[@name="Multipliers"]
${userpass}         dummy
${dropdown}         //*[@id="dropdown-display"]
${real}             //*[@id="real"]
${demo}             //*[@id="demo"]
${risefall}         //*[@id="dt_contract_rise_fall_item"]

*** Keywords ***
Task1
    Open Browser    https://app.deriv.com     chrome
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
   

*** Test Cases ***
Task4
    Task1
    Wait Until Page Contains Element    //*[text()="Deriv Trader"]//following::button[1]    10
    Click Element    //*[text()="Deriv Trader"]//following::button[1]   
    Wait Until Page Does Not Contain Element    //*[@class="chart-container__wrapper"]   30
    Wait Until Page Contains Element    //*[@class="sc-toolbar-widget"]    10
    Wait Until Page Contains Element    //*[@class="cq-symbol"]    10
    Click Element     //*[@class="cq-symbol-select-btn"]
    Wait Until Page Contains Element    //*[@class="sc-dialog cq-menu-dropdown cq-menu-dropdown-enter-done"]
    Click Element     //*[@class="sc-mcd__filter__item "][2]
    Click Element     //*[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]
    Wait Until Page Contains Element     //*[@id="dt_contract_dropdown"]    10
    Click Element    //*[@id="dt_contract_dropdown"] 
    Wait Until Element Is Visible     //*[@class="contract-type-dialog contract-type-dialog--enterDone"]
    Click Element     //*[@id="dt_contract_high_low_item"]
    Press Keys    //*[@class="dc-input__field"]    CTRL+a+BACKSPACE
    Input Text     //*[@class="dc-input__field"]    2
    Press Keys    //*[@id="dt_barrier_1_input"]    CTRL+a+BACKSPACE
    Input Text     //*[@id="dt_barrier_1_input"]     -0.2
    Wait Until Element Is Visible    //*[@id="dt_barrier_1_input"]    10   
    Wait Until Element Is Enabled    (//*[@class="btn-purchase__shadow-wrapper btn-purchase__shadow-wrapper--disabled"])[1]    10
    Wait Until Element Is Enabled    (//*[@class="btn-purchase__shadow-wrapper btn-purchase__shadow-wrapper--disabled"])[2]    10          

    
