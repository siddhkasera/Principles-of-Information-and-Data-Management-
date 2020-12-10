create database if not exists `TrainSchedule`;
use `TrainSchedule`;

DROP TABLE IF EXISTS `admin`;
CREATE TABLE admin(
  `admin-user` varchar(30) NOT NULL,
  `admin-pass` varchar(30) NOT NULL,
primary key(`admin-user`));

DROP TABLE IF EXISTS `customer`;
create table customer ( 
  `customer-user` varchar(30) NOT NULL,
  `email` varchar(45) NOT NULL, 
  `first name` varchar(25) NOT NULL,
  `last name` varchar(25) NOT NULL, 
  `customer-pass` varchar(45) NOT NULL, 
  primary key(`customer-user`)
);

DROP TABLE IF EXISTS `customerrep`;
CREATE TABLE customerrep(
  `rep-user` varchar(30) NOT NULL,
  `rep-pass` varchar(30) NOT NULL,
primary key(`rep-user`));

DROP TABLE IF EXISTS `train`;
CREATE TABLE train(
  `trainId` varchar(5) NOT NULL,
  primary key(`trainId`)
);

DROP TABLE IF EXISTS `origin`;
CREATE TABLE origin(
  `uniqueId` varchar(20) NOT NULL,
  `state` varchar(12) NOT NULL,
  `name` varchar(21) NOT NULL,
  `city` varchar(15) NOT NULL,
  primary key(`uniqueId`)
);

DROP TABLE IF EXISTS `stop`;
CREATE TABLE stop(
  `uniqueId` varchar(20) NOT NULL,
  `state` varchar(12) NOT NULL,
  `name` varchar(21) NOT NULL,
  `city` varchar(15) NOT NULL,
  primary key(`uniqueId`)
);

DROP TABLE IF EXISTS `destination`;
CREATE TABLE destination(
  `uniqueId` varchar(20) NOT NULL,
  `state` varchar(12) NOT NULL,
  `name` varchar(21) NOT NULL,
  `city` varchar(15) NOT NULL,
  primary key(`uniqueId`)
);

DROP TABLE IF EXISTS `trainStartsAt`;
CREATE TABLE trainStartsAt(
  `trainId` int,
  `uniqueId` varchar(20) NOT NULL,
  `state` varchar(12) NOT NULL,
  `name` varchar(21) NOT NULL,
  `city` varchar(15) NOT NULL,
  primary key(`uniqueId`),
  foreign key(`trainId`) References TrainSchedule.train(`trainId`),
  foreign key(`uniqueId`) References TrainSchedule.origin(`uniqueId`)
);

DROP TABLE IF EXISTS `trainEndsAt`;
CREATE TABLE trainEndsAt(
  `trainId` int NOT NULL,
  `uniqueId` varchar(20) NOT NULL,
  `state` varchar(12) NOT NULL,
  `name` varchar(21) NOT NULL,
  `city` varchar(15) NOT NULL,
  primary key(`uniqueId`),
  foreign key(`trainId`) References TrainSchedule.train(`trainId`),
  foreign key(`uniqueId`) References TrainSchedule.destination(`uniqueId`)
);

DROP TABLE IF EXISTS `trainRunsOn`;
CREATE TABLE trainRunsOn(
  `trainId` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `fixed fare` float NOT NULL,
  `fare` float NOT NULL,
  `noStops` int NOT NULL,
  primary key(`name`),
  primary key(`trainId`),
  foreign key(`trainId`) References TrainSchedule.train(`trainId`)
);

DROP TABLE IF EXISTS `ScheduleStartsAt`;
create table ScheduleStartsAt ( 
  `trainID` int NOT NULL,
  `name` varchar(20) NOT NULL, 
  `travel time` int NOT NULL, 
  `start time` datetime NOT NULL, 
  `uniqueID` varchar(20) NOT NULL, 
  primary key(`trainID`, `name`), 
  foreign key(`trainID`, `name`) References TrainSchedule.trainRunsOn(`trainID`, `name`), 
  foreign key(`uniqueID`) References TrainSchedule.stop(`uniqueID`)
);

DROP TABLE IF EXISTS `ScheduleEndsAt`;
create table ScheduleEndsAt ( 
  `trainID` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `travel time` int NOT NULL,
  `end time` datetime NOT NULL,
  `uniqueID` varchar(20) NOT NULL,
  primary key(`trainID`, `name`),
  foreign key(`trainID`, `name`) References TrainSchedule.trainRunsOn(`trainID`, `name`), 
  foreign key(`uniqueID`) References TrainSchedule.stop(`uniqueID`)
);

DROP TABLE IF EXISTS `reservation`;
create table reservation ( 
  `reservation no.`int NOT NULL, 
  `date` date NOT NULL, 
  `passenger`varchar(50), 
  primary key(`reservation no.`)
);

DROP TABLE IF EXISTS `reserves`;
create table reserves ( 
  `username` varchar(30) NOT NULL, 
  `reservation no.` int NOT NULL, 
  primary key(`username`, `reservation no.`),
  foreign key(`reservation no.`) References TrainSchedule.reservation(`reservation no.`), 
  foreign key(`username`) References TrainSchedule.customer(`username`)
);

DROP TABLE IF EXISTS `madeFrom`;
create table madeFrom ( 
  `reservation no.` int NOT NULL, 
  `trainID` int NOT NULL, 
  `name` varchar(20) NOT NULL, 
  primary key(`trainID`, `name`),
  foreign key(`reservation no.`) References TrainSchedule.reservation(`reservation no.`), 
  foreign key(`name`) References TrainSchedule.trainRunsOn(`name`)
);

DROP TABLE IF EXISTS `employee`;
create table employee ( 
  `ssn` int NOT NULL, 
  `first name` varchar(15) NOT NULL, 
  `last name` varchar(15) NOT NULL, 
  `username` varchar(30) NOT NULL, 
  `password` varchar(35) NOT NULL, 
  primary key(`ssn`)
);

