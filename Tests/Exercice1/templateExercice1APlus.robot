*** Settings ***
Documentation
...             Commande pour éxécuter le test : robot -d "Resultats/Exercice 1A/" -i "exercice 1A" Tests
...             Keywords SeleniumLibrary : https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html
Force Tags      template exercice 1A
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

*** Test Cases ***
# Renommer clairement le Test Case, exemple : Login Page Accueil
Mon Test Case Exercice 1A

    # Objectifs :
        # Ouvrir le navigateur et aller sur la bonne URL (voir VARIABLES>URL)
        # Renseigner le champ username avec la valeur : Admin
        # Renseigner le champ password avec la valeur : admin123
        # Cliquer sur le bouton de connexion
        # Vérifier la présence de l'élément Dashboard qui prouve la bonne connexion

    # Utilisation d'une variable du fichier locator.py :
    Log To Console    ${UsernameInputBox}

    # Keywords utiles :
    Open Browser    ${URL}    ${BROWSER} 
    Title Should Be    OrangeHRM
    Element Should Be Visible  xpath://*[@id="app"]/div[1]/div/div[1]/div/div[2]/h5  ${MA_VARIABLE}
    Input Text     ${UsernameInputBox}   Admin
    Input Text     ${PasswordInputBox}   admin123
    Click Element    ${LoginButton}
#   Click Button (attention, ce keyword ne fonctionne pas si le bouton n'est pas un <button> dans le code HTML)
    Element Text Should Be    ${TitleDashboard}   Dashboard
