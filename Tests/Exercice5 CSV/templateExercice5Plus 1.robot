*** Settings ***
Documentation
...             Commande pour éxécuter le test : robot -d "Resultats/Exercice 5/" -i "exercice 5" Tests
...             Keywords String : https://robotframework.org/robotframework/latest/libraries/String.html
...             Doc DataDriver : https://github.com/Snooz82/robotframework-datadriver
Test Tags      template exercice 5
Library         String
Library         DataDriver      file=../../data/data.csv  encoding=utf_8      dialect=unix
Library         SeleniumLibrary    implicit_wait=0:00:30    timeout=0:00:30
Test Setup      Set Selenium Speed  0.5s
Test Teardown   Close Browser
Variables       ../../Resources/Exercice1/locators 1.py

# Définir le template :
Test Template   Verifier Ajout job titles


*** Variables ***
# Les variables déclarées ici sont visibles par le Test Case ainsi que par tous les Keywords

# Exemple :
${MA_VARIABLE}   Login
${URL}   https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}    Chrome
${Menu}        Admin


*** Test Cases ***
# Renommer clairement le Test Case, exemple : Verifier Menus Volet Gauche
Mon Test Case Exercice 5
  
 

# /!\ ATENTION /!\
#       EN MODE DATA DRIVEN
#       TOUT SE PASSE DANS LA PARTIE KEYWORDS
#       LE TEST CASE NE SERT QUE DE TEMPLATE PAR DEFAUT

    # Objectifs :
        # Utiliser le fichier fourni en entrée contenant 2 JDD : data.csv et les 2 fichiers png fournis
        # pour faire un upload de fichier dans le champ « Job Specification » (utiliser la méthode Choose File)
        # Bien penser à mettre le test case « Verifier Ajout job titles » dans la rubrique Keywords
        # Ecrire le test case en Gherkin
        # Les champs « Job Description », « Job Specification » et « Note » étant des champs facultatifs, vérifier que la valeur de ces champs n’est pas vide dans le fichier avant de les renseigner (utiliser la méthode Run Keyword If)
        # Vérifier le message de confirmation lors de l’ajout
        # Les job titles ajoutés sont uniques et doivent être supprimés avant de pouvoir être de nouveau ajoutés

    # Keywords utiles (voir le fonctionnement dans la doc associée) :
        # Choose File
        # Run Keyword If

    # Documentation Template :
        # https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#test-templates

*** Keywords ***
Verifier Ajout job titles
    [Arguments]     ${Job_title}    ${Job_description}      ${Job_file}     ${Job_note}
    Log To Console    -
    Log To Console    >>>>>>>>> ${Job_title} - ${Job_description} - ${Job_file} - ${Job_note}
    
    JE ME LOGUE A LA PAGE DACCUEIL
    l'utilisateur accéde à la liste de menu et choisi
    il ouvre l'onglet   Job
    Ajouter un job 
    Renseigner les données  ${Job_title}  ${Job_description}
    Sleep    5s

JE ME LOGUE A LA PAGE DACCUEIL
    
    Open Browser    ${URL}    ${BROWSER} 
    Title Should Be    OrangeHRM
    Element Should Be Visible  xpath://*[@id="app"]/div[1]/div/div[1]/div/div[2]/h5  ${MA_VARIABLE}
    Input Text     ${UsernameInputBox}   Admin
    Input Text     ${PasswordInputBox}   admin123
    Click Element    ${LoginButton}
#   Click Button (attention, ce keyword ne fonctionne pas si le bouton n'est pas un <button> dans le code HTML)
    Element Text Should Be    ${TitleDashboard}   Dashboard

    # exemple de condition : '${Job_description}'!='${EMPTY}'

    #Choose File    ${JobSpecificationInput}    ${Job_file}

l'utilisateur accéde à la liste de menu et choisi
    
    Click Element    ${DynamicMenu.format('${Menu}')}
il ouvre l'onglet
    [Arguments]     ${tab}
    Click Element   ${DynamicTab.format('${tab}')}
    Click Element   ${FirstTab}
    Wait Until Page Contains Element    ${JobTitlesHeader}    
Ajouter un job 

     Click Element     ${AddButton}
Renseigner les données 
         [Arguments]     ${Job_title}  ${Job_description}
     Input Text      ${JobTitleInput}      ${Job_title}  
     Input Text    ${JobDescriptionInput}     ${Job_description}



