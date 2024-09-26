*** Settings ***
Documentation
...             Commande pour éxécuter le test : robot -d "Resultats/Exercice 3/" -i "exercice 3" Tests
...             Keywords String : https://robotframework.org/robotframework/latest/libraries/String.html
...             Keywords DateTime : https://robotframework.org/robotframework/latest/libraries/DateTime.html
Test Tags      template exercice 3
Library         String
Library         DateTime
Library         SeleniumLibrary    implicit_wait=0:00:30    timeout=0:00:30
Test Setup      Set Selenium Speed  0.5s
Test Teardown   Close Browser
Variables       ../../Resources/Exercice1/locators 1.py

*** Variables ***
# Les variables déclarées ici sont visibles par le Test Case ainsi que par tous les Keywords

# Exemple :
${MA_VARIABLE}   Login
${URL}   https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}    Chrome

*** Test Cases ***
# Renommer clairement le Test Case, exemple : Verifier Menus Volet Gauche
Mon Test Case Exercice 3

   JE ME LOGUE A LA PAGE DACCUEIL

    # Objectifs :
        # Ouvrir le navigateur et aller sur la bonne URL (voir VARIABLES>URL)
        # Se connecter et atteindre la page d'accueil (exercice 1A)
        # Accéder à la page My Info
        # Récupérer le nom et prénom de l'employé
        # Modifier son nom et prénom
        # Récupérer la date du jour à l’aide de la méthode Get Current Date au format AAAA-MM-JJ
        # Renseigner la valeur dans le champ License Expiry Date avec la méthode Input Text (Effacer au préalable le champ avec Press Keys)
        # Vérifier le message de confirmation lorsqu’on fait la sauvegarde
        # Indiquer si la sauvegarde s'est bien passée ou non (Success)

    # Objectif Bonus :
        # Récupérer le jour de naissance en cliquant sur le champ « Date of birth » et ainsi en ouvrant le calendrier
        # Le jour sélectionné dans le calendrier (surligné) a une classe dont l’attribut est –selected

    # Appel de nos propres Keywords

    # Keywords utiles :
    ${STRING_1}    ${STRING_2}=    Split String    MA STRING    max_split=1
    # STRING_1 = MA
    # STRING_2 = STRING
    # max_split=1 --> évite des problèmes quand il y a un espace dans le prénom
    Acces Menu   My Info
    Press Keys  ${EmployeeFirstName}     CTRL+a+BACKSPACE  

    Input Text     ${EmployeeFirstName}   Amine

    

    Click Element    ${MyInfoSaveButton}

    Element Should Be Visible   ${MessageContainer}


    Sleep    5

    # Should Be Equal As Strings    texte_1    texte_2
    # True si texte1=texte_2

    ${today}=    Get Current Date   result_format=%Y-%m-%d

*** Keywords ***
# Utiliser cette section pour déclarer vos Keywords qui seront utilisés par votre Test Case
# A noter : un fichier .robot sans Test Case (avec uniquement des Keywords) ne fera rien
# Un fichier .robot exécute un Test Case qui utilise des Keywords

# Nommer clairement vos Keywords, exemple : Recuperer Texte Menus Volet Gauche
# Bonne pratique : faites commencer vos Keywords par un verbe d'action

# Réutiliser l'exercice 1A pour vous connecter à la page d'accueil
JE ME LOGUE A LA PAGE DACCUEIL
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
Reutiliser Mon Test Case De Connexion De L'Exercice 1A Et En Faire Un Keyword
    Open Browser    ${URL}    ${BROWSER}
    # etc.

Declarer Un Autre Keyword Utile Pour Découper Logiquement Mon Test


 # Astuce : il est possible d'accéder aux méthodes et aux attributs d'un objet directement depuis l'appel de la variable
    # Exemple : la classe WebElement a pour attribut text, il est donc possible de faire ${string.format()}

    # https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#extended-variable-syntax
    # https://docs.python.org/fr/3/library/stdtypes.html#str.format

Acces Menu
    [Arguments]    ${MENU}
    Click Element    ${DynamicMenu.format('${MENU}')}

