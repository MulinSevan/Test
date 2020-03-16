/*___________________________________

			PROCEDURES (à compléter)
  ___________________________________*/
  
-----------------------------------------------------------------------
-- Durée en jours d'une activité
-----------------------------------------------------------------------
CREATE OR REPLACE function NombreJours(nact numeric) RETURNS numeric AS
--{} => {résultat = durée en jours de l'activité de numéro numact}
$$
declare 
	nb numeric(3);
begin
	select datefin-datedebut+1 into nb
	from VActivitesFutures
	where numact=nact;
RETURN nb;
end;
$$language 'plpgsql';

-----------------------------------------------------------------------
-- Non recouvrement de deux plages de dates
-----------------------------------------------------------------------
CREATE OR REPLACE function Disjonction(dd1 date, df1 date, dd2 date, df2 date) RETURNS boolean AS
--{dd1 <= df1, dd2 <= df2} => {résultat = vrai si les plages dd1->df1 et dd2->df2 sont disjointes}
$$
begin
if (df1<dd2) or (df2<dd1) then return true;
else return false;
end if;
end; $$language 'plpgsql';

-----------------------------------------------------------------------
-- Disponibilité d'un bateau entre deux dates (comprises)
-----------------------------------------------------------------------
CREATE OR REPLACE function BateauDispo(numb numeric, dd date, df date) RETURNS boolean AS
--{numb est un numéro de bateau enregistré dans la base} => 
--		{résultat = vrai si le bateau de numéro numb est disponible de dd à df (comprises)
--		 si dd > df, une exception est levée}
$$
begin
if dd>df then raise exception 'la date de fin est avant la date de depart';
end if;
if exists (select a.numact from activite a, chefdebord c 
			where c.numbat = numb and c.numact = a.numact 
			and not Disjonction(datedebut,datefin,dd,df))
then return false;
else return true;
end if;

end; $$ language 'plpgsql';






-- Disponibilité d'un adhérent entre deux dates (comprises)
-----------------------------------------------------------------------
/*CREATE OR REPLACE function MembreDispo(numa numeric, dd date, df date) RETURNS boolean AS
--{numa est le numéro d'un adhérent enregistré dans la base} => 
--		{résultat = vrai si l'adhérent de n° numa est disponible de dd à df (comprises)
--		 une exception est levée si df est antérieure à dd}

$$
begin
if dd>df then raise exception 'la date de fin est avant la date de depart';
end if;
if		  (exists(select  a.numact from activite a, equipage e 
			where e.numadh = numa and e.numact = a.numact 
			and not Disjonction(datedebut,datefin,dd,df)) )
			and (exists
		  (select a.numact from activite a, chefdebord c 
		    where c.numadh = numa and c.numact = a.numact 
	        and not Disjonction(datedebut,datefin,dd,df)))
then return true;
else return false;
end if;

end; $$ language 'plpgsql';*/ --marche pas pour d'obscure raison


CREATE OR REPLACE function MembreDispo(numa numeric, dd date, df date) RETURNS boolean AS
$$
declare 
com1 numeric(2);
com2 numeric(2);
begin
if dd>df then raise exception 'la date de fin est avant la date de depart';
end if;
select count(*) into com1 from equipage e,activite a where a.numact = e.numact 
						and numa = e.numadh and not Disjonction(datedebut,datefin,dd,df); 
select count(*) into com2 from chefdebord c,activite a where c.numact = a.numact 
						and numa = c.numadh and not Disjonction(datedebut,datefin,dd,df); 

return (com2=0 and com1=0);
end; $$ language 'plpgsql';

-----------------------------------------------------------------------
-- Possibilité de prévoir une sortie entre deux dates (comprises)
-----------------------------------------------------------------------
CREATE OR REPLACE function SortiePossible(dd date, df date) RETURNS boolean AS
--{} => {résultat = vrai si au moins un bateau, un skipper et 4 AUTRES membres sont
--       disponibles de dd à df (comprises)}

$$
begin
if dd>df then raise exception 'la date de fin est avant la date de depart';
end if;

if ((Select count(numbat) from bateau where BateauDispo(numbat,dd,df))>=1) 
and
((select count(numadh) from adherent where MembreDispo(numadh,dd,df))>=4)
and 
((select count(numadh) from adherent where MembreDispo(numadh,dd,df) and skipper='oui')>=1)

then return true;
else return false;
end if;
end; $$ language 'plpgsql';


-----------------------------------------------------------------------
-- Participations passées d'un membre à une activité 
-----------------------------------------------------------------------
CREATE OR REPLACE function Participations(in numa numeric,
														out nbsorties numeric, out nbrallyes numeric) AS
--{numa est le numéro d'un adhérent enregistré dans la base} => 
--{nbsorties = nombre de sorties terminées auxquelles numa a participé,
--nbrallyes = nombre de rallyes terminés auxquels numa a participé}

$$
begin

nbsorties:=
(select count(*) from equipage e, activite a where e.numadh=numa and a.numact=e.numact and a.typeact='sortie' and a.numact not in (select numact from VActivitesFutures))
+ (select count(*) from chefdebord c, activite a where c.numadh=numa and a.numact=c.numact and a.typeact='sortie' and a.numact not in (select numact from VActivitesFutures));
nbrallyes:=
(select count(*) from equipage e, activite a where e.numadh=numa and a.numact=e.numact and a.typeact='rallye' and a.numact not in (select numact from VActivitesFutures))
+(select count(*) from chefdebord c, activite a where c.numadh=numa and a.numact=c.numact and a.typeact='rallye'and a.numact not in (select numact from VActivitesFutures));


end; $$ language 'plpgsql';


-----------------------------------------------------------------------
-- Saisie des résultats des concurrents et calcul automatisé des points
-- obtenus selon le classement, après une régate d'un rallye terminé
-----------------------------------------------------------------------
CREATE OR REPLACE function EnregResultats(numra numeric, numre numeric, numb numeric, place int) 
		RETURNS VOID AS 
--{numra est le numéro d'un rallye, numre est le numéro d'une régate,
-- numb est le numéro d'un bateau, place est le classement supposé de ce bateau
-- si place = 999, le bateau a abandonné lors de la régate numre} => 
--		{si le rallye n'est pas terminé ou s'il a moins de numre régates, ou encore si le bateau numb
-- 	 n'a pas participé à ce rallye, une exception est levée
--		 sinon, les points obtenus sont calculés et affichés et la table résultat est mise à jour}
$$
begin











end; $$ language 'plpgsql';









 

-----------------------------------------------------------------------
-- Création automatisée de nouvelles régates pour un rallye
-- version 1
-----------------------------------------------------------------------

-- version 1 : aucune régate préalablement créée pour l'activité
CREATE OR REPLACE function Insregates(nact numeric, nbreg numeric) RETURNS void AS 
--{nact est le numéro d'une activité, nbreg est le nombre de régates à créer, 
-- il n'y a aucune régate déjà créée pour cette activité} => 
--		{si nact est bien le numéro d'un rallye futur, nbreg régates ont été créées
--		 sinon des exceptions sont levées}





-- version 2 (BONUS) : il peut exister des régates pour cette activité
CREATE OR REPLACE function Insregates(nact numeric, nbreg numeric) RETURNS void AS 
--{nact est le numéro d'une activité, nbreg est le nombre de régates à créer} => 
--		{si nact est bien le numéro d'un rallye futur, nbreg régates ont été créées
--		 sinon des exceptions sont levées}






-----------------------------------------------------------------------
-- Information sur les membres inscrits comme équipiers sur un bateau
-- pour une activité donnée
-----------------------------------------------------------------------
CREATE OR REPLACE function InfosEquipiers(act numeric, numb numeric) 
						RETURNS TABLE(nadh numeric, pr varchar, nm varchar, tel varchar) AS
--{act est le numéro d'une activité, numb est le numéro d'un bateau} => 
--		{le résultat est une table où dans chaque ligne :
--		 nadh est le numéro, pr est le prénom, nm est le nom, tel est le téléphone d'un membre
--		 inscrit comme équipier du bateau numb pour l'activité act}




-----------------------------------------------------------------------
-- Numéro des activités commençant entre J+7 et J+13
-----------------------------------------------------------------------
CREATE OR REPLACE function ListActNextWeek() RETURNS SETOF numeric AS 
-- {} => {résultat = liste de numéros d'activités dont la date de début est comprise entre J+7 et
--			 J+13 au sens large}





-----------------------------------------------------------------------
-- SUIVI des activités futures
-----------------------------------------------------------------------

----------------------------------------------------------
-- 1 - Contrôle des activités commençant entre J+7 et J+13
----------------------------------------------------------
CREATE OR REPLACE function EtatActNextWeek() RETURNS TABLE
			(num numeric, nature varchar, dd date, df date, etat varchar) AS
-- {} => {résultat = table où, pour chaque ligne : 
--				* num est le numéro d'une activité débutant entre J+7 et J+13
--				* nature est son type
--				* dd et df sont ses dates de début et de fin
--				* etat = 'SANS SKIPPER' ou 'RAS' ou 'PBM'
-- SANS SKIPPER => aucun bateau n'est inscrit à l'activité de numéro num
-- RAS => tous les bateaux inscrits à l'activité de numéro num ont au moins 5 membres à leur bord
-- PBM => au moins un bateau inscrit à l'activité de numéro num n'a pas 5 membres à son bord
--
-- La table résultat est triée par ordre chronologique (de date début)}
$$
declare
	act record;
	bat numeric;
	OK boolean;
begin
	FOR act IN SELECT * FROM activite WHERE numact IN (SELECT * FROM ListActNextWeek()) ORDER BY datedebut loop
		if act.numact NOT IN (SELECT numact FROM chefdebord) then
			etat := 'SANS SKIPPER';
		else
			OK := true;
			for bat IN SELECT numbat FROM chefdebord WHERE numact = act.numact loop
				if (SELECT count(*) +1 FROM equipage WHERE numact = act.numact and numbat = bat) < 5 then
					OK := false;
				end if;
			end loop;
			if OK then etat := 'RAS';
			else	etat := 'PBM';
			end if;
		end if;
		SELECT act.numact, act.typeact, act.datedebut, act.datefin INTO num, nature, dd, df;
		RETURN NEXT;
	end loop;					
end; $$ language 'plpgsql';

----------------------------------------------------------
-- 2 - Contrôle des bateaux inscrits à des activités
--		 commençant entre J+7 et J+13
----------------------------------------------------------
CREATE OR REPLACE function ControleBat(numa numeric) 
	RETURNS TABLE(numb numeric, nbinsc numeric, places numeric, nbdispo numeric, etat varchar) AS
-- {numa = le numéro d'une activité future} => {résultat = table où pour chaque ligne : 
--				* numb est le numéro d'un bateau inscrit à l'activité numa
--				* nbinsc est le nombre d'inscrits sur ce bateau pour l'activité numa
--				* places est le nombre de places restantes sur ce bateau 
--				* nbdispo est le nombre d'adhérents disponibles pour participer à l'activté numa
--				* etat = 'OK' ou 'INCOMPLET'
-- OK => au moins 5 membres sont inscrits sur le bateau numb pour l'activité numa
-- INCOMPLET => moins de 5 membres sont inscrits sur le bateau numb pour l'activité numa}





-----------------------------------------------------------------------
-- Planning d'un adhérent (ses participations futures)
-----------------------------------------------------------------------
CREATE OR REPLACE function MonPlanning() RETURNS void AS
--{} => {affiche les informations sur les activités futures auxquelles le membre connecté est inscrit
-- 		ainsi que le poste qu'il occupe (équipier ou skipper) pour chacune de ces activités
--			les informations sont triées par ordre chronologique sur la date de début}





-----------------------------------------------------------------------
-- Préparation de l'annulation d'activités ou de la participation de
-- bateaux à ces activités
-- Activités concernées : celles débutant entre J+7 et J+13 (compris)
-----------------------------------------------------------------------
CREATE OR REPLACE function PrepAnnulation() RETURNS void AS
-- {} => {le numéro, le type, les dates et les ports de chaque activité débutant entre J+7 et J+13
--			 a été affiché ;
--        pour chaque activité :
--			 * un message exprime si l'activité est maintenue, partiellement maintenue ou annulée
--			 * dans le cas d'une activité partiellement maintenue ou annulée :
--				un message est affiché pour chaque bateau dont la participation doit être annulée, il
--				précise le prénom, le nom et le numéro de téléphone du chef de bord ainsi que le prénom, le nom et
--				le numéro de téléphone de chaque membre d'équipage}		





-----------------------------------------------------------------------	

---------------------------------------------------------------
-- Vue VActivitesFutures 
-- Toutes les informations sur les activités dont la date de départ est ultérieure à la date du jour 
-- Vue ordonnée sur la date de départ
---------------------------------------------------------------
create view VActivitesFutures as
    select * from activite where datedebut > current_date
    order by datedebut;


---------------------------------------------------------------
-- Vue VParticipations(id, nom, nbfois_cdb, nbfois_equ)
-- Pour chaque ligne affichée par la vue
-- id = numéro d'un adhérent
-- nom = nom de cet adhérent
-- nbfois_cdb = nombre de fois où il a été chef de bord par le passé
-- nbfois_equ = nombre de fois où il a été simple équipier par le passé
---------------------------------------------------------------
create view VParticipations (id, nom, nbfois_cdb,nbfois_equ) as
select 
    adherent.numadh,adherent.nom,
    (select count(*) 
        from chefdebord
        where chefdebord.numadh = adherent.numadh
        and chefdebord.numact not in (select numact from VActivitesFutures)),
    (select count(*) 
        from equipage
        where equipage.numadh = adherent.numadh
        and numact not in (select numact from VActivitesFutures))
from adherent;

--ou alors : 

--select * from VParticipations
--where id in (select numadh from adherent where skipper='oui') 
--and nbfois_equ >= 1 and nbfois_cdb + nbfois_equ >=4
--order by nbfois_cdb + nbfois_equ desc; 
--???

---------------------------------------------------------------
-- Vue VMoi (pour les adhérents)
---------------------------------------------------------------

create view VMoi as select * from adherent where nom=getpgusername();



---------------------------------------------------------------
-- Vue VMembres (pour les adhérents)
---------------------------------------------------------------

create view VMembres as 
select nom,prenom,adresse,telephone,fonction,skipper
from adherent;

	
---------------------------------------------------------------
-- Vue VMesCotisations (pour les adhérents)
---------------------------------------------------------------

create view VMesCotisations as select anneecot,montant,paye 
from cotisation, adherent where adherent.nom=getpgusername() 
and cotisation.numadh=adherent.numadh;
	
---------------------------------------------------------------
-- Vue VMesRespFutures(pour les skippers)
---------------------------------------------------------------

create or replace view VMesRespFutures as 
select distinct VActivitesFutures.numact,VActivitesFutures.typeact,
				depart,arrivee,datedebut,datefin,B.nombat,B.nbplaces,
				(select count(distinct numadh) from equipage e
				where e.numact = VActivitesFutures.numact 
				and e.numbat = b.numbat ) 

from VActivitesFutures,bateau B,equipage E,Vmoi,chefdebord c
where Vmoi.numadh=c.numadh
and VActivitesFutures.numact=c.numact
and c.numbat= b.numbat 
and B.numbat=E.numbat
order by VActivitesFutures.datedebut;






---------------------------------------------------------------
-- Vue VAppelCotisation (pour le trésorier)
---------------------------------------------------------------

create view VAppelCotisation as select numadh,montant,paye from cotisation
where anneecot= extract(year from current_date);








create table adherent(
	numadh numeric(4) primary key,
	nom varchar(10) UNIQUE,
	prenom varchar(10),
	fonction varchar(15) default 'autre'	
	constraint c_fonction check (fonction in 
		('president','vice-president','tresorier','secretaire','membre actif','autre')),
	adresse varchar(40),
	telephone varchar(10),
	skipper char(3) constraint c_skipper check (skipper in ('oui','non')),
	anneeadh numeric(4) default extract(year from now()));

create table cotisation (
	numadh numeric(4) references adherent(numadh),
	anneecot numeric(4),
	montant real,
	paye char(3) constraint c_paye check(paye in ('oui', 'non')),
	primary key (numadh,anneecot));

create table bateau(
	numbat smallint primary key,
	nombat varchar(20),
	taille numeric(4,2),
	typebat  varchar(10),
	nbplaces numeric(2) check (nbplaces>=5));

create table  agence(
	nomagence varchar(20) primary key,
	telephone varchar(10),
	fax varchar(10),
	adresse varchar(40));

create table proprietaire(
	numadh numeric(4) primary key references adherent(numadh),
	numbat smallint unique references bateau(numbat));
	
create table loueur(
	numbat smallint primary key references bateau(numbat),
	nomagence varchar(20) references agence(nomagence));

create table activite(
	numact numeric(4) primary key,
	typeact varchar(6) 
		constraint c_typeact check (typeact in ('rallye','sortie')),
	depart varchar(10) ,
	arrivee varchar(10) ,
	datedebut date,
	datefin date,
	constraint c_dates check (datedebut<=datefin));
	
create table chefdebord(
	numact numeric(4) references activite(numact),
	numadh numeric(4) references adherent(numadh),
	numbat smallint references bateau(numbat),
	unique (numbat, numact),
	primary key (numact, numadh));

create table equipage(
	numact numeric(4),
	numadh numeric(4) references adherent(numadh),
	numbat smallint not null,
	foreign key (numbat, numact) references chefdebord (numbat, numact),
	primary key (numact, numadh));

create table regate(
	numact numeric(4) references activite(numact),
	numregate smallint,
	forcevent smallint default null,
	primary key (numact,numregate));

create table resultat(
	numbat smallint,
	numact numeric(4),
	numregate smallint,
	classement smallint default null,
	points numeric(4) default null,
	foreign key (numact,numregate) references regate (numact, numregate),
	foreign key (numact,numbat) references chefdebord(numact, numbat),
	primary key (numbat, numact, numregate));
