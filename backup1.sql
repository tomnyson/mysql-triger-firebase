-- MySQL dump 10.13  Distrib 8.0.12, for macos10.13 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `log_multi`
--

DROP TABLE IF EXISTS `log_multi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `log_multi` (
  `EXCHANGE` varchar(200) DEFAULT NULL,
  `SYMBOL` varchar(200) DEFAULT NULL,
  `TRADE` varchar(200) DEFAULT NULL,
  `PRICE` int(20) DEFAULT NULL,
  `DATE_TIME` datetime DEFAULT NULL,
  `ID` int(20) NOT NULL,
  `CONCATENATED_STRING` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_multi`
--

LOCK TABLES `log_multi` WRITE;
/*!40000 ALTER TABLE `log_multi` DISABLE KEYS */;
INSERT INTO `log_multi` VALUES ('NSE','DISHMAN','BUY',13000,'2018-09-30 15:33:18',1,'15:33 PM - NSE : BUY DISHMAN @ 13000'),('NSE','DISHMAN','SELL',13000,'2018-09-30 15:33:18',3,'15:33 PM - NSE : SELL DISHMAN @ 13000'),('NSE','DISHMAN','BUY',13000,'2018-09-30 15:33:18',5,'15:33 PM - NSE : BUY DISHMAN @ 13000'),('NSE','DISHMAN','SELL',13000,'2018-09-30 15:33:18',7,'15:33 PM - NSE : SELL DISHMAN @ 13000');
/*!40000 ALTER TABLE `log_multi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multi`
--

DROP TABLE IF EXISTS `multi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `multi` (
  `EXCHANGE` varchar(200) DEFAULT NULL,
  `SYMBOL` varchar(200) DEFAULT NULL,
  `TRADE` varchar(200) DEFAULT NULL,
  `PRICE` int(20) DEFAULT NULL,
  `DATE_TIME` datetime DEFAULT NULL,
  `ID` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multi`
--

LOCK TABLES `multi` WRITE;
/*!40000 ALTER TABLE `multi` DISABLE KEYS */;
INSERT INTO `multi` VALUES ('NSE','DISHMAN','SELL',13000,'2018-09-30 15:33:18',1),('BSE','DISHMAN','Buy',12000,'2018-09-30 09:32:18',2),('BSE','DISHTV','Buy',67,'2018-09-30 06:32:18',3),('BSE','DIVISLAB','Sell',1755,'2018-09-30 06:32:18',4),('BSE','DLF','Sell',137,'2018-09-30 06:32:18',5),('BSE','DOLPHINOFF','Sell',178,'2018-09-30 06:32:18',6),('BSE','DPSCLTD','Buy',18,'2018-09-30 06:32:18',7),('BSE','DQE','Sell',29,'2018-09-30 06:32:18',8);
/*!40000 ALTER TABLE `multi` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_multi` AFTER UPDATE ON `multi` FOR EACH ROW BEGIN
     declare msg varchar(255);
       declare numId int DEFAULT 1;
        set msg = concat(cast(DATE_FORMAT(NEW.DATE_TIME, "%H:%i %p") as char)," - ",NEW.EXCHANGE, " : ", NEW.TRADE," ", NEW.SYMBOL," @ ", cast(NEW.PRICE as char));
         IF (NEW.TRADE != OLD.TRADE)  THEN  
           SET numId = (SELECT count(*) FROM log_multi);
                  IF(numId > 0) THEN
    SET numId = (SELECT MAX(ID) + 2 FROM log_multi) ;
ELSE
    SET numId = 1;
END IF;
            INSERT INTO log_multi(
        EXCHANGE,
        SYMBOL,
        TRADE,
        PRICE,
        DATE_TIME,
                ID,
        CONCATENATED_STRING
    )
VALUES(
    NEW.EXCHANGE,
    NEW.SYMBOL,
    NEW.TRADE,
    NEW.PRICE,
    NEW.DATE_TIME,
    numId,
   msg
);
        END IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'mydb'
--

--
-- Dumping routines for database 'mydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-13  9:55:56
