# Projektplan

## 1. Projektbeskrivning (Beskriv vad sidan ska kunna göra).
Denna sida ska kunna visa upp spel av flera olika genre och företag under samma kategorier för att kunna hitta liknade spel eller spel av samma företag. Vilket då ska ge användaren en bra förstålse vilka spel han kanske också gillar. Sidan ska man kunna logga in och registrera sig på hemsidan. Men loggar man inte in så kan man fortfarande kolla påhemsidan fast man kan inte göra dess funktioner eller liknade. Där inlågare kommer ha funktioner att kunna göra så som man kan markera dem spelen man gillar och genre man gillar att spela vilket kommer upp i sin lista efter ått. Där spelen kommer visa vilket gengre dem är, samt vilket företag som har gjort dem.    
## 2. Vyer (visa bildskisser på dina sidor).
Första bilden är start sidan man kommer in på när man startar hemsidan 
![start sidan](planerings_bilder/BIld1.jpg)
Denna bild kommer efter man har loggat in för att välja vilket genre eller företag man vill kolla på!
Yeild är samma som houvdbaren från första bilden!!
![spel sidan](planerings_bilder/bild2.jpg)
Denna bild är på sin lista man kan se sina favoriter
![min lista](planerings_bilder/bild3.jpg)
Denna bild är på spelet information när man klickar på den 
![Spel info](planerings_bilder/bild4.jpg)

## 3. Databas med ER-diagram (Bild på ER-diagram).
Mitt ER diagram på hemsidan 
![ER Diagram](planerings_bilder/er-diagram2.jpg)
## 4. Arkitektur (Beskriv filer och mappar - vad gör/innehåller de?).

[Planeringss_bilder] => Innehåller alla bilder av planeringen av projektet, samt er digramen de första och den andra mer upptaterade.

[projektet] => Innehåller alla mappar och koder för att arbetet skall kunna fungera.

[projektet\yardoc] => Innehåller en funktioner som gör det enklare för dekumentation för hemsidan. Som sedan gör en automatisk dekumation på den.

[projektet\db] => Innehåller databasen som hemssidan arbetar mot med alla användare och infromation på hemsidan.

[projektet\doc] => Innehåller hör ihop med yardoc vet inte exakt hur den fungerar men den visar sen dukumentaion på en localhost

[projektet\public] => Innehåller alla saker som är publik till allmänheten och sedan har två deperata mappar med olika funtkioner.

[projektet\public\css] => Innehåller alla styling för hemsidan, och för jag använnder mig av scss så finns det lite mer funktioner som gör den mögligt på vilken webbläsare som helst och den kommer se samma ut. för den är intergerar med all olika webbläsare vi har. Där _variables innehåller alla snabb css jag vill ha på sidan så jag skriver mindre kod på stylle.scss. Dem två css är auto genererande från scss då den skriver ut allt jag skriver i style ut i ren css kod som funkar på alla weblässare. Där style.scss är houved css sidan där jag skriver in css koden jag vill ha som sedan generas till ren css kod. 

 [projektet\public\misc] => Innehåller alla bilder som finns på hemsidan och i databasen. 


[projektet\app.rb] => Innehåller alla routes i hemsidan och är kontrolpanelen till hemssidan där allt måste gå igenom att de skall fungera. 


[projektet\model.rb] => Innehåller alla fonktioner till hemsidan sammt alla databas anropnigar som händer under sidan gång. 

[projektet\views\index.slim] => är start sidan för hemsidan

[projektet\views\layout.slim] => är naven och houvdbar för alla sidor i hemsidan 

[projektet\views\login.slim] =>  visar login template 

[projektet\views\register.slim] =>  visar register template 

[projektet\views\user\index.slim] =>  visar spelen för som inte loggade in på hemsidan 

[projektet\views\user\show.slim] =>  visar all infromatn för varje spel 

[projektet\views\login_user\index.slim] =>  visar spelen för den som har loggat in 

[projektet\views\login_user\show.slim] =>  visar all infromatn för varje spel 

[projektet\views\login_user\edit.slim] => editar på min sida för ens tankar 

[projektet\views\login_user\minsida.slim] => visar den in loggande speciala sida. 





