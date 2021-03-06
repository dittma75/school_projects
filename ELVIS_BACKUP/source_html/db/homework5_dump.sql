-- MySQL dump 10.13  Distrib 5.5.38, for Linux (x86_64)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	5.5.38

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
-- Current Database: `dittma75`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dittma75` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dittma75`;

--
-- Temporary table structure for view `author_collection`
--

DROP TABLE IF EXISTS `author_collection`;
/*!50001 DROP VIEW IF EXISTS `author_collection`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `author_collection` (
  `SSN` tinyint NOT NULL,
  `author` tinyint NOT NULL,
  `value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `title` varchar(50) NOT NULL,
  `author` varchar(30) NOT NULL,
  `year` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('Back in the Day','Some Body',1959,17.99),('Back When I Was a Kid','Old Angry Guy',1958,18.99),('Casino Royale','Ian Fleming',1953,19.95),('Computing','Alan Turing',1965,19.99),('Crash','William Gates',1995,24.99),('Diamonds Are Forever','Ian Fleming',1956,32.99),('Dr. No','Ian Fleming',1958,9.99),('Failure','BeOS Development Team',1998,4.99),('Fifties','Historian',1957,18.99),('For Your Eyes Only','Ian Fleming',1960,14.95),('From Russia with Love','Ian Fleming',1957,14.99),('Goldfinger','Ian Fleming',1959,12.99),('Intuitive','Steve Jobs',1997,34.99),('Live and Let Die','Ian Fleming',1954,22.95),('Moonraker','Ian Fleming',1955,49.99),('My Little Pony','Unicornian',1964,9.99),('Octopussy and The Living Daylights','Ian Fleming',1966,9.99),('Old School','No Body',1959,16.99),('On Her Majesty\'s Secret Service','Ian Fleming',1963,49.99),('Pokemon','Pokemonian',2002,49.99),('The Best Book Ever Written','Genius',2013,0.99),('The Little Pet Shop','Geo Ianny',2004,29.99),('The Man with the Golden Gun','Ian Fleming',1965,24.99),('The Spy Who Loved Me','Ian Fleming',1962,39.99),('Thunderball','Ian Fleming',1961,27.99),('White Flour Bread is Evil','Orpah Whinfrey',2004,17.49),('Whoops I Got Married Again','Britney Spears',2004,18.49),('You Only Live Twice','Ian Fleming',1964,9.99);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `collection`
--

DROP TABLE IF EXISTS `collection`;
/*!50001 DROP VIEW IF EXISTS `collection`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `collection` (
  `SSN` tinyint NOT NULL,
  `value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `min_collection`
--

DROP TABLE IF EXISTS `min_collection`;
/*!50001 DROP VIEW IF EXISTS `min_collection`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `min_collection` (
  `value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `min_personal_collection`
--

DROP TABLE IF EXISTS `min_personal_collection`;
/*!50001 DROP VIEW IF EXISTS `min_personal_collection`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `min_personal_collection` (
  `SSN` tinyint NOT NULL,
  `value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `owns`
--

DROP TABLE IF EXISTS `owns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owns` (
  `SSN` char(9) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`SSN`,`title`),
  KEY `title` (`title`),
  CONSTRAINT `owns_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `person` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `owns_ibfk_2` FOREIGN KEY (`title`) REFERENCES `book` (`title`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owns`
--

LOCK TABLES `owns` WRITE;
/*!40000 ALTER TABLE `owns` DISABLE KEYS */;
INSERT INTO `owns` VALUES ('111348235','Back in the Day'),('111382811','Back in the Day'),('111382812','Back in the Day'),('111348235','Casino Royale'),('111382811','Computing'),('111382812','Computing'),('111382811','Crash'),('111382812','Crash'),('111348235','Diamonds Are Forever'),('111382811','Diamonds Are Forever'),('111382812','Diamonds Are Forever'),('111382834','Diamonds Are Forever'),('111348235','Dr. No'),('111382811','Dr. No'),('111382812','Dr. No'),('111382834','Dr. No'),('111382811','Failure'),('111382812','Failure'),('111382812','Fifties'),('111348235','For Your Eyes Only'),('111382811','For Your Eyes Only'),('111382812','For Your Eyes Only'),('111348235','From Russia with Love'),('111382811','From Russia with Love'),('111382812','From Russia with Love'),('111348235','Goldfinger'),('111382811','Goldfinger'),('111382812','Goldfinger'),('111382834','Goldfinger'),('111382811','Intuitive'),('111382812','Intuitive'),('111348235','Live and Let Die'),('111382811','Live and Let Die'),('111382812','Live and Let Die'),('111348235','Moonraker'),('111382811','Moonraker'),('111382812','Moonraker'),('111348236','My Little Pony'),('111382811','My Little Pony'),('111348235','Octopussy and The Living Daylights'),('111382811','Octopussy and The Living Daylights'),('111382812','Octopussy and The Living Daylights'),('111348235','Old School'),('111382811','Old School'),('111382812','Old School'),('111348235','On Her Majesty\'s Secret Service'),('111382811','On Her Majesty\'s Secret Service'),('111382812','On Her Majesty\'s Secret Service'),('111348236','Pokemon'),('111382812','Pokemon'),('111382811','The Little Pet Shop'),('111348235','The Man with the Golden Gun'),('111382811','The Man with the Golden Gun'),('111382812','The Man with the Golden Gun'),('111348235','The Spy Who Loved Me'),('111382811','The Spy Who Loved Me'),('111382812','The Spy Who Loved Me'),('111348235','Thunderball'),('111382811','Thunderball'),('111382812','Thunderball'),('111348236','White Flour Bread is Evil'),('111382811','White Flour Bread is Evil'),('111382812','White Flour Bread is Evil'),('111348238','Whoops I Got Married Again'),('111382811','Whoops I Got Married Again'),('111382812','Whoops I Got Married Again'),('111382835','Whoops I Got Married Again'),('111348235','You Only Live Twice'),('111348236','You Only Live Twice'),('111382811','You Only Live Twice'),('111382812','You Only Live Twice'),('111382834','You Only Live Twice');
/*!40000 ALTER TABLE `owns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `SSN` char(9) NOT NULL,
  `name` varchar(25) NOT NULL,
  `sex` varchar(6) NOT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('111293834','Diego','male'),('111348234','Granny','female'),('111348235','Manny','male'),('111348236','Ellie','female'),('111348238','Sid','male'),('111382811','Crash','male'),('111382812','Scrat','male'),('111382834','Scratte','female'),('111382835','Shira','female'),('111838273','Peaches','female'),('172489104','Precious','female'),('739125829','Granny','male'),('739398320','Eddie','male');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `test`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `test` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `test`;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `title` varchar(50) COLLATE latin1_bin NOT NULL,
  `author` varchar(30) COLLATE latin1_bin NOT NULL,
  `year` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('Back When I Was a Kid','Old Angry Guy',1958,18.99),('Back in the Day','Some Body',1959,17.99),('Casino Royale','Ian Fleming',1953,19.95),('Computing','Alan Turing',1965,19.99),('Crash','William Gates',1995,24.99),('Diamonds Are Forever','Ian Fleming',1956,32.99),('Dr. No','Ian Fleming',1958,9.99),('Failure','BeOS Development Team',1998,4.99),('Fifties','Historian',1957,18.99),('For Your Eyes Only','Ian Fleming',1960,14.95),('From Russia with Love','Ian Fleming',1957,14.99),('Goldfinger','Ian Fleming',1959,12.99),('Intuitive','Steve Jobs',1997,34.99),('Live and Let Die','Ian Fleming',1954,22.95),('Moonraker','Ian Fleming',1955,49.99),('My Little Pony','Unicornian',1964,9.99),('Octopussy and The Living Daylights','Ian Fleming',1966,9.99),('Old School','No Body',1959,16.99),('On Her Majesty\'s Secret Service','Ian Fleming',1963,49.99),('Pokemon','Pokemonian',2002,49.99),('The Best Book Ever Written','Genius',2013,0.99),('The Little Pet Shop','Geo Ianny',2004,29.99),('The Man with the Golden Gun','Ian Fleming',1965,24.99),('The Spy Who Loved Me','Ian Fleming',1962,39.99),('Thunderball','Ian Fleming',1961,27.99),('White Flour Bread is Evil','Orpah Whinfrey',2004,17.49),('Whoops I Got Married Again','Britney Spears',2004,18.49),('You Only Live Twice','Ian Fleming',1964,9.99);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owns`
--

DROP TABLE IF EXISTS `owns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owns` (
  `SSN` char(9) COLLATE latin1_bin NOT NULL DEFAULT '',
  `title` varchar(50) COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`SSN`,`title`),
  KEY `title` (`title`),
  CONSTRAINT `owns_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `person` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `owns_ibfk_2` FOREIGN KEY (`title`) REFERENCES `book` (`title`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owns`
--

LOCK TABLES `owns` WRITE;
/*!40000 ALTER TABLE `owns` DISABLE KEYS */;
INSERT INTO `owns` VALUES ('111348235','Back in the Day'),('111382811','Back in the Day'),('111382812','Back in the Day'),('111348235','Casino Royale'),('111382811','Computing'),('111382812','Computing'),('111382811','Crash'),('111382812','Crash'),('111348235','Diamonds Are Forever'),('111382811','Diamonds Are Forever'),('111382812','Diamonds Are Forever'),('111382834','Diamonds Are Forever'),('111348235','Dr. No'),('111382811','Dr. No'),('111382812','Dr. No'),('111382834','Dr. No'),('111382811','Failure'),('111382812','Failure'),('111382812','Fifties'),('111348235','For Your Eyes Only'),('111382811','For Your Eyes Only'),('111382812','For Your Eyes Only'),('111348235','From Russia with Love'),('111382811','From Russia with Love'),('111382812','From Russia with Love'),('111348235','Goldfinger'),('111382811','Goldfinger'),('111382812','Goldfinger'),('111382834','Goldfinger'),('111382811','Intuitive'),('111382812','Intuitive'),('111348235','Live and Let Die'),('111382811','Live and Let Die'),('111382812','Live and Let Die'),('111348235','Moonraker'),('111382811','Moonraker'),('111382812','Moonraker'),('111348236','My Little Pony'),('111382811','My Little Pony'),('111348235','Octopussy and The Living Daylights'),('111382811','Octopussy and The Living Daylights'),('111382812','Octopussy and The Living Daylights'),('111348235','Old School'),('111382811','Old School'),('111382812','Old School'),('111348235','On Her Majesty\'s Secret Service'),('111382811','On Her Majesty\'s Secret Service'),('111382812','On Her Majesty\'s Secret Service'),('111348236','Pokemon'),('111382812','Pokemon'),('111382811','The Little Pet Shop'),('111348235','The Man with the Golden Gun'),('111382811','The Man with the Golden Gun'),('111382812','The Man with the Golden Gun'),('111348235','The Spy Who Loved Me'),('111382811','The Spy Who Loved Me'),('111382812','The Spy Who Loved Me'),('111348235','Thunderball'),('111382811','Thunderball'),('111382812','Thunderball'),('111348236','White Flour Bread is Evil'),('111382811','White Flour Bread is Evil'),('111382812','White Flour Bread is Evil'),('111348238','Whoops I Got Married Again'),('111382811','Whoops I Got Married Again'),('111382812','Whoops I Got Married Again'),('111382835','Whoops I Got Married Again'),('111348235','You Only Live Twice'),('111348236','You Only Live Twice'),('111382811','You Only Live Twice'),('111382812','You Only Live Twice'),('111382834','You Only Live Twice');
/*!40000 ALTER TABLE `owns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `SSN` char(9) COLLATE latin1_bin NOT NULL,
  `name` varchar(25) COLLATE latin1_bin NOT NULL,
  `sex` varchar(6) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('111293834','Diego','male'),('111348234','Granny','female'),('111348235','Manny','male'),('111348236','Ellie','female'),('111348238','Sid','male'),('111382811','Crash','male'),('111382812','Scrat','male'),('111382834','Scratte','female'),('111382835','Shira','female'),('111838273','Peaches','female'),('172489104','Precious','female'),('739125829','Granny','male'),('739398320','Eddie','male');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `dittma75`
--

USE `dittma75`;

--
-- Final view structure for view `author_collection`
--

/*!50001 DROP TABLE IF EXISTS `author_collection`*/;
/*!50001 DROP VIEW IF EXISTS `author_collection`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dittma75`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `author_collection` AS select `owns`.`SSN` AS `SSN`,`book`.`author` AS `author`,sum(`book`.`price`) AS `value` from (`owns` join `book` on((`owns`.`title` = `book`.`title`))) group by `owns`.`SSN`,`book`.`author` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `collection`
--

/*!50001 DROP TABLE IF EXISTS `collection`*/;
/*!50001 DROP VIEW IF EXISTS `collection`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dittma75`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `collection` AS select `owns`.`SSN` AS `SSN`,sum(`book`.`price`) AS `value` from (`owns` join `book` on((`owns`.`title` = `book`.`title`))) group by `owns`.`SSN` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `min_collection`
--

/*!50001 DROP TABLE IF EXISTS `min_collection`*/;
/*!50001 DROP VIEW IF EXISTS `min_collection`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dittma75`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `min_collection` AS select min(`collection`.`value`) AS `value` from `collection` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `min_personal_collection`
--

/*!50001 DROP TABLE IF EXISTS `min_personal_collection`*/;
/*!50001 DROP VIEW IF EXISTS `min_personal_collection`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dittma75`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `min_personal_collection` AS select `collection`.`SSN` AS `SSN`,`collection`.`value` AS `value` from (`collection` join `min_collection`) where (`collection`.`value` = `min_collection`.`value`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `test`
--

USE `test`;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-17 16:29:29
