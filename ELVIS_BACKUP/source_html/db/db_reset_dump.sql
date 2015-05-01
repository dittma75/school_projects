USE `dittma75`;
-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: dittma75
-- ------------------------------------------------------
-- Server version	5.6.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `authorID` int(11) NOT NULL AUTO_INCREMENT,
  `author_fname` varchar(45) NOT NULL,
  `author_lname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`authorID`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (100,'Charlotte','Bronte','Charlotte.Bronte@xyz.com'),(101,'J.K','Rowling','J.K.Rowling@xyz.com'),(102,'Stephen','King','Stephen.King@xyz.com'),(103,'Ina','Garten','Ina.Garten@xyz.com'),(104,'Tom','Clancy','Tom.Clancy@xyz.com'),(105,'Mark','Twain','Mark.Twain@xyz.com'),(106,'Charles','Dickens','Charles.Dickens@xyz.com'),(107,'William','Shakespeare','William.Shakespeare@xyz.com'),(108,'James','Baldwin','James.Baldwin@xyz.com'),(109,'T.S','Elliot','T.S.Elliot@xyz.com'),(110,'Laura','Hillenbrand','Laura.Hillenbrand@xyz.com'),(111,'Steve','Berry','Steve.Berry@xyz.com'),(112,'Peter','Brett','Peter.Brett@xyz.com'),(113,'Martin','Dugard','Martin.Dugard@xyz.com'),(114,'Bill','ORiley','Bill.ORiley@xyz.com'),(115,'Brian','Kilmeade','Brian.Kilmeade@xyz.com'),(116,'Don','Yaeger','Don.Yaeger@xyz.com'),(117,'Ree','Drummond','Ree.Drummond@xyz.com'),(118,'John','Ray','John.Ray@xyz.com'),(119,'John','Green','John.Green@xyz.com'),(120,'Gary','Chapman','Gary.Chapman@xyz.com'),(121,'Patricia','McCormick','Patricia.McCormick@xyz.com'),(122,'Kathryn','Stockett','Kathryn.Stockett@xyz.com'),(123,'Susan','Benjamin','Susan.Benjamin@xyz.com'),(124,'Joanna','Dreby','Joanna.Dreby@xyz.com');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `best_sellers`
--

DROP TABLE IF EXISTS `best_sellers`;
/*!50001 DROP VIEW IF EXISTS `best_sellers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `best_sellers` AS SELECT 
 1 AS `ISBN`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `ISBN` char(13) NOT NULL,
  `title` varchar(45) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `publisher_ID` int(11) NOT NULL,
  `date_published` date NOT NULL,
  PRIMARY KEY (`ISBN`),
  KEY `publisher_ID` (`publisher_ID`),
  CONSTRAINT `publisher_ID` FOREIGN KEY (`publisher_ID`) REFERENCES `publisher` (`publisher_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('9021347257444','Shall We Tell the President?',36.40,50,7,'1946-06-02'),('9044515704729','Into the Wild',47.60,8,8,'1990-03-10'),('9085864929874','Death on the Nile',4.50,6,6,'1936-11-01'),('9147240725544','King John',33.30,25,3,'1990-07-21'),('9162661479765','Memory Man',45.20,9,6,'2003-05-23'),('9166397962071','Solitude Creek',38.20,18,4,'2010-07-09'),('9185093299212','Ulysses',7.00,8,8,'1958-02-25'),('9208898835171','Nothing Lasts Forever',35.50,29,2,'1985-04-15'),('9223796950134','Pericles',47.60,7,7,'1963-07-17'),('9238871539340','Backfire',38.60,16,2,'1991-07-24'),('9260751734932','Mornings on Horseback',4.50,11,4,'1961-04-25'),('9261003075663','Cleopatra: A Life ',47.60,37,2,'1993-12-07'),('9270568133017','Insomnia',27.90,44,6,'1953-11-24'),('9284877555107','The Girl on the Train',27.00,54,10,'1996-12-25'),('9311839942262','Cat Among the Pigeons',22.70,12,2,'1991-04-13'),('9349669287042','If Tomorrow Comes',32.00,50,3,'1947-08-22'),('9362978271314','Three Act Tragedy',47.20,30,3,'1974-05-27'),('9372526184495','Rajinikanth: The Hero',14.00,10,3,'1986-11-09'),('9407655827345','Rage of Angels',4.50,5,5,'1998-09-09'),('9452425951010','As You Like It',6.30,40,6,'1963-04-23'),('9458869679573','Ages Of Man',6.60,10,2,'1992-06-16'),('9476341903038','Parting the Waters',47.60,4,2,'1982-03-25'),('9566508823158','Tell Me Your Dreams',28.00,29,10,'1957-01-10'),('9583020150600','To The Mafia With Love',43.30,3,1,'1954-09-30'),('9604723036705','Julius Caesar',34.80,16,9,'1972-05-14'),('9661783446324','The Taming of the Shrew',47.00,40,6,'2011-12-14'),('9673635029547','Affairs Of State',25.70,15,6,'1956-11-19'),('9677171884010','Garden of Lies',36.00,14,7,'1982-10-08'),('9684233791334','Catch22',37.10,13,6,'1999-11-13'),('9694409545011','Einstein: His Life and Universe',12.30,3,7,'1990-03-24'),('9694423469346','The Merchant of Venice',18.70,11,5,'1964-10-17'),('9702165597554','The Big Four',28.30,33,10,'1986-01-30'),('9719858962028','The Grapes of Wrath',25.60,35,9,'1999-08-10'),('9734162727340','The Very Hungry Caterpillar',42.40,7,5,'1979-04-24'),('9745836073931','The Clocks',43.90,7,7,'1999-12-26'),('9764757310788','The Great Gatsby',20.80,45,1,'2004-09-27'),('9774528542643','One Two Buckle My Shoe',21.80,6,5,'1950-10-18'),('9804578885525','Revival',36.70,775,10,'2009-09-18'),('9820516336637','All the Light We Cannot See',45.70,63,7,'1955-01-19'),('9843468714365','Goodnight Moon',7.40,51,1,'1997-05-23'),('9846843928944','The Secret of the Tower',35.60,70,7,'1967-06-12'),('9861881295838','Curtain',20.50,5,6,'1946-08-31'),('9886164179740','Cards on the Table',5.00,20,2,'1936-11-02'),('9926378019982','A Stranger in the Mirror',46.30,5,7,'2006-12-26'),('9940203488478','Lisey Story',43.80,40,3,'1996-04-06'),('9956888108985','Kane and Abel',35.90,24,7,'1984-01-26'),('9963872990443','Destination Unknown',29.80,28,5,'1998-02-17'),('9977624138210','Desperation',11.60,10,2,'1946-06-18'),('9993553536395','green mile',26.90,9,3,'1999-10-01'),('9994648981234','Gathering Prey',31.10,21,9,'1949-06-25');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `book_order_quantities`
--

DROP TABLE IF EXISTS `book_order_quantities`;
/*!50001 DROP VIEW IF EXISTS `book_order_quantities`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `book_order_quantities` AS SELECT 
 1 AS `ISBN`,
 1 AS `total_quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `book_orders_last_month`
--

DROP TABLE IF EXISTS `book_orders_last_month`;
/*!50001 DROP VIEW IF EXISTS `book_orders_last_month`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `book_orders_last_month` AS SELECT 
 1 AS `ISBN`,
 1 AS `total_quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `busy_authors`
--

DROP TABLE IF EXISTS `busy_authors`;
/*!50001 DROP VIEW IF EXISTS `busy_authors`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `busy_authors` AS SELECT 
 1 AS `authorID`,
 1 AS `num_written`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contains`
--

DROP TABLE IF EXISTS `contains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contains` (
  `orderID` int(11) NOT NULL,
  `ISBN` char(13) NOT NULL,
  `quantity` int(11) unsigned NOT NULL,
  PRIMARY KEY (`orderID`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `ISBN` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderID` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contains`
--

LOCK TABLES `contains` WRITE;
/*!40000 ALTER TABLE `contains` DISABLE KEYS */;
INSERT INTO `contains` VALUES (1,'9044515704729',2),(1,'9085864929874',2),(1,'9362978271314',1),(2,'9223796950134',1),(2,'9774528542643',3),(2,'9886164179740',1),(3,'9044515704729',2),(3,'9166397962071',2),(3,'9260751734932',1),(3,'9270568133017',4),(3,'9311839942262',1),(3,'9372526184495',1),(3,'9566508823158',1),(3,'9702165597554',3),(4,'9963872990443',6),(4,'9977624138210',1),(5,'9604723036705',4),(5,'9745836073931',6),(5,'9846843928944',2),(6,'9702165597554',1),(6,'9993553536395',3),(7,'9021347257444',2),(7,'9208898835171',1),(7,'9926378019982',2),(8,'9956888108985',5),(9,'9044515704729',3),(9,'9804578885525',8),(9,'9861881295838',1),(10,'9940203488478',6),(11,'9764757310788',7),(12,'9044515704729',2),(12,'9694423469346',7),(12,'9719858962028',1),(13,'9185093299212',5),(13,'9661783446324',4),(14,'9820516336637',9),(15,'9677171884010',8),(16,'9349669287042',2),(17,'9044515704729',9),(17,'9261003075663',2),(18,'9583020150600',3),(19,'9476341903038',2),(19,'9994648981234',5),(20,'9284877555107',5),(21,'9452425951010',3),(22,'9694409545011',4),(23,'9044515704729',1),(23,'9162661479765',3),(23,'9843468714365',3),(24,'9458869679573',9),(24,'9684233791334',3),(25,'9147240725544',5),(25,'9238871539340',4),(25,'9734162727340',2),(26,'9085864929874',6),(27,'9886164179740',6),(28,'9362978271314',12),(28,'9774528542643',3),(29,'9311839942262',7),(29,'9963872990443',9),(30,'9021347257444',9),(30,'9702165597554',5),(30,'9745836073931',8),(31,'9956888108985',3),(31,'9977624138210',5),(32,'9804578885525',1),(32,'9993553536395',6),(33,'9940203488478',3),(34,'9270568133017',4),(35,'9764757310788',11),(36,'9185093299212',8),(36,'9684233791334',10),(36,'9719858962028',12),(37,'9162661479765',11),(37,'9284877555107',2),(37,'9820516336637',12),(38,'9166397962071',5),(38,'9846843928944',7),(38,'9994648981234',6),(39,'9238871539340',4),(39,'9673635029547',2),(39,'9677171884010',3),(40,'9349669287042',7),(40,'9407655827345',8),(40,'9583020150600',5),(40,'9861881295838',6),(41,'9208898835171',9),(42,'9926378019982',12),(43,'9566508823158',2),(44,'9843468714365',4),(45,'9734162727340',8),(46,'9044515704729',1),(46,'9261003075663',11),(46,'9694409545011',9),(47,'9260751734932',10),(47,'9372526184495',9),(47,'9476341903038',6),(48,'9452425951010',5),(48,'9604723036705',4),(48,'9661783446324',7),(48,'9694423469346',13),(49,'9458869679573',4),(50,'9147240725544',4),(50,'9223796950134',6),(51,'9362978271314',3),(51,'9804578885525',1),(52,'9260751734932',2),(52,'9764757310788',7),(52,'9977624138210',1),(53,'9166397962071',4),(54,'9162661479765',1),(54,'9223796950134',1),(54,'9238871539340',2),(54,'9407655827345',1),(54,'9694409545011',1),(54,'9745836073931',1),(55,'9147240725544',25),(56,'9021347257444',5),(56,'9185093299212',4),(56,'9284877555107',7),(56,'9362978271314',6),(57,'9362978271314',1),(58,'9994648981234',5),(59,'9843468714365',1),(60,'9162661479765',1),(60,'9349669287042',8),(60,'9684233791334',9),(61,'9208898835171',1),(61,'9926378019982',25),(62,'9604723036705',3),(63,'9673635029547',1),(64,'9734162727340',19),(65,'9021347257444',1),(65,'9044515704729',1),(65,'9085864929874',1),(65,'9147240725544',1),(65,'9162661479765',1),(65,'9166397962071',1),(65,'9185093299212',1),(65,'9208898835171',1),(65,'9223796950134',1),(65,'9238871539340',1),(65,'9260751734932',1),(65,'9261003075663',1),(65,'9270568133017',1),(65,'9284877555107',1),(65,'9311839942262',1),(65,'9349669287042',1),(65,'9362978271314',1),(65,'9372526184495',1),(65,'9407655827345',1),(65,'9452425951010',1),(65,'9458869679573',1),(65,'9476341903038',1),(65,'9566508823158',1),(65,'9583020150600',1),(65,'9604723036705',1),(65,'9661783446324',1),(65,'9673635029547',1),(65,'9677171884010',1),(65,'9684233791334',1),(65,'9694409545011',1),(65,'9694423469346',1),(65,'9702165597554',1),(65,'9719858962028',1),(65,'9734162727340',1),(65,'9745836073931',1),(65,'9764757310788',1),(65,'9774528542643',1),(65,'9804578885525',1),(65,'9820516336637',1),(65,'9843468714365',1),(65,'9846843928944',1),(65,'9861881295838',1),(65,'9886164179740',1),(65,'9926378019982',1),(65,'9940203488478',1),(65,'9956888108985',1),(65,'9963872990443',1),(65,'9977624138210',1),(65,'9993553536395',1),(65,'9994648981234',1),(66,'9719858962028',9),(66,'9994648981234',10),(67,'9185093299212',7),(68,'9284877555107',1),(69,'9284877555107',21),(70,'9284877555107',4),(71,'9284877555107',6),(72,'9284877555107',1),(72,'9820516336637',21),(73,'9820516336637',3),(74,'9673635029547',4),(75,'9021347257444',1),(75,'9185093299212',3),(75,'9270568133017',2),(75,'9684233791334',2),(75,'9719858962028',2),(75,'9764757310788',1),(75,'9804578885525',2),(75,'9940203488478',3),(75,'9956888108985',3),(75,'9977624138210',2),(75,'9993553536395',1),(76,'9085864929874',1),(76,'9185093299212',12),(76,'9661783446324',2),(76,'9994648981234',2),(77,'9661783446324',1),(77,'9734162727340',1),(77,'9926378019982',4),(78,'9702165597554',4),(78,'9734162727340',82),(79,'9702165597554',8),(79,'9734162727340',14),(79,'9861881295838',1),(80,'9702165597554',1),(80,'9734162727340',90),(80,'9846843928944',7),(81,'9734162727340',4),(82,'9185093299212',2),(82,'9362978271314',3),(82,'9684233791334',3),(82,'9734162727340',18),(83,'9270568133017',1),(84,'9861881295838',7),(84,'9940203488478',6),(85,'9702165597554',2),(85,'9734162727340',19),(86,'9362978271314',4),(86,'9583020150600',6),(87,'9846843928944',4),(87,'9886164179740',2),(88,'9977624138210',5),(89,'9270568133017',14),(89,'9734162727340',13),(90,'9702165597554',12),(91,'9993553536395',3),(92,'9270568133017',2),(93,'9270568133017',7),(93,'9764757310788',1),(94,'9270568133017',1),(94,'9284877555107',6),(94,'9702165597554',3),(95,'9804578885525',4),(96,'9270568133017',2),(97,'9162661479765',18),(97,'9684233791334',5),(98,'9238871539340',7),(99,'9270568133017',12),(99,'9284877555107',3),(99,'9583020150600',4),(99,'9764757310788',2),(100,'9994648981234',2),(101,'9583020150600',3),(101,'9764757310788',1);
/*!40000 ALTER TABLE `contains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL AUTO_INCREMENT,
  `Fname` varchar(45) NOT NULL,
  `Lname` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` char(2) NOT NULL,
  `zip` char(5) NOT NULL,
  `gender` char(1) NOT NULL,
  `pass` varchar(45) NOT NULL DEFAULT 'password',
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Allene','Iturbide','1 Central Ave','Portage','WI','54481','F','AlleneIturbide'),(2,'Marino','Lueckenbach','1 Century Park E','San Diego','CA','92110','M','MarinoLueckenbach'),(3,'Twana','Felger','1 Commerce Way','Washington','OR','97224','F','TwanaFelger'),(4,'Salena','Karpel','1 Garfield Ave #7','Stark','OH','44707','F','SalenaKarpel'),(5,'Arminda','Parvis','1 Huntwood Ave','Maricopa','AZ','85017','F','ArmindaParvis'),(6,'Nicolette','Brossart','1 Midway Rd','Worcester','MA','15281','F','NicoletteBrossart'),(7,'Arafat','Qureshi','1 N Harlem Ave #9','Essex','NJ','70503','M','ArafatQureshi'),(8,'Jacque','Rowling','1 N San Saba','Erie','PA','16501','M','JacqueRowling'),(9,'Hermin','Thyberg','1 Rancho Del Mar Shopping C','Providence','RI','29103','M','HerminThyberg'),(10,'Johann','Leinenbach','1 Washington St','Palm Beach','FL','33461','M','JohannLeinenbach'),(11,'Roxane','Campain','1048 Main St','Fairbanks North Star','AK','99708','F','RoxaneCampain'),(12,'Clorinda','Heimann','105 Richmond Valley Rd','San Diego','CA','92025','F','ClorindaHeimann'),(13,'Regis','Kannady','10759 Main St','Maricopa','AZ','85260','M','RegisKannady'),(14,'John','Abdallah','1088 Pinehurst St','Orange','NC','27514','M','JohnAbdallah'),(15,'Arlette','Honeywell','11279 Loytan St','Duval','FL','32254','F','ArletteHoneywell'),(16,'Aliza','Baltimore','1128 Delaware St','Santa Clara','CA','95132','F','AlizaBaltimore'),(17,'Carissa','Batman','12270 Caton Center Dr','Lane','OR','97401','F','CarissaBatman'),(18,'Manny','Kohnert','134 Lewis Rd','Davidson','TN','37211','M','MannyKohnert'),(19,'Amber','Monarrez','14288 Foster Ave #4121','Montgomery','PA','19046','F','AmberMonarrez'),(20,'Dean','Juhas','14302 Pennsylvania Ave','Montgomery','PA','19006','M','DeanJuhas'),(21,'Jolene','Ostolaza','1610 14th St Nw','Newport News City','VA','23608','F','JoleneOstolaza'),(22,'Rozella','Ostrosky','17 Morena Blvd','Ventura','CA','93012','F','RozellaOstrosky'),(23,'Cyndy','Goldammer','170 Wyoming Ave','Dakota','MN','55337','F','CyndyGoldammer'),(24,'Angello','Cetta','185 Blackstone Bldge','Honolulu','HI','96817','M','AngelloCetta'),(25,'Paris','Wide','187 Market St','Fulton','GA','30342','F','ParisWide'),(26,'Jean','Claucherty','19 Amboy Ave','Miami-Dade','FL','33142','M','JeanClaucherty'),(27,'Merlin','Bayless','195 13n N','Santa Clara','CA','95054','M','MerlinBayless'),(28,'Diane','Devreese','1953 Telegraph Rd','Buchanan','MO','64504','F','DianeDevreese'),(29,'Fatima','Saylors','2 Lighthouse Ave','Hennepin','MN','55343','F','FatimaSaylors'),(30,'Kaitlyn','Ogg','2 S Biscayne Blvd','Baltimore City','MD','21230','F','KaitlynOgg'),(31,'Sunny','Kownacki','2 Se 3rd Ave','Dallas','TX','75149','M','SunnyKownacki'),(32,'Ray','Kampa','2 Sw Nyberg Rd','Elkhart','IN','46514','M','new_password'),(33,'Lili','Paskin','20113 4th Ave E','Hudson','NJ','71032','F','LiliPaskin'),(34,'Rebecka','Gesick','2026 N Plankinton Ave #3','Travis','TX','78754','F','RebeckaGesick'),(35,'Micael','Rhymes','20932 Hedley St','Contra Costa','CA','94520','M','MicaelRhymes'),(36,'Colette','Kardas','21575 S Apple Creek Rd','Douglas','NE','68124','F','ColetteKardas'),(37,'Refugia','Jacobos','2184 Worth St','Alameda','CA','94545','F','RefugiaJacobos'),(38,'Tresa','Sweely','22 Bridle Ln','Saint Louis','MO','63088','F','TresaSweely'),(39,'Jesusa','Shin','2239 Shawnee Mission Pky','Coffee','TN','37388','F','JesusaShin'),(40,'Layla','Springe','229 N Forty Driv','New York','NY','10011','F','LaylaSpringe'),(41,'Sheldon','Zane','2409 Alabama Rd','Riverside','CA','92501','M','SheldonZane'),(42,'Kiley','Caldarera','25 E 75th St #69','Los Angeles','CA','90034','F','KileyCaldarera'),(43,'Luis','Jurney','25 Se 176th Pl','Middlesex','MA','82138','M','LuisJurney'),(44,'Rasheed','Sayaphon','251 Park Ave #979','Santa Clara','CA','95070','M','RasheedSayaphon'),(45,'Renea','Monterrubio','26 Montgomery St','Fulton','GA','30328','F','ReneaMonterrubio'),(46,'Carmelo','Lindall','2664 Lewis Rd','Douglas','CO','80126','M','CarmeloLindall'),(47,'Linn','Paa','1 S Pine St','Shelby','TN','38112','M','LinnPaa'),(48,'Yuki','Whobrey','1 State Route 27','Wayne','MI','48180','M','YukiWhobrey'),(49,'Trinidad','Mcrae','10276 Brooks St','San Francisco','CA','94105','M','TrinidadMcrae'),(50,'Daniel','Perruzza','11360 S Halsted St','Orange','CA','92705','M','DanielPerruzza');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/  /*!50003 TRIGGER before_insert_customer
BEFORE INSERT ON customer 
FOR EACH ROW
SET NEW.pass = CONCAT(NEW.fname, NEW.lname) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `customer_books`
--

DROP TABLE IF EXISTS `customer_books`;
/*!50001 DROP VIEW IF EXISTS `customer_books`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customer_books` AS SELECT 
 1 AS `ISBN`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customer_genres`
--

DROP TABLE IF EXISTS `customer_genres`;
/*!50001 DROP VIEW IF EXISTS `customer_genres`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customer_genres` AS SELECT 
 1 AS `genrename`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customer_orders`
--

DROP TABLE IF EXISTS `customer_orders`;
/*!50001 DROP VIEW IF EXISTS `customer_orders`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customer_orders` AS SELECT 
 1 AS `orderID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customers_owning`
--

DROP TABLE IF EXISTS `customers_owning`;
/*!50001 DROP VIEW IF EXISTS `customers_owning`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `customers_owning` AS SELECT 
 1 AS `ISBN`,
 1 AS `owners`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `genrename` varchar(45) NOT NULL,
  PRIMARY KEY (`genrename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES ('Action and Adventure'),('Art'),('Autobiography'),('Biography'),('Comics'),('Diaries'),('Drama'),('Fantasy'),('History'),('Horror'),('Math'),('Mystery'),('Poetry'),('Romance'),('Satire'),('Science'),('Science fiction'),('Self help'),('Series'),('Youth');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in`
--

DROP TABLE IF EXISTS `in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `in` (
  `ISBN` char(13) NOT NULL,
  `genrename` varchar(45) NOT NULL,
  PRIMARY KEY (`ISBN`,`genrename`),
  KEY `in_ibfk_2_idx` (`genrename`),
  CONSTRAINT `in_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `in_ibfk_2` FOREIGN KEY (`genrename`) REFERENCES `genre` (`genrename`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in`
--

LOCK TABLES `in` WRITE;
/*!40000 ALTER TABLE `in` DISABLE KEYS */;
INSERT INTO `in` VALUES ('9166397962071','Action and Adventure'),('9238871539340','Action and Adventure'),('9260751734932','Action and Adventure'),('9284877555107','Action and Adventure'),('9846843928944','Action and Adventure'),('9886164179740','Action and Adventure'),('9734162727340','Art'),('9745836073931','Art'),('9820516336637','Art'),('9223796950134','Autobiography'),('9261003075663','Biography'),('9372526184495','Biography'),('9694409545011','Biography'),('9702165597554','Biography'),('9452425951010','Comics'),('9407655827345','Diaries'),('9476341903038','Diaries'),('9021347257444','Drama'),('9044515704729','Drama'),('9147240725544','Drama'),('9162661479765','Drama'),('9166397962071','Drama'),('9284877555107','Drama'),('9362978271314','Drama'),('9604723036705','Drama'),('9677171884010','Drama'),('9719858962028','Drama'),('9764757310788','Drama'),('9956888108985','Drama'),('9993553536395','Drama'),('9994648981234','Drama'),('9223796950134','Fantasy'),('9804578885525','Fantasy'),('9846843928944','Fantasy'),('9861881295838','Fantasy'),('9993553536395','Fantasy'),('9021347257444','History'),('9260751734932','History'),('9261003075663','History'),('9407655827345','History'),('9458869679573','History'),('9604723036705','History'),('9673635029547','History'),('9684233791334','History'),('9694423469346','History'),('9702165597554','History'),('9719858962028','History'),('9764757310788','History'),('9956888108985','History'),('9085864929874','Horror'),('9270568133017','Horror'),('9694423469346','Horror'),('9804578885525','Horror'),('9940203488478','Horror'),('9977624138210','Horror'),('9694409545011','Math'),('9085864929874','Mystery'),('9162661479765','Mystery'),('9166397962071','Mystery'),('9270568133017','Mystery'),('9284877555107','Mystery'),('9926378019982','Mystery'),('9963872990443','Mystery'),('9994648981234','Mystery'),('9311839942262','Poetry'),('9566508823158','Poetry'),('9820516336637','Poetry'),('9861881295838','Poetry'),('9349669287042','Romance'),('9362978271314','Romance'),('9583020150600','Romance'),('9661783446324','Romance'),('9886164179740','Romance'),('9940203488478','Romance'),('9238871539340','Satire'),('9311839942262','Satire'),('9349669287042','Satire'),('9452425951010','Satire'),('9661783446324','Satire'),('9684233791334','Satire'),('9694409545011','Science'),('9963872990443','Science fiction'),('9208898835171','Self help'),('9185093299212','Series'),('9677171884010','Series'),('9702165597554','Series'),('9208898835171','Youth'),('9734162727340','Youth'),('9774528542643','Youth'),('9843468714365','Youth'),('9846843928944','Youth');
/*!40000 ALTER TABLE `in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(45) NOT NULL,
  `card_number` char(16) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(45) NOT NULL,
  `customerID` int(11) NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `customerID` (`customerID`),
  CONSTRAINT `customerID` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'DISCOVER','8483825346586352','2015-04-15','pending',11),(2,'DISCOVER','6348315276325270','2015-01-08','shipped',1),(3,'AMEX','7857046261837603','2015-03-14','shipped',9),(4,'MC','4318138082184633','2015-04-15','pending',1),(5,'VISA','6707674154533541','2015-01-07','shipped',3),(6,'VISA','2066005258463654','2015-04-13','pending',3),(7,'DISCOVER','6358642045764331','2015-02-13','shipped',7),(8,'MC','1352270742563856','2015-04-13','pending',10),(9,'AMEX','3136736416650118','2015-04-15','pending',2),(10,'AMEX','5127421441012272','2015-02-05','shipped',3),(11,'VISA','0433445665834775','2015-04-13','pending',9),(12,'MC','6677220147160481','2015-02-03','shipped',11),(13,'VISA','8655882683744482','2015-04-15','pending',3),(14,'MC','0276073081423211','2015-03-14','shipped',2),(15,'DISCOVER','8583724183358844','2015-02-02','shipped',9),(16,'VISA','5720351320077880','2015-04-15','pending',11),(17,'AMEX','2156286312075414','2015-04-15','pending',3),(18,'MC','7684545162148265','2015-04-15','pending',6),(19,'VISA','2107155584328623','2015-04-12','pending',4),(20,'AMEX','4181024575584852','2015-04-13','pending',1),(21,'AMEX','3547834134833332','2015-03-04','shipped',4),(22,'VISA','6746747055130424','2015-03-04','shipped',11),(23,'AMEX','7822320747433230','2015-03-11','shipped',11),(24,'AMEX','2560227161572050','2015-04-13','pending',10),(25,'DISCOVER','1616007778685758','2015-04-12','pending',11),(26,'MC','5580382994824886','2013-12-07','shipped',13),(27,'VISA','7986257918886079','2014-05-25','shipped',19),(28,'DISCOVER','4297901853094167','2013-09-19','shipped',13),(29,'AMEX','9504869478482920','2014-12-27','shipped',24),(30,'MC','5777292595811645','2013-04-24','shipped',14),(31,'DISCOVER','5916843431282599','2015-01-08','shipped',16),(32,'VISA','2129417111103000','2013-09-14','shipped',16),(33,'DISCOVER','9058080833995639','2014-11-09','shipped',17),(34,'MC','4463607991677461','2014-09-05','shipped',18),(35,'AMEX','9198314089379185','2014-02-18','shipped',15),(36,'MC','0904755964083279','2014-01-21','shipped',25),(37,'VISA','9098242165037227','2013-08-11','shipped',21),(38,'AMEX','7101512077977467','2015-04-21','pending',14),(39,'VISA','7311368174615156','2013-05-05','shipped',22),(40,'AMEX','3716256833750010','2013-07-01','shipped',18),(41,'MC','3824539574157598','2015-03-06','shipped',22),(42,'MC','3179414075413885','2015-04-10','pending',23),(43,'MC','0535460212015790','2014-11-21','shipped',23),(44,'DISCOVER','0051807762491816','2015-03-25','shipped',15),(45,'DISCOVER','4155483388193634','2014-08-25','shipped',15),(46,'VISA','7764903202523503','2014-11-15','shipped',14),(47,'DISCOVER','2793829727514927','2015-03-25','pending',15),(48,'VISA','6816077787007076','2015-02-27','pending',19),(49,'AMEX','3492478309121689','2013-07-06','shipped',19),(50,'MC','6940170205460148','2013-05-16','shipped',19),(51,'MC','6940170205260148','2013-05-16','shipped',26),(52,'MC','6940170205860148','2013-05-16','shipped',27),(53,'DISCOVER','6940173205460148','2013-05-16','shipped',28),(54,'MC','6940172205460148','2013-05-16','shipped',29),(55,'VISA','6940170205460122','2015-02-16','shipped',30),(56,'MC','6940171205460122','2015-04-16','pending',31),(57,'MC','6940171205460118','2013-05-16','shipped',32),(58,'DISCOVER','6940170215460148','2012-11-16','shipped',33),(59,'VISA','6940190205460948','2015-04-19','pending',34),(60,'MC','6940172205460118','2013-12-16','shipped',35),(61,'AMEX','6940970205469148','2013-11-16','shipped',36),(62,'MC','6940179205460148','2014-05-16','shipped',37),(63,'MC','6940173205461118','2015-04-13','pending',34),(64,'AMEX','6340170205460148','2008-05-16','shipped',35),(65,'MC','6967170205460118','2015-02-26','pending',36),(66,'MC','6933170205460148','2012-12-15','shipped',37),(67,'DISCOVER','6000170215460148','2013-05-16','shipped',31),(68,'MC','6940170209469948','2013-04-15','shipped',33),(69,'MC','6940170295465548','2011-05-16','shipped',32),(70,'DISCOVER','6956170305460148','2012-05-16','shipped',33),(71,'MC','6940170211468848','2007-05-16','shipped',33),(72,'MC','6940170209463348','2012-05-16','shipped',32),(73,'DISCOVER','6955170305460148','2015-04-20','pending',33),(74,'MC','6940174409460248','2015-04-21','pending',31),(75,'DISCOVER','9940170205469948','2011-03-16','shipped',25),(76,'VISA','4916082678330849','2015-04-10','pending',38),(77,'AMEX','376489087979598','2014-01-20','shipped',38),(78,'MC','5175828678188691','2015-03-03','pending',38),(79,'VISA','4532725024728389','2014-05-03','shipped',39),(80,'AMEX','348566766902481','2014-05-05','shipped',40),(81,'AMEX','348829662412868','2014-06-06','shipped',40),(82,'DISCOVER','6011271134983445','2015-04-03','pending',50),(83,'AMEX','377595718714334','2014-09-05','shipped',49),(84,'VISA','4929831317822342','2014-09-10','shipped',49),(85,'VISA','4532230260650686','2014-09-17','shipped',49),(86,'VISA','4716973500170795','2014-10-01','shipped',48),(87,'VISA','4929067552539495','2015-04-05','pending',43),(88,'MC','5335031671548352','2015-03-24','pending',44),(89,'AMEX','349026363375481','2015-02-20','pending',46),(90,'AMEX','376189184679626','2014-12-21','shipped',46),(91,'MC','5538944171407975','2014-12-22','shipped',45),(92,'MC','5335031671548352','2015-01-31','pending',44),(93,'DISCOVER','6011271134983445','2015-01-04','shipped',50),(94,'MC','5335031671548352','2015-04-15','pending',44),(95,'DISCOVER','6011356208872903','2015-02-01','shipped',43),(96,'VISA','4556192904159071','2015-02-03','pending',44),(97,'VISA','4556946673894402','2015-02-20','pending',43),(98,'VISA','4024007131111022','2015-03-03','shipped',43),(99,'DISCOVER','6011310196182064','2015-03-15','shipped',42),(100,'MC','5520425659907371','2015-04-10','shipped',38),(101,'AMERICAN EXPRESS','1234567890123456','2015-04-28','shipped',42);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher` (
  `publisher_ID` int(11) NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(45) NOT NULL,
  `phone` char(10) NOT NULL,
  PRIMARY KEY (`publisher_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'Addison-Wesley','6178487500'),(2,'Troy Publications','8565551092'),(3,'Seal Press','2155559087'),(4,'Avocado Press','2125550123'),(5,'Hristescu Books','8562564805'),(6,'Random House','2127829000'),(7,'Penguin Books','2123662000'),(8,'Harper Collins','8002427737'),(9,'Simon & Schuster','2126987000'),(10,'Good Books','8565554567');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wrote`
--

DROP TABLE IF EXISTS `wrote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wrote` (
  `authorID` int(11) NOT NULL,
  `ISBN` char(13) NOT NULL,
  PRIMARY KEY (`authorID`,`ISBN`),
  KEY `ISBN_idx` (`ISBN`),
  CONSTRAINT `wrote_ibfk_1` FOREIGN KEY (`authorID`) REFERENCES `author` (`authorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wrote_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wrote`
--

LOCK TABLES `wrote` WRITE;
/*!40000 ALTER TABLE `wrote` DISABLE KEYS */;
INSERT INTO `wrote` VALUES (102,'9021347257444'),(105,'9021347257444'),(116,'9021347257444'),(117,'9021347257444'),(122,'9021347257444'),(103,'9044515704729'),(105,'9044515704729'),(107,'9085864929874'),(118,'9085864929874'),(110,'9147240725544'),(121,'9147240725544'),(109,'9162661479765'),(115,'9162661479765'),(105,'9166397962071'),(123,'9166397962071'),(111,'9185093299212'),(118,'9185093299212'),(102,'9208898835171'),(116,'9223796950134'),(122,'9223796950134'),(103,'9238871539340'),(109,'9238871539340'),(123,'9260751734932'),(102,'9261003075663'),(114,'9261003075663'),(102,'9270568133017'),(103,'9270568133017'),(113,'9284877555107'),(115,'9284877555107'),(122,'9284877555107'),(101,'9311839942262'),(105,'9311839942262'),(106,'9311839942262'),(108,'9311839942262'),(121,'9311839942262'),(123,'9311839942262'),(117,'9349669287042'),(106,'9362978271314'),(112,'9362978271314'),(100,'9372526184495'),(109,'9407655827345'),(112,'9407655827345'),(116,'9407655827345'),(111,'9452425951010'),(112,'9452425951010'),(116,'9458869679573'),(120,'9458869679573'),(103,'9476341903038'),(109,'9476341903038'),(116,'9476341903038'),(118,'9476341903038'),(101,'9566508823158'),(112,'9566508823158'),(124,'9583020150600'),(111,'9604723036705'),(112,'9661783446324'),(117,'9661783446324'),(102,'9673635029547'),(119,'9673635029547'),(121,'9673635029547'),(123,'9673635029547'),(122,'9677171884010'),(108,'9684233791334'),(116,'9684233791334'),(100,'9694409545011'),(102,'9694409545011'),(117,'9694409545011'),(107,'9694423469346'),(107,'9702165597554'),(114,'9702165597554'),(106,'9719858962028'),(117,'9719858962028'),(105,'9734162727340'),(103,'9745836073931'),(116,'9745836073931'),(117,'9745836073931'),(119,'9745836073931'),(101,'9764757310788'),(104,'9764757310788'),(105,'9764757310788'),(114,'9764757310788'),(109,'9774528542643'),(114,'9774528542643'),(102,'9804578885525'),(116,'9804578885525'),(100,'9820516336637'),(103,'9820516336637'),(106,'9820516336637'),(120,'9820516336637'),(121,'9820516336637'),(124,'9820516336637'),(110,'9843468714365'),(107,'9846843928944'),(110,'9846843928944'),(116,'9846843928944'),(119,'9846843928944'),(117,'9861881295838'),(119,'9886164179740'),(102,'9926378019982'),(104,'9926378019982'),(109,'9926378019982'),(113,'9926378019982'),(118,'9926378019982'),(119,'9926378019982'),(120,'9926378019982'),(102,'9940203488478'),(104,'9940203488478'),(107,'9940203488478'),(100,'9956888108985'),(122,'9956888108985'),(106,'9963872990443'),(104,'9977624138210'),(112,'9977624138210'),(102,'9993553536395'),(112,'9994648981234');
/*!40000 ALTER TABLE `wrote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'dittma75'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_ordered_books` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `add_ordered_books`(o_ID INT(11),
                                    i CHAR(13),
                                    qu INT(11))
BEGIN
INSERT INTO contains(orderID, ISBN, quantity)
VALUES(o_ID, i, qu);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `books_at_reorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `books_at_reorder`()
BEGIN
    SELECT ISBN, title, stock
    FROM book
    WHERE stock <= 10;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `change_password`(c_ID INT(11), p VARCHAR(45))
BEGIN
    UPDATE customer
    SET pass = p
    WHERE customerID = c_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `create_new_book`(newISBN CHAR(13),
                                 newTitle VARCHAR(50),
                                 newPrice DECIMAL(10,2),
                                 newStock INT(11),
                                 newPub INT(11),
                                 newPubDate DATE)
BEGIN
    INSERT INTO book(ISBN,
                     title,
                     price,
                     stock,
                     publisher_id,
                     date_published)
    VALUES(newISBN,
           newTitle,
           newPrice,
           newStock,
           newPub,
           newPubDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `create_new_customer`(newFName VARCHAR(25),
                                     newLname VARCHAR(30),
                                     newStreet VARCHAR(50),
                                     newCity VARCHAR(25),
                                     newState CHAR(2),
                                     newZip CHAR(5),
                                     newGender CHAR(1))
BEGIN
    INSERT INTO customer(Fname,
                         Lname,
                         street,
                         city, 
                         state,
                         zip,
                         gender)
    VALUES(newFname,
           newLname,
           newStreet,
           newCity,
           newState,
           newZip,
           newGender);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `create_new_order`(o_ID INT(11),
                                   pt VARCHAR(45), 
                                   cn CHAR(16),
                                   c_ID INT(11))
BEGIN
INSERT INTO orders(orderID, 
                   payment_type,
                   card_number,
                   date,
                   status,
                   customerID)
VALUES(o_ID, pt, cn, CURDATE(), "pending", c_ID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_publisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `create_new_publisher`(new_publisher_name VARCHAR(45),
                                      newPhone VARCHAR(30))
BEGIN
    INSERT INTO publisher(publisher_name,phone)
    VALUES(new_publisher_name, newPhone);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customer_suggestions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `customer_suggestions`()
BEGIN
    SELECT title 
    FROM book  
    WHERE ISBN IN (SELECT ISBN 
                   FROM `in` 
                   WHERE genrename IN (SELECT genrename
                                       FROM customer_genres))
    AND   ISBN IN (SELECT ISBN
                   FROM best_sellers)
    AND   ISBN NOT IN (SELECT ISBN
                       FROM customer_books);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `delete_book`(b_ISBN CHAR(13))
BEGIN
    DELETE
    FROM book 
    WHERE ISBN = b_ISBN;        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `delete_customer`(c_ID INT(11))
BEGIN
    DELETE
    FROM customer 
    WHERE customerID = c_ID;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_publisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `delete_publisher`(p_ID INT(11))
BEGIN
    DELETE
    FROM publisher 
    WHERE publisher_ID = p_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inactive_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `inactive_customers`(from_day DATE,
                                    time_period INT(11))
BEGIN
SELECT fname, lname
FROM customer
WHERE (customerID) IN (SELECT customerID
                       FROM (SELECT customerID, SUM(quantity*price) AS total_spent, AVG(price), SUM(quantity*price)/AVG(price)+SUM(quantity) AS activity_value
                             FROM ((orders JOIN contains USING(orderID)) JOIN book USING (ISBN))
                             WHERE date BETWEEN from_day - INTERVAL time_period DAY AND from_day
                             GROUP BY customerID
                             HAVING activity_value<5)AS table2);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_best_sellers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `list_best_sellers`()
BEGIN
    SELECT title
    FROM book
    WHERE ISBN IN (SELECT ISBN
                   FROM best_sellers);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `list_prolific_authors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `list_prolific_authors`()
BEGIN
    SELECT author_lname, author_fname
    FROM author
    WHERE authorID IN (SELECT authorID
                       FROM busy_authors)
    AND   authorID IN (SELECT authorID
                       FROM wrote
                       WHERE ISBN IN (SELECT ISBN
                                      FROM customers_owning
                                      WHERE owners >= (SELECT COUNT(*) FROM customer) *.15));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `not_selling_well` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `not_selling_well`()
BEGIN
    SELECT DISTINCT ISBN, title, SUM(quantity)
    FROM contains JOIN (SELECT ISBN, title FROM book) AS temp_book USING (ISBN)
    WHERE ISBN NOT IN (SELECT ISBN
                       FROM book
                       WHERE date_published BETWEEN CURDATE() -
                                            INTERVAL 180 DAY AND CURDATE())
    GROUP BY ISBN
    HAVING (SUM(quantity) * 2) < (SELECT AVG(total_quantity)
                                  FROM book_order_quantities);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `priced_too_high` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `priced_too_high`()
BEGIN
    SELECT ISBN, title, price
    FROM book
    WHERE price > (SELECT AVG(price) FROM book) AND
    date_published NOT BETWEEN CURDATE() - INTERVAL 180 DAY AND CURDATE() AND
    ISBN IN (SELECT ISBN
             FROM contains
             GROUP BY ISBN
             HAVING (SUM(quantity) * 2) < (SELECT AVG(total_quantity)
                                           FROM book_order_quantities));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reset_passwords` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `reset_passwords`()
BEGIN
    UPDATE customer
    SET pass = CONCAT(fname, lname);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `search_book`(search VARCHAR(50))
BEGIN
    Select ISBN,
           title,
           IF ((stock > 0),
               "in stock",
               "out of stock") AS available
    FROM book
    WHERE ISBN LIKE CONCAT("%", search, "%") OR
          title LIKE CONCAT("%", search, "%") OR
          ISBN IN (SELECT ISBN
                   FROM wrote
                   WHERE authorID IN (SELECT authorID
                                      FROM author
                                      WHERE author_fname LIKE CONCAT("%", search, "%") OR
                                            author_lname LIKE CONCAT("%", search, "%") OR
                                            search LIKE CONCAT("%", author_lname, "%") OR
                                            search LIKE CONCAT("%", author_fname, "%")));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ship_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `ship_order`(o_ID INT(11))
BEGIN
    DECLARE shippable CHAR(0);
    DECLARE has_shipped CHAR(0);
    DECLARE n INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE this_stock INT DEFAULT 0;
    DECLARE this_quant INT DEFAULT 0;
    DECLARE this_ISBN CHAR(13);
    
    SET autocommit=0;
    START TRANSACTION;
    
    DROP TEMPORARY TABLE IF EXISTS ship_table;
    CREATE TEMPORARY TABLE ship_table(
        orderID int,
        ISBN char(13),
        quantity int,
        stock int
    );
    INSERT INTO ship_table (orderID, ISBN, quantity, stock)
    SELECT orderID, ISBN, quantity, stock
    FROM orders JOIN (SELECT orderID, ISBN, quantity
                      FROM contains
                      WHERE orderID = o_ID) AS order_to_update USING (orderID)
                JOIN (SELECT ISBN, stock
                      FROM book) AS book_to_update USING (ISBN);
    
    SELECT COUNT(*)
    FROM ship_table
    INTO n;
    
    SET i=0;
    SET shippable = '';
    SET has_shipped =
        IF (((SELECT status FROM orders WHERE orderID = o_ID) = 'shipped'),
            '',
            NULL
        );
        
    WHILE i<n DO
      SELECT stock FROM ship_table LIMIT i,1 INTO this_stock;
      SELECT quantity FROM ship_table LIMIT i,1 INTO this_quant;
      SET shippable =
        IF(
            (has_shipped IS NOT NULL OR this_stock < this_quant),
            NULL,
            shippable
        );
      SET i = i + 1;
    END WHILE;

    UPDATE orders
    SET status =
        IF(
            (shippable IS NOT NULL),
            "shipped",
            status
        )
    WHERE orderID = o_ID;
    
    SET i=0;
    
    WHILE i<n DO
        SELECT ISBN FROM ship_table LIMIT i,1 INTO this_ISBN;
        SELECT quantity FROM ship_table LIMIT i,1 INTO this_quant;
        UPDATE book
        SET stock = 
            IF(
                (shippable IS NOT NULL),
                stock - this_quant,
                stock
            )
        WHERE ISBN = this_ISBN;
        SET i = i + 1;
    END WHILE;
    DROP TEMPORARY TABLE IF EXISTS ship_table;
    COMMIT;
    SET autocommit=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_order_by_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `track_order_by_customer`(c_ID INT(11))
BEGIN
    SELECT orderID, date, status
    FROM orders
    WHERE customerID = c_ID
    ORDER BY date DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `update_book`(b_ISBN CHAR(13),
                             newTitle VARCHAR(50),
                             newPrice DECIMAL(10,2),
                             newStock INT(11),
                             newPub INT(11),
                             newPubDate DATE)
BEGIN
    UPDATE book 
    SET title = newTitle,
        price = newPrice,
        stock = newStock,
        publisher_ID = newPub,
        date_published = newPubDate 
    WHERE ISBN = b_ISBN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `update_customer`(c_ID INT(11),
                                 newFName VARCHAR(25),
                                 newLname VARCHAR(30),
                                 newStreet VARCHAR(50),
                                 newCity VARCHAR(25),
                                 newState CHAR(2),
                                 newZip CHAR(5),
                                 newGender CHAR(1))
BEGIN
    UPDATE customer 
    SET Fname = newFname,
        Lname = newLname,
        street = newStreet,
        city = newCity,
        state = newState,
        zip = newZip,
        gender = newGender
    WHERE customerID = c_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_ordered_books` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `update_ordered_books`(o_ID INT(11),
                                       i CHAR(13),
                                       qu INT(11))
BEGIN
SET autocommit=0;
START TRANSACTION;

INSERT INTO contains(orderID, ISBN, quantity)
VALUES(o_ID, i, qu);

UPDATE orders JOIN (SELECT orderID, ISBN, quantity
                    FROM contains
                    WHERE orderID = o_ID) AS order_to_update USING (orderID)
              JOIN (SELECT ISBN, stock
                    FROM book
                    WHERE ISBN = i) AS book_to_update USING (ISBN)
SET status = IF(
    (stock >= quantity),
    "shipped",
    "pending"
)
WHERE orderID = o_ID;

UPDATE book
SET stock = IF(
    (stock >= qu),
    stock - qu,
    stock
)
WHERE ISBN = i;

COMMIT;
SET autocommit=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_publisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `update_publisher`(p_ID INT(11),
                                  newName VARCHAR(25),
                                  newPhone VARCHAR(30))
BEGIN
    UPDATE publisher 
    SET publisher_name = newName,
        phone = newPhone 
    WHERE publisher_ID = p_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `very_active_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `very_active_customers`(starting_day DATE,
                                       time_period INT(11))
BEGIN

SELECT fname, lname
FROM customer
WHERE (customerID) IN (SELECT customerID
                       FROM(SELECT customerID, SUM(quantity*price) AS total_spent, AVG(price), SUM(quantity*price)/AVG(price)+SUM(quantity) AS activity_value
                            FROM ((orders JOIN contains USING(orderID)) JOIN book USING (ISBN))
                            WHERE date BETWEEN starting_day - INTERVAL time_period DAY AND starting_day
                            GROUP BY customerID
                            HAVING activity_value>20)AS table2);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `view_book`(b_ISBN CHAR(13))
BEGIN
        SELECT *
        FROM book 
        WHERE ISBN = b_ISBN;        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_book_in_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `view_book_in_stock`(search VARCHAR(50))
BEGIN
    Select ISBN,
           title,
           IF ((stock > 0),
               "in stock",
               "out of stock") AS available
    FROM book
    WHERE ISBN LIKE CONCAT("%", search, "%") OR
          title LIKE CONCAT("%", search, "%") OR
          ISBN IN (SELECT ISBN
                   FROM wrote
                   WHERE authorID IN (SELECT authorID
                                      FROM author
                                      WHERE author_fname LIKE CONCAT("%", search, "%") OR
                                            author_lname LIKE CONCAT("%", search, "%") OR
                                            search LIKE CONCAT("%", author_lname, "%") OR
                                            search LIKE CONCAT("%", author_fname, "%")));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_book_in_stock_by_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `view_book_in_stock_by_title`(searchTitle VARCHAR(50))
BEGIN
    Select ISBN,
           title,
           IF ((stock > 0),
               "in stock",
               "out of stock") AS available
    FROM book
    WHERE CAST(title AS BINARY) LIKE CONCAT("%", searchTitle, "%");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `view_customer`(c_ID INT(11))
BEGIN
    SELECT *
    FROM customer 
    WHERE customerID = c_ID;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `view_inventory`()
BEGIN
        SELECT ISBN, title, stock
        FROM book;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_publisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `view_publisher`(p_ID INT(11))
BEGIN
    SELECT *
    FROM publisher 
    WHERE publisher_ID = p_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `best_sellers`
--

/*!50001 DROP VIEW IF EXISTS `best_sellers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `best_sellers` AS (select `book_orders_last_month`.`ISBN` AS `ISBN` from `book_orders_last_month` order by `book_orders_last_month`.`total_quantity` desc limit 10) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `book_order_quantities`
--

/*!50001 DROP VIEW IF EXISTS `book_order_quantities`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `book_order_quantities` AS (select `contains`.`ISBN` AS `ISBN`,sum(`contains`.`quantity`) AS `total_quantity` from `contains` group by `contains`.`ISBN`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `book_orders_last_month`
--

/*!50001 DROP VIEW IF EXISTS `book_orders_last_month`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `book_orders_last_month` AS (select `contains`.`ISBN` AS `ISBN`,sum(`contains`.`quantity`) AS `total_quantity` from (`contains` join `orders` on((`contains`.`orderID` = `orders`.`orderID`))) where (`orders`.`date` between (curdate() - interval 30 day) and curdate()) group by `contains`.`ISBN`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `busy_authors`
--

/*!50001 DROP VIEW IF EXISTS `busy_authors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `busy_authors` AS (select `wrote`.`authorID` AS `authorID`,count(distinct `wrote`.`ISBN`) AS `num_written` from `wrote` group by `wrote`.`authorID` having (`num_written` >= 5)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_books`
--

/*!50001 DROP VIEW IF EXISTS `customer_books`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `customer_books` AS (select `book`.`ISBN` AS `ISBN` from `book` where `book`.`ISBN` in (select `contains`.`ISBN` from `contains` where `contains`.`orderID` in (select `customer_orders`.`orderID` from `customer_orders`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_genres`
--

/*!50001 DROP VIEW IF EXISTS `customer_genres`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `customer_genres` AS (select distinct `in`.`genrename` AS `genrename` from `in` where `in`.`ISBN` in (select `customer_books`.`ISBN` from `customer_books`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_orders`
--

/*!50001 DROP VIEW IF EXISTS `customer_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `customer_orders` AS (select `orders`.`orderID` AS `orderID` from `orders` where (`orders`.`customerID` = 32)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customers_owning`
--

/*!50001 DROP VIEW IF EXISTS `customers_owning`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `customers_owning` AS (select `contains`.`ISBN` AS `ISBN`,count(distinct `orders`.`customerID`) AS `owners` from (`contains` join `orders` on((`contains`.`orderID` = `orders`.`orderID`))) group by `contains`.`ISBN`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-28 11:30:02
