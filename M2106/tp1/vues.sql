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



