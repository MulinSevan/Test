 --****************************************************************************************
 --*	RESPECTER LES CONSIGNES :																				*
 --*		- N'enlever aucun commentaire dans ce fichier                    			         *
 --*																													*
 --* 		- les instructions de création d'une vue doivent être écrites dans vues.sql      *
 --* 		- les instructions de suppression d'une vue doivent être écrites dans drop.sql  *
 --* 		- les instructions d'attribution de droits doivent être écrites dans droits.sql  *
 --* 		- les instructions de test doivent être complétées dans ce fichier               *
 --* 		- les instructions de test doivent être complétées dans ce fichier               *
 --*       au fur et à mesure des questions sous le commentaire correspondant					* 
 --*																													*
 --*		- l'éxécution des instructions de création d'une vue et d'attribution de droits  *
 --*       seront toujours faites dans la console SOUS VOTRE PROPRE LOGIN                 *
 --*     - les instructions de test seront toujours exécutées dans la console             *
 --*       sous le login indiqué                                                          *
 --*																													*
 --*	SAUVEGARDEZ régulièrement les fichiers :vues.sql, drop.sql, droits.sql et           *
 --*  le fichier test_TP1.sql                                                             *
 --****************************************************************************************
 
 
/*_________________________________________________________________________________________

	A - Rappel : vues et manipulations de donénes
___________________________________________________________________________________________*/


-------------------------------------------------------------------------------- 
-- Q1 - Création et tests de la vue VActivitesFutures
-------------------------------------------------------------------------------- 

-- écrire les instructions de création de la vue VActivitesFutures dans le fichier vues.sql
-- écrire les instructions de suppression de cette vue dans droits.sql
-- exécuter les instructions de création de cette vue

------------------- 
-- TESTS Q1 
------------------- 

-- Affichage de la vue VActivitesFutures

 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin   
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2020-06-15 | 2020-06-15
     13 | rallye  | Monaco     | Monaco     | 2020-07-01 | 2020-07-01
     12 | rallye  | Nice       | Cannes     | 2020-08-01 | 2020-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2020-08-10 | 2020-08-15
      6 | sortie  | Toulon     | Toulon     | 2020-09-02 | 2020-09-12
     10 | sortie  | Macinaggio | Centuri    | 2020-09-14 | 2020-09-14
      9 | sortie  | Brest      | Concarneau | 2020-09-14 | 2020-09-14
      7 | sortie  | Toulon     | Toulon     | 2020-09-14 | 2020-09-14
(8 rows)

-- Insertion à partir de VActivitesFutures d'une nouvelle sortie 
-- (numéro 100, de Bastia à Pino, départ et arrivée le 25 fév. 2021)

insert into VActivitesFutures values ( 100, 'sortie', 'Bastia','Pino','25/02/2021','25/02/2021');


-- Affichage de la vue VActivitesFutures
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin   
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2020-06-15 | 2020-06-15
     13 | rallye  | Monaco     | Monaco     | 2020-07-01 | 2020-07-01
     12 | rallye  | Nice       | Cannes     | 2020-08-01 | 2020-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2020-08-10 | 2020-08-15
      6 | sortie  | Toulon     | Toulon     | 2020-09-02 | 2020-09-12
     10 | sortie  | Macinaggio | Centuri    | 2020-09-14 | 2020-09-14
      7 | sortie  | Toulon     | Toulon     | 2020-09-14 | 2020-09-14
      9 | sortie  | Brest      | Concarneau | 2020-09-14 | 2020-09-14
    100 | sortie  | Bastia     | Pino       | 2021-02-25 | 2021-02-25
(9 rows)
-- Modification à partir de VActivitesFutures de cette activité
-- (départ 2 jours avant la date d'arrivée)
update VActivitesFutures set datedebut = datedebut-2 where numact=100;


-- Affichage de la vue VActivitesFutures
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin   
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2020-06-15 | 2020-06-15
     13 | rallye  | Monaco     | Monaco     | 2020-07-01 | 2020-07-01
     12 | rallye  | Nice       | Cannes     | 2020-08-01 | 2020-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2020-08-10 | 2020-08-15
      6 | sortie  | Toulon     | Toulon     | 2020-09-02 | 2020-09-12
     10 | sortie  | Macinaggio | Centuri    | 2020-09-14 | 2020-09-14
      7 | sortie  | Toulon     | Toulon     | 2020-09-14 | 2020-09-14
      9 | sortie  | Brest      | Concarneau | 2020-09-14 | 2020-09-14
    100 | sortie  | Bastia     | Pino       | 2021-02-23 | 2021-02-25
(9 rows)
-- Suppression de cette activité à partir de VActivitesFutures

delete from VActivitesFutures where numact=100;

-- Affichage de la vue VActivitesFutures
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin   
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2020-06-15 | 2020-06-15
     13 | rallye  | Monaco     | Monaco     | 2020-07-01 | 2020-07-01
     12 | rallye  | Nice       | Cannes     | 2020-08-01 | 2020-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2020-08-10 | 2020-08-15
      6 | sortie  | Toulon     | Toulon     | 2020-09-02 | 2020-09-12
     10 | sortie  | Macinaggio | Centuri    | 2020-09-14 | 2020-09-14
      9 | sortie  | Brest      | Concarneau | 2020-09-14 | 2020-09-14
      7 | sortie  | Toulon     | Toulon     | 2020-09-14 | 2020-09-14
(8 rows)

-------------------------------------------------------------------------------- 
-- Q2 - Création et tests de la vue VParticipations
-------------------------------------------------------------------------------- 

-- écrire les instructions de création de la vue vue VParticipations dans le fichier vues.sql
-- écrire les instructions de suppression de cette vue dans droits.sql
-- exécuter les instructions de création de cette vue

------------------- 
-- TESTS Q2 
------------------- 

-- Affichage de la vue VParticipations 

select * from VParticipations;
-- A partir de cette vue : nom des adhérents ayant participé au plus grand nombre d'activités

select * from VParticipations
where nbfois_cdb + nbfois_equ = (select max(nbfois_equ) from VParticipations)
order by nbfois_cdb + nbfois_equ desc; 

-- En s'aidant de cette vue : nom des skippers qui ont participé au moins 4 fois à une activité passée, -- soit comme chef de bord, soit comme équipier
select * from VParticipations
where nbfois_cdb >= 1 and nbfois_equ >= 1 and nbfois_cdb + nbfois_equ >=4;
order by nbfois_cdb + nbfois_equ desc; 

/*_________________________________________________________________________________________

	B1 - Droits sur votre base
___________________________________________________________________________________________*/

-------------------------------------------------------------------------------- 
-- Q1 - Sécurisation de votre base
-------------------------------------------------------------------------------- 

-- compléter le fichier droits.sql : modification de votre mot de passe
-- compléter le fichier droits.sql : suppression du droit de connexion à votre base
-- exécuter les instructions correspondantes

------------------- 
-- TESTS Q1 
------------------- 

-- Connexion à votre base avec le login usera100, mot de passe p00


-- Affichage des relations existantes (après s'être reconnecté)
\d



-------------------------------------------------------------------------------- 
-- Q2 - Partage de votre base avec tous les adherents de Tourmentin
-------------------------------------------------------------------------------- 

-- compléter le fichier droits.sql : droits d'accès à votre base pour tous les adhérents
-- exécuter la ou les instructions correspondantes (sous votre login)

------------------- 
-- TESTS Q2 
------------------- 

-- Connexion en tant que aflau, puis affichage des relations existantes


-- Que remarquez-vous ?

--impossible d'afficher les tables

-- Tentative d'affichage du contenu de la table agence


/*_________________________________________________________________________________________

	B2 - Droits sur les objets de la base
___________________________________________________________________________________________*/

-------------------------------------------------------------------------------- 
-- Q1 - Droits du rôle président
-------------------------------------------------------------------------------- 

-- compléter le fichier droits.sql : droits du rôle president
-- exécuter la ou les instructions correspondantes (sous votre login)

-------------------------------------------------------------------------------- 
------------------------ 
-- TESTS Q1
-- connexion : aflau 
------------------------ 

-- Insertion du bateau requin ayant 10 places
insert into bateau values(7,'le requins',15.80,'pouvreau',10);

-- Suppression de ce bateau
delete from bateau where nombat='le requin';

-- Affichage de la table resultat pour l'activité numéro 2

select * from resultat where numact=2;

-- Modification de l'adresse de garnier
update adherent SET adresse='quelque part', where nom='garnier';

-- Tentative de suppression de la table resultat
drop table resultat;
error must be owner of table resultat


-- Tentative d'ajout d'une colonne caution de type int dans la table loueur

alter table loueur add caution int;
error: must be owner of table loueur; 

-- Tentative de suppression de la vue VActivitesFutures
drop view VActivitesFutures;ERROR:  
must be owner of view vactivitesfutures

-- BILAN ------------------------------------------------------------------------ 

-- Quels droits n'a pas aflau sur les objets de votre base ?

il ne peut rien supprimer ni ajouter des attribuer;

-- Pourquoi ?

ce droit revient au proprietaire

-------------------------------------------------------------------------------- 
-- Q2 - Droits du rôle adherent
-------------------------------------------------------------------------------- 

-- compléter le fichier droits.sql : premiers droits du rôle adherent
-- exécuter la ou les instructions correspondantes (sous votre login)

-- compléter le fichier vues.sql : instructions de création de la vue VMoi
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits du rôle adherent sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)

-- compléter le fichier vues.sql : vue VMembres
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits du rôle adherent sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)

-- compléter le fichier vues.sql : vue VMesCotisations
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits du rôle adherent sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)


-------------------------------------------------------------------------------- 
------------------------ 
-- TESTS Q2
-- connexion : limande 
------------------------ 

-- Affichage des activités futures

select * from VActivitesFutures;

-- Affichage de ses informations personnelles

select * from Vmoi;

-- Tentative de modification de l'adresse de merlu

update adherent set adresse='Port-saint-louis' where nom='merlu';
ERROR:  permission denied for table adherent
-- Modification de sa propre adresse (nouvelle adresse 'lyon')

update Vmoi set adresse='Port-saint-louis';


-- Vérification de l'effet de la modification

select * from Vmoi;

-- A partir de VMembres, affichage des informations sur tous les skippers
select * from VMembres where skipper='oui';

-- Affichage des résultats (N° régate, classement, points)
-- obtenus par le bateau 5 aux régates de l'activité 2
select numregate,classement,points 
from resultat where numbat=5 and numact=2;

-- Affichage de ses cotisations
select * from VMesCotisations;

-------------------------------------------------------------------------------- 
-- Q3 - Droits du rôle skipper
-------------------------------------------------------------------------------- 

-- compléter le fichier vues.sql : vue VMesRespFutures
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)
-- compléter le fichier droits.sql : droits dur rôle skipper sur cette vue
-- exécuter la ou les instructions correspondantes (sous votre login)

-------------------------------------------------------------------------------- 
------------------------ 
-- TESTS Q3
-- connexion : merlu/aflau 
------------------------ 

-- CONNEXION en tant que merlu
-- Activités futures pour lesquelles merlu est chef de bord

 numact | typeact | depart | arrivee | datedebut  |  datefin   |       nombat       | nbplaces | count 
--------+---------+--------+---------+------------+------------+--------------------+----------+-------
     13 | rallye  | Monaco | Monaco  | 2020-07-01 | 2020-07-01 | rêve des iles      |        8 |     4
     11 | sortie  | Bastia | Ajaccio | 2020-08-10 | 2020-08-15 | cauchemar des mers |        5 |     4
      6 | sortie  | Toulon | Toulon  | 2020-09-02 | 2020-09-12 | évasion            |        7 |     5
      7 | sortie  | Toulon | Toulon  | 2020-09-14 | 2020-09-14 | le renard          |        6 |     3

-- CONNEXION en tant que aflau
-- Activités futures pour lesquelles aflau est chef de bord
select * from VMesRespFutures;

 numact | typeact | depart | arrivee | datedebut  |  datefin   |  nombat   | nbplaces | count 
--------+---------+--------+---------+------------+------------+-----------+----------+-------
      8 | rallye  | Toulon | Toulon  | 2020-06-15 | 2020-06-15 | imagine   |        6 |     4
     13 | rallye  | Monaco | Monaco  | 2020-07-01 | 2020-07-01 | imagine   |        6 |     4
     12 | rallye  | Nice   | Cannes  | 2020-08-01 | 2020-08-01 | imagine   |        6 |     4
      6 | sortie  | Toulon | Toulon  | 2020-09-02 | 2020-09-12 | intermède |       10 |     7
      7 | sortie  | Toulon | Toulon  | 2020-09-14 | 2020-09-14 | imagine   |        6 |     2
....

-------------------------------------------------------------------------------- 
-- Q4 - Intermède
-------------------------------------------------------------------------------- 

------------------------ 
-- TESTS Q4
-- connexion : vous 
------------------------ 

\du tresorier


\du guy

 guy       |            | {tresorier,skipper,adherent}
-- A quels groupes appartient guy ?

\dp bateau


-- Quels sont les droits de guy sur la relation bateau ?

il peut lire (read r)

-- suppression des droits de consultation de la relation bateau pour l'adherent guy
REVOKE SELECT ON bateau FROM guy;

-- CONNEXION en tant que guy : affichage de la relation bateau

marche encore...

-- Quels sont les nouveaux droits de guy sur la relation bateau (pourquoi) ?
il a toujour les droits car il est adherent

-------------------------------------------------------------------------------- 
-- Q5 - Droits du rôle bureau
-------------------------------------------------------------------------------- 

-- compléter le fichier droits.sql : droits supplémentaires du rôle bureau
-- exécuter la ou les instructions correspondantes (sous votre login)
-------------------------------------------------------------------------------- 
------------------------ 
-- TESTS Q5
-- connexion : michal 
------------------------ 

-- Affichage de la table agence
select * from agence;

-- Affichage de la table cotisation
select * from vappelcotisation;

-------------------------------------------------------------------------------- 
-- Q6 - Droits du rôle tresorier
-------------------------------------------------------------------------------- 

-- compléter le fichier vues.sql : création de la vue VAppelCotisation
-- compléter le fichier drop.sql : instructions de suppression de cette vue
-- exécuter les instructions de création de cette vue (sous votre login)

-- compléter le fichier droits.sql : droits supplémentaires du rôle tresorier
-- exécuter la ou les instructions correspondantes (sous votre login)
-------------------------------------------------------------------------------- 
------------------------ 
-- TESTS Q6
-- connexion : guy 
------------------------ 

-- Affichage de VAppelCotisation

select * from vappelcotisation;

-- A partir de VAppelCotisation, augmentation de 2€ sur la cotisation de tous les adhérents qui n'ont pas encore payé
update vappelcotisation set montant=montant+2 where paye = 'non';

-- Affichage de VAppelCotisation
basea111=> select * from vappelcotisation;
 numadh | montant | paye 
--------+---------+------
      1 |     125 | oui
      4 |     125 | oui
      5 |     125 | oui
      6 |     115 | oui
...
      9 |     127 | non
     15 |     137 | non
     18 |     137 | non
     19 |     132 | non
(19 rows)


-------------------------------------------------------------------------------- 
-- Q7 - Droits du rôle secretaire
-------------------------------------------------------------------------------- 

-- compléter le fichier droits.sql : droits supplémentaires du rôle secretaire
-- exécuter la ou les instructions correspondantes (sous votre login)
-------------------------------------------------------------------------------- 
------------------------ 
-- TESTS Q7
-- connexion : michal 
------------------------ 



-- Insertion d'une nouvelle régate pour l'activité 12

insert into regate values (12,(select max(numregate) from regate where numact=12)+1);

-- Insertion des lignes correspondantes dans la table résultat
insert into resultat values (1,12,(select max(numregate) from regate where numact=12));
insert into resultat values (2,12,(select max(numregate) from regate where numact=12));
insert into resultat values (3,12,(select max(numregate) from regate where numact=12));

-- Affichage de la table resultat pour l'activité 12, ordonnée par numéro de régate puis
-- par numéro de bateau

select * from resultat where numact=12 order by numregate,numbat;
 numbat | numact | numregate | classement | points 
--------+--------+-----------+------------+--------
      1 |     12 |         1 |            |       
      2 |     12 |         1 |            |       
      3 |     12 |         1 |            |       
      1 |     12 |         2 |            |       
      2 |     12 |         2 |            |       
      3 |     12 |         2 |            |       
      1 |     12 |         3 |            |       
      2 |     12 |         3 |            |       
      3 |     12 |         3 |            |       
      1 |     12 |         4 |            |       
      2 |     12 |         4 |            |       
      3 |     12 |         4 |            |       
(12 rows)

-- Création d'une nouvelle sortie pour le réveillon, départ de Marseille le 31 décembre 2020,
insert into activite values((select max(numact) from activite)+1,'sortie','Marseille','Bastia','31/12/2020','02/01/2021');
-- arrivée à Bastia le 2 janvier 2021
SET DATESTYLE TO european; -- au cas où le format de dates ne soit pas JJ/MM/AAAA


-- Vérification : affichage des activités futures

select * from VActivitesFutures;
 numact | typeact |   depart   |  arrivee   | datedebut  |  datefin   
--------+---------+------------+------------+------------+------------
      8 | rallye  | Toulon     | Toulon     | 2020-06-15 | 2020-06-15
     13 | rallye  | Monaco     | Monaco     | 2020-07-01 | 2020-07-01
     12 | rallye  | Nice       | Cannes     | 2020-08-01 | 2020-08-01
     11 | sortie  | Bastia     | Ajaccio    | 2020-08-10 | 2020-08-15
      6 | sortie  | Toulon     | Toulon     | 2020-09-02 | 2020-09-12
     10 | sortie  | Macinaggio | Centuri    | 2020-09-14 | 2020-09-14
      9 | sortie  | Brest      | Concarneau | 2020-09-14 | 2020-09-14
      7 | sortie  | Toulon     | Toulon     | 2020-09-14 | 2020-09-14
(8 rows)


-- Inscription de aflau comme chef de bord du bateau évasion pour cette nouvelle sortie

insert into chefdebord values(
      
(select max(numact) from activite),
(select numadh from adherent where nom='aflau'),
(select numbat from bateau where nombat='évasion'));

-- Inscription de tous les autres skippers comme équipiers de aflau pour cette nouvelle sortie
select numadh from adherent where skipper='oui' and numadh not in (select numadh from adherent where nom='aflau');
 numadh 
--------
      2
      5
     10
     13
(4 rows)

-- CONNEXION aflau
-- Vérification : affichage de ses responsabilités futures

insert into equipage values ((select max(numact) from activite),2,(select numbat from bateau where nombat='évasion'));
insert into equipage values ((select max(numact) from activite),5,(select numbat from bateau where nombat='évasion'));
insert into equipage values ((select max(numact) from activite),10,(select numbat from bateau where nombat='évasion'));
insert into equipage values ((select max(numact) from activite),13,(select numbat from bateau where nombat='évasion'));




-------------------------------------------------------------------------------- 
-- Q8 - Droits manquants au rôle president
-------------------------------------------------------------------------------- 

-- compléter le fichier droits.sql : droits supplémentaires du rôle president
-- exécuter la ou les instructions correspondantes (sous votre login)

-------------------------------------------------------------------------------- 
------------------------ 
-- TESTS libres
-- connexion : aflau 
------------------------ 



