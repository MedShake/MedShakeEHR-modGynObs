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

1- Follow the procedure to install MedShakeEHR-base.
1- Suivre la procédure d'installation de MedShakeEHR-base.

WARNING: the default configuration reuse the host ~ehr folder for data and log. If you had a previous EHR container running, please backup & remove ~ehr beforehand.
ATTENTION: la configuration par défaut réutilise le ~ehr de l'hôte. Si vous avez déjà lancé un conteneur EHR,veuillez sauvegarder puis supprimer ~ehr au préalable.

2- Fetch/clone the desired version of the EHR module (here the latest):
2- Récupérer la version souhaitée du module EHR (ici la dernière):

>git clone https://github.com/MedShake/MedShakeEHR-modGynObs.git

3- Enter the folder
3- Entrer dans le répertoire

>cd MedShakeEHR-base

4- Build the required EHR images
4- Construire les images de EHR

> docker-ehr-build.sh

Launch the application (create + start)
Lancer l'application (create + start)

> docker-compose up

5- First time there will be an error trying to start the web container.
5- La première fois, une erreur va bloquer le lancement du conteneur web.
5- As a workaround for this issue launch :
5- Pour contourner cette difficulté, lancer :

> mkdir ~ehr/log/apache2

6- And restart compose :
6- Puis, relancer compose :

> docker-compose up

7- An EHR instance is ready :
7- Vous avez une instance de EHR de disponible :

>http://host/

8- Follow the instructions there ...
8- Y suivre les instructions ...



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

