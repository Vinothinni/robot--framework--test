*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary
Library    XML


*** Variables ***
${deposit_btn}      //*[text()="Deposit"]//parent::button
${userpass}         dummy
${dropdown}         //*[@id="dropdown-display"]
${real}             //*[@id="real"]
${demo}             //*[@id="demo"]
${read}             //*[@name="read"]//parent::label
${trade}             //*[@name="trade"]//parent::label
${payment}             //*[@name="payments"]//parent::label
${tradeinfo}          //*[@name="trading_information"]//parent::label
${admin}            //*[@name="admin"]//parent::label



*** Test Cases ***
Create API
    login
    Click Element    (//*[@class="dc-icon"])[3]
    Wait Until Page Contains Element   //*[@class="dc-page-overlay__header-title"]    10
    Wait Until Page Contains Element   //*[@class="dc-vertical-tab__tab dc-vertical-tab__tab--floating"]    10
    Click Element    //*[@id="dc_api-token_link"]
    Wait Until Page Contains Element    //*[@class="da-article"]
Unchecked
    Unselecting Checkbox
input__field
    Press Keys    //*[@class="dc-input__field"]     CTRL+a+BACKSPACE  
    Input Text    //*[@class="dc-input__field"]    ""
    Wait Until Page Contains Element  //*[@class="dc-field dc-field--error" ]   10
inputField2
    Press Keys    //*[@class="dc-input__field"]     CTRL+a+BACKSPACE  
    Input Text    //*[@class="dc-input__field"]    a
    Wait Until Page Contains Element  //*[@class="dc-field dc-field--error" ]   10
inputField3
    Press Keys    //*[@class="dc-input__field"]     CTRL+a+BACKSPACE  
    Input Text    //*[@class="dc-input__field"]    andeniejfnefijrnfregrngjiejgniuj
    Wait Until Page Contains Element   //*[@class="dc-input__hint" ]   10

Checked
    Selecting Checkbox
# Copy API Token
#     Click Element   //*[@class="da-api-token__table-cell-row" ]    
#     Click Element    (//*[@id="ic-clipboard"])
#     Wait Until Page Contains Element    //*[@class="dc-modal__container dc-modal__container--small dc-modal__container--enter-done"]    10
#     Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
#     Wait Until Page Contains Element    //*[@class="dc-clipboard__popover dc-popover__bubble"]


API Table
    Wait Until Page Contains Element    //*[@class="dc-icon dc-clipboard"]    10   
    Click Element    //*[@class="dc-icon dc-clipboard"]
    Wait Until Page Contains Element    //*[@class="dc-modal__container dc-modal__container--small dc-modal__container--enter-done"]    10
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
    Wait Until Page Contains Element    //*[@class="dc-clipboard__popover dc-popover__bubble"]    10
    
    Click Element   //*[@class="da-api-token__table-cell-row" ] 
    Click Element    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]  
    Wait Until Page Contains Element    //*[@class="dc-modal__container dc-modal__container--small dc-modal__container--enter-done"]    10
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
    Wait Until Page Contains Element    //*[@class="da-api-token__table-cell-row" ]    10
    Page Should Not Contain    'Token1'


  


*** Keywords ***
login
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
   
Selecting Checkbox
    # All the checkbox not selected
    Click Element    ${read}     
    Click Element    ${trade}
    Click Element    ${payment}             
    Click Element    ${tradeinfo}     
    Click Element    ${admin}  
    Press Keys    //*[@class="dc-input__field"]     CTRL+a+BACKSPACE  
    Input Text      //*[@class="dc-input__field"]    Token1
    Element Should Be Enabled     //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]   
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]
    Wait Until Element Is Visible   //*[@class="da-api-token__table-cell da-api-token__table-cell--name"]  10
Unselecting Checkbox
    Input Text      //*[@class="dc-input__field"]    Token1
    Element Should Be Disabled    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]


    