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
    # Set Selenium Speed    0.5
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    dummy
    Click Element    //input[@id="txtPass"]
    Input Text    //input[@id="txtPass"]    ${userpass}
    Click Element    //button[@name="login"]
    Wait Until Page Contains Element    ${deposit_btn}    15
    Click Element    ${dropdown}
    Wait Until Page Contains Element     //*[@class="dc-dropdown__list dc-dropdown__list--enter-done"]   15
    Click Element    ${demo} 
    Wait Until Page Contains Element    //*[@class="dc-text demo-account-card__title"]    20


*** Test Cases ***
Task5
    #login
    Task1
Homepage
    Wait Until Page Contains Element    //*[text()="Deriv Trader"]//following::button[1]    10
    Click Element    //*[text()="Deriv Trader"]//following::button[1]  
Display trader page 
    Wait Until Page Does Not Contain Element    //*[@class="chart-container__wrapper"]   30
    Wait Until Page Contains Element    //*[@class="cq-menu-btn"]    10
    Wait Until Page Contains Element    //*[@class="cq-symbol-select-btn"]    15
 Volatility 50
    Click Element    //*[@class="cq-symbol-select-btn"]
    Wait Until Page Contains Element  //*[@class="sc-dialog cq-menu-dropdown cq-menu-dropdown-enter-done"]
    Click Element    //*[@class="sc-mcd__filter__subgroups-item sc-mcd__filter__item--active sc-mcd__filter__item--selected"]
    Click Element     //*[@class="sc-mcd__item sc-mcd__item--R_50 "]
    Wait Until Element Is Visible      //*[@id="dt_contract_dropdown"]
 Multiplier
    Click Element    //*[@id="dt_contract_dropdown"]    
    Wait Until Page Contains Element    //*[@class="contract-type-dialog contract-type-dialog--enterDone"]
    Click Element    //*[@id="dt_contract_multiplier_item"]
Checking Stake
    Page Should Contain    "Stake"


Checkbox1
    Click Element   //*[@class="dc-checkbox take_profit-checkbox__input"]
    Checkbox Should Be Selected    //*[@id="dc_take_profit-checkbox_input"]
    Checkbox Should Not Be Selected    //*[@id="dc_stop_loss-checkbox_input"]
    Checkbox Should Not Be Selected    //*[@id="dt_cancellation-checkbox_input"]
    
Checkbox2
    Click Element    //*[@class="dc-checkbox stop_loss-checkbox__input"]
    Checkbox Should Be Selected    //*[@id="dc_take_profit-checkbox_input"]
    Checkbox Should Be Selected    //*[@id="dc_stop_loss-checkbox_input"]
    Checkbox Should Not Be Selected     //*[@id="dt_cancellation-checkbox_input"]
   
Checkbox3
    Click Element    //*[@class="dc-checkbox"]
    Checkbox Should Not Be Selected    //*[@id="dc_take_profit-checkbox_input"]
    Checkbox Should Not Be Selected    //*[@id="dc_stop_loss-checkbox_input"]
    Checkbox Should Be Selected     //*[@id="dt_cancellation-checkbox_input"]
    
Checkbox4   
    Click Element    //*[@class="dc-checkbox stop_loss-checkbox__input"]
    Checkbox Should Not Be Selected   //*[@id="dc_take_profit-checkbox_input"]
    Checkbox Should Be Selected    //*[@id="dc_stop_loss-checkbox_input"]
    Checkbox Should Not Be Selected    //*[@id="dt_cancellation-checkbox_input"]


Chcekbox5 
    Click Element    //*[@class="dc-checkbox take_profit-checkbox__input"]
    Checkbox Should Be Selected     //*[@id="dc_take_profit-checkbox_input"]
    Checkbox Should Be Selected     //*[@id="dc_stop_loss-checkbox_input"]
    Checkbox Should Not Be Selected    //*[@id="dt_cancellation-checkbox_input"]
       
Multiplier Selection
    Click Element    //*[@data-testid="dti_dropdown_display"]
    Wait Until Page Contains Element    //*[@class="dc-dropdown__list dc-dropdown__list--left dc-dropdown__list--enter-done dc-dropdown__list--left--enter-done"]
    Page Should Contain Element     //*[@class="dc-dropdown__list dc-dropdown__list--left dc-dropdown__list--enter-done dc-dropdown__list--left--enter-done"]
Deal Cancelation
    Click Element    //*[@class="dc-checkbox"]
    Press Keys    //*[@id="dt_amount_input"]    CTRL+a+BACKSPACE  
    Input Text    //*[@id="dt_amount_input"]    10
    Wait Until Element Is Visible    (//*[@class="trade-container__price-info-currency"])
    ${cancel_fee}    Get Text    //*[@class="trade-container__price-info-currency"]
    ${cancel_fee}    Set Variable    ${cancel_fee[:-4]}
    Press Keys   //*[@id="dt_amount_input"]   CRTL+a+BACKSPACElocator
    Input Text   //*[@id="dt_amount_input"]    11
    Wait Until Element Is Visible    //*[@class="trade-container__price-info-currency"]    20
    ${updated_fee}    Get Text    //*[@class="trade-container__price-info-currency"]
    ${updated_fee}    Set Variable    ${updated_fee[:-4]}
    Should Be True    ${updated_fee} > ${cancel_fee}

Max stake
    Press Keys    //*[@id="dt_amount_input"]    CTRL+a+BACKSPACE
    Input Text    //*[@id="dt_amount_input"]   2001
    Wait Until Element Is Visible    //*[@id="dt_amount_input"]    20
    Page Should Contain Element    //*[@id="dt_amount_input"]   
    Wait Until Page Contains Element    (//*[@id="dt_purchase_multup_button"])  10 
    Wait Until Page Contains Element    (//*[@id="dt_purchase_multdown_button"])  10 
 Min stake
    Press Keys    //*[@id="dt_amount_input"]    CTRL+a+BACKSPACE
    Input Text    //*[@id="dt_amount_input"]   0
    Wait Until Element Is Visible    //*[@id="dt_amount_input"]    20
    Page Should Contain Element    //*[@id="dt_amount_input"]  
    Wait Until Page Contains Element    (//*[@id="dt_purchase_multup_button"])  10 
    Wait Until Page Contains Element    (//*[@id="dt_purchase_multdown_button"])  10  
Click + button
    Click Element    (//*[@class="dc-checkbox__box"])[1]
    Click Element    //*[@id="dc_take_profit_input_add"]
    ${current_value}=    Get Text    //*[@id="dc_take_profit_input"]
    ${new_value}=    Evaluate    int(${current_value}) + 1
    Input Text    //*[@id="dc_take_profit_input"]    ${new_value}
Click - button
    Click Element    (//*[@class="dc-checkbox__box"])[1]
    Click Element    //*[@id="dc_take_profit_input_sub"]
    ${current_value}=    Get Text    //*[@id="dc_take_profit_input"]
    ${new_value}=    Evaluate    int(${current_value}) - 1
    Input Text    //*[@id="dc_take_profit_input"]    ${new_value}
Deal Cancellation duration check
    Wait Until Page Contains Element    //*[@class="dc-checkbox"]
    Click Element    //*[@class="dc-text dc-dropdown__display-text"]
    Wait Until Element Is Visible    (//*[@class="dc-text dc-dropdown__display-text"])
  

 