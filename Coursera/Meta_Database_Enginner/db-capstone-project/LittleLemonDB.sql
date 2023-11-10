CREATE DATABASE  IF NOT EXISTS `littlelemondb` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `littlelemondb`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `BookingID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `StaffID` int NOT NULL,
  `Date` datetime NOT NULL,
  `TableNumber` int NOT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `customer_fk_idx` (`CustomerID`),
  KEY `staff_fk_idx` (`StaffID`),
  CONSTRAINT `customer_fk` FOREIGN KEY (`CustomerID`) REFERENCES `customerdetails` (`CustomerID`),
  CONSTRAINT `staff_fk` FOREIGN KEY (`StaffID`) REFERENCES `staffinformation` (`StaffID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,1,'2023-09-01 12:00:00',10),(2,2,2,'2023-09-01 12:30:00',12),(3,3,3,'2023-09-02 13:00:00',14),(4,4,4,'2023-09-02 14:00:00',16),(5,5,5,'2023-09-03 15:00:00',18),(6,6,6,'2023-09-03 16:00:00',20),(7,7,7,'2023-09-04 17:00:00',22),(8,8,8,'2023-09-04 18:00:00',24),(10,10,10,'2023-09-05 20:00:00',28),(11,1,1,'2022-10-10 00:00:00',5),(12,3,2,'2022-11-12 00:00:00',3),(13,2,3,'2022-10-11 00:00:00',2),(14,1,1,'2022-10-13 00:00:00',2),(15,1,1,'2022-10-11 00:00:00',5),(16,1,2,'2022-10-10 00:00:00',5);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerdetails`
--

DROP TABLE IF EXISTS `customerdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerdetails` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `ContactNumber` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerdetails`
--

LOCK TABLES `customerdetails` WRITE;
/*!40000 ALTER TABLE `customerdetails` DISABLE KEYS */;
INSERT INTO `customerdetails` VALUES (1,'John Doe','555-1234','customer1@email.com'),(2,'Jane Doe','555-2345','customer2@email.com'),(3,'Alice','555-3456','customer3@email.com'),(4,'Bob','555-4567','customer4@email.com'),(5,'Charlie','555-5678','customer5@email.com'),(6,'David','555-6789','customer6@email.com'),(7,'Emily','555-7890','customer7@email.com'),(8,'Frank','555-8901','customer8@email.com'),(9,'Grace','555-9012','customer9@email.com'),(10,'Hannah','555-0123','customer10@email.com');
/*!40000 ALTER TABLE `customerdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `MenuItemsID` int NOT NULL AUTO_INCREMENT,
  `CourseName` varchar(45) DEFAULT NULL,
  `StarterName` varchar(45) DEFAULT NULL,
  `DesertName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`MenuItemsID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitems`
--

LOCK TABLES `menuitems` WRITE;
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
INSERT INTO `menuitems` VALUES (1,'Grilled Chicken','Caesar Salad','Cheesecake'),(2,'Beef Steak','Tomato Soup','Chocolate Mousse'),(3,'Vegetarian Pizza','Garlic Bread','Fruit Salad'),(4,'Spaghetti Carbonara','Bruschetta','Tiramisu'),(5,'Fish and Chips','Coleslaw','Apple Pie'),(6,'Sushi Platter','Miso Soup','Green Tea Ice Cream'),(7,'BBQ Ribs','Cornbread','Peach Cobbler'),(8,'Chicken Curry','Samosas','Gulab Jamun'),(9,'Lobster Tail','Oysters','Key Lime Pie'),(10,'Vegan Burger','Sweet Potato Fries','Vegan Brownie');
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `MenuID` int NOT NULL AUTO_INCREMENT,
  `MenuItemsID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Type` varchar(45) NOT NULL,
  `Price` decimal(10,0) NOT NULL,
  `Cuisine` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`MenuID`),
  KEY `menu_items_menu_fk_idx` (`MenuItemsID`),
  CONSTRAINT `menus_items_menu_fk` FOREIGN KEY (`MenuItemsID`) REFERENCES `menuitems` (`MenuItemsID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,1,'Cheese Burger','Main',10,NULL),(2,2,'Veggie Burger','Main',9,NULL),(3,3,'French Fries','Side',3,NULL),(4,4,'Caesar Salad','Main',8,NULL),(5,5,'Chicken Wings','Appetizer',6,NULL),(6,6,'Coca Cola','Drink',2,NULL),(7,7,'Pasta','Main',11,NULL),(8,8,'Rice','Side',4,NULL),(9,9,'Margarita','Drink',5,NULL),(10,10,'Ice Cream','Dessert',4,NULL);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdeliverystatuses`
--

DROP TABLE IF EXISTS `orderdeliverystatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdeliverystatuses` (
  `DeliveryID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `Date` datetime NOT NULL,
  `Status` varchar(45) NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  KEY `order_fk_idx` (`OrderID`),
  CONSTRAINT `order_delivery_fk` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdeliverystatuses`
--

LOCK TABLES `orderdeliverystatuses` WRITE;
/*!40000 ALTER TABLE `orderdeliverystatuses` DISABLE KEYS */;
INSERT INTO `orderdeliverystatuses` VALUES (1,1,'2023-09-01 12:15:00','Delivered'),(2,2,'2023-09-01 12:45:00','Preparing'),(3,3,'2023-09-02 13:15:00','Preparing'),(4,4,'2023-09-02 14:15:00','Out for delivery'),(6,6,'2023-09-03 16:15:00','Delivered'),(7,7,'2023-09-04 17:15:00','Preparing'),(8,8,'2023-09-04 18:15:00','Delivered'),(9,9,'2023-09-05 19:15:00','Delivered'),(10,10,'2023-09-05 20:15:00','Delivered');
/*!40000 ALTER TABLE `orderdeliverystatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `MenuItemID` int NOT NULL,
  `StaffID` int NOT NULL,
  `Date` datetime NOT NULL,
  `Quantity` int NOT NULL,
  `TotalCost` decimal(10,0) NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `customer_fk_idx` (`CustomerID`),
  KEY `menu_fk_idx` (`MenuItemID`),
  KEY `staff_fk_idx` (`StaffID`),
  CONSTRAINT `customer_orders_fk` FOREIGN KEY (`CustomerID`) REFERENCES `customerdetails` (`CustomerID`),
  CONSTRAINT `menu_orders_fk` FOREIGN KEY (`MenuItemID`) REFERENCES `menus` (`MenuID`),
  CONSTRAINT `staff_orders_fk` FOREIGN KEY (`StaffID`) REFERENCES `staffinformation` (`StaffID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,1,'2023-09-01 12:00:00',2,171),(2,2,2,2,'2023-09-01 12:30:00',1,174),(3,3,3,3,'2023-09-02 13:00:00',3,358),(4,4,4,4,'2023-09-02 14:00:00',1,265),(6,6,6,6,'2023-09-03 16:00:00',2,465),(7,7,7,7,'2023-09-04 17:00:00',1,65),(8,8,8,8,'2023-09-04 18:00:00',2,437),(9,9,9,9,'2023-09-05 19:00:00',3,484),(10,10,10,10,'2023-09-05 20:00:00',1,111);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ordersview`
--

DROP TABLE IF EXISTS `ordersview`;
/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersview` AS SELECT 
 1 AS `OrderID`,
 1 AS `Quantity`,
 1 AS `Cost`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ordersview2`
--

DROP TABLE IF EXISTS `ordersview2`;
/*!50001 DROP VIEW IF EXISTS `ordersview2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersview2` AS SELECT 
 1 AS `CustomerID`,
 1 AS `FullName`,
 1 AS `OrderID`,
 1 AS `Cost`,
 1 AS `MenuName`,
 1 AS `CourseName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ordersview3`
--

DROP TABLE IF EXISTS `ordersview3`;
/*!50001 DROP VIEW IF EXISTS `ordersview3`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersview3` AS SELECT 
 1 AS `MenuName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `staffinformation`
--

DROP TABLE IF EXISTS `staffinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffinformation` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `Salary` decimal(10,0) NOT NULL,
  PRIMARY KEY (`StaffID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffinformation`
--

LOCK TABLES `staffinformation` WRITE;
/*!40000 ALTER TABLE `staffinformation` DISABLE KEYS */;
INSERT INTO `staffinformation` VALUES (1,'Sarah','Manager',55000),(2,'Tom','Waiter',30000),(3,'Linda','Chef',40000),(4,'Robert','Cashier',31000),(5,'Daniel','Waiter',32000),(6,'Susan','Hostess',28000),(7,'Chris','Manager',60000),(8,'Jessica','Chef',38000),(9,'Brian','Waiter',29000),(10,'Kim','Hostess',27000);
/*!40000 ALTER TABLE `staffinformation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'littlelemondb'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(
    IN new_booking_id INT, 
    IN new_customer_id INT, 
    IN new_booking_date DATE, 
    IN new_table_number INT, 
    IN new_staff_id INT)
BEGIN
    -- Insert the new booking record
    INSERT INTO `LittleLemonDB`.`Bookings`(
        `BookingID`, 
        `CustomerID`, 
        `Date`, 
        `TableNumber`, 
        `StaffID`)
    VALUES(
        new_booking_id, 
        new_customer_id, 
        new_booking_date, 
        new_table_number,
        new_staff_id
    );

    SELECT 'New booking added' AS 'Confirmation';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddValidBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddValidBooking`(IN new_booking_date DATE, IN new_table_number INT, IN new_customer_id INT, IN new_staff_id INT)
BEGIN
    DECLARE table_status INT;
    START TRANSACTION;

    SELECT COUNT(*) INTO table_status
    FROM `LittleLemonDB`.`Bookings`
    WHERE `Date` = new_booking_date AND `TableNumber` = new_table_number;

    IF (table_status > 0) THEN
        ROLLBACK;
        SELECT 'Booking could not be completed. Table is already booked on the specified date.' AS 'Status';
    ELSE
        INSERT INTO `LittleLemonDB`.`Bookings`(`Date`, `TableNumber`, `CustomerID`, `StaffID`)
        VALUES(new_booking_date, new_table_number, new_customer_id, new_staff_id);

        COMMIT;
        SELECT 'Booking completed successfully.' AS 'Status';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CancelBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelBooking`(IN booking_id_to_cancel INT)
BEGIN
    -- Delete the booking record
    DELETE FROM `LittleLemonDB`.`Bookings`
    WHERE `BookingID` = booking_id_to_cancel;

    SELECT CONCAT('Booking ', booking_id_to_cancel, ' cancelled') AS 'Confirmation';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CancelOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelOrder`(IN orderIDToDelete INT)
BEGIN
  DECLARE orderExistence INT;

  -- Check if the order exists in the database
  SELECT COUNT(*) INTO orderExistence FROM `LittleLemonDB`.`Orders` WHERE OrderID = orderIDToDelete;

  -- If the order exists, delete it
  IF orderExistence > 0 THEN
    -- First delete related records from OrderDeliveryStatuses table
    DELETE FROM `LittleLemonDB`.`OrderDeliveryStatuses` WHERE OrderID = orderIDToDelete;

    -- Then delete the order from the Orders table
    DELETE FROM `LittleLemonDB`.`Orders` WHERE OrderID = orderIDToDelete;

    SELECT CONCAT('Order ', orderIDToDelete, ' is cancelled') AS 'Confirmation';
  ELSE
    SELECT CONCAT('Order ', orderIDToDelete, ' does not exist') AS 'Confirmation';
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckBooking`(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE table_status VARCHAR(50);

    SELECT COUNT(*) INTO @table_count
    FROM `LittleLemonDB`.`Bookings`
    WHERE `Date` = booking_date AND `TableNumber` = table_number;

    IF (@table_count > 0) THEN
        SET table_status = 'Table is already booked.';
    ELSE
        SET table_status = 'Table is available.';
    END IF;

    SELECT table_status AS 'Table Status';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMaxQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMaxQuantity`()
BEGIN
  DECLARE maxQty INT;

  SELECT MAX(Quantity) INTO maxQty FROM `LittleLemonDB`.`Orders`;

  SELECT maxQty AS 'Maximum Ordered Quantity';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBooking`(
    IN booking_id_to_update INT, 
    IN new_booking_date DATE)
BEGIN
    -- Update the booking record
    UPDATE `LittleLemonDB`.`Bookings`
    SET `Date` = new_booking_date
    WHERE `BookingID` = booking_id_to_update;

    SELECT CONCAT('Booking ', booking_id_to_update, ' updated') AS 'Confirmation';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `ordersview`
--

/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersview` AS select `orders`.`OrderID` AS `OrderID`,`orders`.`Quantity` AS `Quantity`,`orders`.`TotalCost` AS `Cost` from `orders` where (`orders`.`Quantity` > 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ordersview2`
--

/*!50001 DROP VIEW IF EXISTS `ordersview2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersview2` AS select `cd`.`CustomerID` AS `CustomerID`,`cd`.`Name` AS `FullName`,`o`.`OrderID` AS `OrderID`,`o`.`TotalCost` AS `Cost`,`m`.`Name` AS `MenuName`,`mi`.`CourseName` AS `CourseName` from (((`customerdetails` `cd` join `orders` `o` on((`o`.`CustomerID` = `cd`.`CustomerID`))) join `menus` `m` on((`o`.`MenuItemID` = `m`.`MenuItemsID`))) join `menuitems` `mi` on((`m`.`MenuItemsID` = `mi`.`MenuItemsID`))) order by `o`.`TotalCost` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ordersview3`
--

/*!50001 DROP VIEW IF EXISTS `ordersview3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersview3` AS select `m`.`Name` AS `MenuName` from `menus` `m` where `m`.`MenuItemsID` in (select `o`.`MenuItemID` from `orders` `o` group by `o`.`MenuItemID` having (sum(`o`.`Quantity`) > 2)) */;
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

-- Dump completed on 2023-10-26 9:43:32
