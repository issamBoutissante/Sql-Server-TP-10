create database GestVol
use GestVol
create table pilote(
numPil int,
nomPil varchar(15) not null,
prenomPil varchar(15) not null,
adresse varchar(50),
salarie money not null,
prime money not null,
constraint pk_pilote primary key(numPil)
)
create table avoin(
numAv int,
nomAv varchar(10),
capacite int,
localisation varchar(25)
)