**Les informations ci-dessous sont une rapide introduction purement technique ! 
Consultez [www.logiciel-cabinet-medical.fr](http://www.logiciel-cabinet-medical.fr/) pour toutes les informations sur le logiciel MedShakeEHR et son module Gynécologie Obstétrique !**

# MedShakeEHR-modGynObs
Module Gynécologie Obstétrique pour MedShakeEHR

## Utilisation
Ce module doit être utilisé conjointement avec MedShakeERH-base.

**Pour des informations complètes sur MedShakeEHR, son installation, son fonctionnement, ses différents modules ... consultez [le site MedShakeEHR](http://www.logiciel-cabinet-medical.fr/) !**

Les fichiers sont à copier dans l'arborescence. Ils ne font pas doublon avec ceux de MedShakeEHR-base, mais le feront si un autre module est déjà en place.

Il convient d'utiliser le dump MySQL fourni avec MedShakeEHR-base pour la création de la base de données. 
Le fichier SQL présent ici comporte uniquement le contenu à insérer pour l'utilisation de ce module. 

## Docker Install / Installation Docker

1- Follow the procedure to install MedShakeEHR-base but stop after step calling "docker-ehr-build.sh" to create the EHR base images
1- Suivre la procédure d'installation de MedShakeEHR-base mais arrêtez aprés l'étape "docker-ehr-build.sh" qui crée les images EHR base

WARNING: the default configuration reuse the host ~ehr folder for data and log. If you had a previous EHR container running, please backup & remove ~ehr beforehand.
ATTENTION: la configuration par défaut réutilise le ~ehr de l'hôte. Si vous avez déjà lancé un conteneur EHR,veuillez sauvegarder puis supprimer ~ehr au préalable.

2- Fetch/clone the desired version of the EHR module (here the latest):
2- Récupérer la version souhaitée du module EHR (ici la dernière):

>git clone https://github.com/MedShake/MedShakeEHR-modGynObs.git

3- Enter the folder
3- Entrer dans le répertoire

>cd MedShakeEHR-base

4- Alter the following file to change password (MANDATORY), hostname or anything needed. Make sure that changes made are consistent accross the various files including files from EHR base.
4- Modifier le fichiers suivant pour changer les mots de passe (OBLIGATOIRE), les noms de machines ou tout autre chose requise. Vérifiez que les changements effectués sont cohérents d'un fichier à l'autre y comprit avec les fichier de EHR base.

- docker-compose.yml : MYSQL_ROOT_PASSWORD, MYSQL_USER, MYSQL_PASSWORD

5- Build the required EHR images
5- Construire les images de EHR

> docker-ehr-build.sh

6- Launch the application (create + start)
6- Lancer l'application (create + start)

> docker-compose up

7- First time there will be an error trying to start the web container.
7- La première fois, une erreur va bloquer le lancement du conteneur web.
7- As a workaround for this issue launch :
7- Pour contourner cette difficulté, lancer :

> mkdir ~ehr/log/apache2

8- And restart compose :
8- Puis, relancer compose :

> docker-compose up

9- An EHR instance is ready :
9- Vous avez une instance de EHR de disponible :

>http://host/

10- Follow the instructions there ...
10- Y suivre les instructions ...



To start the containers
Pour démarrer les conteneurs

> docker-compose start

To remove the containers (this will not remove ~ehr/data)
Pour supprimer les conteneurs (ne supprime pas ~ehr/data)

> docker-compose rm

To list the containers :
Pour lister les conteneurs :

> docker-compose ps

From a terminal, access the container's shell (here the db) :
Depuis un terminal, accèder à l'invite du conteneur (ici le db)

> docker exec -it medshakeehrmodgynobs_db_1 /bin/bash

