>Dokumentation von Alex Afonso und Joel Grand

12.04.2019  
TBZ M300

## Einführung
In dieser Dokumentation beschreiben wir unsere im Modul 300 erlernten Erkenntnisse. Wir haben mit Hilfe von Docker und Compose unsere LB02 durchgeführt.

## Anforderungen
Dies sind die Anforderungen für unser Projekt:

##### Software
* VirtualBox
* Docker
* Visual Studio Code (oder einen anderen Editor)
* Docker-Compose


##### Unterlagen
* Markdown Cheat-Sheet
* Docker Cheat-Sheet
* [Klassenjournal](https://docs.google.com/document/d/1M-aswL3k4uI-_MYO8RLX7ExAFEzVJkUoqjAOLj9gtyY/edit)
* [M300 Github](https://github.com/mc-b/M300/tree/master)

## Kapitel 1: Beschrieb des Services

Wir haben für die LB02 mehrere Services aufgesezt. Als erstes setzen wir MySQL auf und erstellen eine Datenbank mit einem Benutzer. Anschliessend setzen wir einen Wordpress auf, welcher sich mit unserer vorher erstellten Datenbank verbinded.

Wir verwenden dafür Docker-Compose und machen Gebrauch von zwei verschiedenen Docker Images. Um unseren Service betreiben zu können muss logischerweise Docker Compose installiert werden.
## Kapitel 2: Technische Angaben inkl. Plan und Anleitung für den Betrieb
In diesem Teil gehen wir anhand der Anforderungen vor.
### Netzwerkplan
![image](https://github.com/joelxavi1/M300/blob/master/LB2/netzplan.PNG)

### Installation von Docker-Compose

Zuerst muss Docker-Compose nach `/usr/local/bin` mit den folgenden Befehl heruntergeladen werden:
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
Nachdem der Download abgeschlossen ist, müssen wir nach einen Berechtigung erteilen, um Compose ausführen zu könnnen:
```bash
sudo chmod +x /usr/local/bin/docker-compose
```
Nun können wir unser Docker compose File erstellen (docker-compose.yml) und im Zielordner ablegen.
### Docker-Compose File ausführen
Jetzt haben wir alles vorbereitet und können nun unser Docker-Compose File ausführen. Dies machen wir so:
```bash
docker-compose up
```

#### Alle Ports gegen localhost müssen im Range 8080-8089 oder 3306 liegen.
Wie in der Anforderung genannt, haben wir unseren Docker Port 80 nach Guest 8080 geforwarded.
* Docker 80 => Guest 8080
####Prinzipiell muss der Service von ausserhalb der VM genutzt werden können.
Da wir die für den Zugriff nötigen Port geforwarded haben ist unser Service von anderen Clients im selben Netz verfügbar.
### Dokumentation des docker-compose.yml
In diesem Abschnitt dokumentieren unser File:
#### docker-compose.yml
```bash
version: '3.3' #compose file version 

services:
 #DB / MYSQL Service
  db:
    image: mysql:5.7
    restart: always #immer neustarten des Containers
    volumes:
      - db_data:/var/lib/mysql #location wo es abgelegt wird
    environment:
      MYSQL_ROOT_PASSWORD: password #password von MYSQL
      MYSQL_DATABASE: wordpress #MYSQL Datenbank

#Wordpress Service
  wordpress:
    image: wordpress
    restart: always #immer neustarten des Containers
    volumes:
      - ./wp_data:/var/www/html #location wo es abgelegt wird
    ports:
      - "8080:80" #von Port 80 auf port 8080 weitergeleitet
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: root
      WORDPRESS_DB_PASSWORD: password
    depends_on:
       - db #wartet bis DB gestartet ist. Vorher wird es nicht gestartet!

volumes:
    db_data:
    wp_data:
```
##Kapitel 3: Testing
Hiermit können wir testen, ob Docker-Compose läuft:
```bash
docker-compose --version
```
Die ist unsere Ausgabe dieses Befehls:
```bash
docker-compose version 1.23.1, build b02f1306
```
#### Testfälle
Dies sind unsere wichtigsten Testdurchläufe:
|Test|Vorgang|Resultat|
|:------------- |:-------------| -----:|
|Wordpress main page is aufrufbar.|Port 8080 der VM forwarden auf gewünschter Port, über die IP des Clients, auf dem die VM läuft Zugreifen (Webbrowser) und ":<gewünschter port>" angeben |ja|
![image](https://github.com/joelxavi1/M300/blob/master/LB2/ipandport.PNG)
![image](https://github.com/joelxavi1/M300/blob/master/LB2/result.PNG)
Dies sind weitere Testfälle:
|Test|Resultat|
| ------------- |:-------------:|
|VM ist pingbar|ja||
|SQL Benutzer ist erstellt|ja|
|DB wird erstellt|ja||
|Wordpress hat Zugriff auf DB|ja|

##Kapitel 4: Troubleshooting
Wir hatten eigentlich keine Probleme bei durchführen des Auftrags. Der einzoge Stolperstein war, dass wir vergessen haben, die Portweiterleitung zu gewährleisten, worauf unser Service dann nicht erreichbar war. Dies haben wir aber direkt behoben.

## Reflexion
Wir haben viel gelernt und konnten unseren Horizont in disesem Thema erweitern. Dieses Thema ist sehr modern und es freut mich persönlich sehr so ein Modul absolvieren zu dürfen.
Ebenfalls habe ich Markdown kennengelernt, was mich persönlich als enthusiatischer Hobbyprogrammierer sehr freut.

Trotzdem haben wir unser bestes gegeben, so viel wie möglich mit zu nehmen.
