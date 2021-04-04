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
constraint fk_vol_avion foreign key(numAv) references Avion(numAv),
constraint fk_vol_pilote foreign key(numPil) references Pilote(numPil)
)