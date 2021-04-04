create database GestVol
use GestVol
drop database GestVol
use master
create table Pilote(
numPil int,
nomPil varchar(15) not null,
prenomPil varchar(15) not null,
adresse varchar(50),
salarie money not null,
prime money not null,
constraint pk_pilote primary key(numPil)
)
create table Avoin (
numAv int,
nomAv varchar(10) not null,
capacite int not null,
localisation varchar(25) not null,
constraint pk_avion primary key(numAv)
)
create table vol(
numVol int,
numPil int not null,
numAv int not null,
date_Vol datetime not null,
heure_dep decimal(5,2) not null,
heure_arr decimal(5,2) not null,
ville_dep varchar(25) not null,
ville_arr varchar(25) not null,
constraint pk_vol primary key(numVol),
constraint fk_vol_avion foreign key(numAv) references [dbo].[Avoin](numAv),
constraint fk_vol_pilote foreign key(numPil) references Pilote(numPil)
)
-- 1-	Autorise Kamal à lancer des ordres  SELECT sur la table Pilote.
-- ajouter un login pour Kamal
exec sp_addlogin 'kamal','kamal'
exec sp_defaultdb 'kamal', 'GestVol'
--donne un utilisateur pour kamal 
exec sp_adduser 'kamal' , 'kamalUser'
--donne la permission de selectionner les donner de la table pilote
grant select on pilote to kamalUser

-- 2-	Autorise Samir et Kamal à modifier les données de la table Pilote par tous les ordres SQL de mise à jour
--   (INSERT, UPDATE, DELETE) mais pas à les lire !
-- ajouter un login pour Samir
exec sp_addlogin 'samir','samir'
exec sp_defaultdb 'samir', 'GestVol'
--donne un utilisateur pour samir 
exec sp_adduser 'samir' , 'samirUser'
-- donner l'authorisation 
grant insert,update,delete on pilote to kamalUser,samirUser

-- 3-	Autorise Youssef à lancer des ordres  SELECT sur la table Avion mais aussi à transmettre à tout 
-- autre utilisateur les droits qu'il a acquis dans cet ordre.
-- ajouter un login pour youssef
exec sp_addlogin 'youssef','youssef'
exec sp_defaultdb 'youssef', 'GestVol'
--donne un utilisateur pour youssef 
exec sp_adduser 'youssef' , 'youssefUser'
-- donner l'autorisation
grant select on [dbo].[Avoin] to youssefUser with grant option

-- 4-	Autorise tous les utilisateurs présents et à venir à lancer des ordres  SELECT et UPDATE sur la table Avion.
grant select,update on [dbo].[Avoin] to public

-- 5-	Autoriser à Ali de modifier uniquement les colonnes "Localisation" et "Capacité" de la table Avion.
-- ajouter un login pour ali
exec sp_addlogin 'ali','ali'
exec sp_defaultdb 'ali', 'GestVol'
--donne un utilisateur pour ali 
exec sp_adduser 'ali' , 'aliUser'
-- donner l'authorisation 
grant update(localisation,capacite) on [dbo].[Avoin] to aliUser

-- 6-	Supprimer le privilège de sélection de la table Pilote attribué à Kamal
revoke select on pilote to kamalUser

-- 7-	Supprimer les privilèges d’insertion et de suppression de la table Pilote 
-- attribué à Samir et Kamal, mais pas celui de mise à jour (UPDATE)
revoke delete,insert on pilote to samirUser,kamalUser

-- 8-	Supprimer la possibilité pour Youssef de transmettre le privilège de sélection sur la table Pilote.
revoke grant option for select on pilote to youssefUser