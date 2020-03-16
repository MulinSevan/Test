-----------------------------------------------------------------------------------
-- B1 - Droits sur la base
-----------------------------------------------------------------------------------

-- modification de votre mot de passe

alter user Usera111 password 'p11';




-- suppression pour tous des droits de connexion à la base

revoke connect on database basea111 from public;

-- droits d'accès à la base pour tous les adhérents (rôle adherent)

grant connect on database basea111 to adherent;
-----------------------------------------------------------------------------------
-- B2 - Droits sur les objets de la base
-----------------------------------------------------------------------------------

-- 1 - Droits du rôle president

grant All on ADHERENT,BATEAU,cotisation,bateau,agence,proprietaire,loueur,activite,chefdebord,equipage,regate,resultat to president;
-----------------------------------------------------------------------------
-- 2 - Droits du rôle adherent

-- Premiers droits du rôle adherent

grant select on bateau,chefdebord,equipage,resultat,VActivitesFutures to adherent;
	
-- Droits sur la vue VMoi

grant select on adherent to adherent;
grant select,update on VMoi to adherent;

-- Droits sur la vue VMembres

grant select on VMembres to adherent;

-- Droits sur la vue VMesCotisations

grant select on VMesCotisations to adherent;

-----------------------------------------------------------------------------
-- 3 - Droits spécifiques au rôle skipper : droits sur la vue VMesRespFutures

grant select on VMesRespFutures to skipper;

-----------------------------------------------------------------------------
-- 5 - Droits spécifiques au rôle bureau 


grant select,update on activite,agence,bateau,chefdebord,
cotisation ,equipage, loueur, proprietaire, 
regate, resultat
to president,secretaire,tresorier;

-----------------------------------------------------------------------------
-- 6 - Droits spécifiques au rôle tresorier
grant select on VAppelCotisation to tresorier;

----------------------------------------------------------------------------
-- 7 - Droits spécifiques du rôle secretaire

grant update,insert on adherent to secretaire;
grant update,insert(depart,arrivee,datedebut,datefin),
delete on VActivitesFutures,activite to secretaire;

grant update,insert,delete on equipage,chefdebord to secretaire;

grant insert(numact,numregate),
        update(forcevent), delete on regate to secretaire;

grant insert(numbat,numact,numregate),
    update(classement,points), delete
    on resultat to secretaire;



----------------------------------------------------------------------------------------------------------------
-- 8 Droits manquants au rôle président...


grant all on ALL TABLES IN SCHEMA basea111 to president;
