-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 29, 2024 at 05:09 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

CREATE DATABASE IF NOT EXISTS test;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_account`(IN `param` VARCHAR(5)) NO SQL
BEGIN
	DECLARE done INT DEFAULT FALSE;
  DECLARE currentID INT DEFAULT 1;
  DECLARE nextID INT DEFAULT 1;
  DECLARE output TEXT DEFAULT '';
  DECLARE name VARCHAR(255);
  DECLARE cur CURSOR FOR SELECT id FROM accounts;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
  OPEN cur;
    
  read_loop: LOOP
    
    -- current cursor
    FETCH cur INTO currentID;

      /**
      * Detect for previously used primary key
      *
      * Once the current row has an ID greater than the index counter
      * it will automatically use its value as the next primary key
      *
      *
      * sample data
      *|-------------------------|
      *|       Table             |
      *|-------------------------|
      *|  id        |     name   |
      *|-------------------------|
      *|  5         |     test5   |
      *|-------------------------|
      *|  6         |     test6   |
      *|-------------------------|
      *|  7         |     test7   |
      *|-------------------------|
      *
      * currentID: 5
      * nextID: 1
      * 
      */
      IF currentID > nextID THEN
        SET output = CONCAT('An old primary_key will be reused: ', nextID);     
        LEAVE read_loop;
      END IF;
      
      /**
      * Get the value of the last ID and increment it by 1
      * this will be used as next primary key if no error has been detected
      */
      IF done THEN
        IF nextID > 1 THEN
          SET nextID = currentID + 1;
        END IF;
        
        SET output = CONCAT('Data will be appended on the list : ', nextID);  
        LEAVE read_loop;
      END IF;
      
      /**
      * Increment cursor every read
      */
      SET nextID = nextID + 1;

  END LOOP;

	CLOSE cur;

  SELECT output;
  IF param IS NULL OR param = '' THEN
    SET name = concat(
      char(round(rand()*25)+97),
      char(round(rand()*25)+97),
      char(round(rand()*25)+65),
      char(round(rand()*25)+65),
      nextID);
  ELSE
	  SET name = concat(param, nextID);
  END IF;
      
  INSERT INTO accounts (id, name) VALUES (nextID, name);
END$$
DELIMITER ;