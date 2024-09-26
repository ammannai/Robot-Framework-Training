*** Settings ***
Documentation
...             Commande pour éxécuter le test : robot -d "Resultats/Exercice 1B/" -i "exercice 1B" Tests
...             Keywords SeleniumLibrary : https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html
Force Tags      template exercice 1B
Library         SeleniumLibrary    implicit_wait=0:00:05    timeout=0:00:05
Test Setup      Set Selenium Speed  1s
Test Teardown   Close Browser
Variables       ../../Resources/Exercice1/locators 1.py

*** Variables ***
# Les variables déclarées ici sont visibles par le Test Case ainsi que par tous les Keywords

# Exemple :
${MA_VARIABLE}      Login
${URL}              https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}          Chrome
${ERROR_MESSAGE}    Invalid credentials

*** Test Cases ***
# Renommer clairement le Test Case, exemple : Login Cas Non Passant
Mon Test Case Exercice 1B

    # Objectifs :
        # Ouvrir le navigateur et aller sur la bonne URL (voir VARIABLES>URL)
        # Renseigner le champ username et/ou le champ password avec une valeur erronée (autre que Admin/admin123)
        # Cliquer sur le bouton de connexion
        # Vérifier la présence du message d'erreur qui prouve la non connexion

    # Utilisation d'une variable du fichier locator.py :
    Log To Console    ${UsernameInputBox}

    # Keywords utiles :
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    OrangeHRM
    Element Should Be Visible    xpath://*[@id="app"]/div[1]/div/div[1]/div/div[2]/h5  ${MA_VARIABLE}
    Input Text     ${UsernameInputBox}   Admin
    Input Text     ${PasswordInputBox}   admin1234
    Click Element    ${LoginButton}
     Element Should Be Visible    ${LoginErrorMessage}  ${ERROR_MESSAGE}
    Sleep    15
