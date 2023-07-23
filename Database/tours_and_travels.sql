-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2023 at 08:13 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tours_and_travels`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking_package`
--

CREATE TABLE `booking_package` (
  `id` int(11) NOT NULL,
  `srfid` varchar(20) NOT NULL,
  `pack_id` int(11) NOT NULL,
  `pack_type` varchar(20) NOT NULL,
  `hcode` varchar(30) NOT NULL,
  `hotel_name` varchar(30) NOT NULL,
  `cost` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `address` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking_package`
--

INSERT INTO `booking_package` (`id`, `srfid`, `pack_id`, `pack_type`, `hcode`, `hotel_name`, `cost`, `email`, `username`, `phone`, `address`) VALUES
(16, '12345678', 0, 'brounce', ' HA1', 'kalakkara', 0, 'abhijithvvl725@gmail.com', 'abijith', '9961156155', 'valavvu'),
(25, '11111111', 1, 'gold', 'BHIT', 'victory', 20000, 'jurij@gmail.com', 'jurij', '9562260750', 'valavvu'),
(64, '4KV001', 3, 'brounce', 'HA1', 'Kalakkara', 1500, 'aneesh@gmail.com', 'anees', '9961156155', 'valavvu'),
(66, 'sss', 4, 'silver', 'BHIT', 'victory', 2500, 'sss@gmail.com', 'Nikhil', '9400582858', 'Kuttikol'),
(90, 'nikhil', 3, 'brounce', 'HA1', 'Kalakkara', 1500, 'nikhilkalakkara@gmail.com', 'nikhil', '9562260750', 'kuttikol');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(30) NOT NULL,
  `country` varchar(20) NOT NULL,
  `gender` varchar(5) NOT NULL,
  `address` varchar(50) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `username`, `name`, `country`, `gender`, `address`, `phone`, `email`) VALUES
(1, 'abijith', 'Abijith', 'china', 'M', 'valavvu', '9919961156', 'abhijithvvl725@gmail.com'),
(3, 'anees', 'Aneesh', 'Africa', 'M', 'valavvu', '9961156155', 'aneesh@gmail.com'),
(6, 'saranya', 'Nikhil suresh', 'India', 'F', 'Kuttikol', '0940058285', 'ssss@gmail.com'),
(7, 'saranyadda', 'sundris', 'India', 'M', 'Kuttikol', '9562260750', 'sanku@gmail.com'),
(16, 'Nikhil', 'Nikhil', 'India', 'M', 'Kuttikol', '9961156155', 'nikhil@gmail.com'),
(17, 'nikhil', 'Nikhil', 'india', 'M', 'kuttikol', '9562260750', 'nikhilkalakkara@gmail.com'),
(18, 'Nikhil', 'Nikhil', 'India', 'M', 'Kuttikol', '9562260750', 'nikhilkalakkara05@gmail.com'),
(20, 'asif', 'asig', 'china', 'M', 'asif', '9562260750', 'asif@gmail.com');

--
-- Triggers `customer`
--
DELIMITER $$
CREATE TRIGGER `Deletecustomer` BEFORE DELETE ON `customer` FOR EACH ROW INSERT INTO trig2
VALUES(null,OLD.customer_id,OLD.username,OLD.phone,OLD.email,'DELETED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Insertcustomer` AFTER INSERT ON `customer` FOR EACH ROW INSERT INTO trig2
VALUES(null,NEW.customer_id,NEW.username,NEW.phone,NEW.email,'INSERTED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Updatecustomer` AFTER UPDATE ON `customer` FOR EACH ROW INSERT INTO trig2
VALUES(null,NEW.customer_id,NEW.username,NEW.phone,NEW.email,'UPDATED',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hoteluser`
--

CREATE TABLE `hoteluser` (
  `id` int(50) NOT NULL,
  `hcode` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hoteluser`
--

INSERT INTO `hoteluser` (`id`, `hcode`, `email`, `password`) VALUES
(11, ' HA1', 'nikhilkalakkara05@gmail.com', 'pbkdf2:sha256:260000$G8CnOFJETi4OKd38$c896124b1ff6e50d21cd30266574f42c70b68670140297b23c070717d3d65fb7'),
(20, 'MM5', 'aneesh@gmail.com', 'pbkdf2:sha256:260000$F67HnyfpoF3bokAJ$ff35ea3010d8fe37842ae75faa9a2f9eb62caef023da413e4450eab13530b519'),
(24, 'OSA', 'pokki@gmail.com', 'pbkdf2:sha256:260000$WOJDfL5mCD7v7oWw$c300713dbd679a644846846d354e028e6cac9271e2f5c6a416062d060063fd34'),
(26, 'AAB', 'abcd@gmail.com', 'pbkdf2:sha256:260000$UAHiroKPOJYxV1f0$201f90f289f1591dbc76e228d23a169a715f96ed3b0e63eea2a900d003df80b8');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_details`
--

CREATE TABLE `hotel_details` (
  `id` int(50) NOT NULL,
  `hcode` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `hotel_name` varchar(20) NOT NULL,
  `hotel_type` varchar(10) NOT NULL,
  `rooms` int(11) NOT NULL,
  `address` varchar(20) NOT NULL,
  `package` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hotel_details`
--

INSERT INTO `hotel_details` (`id`, `hcode`, `email`, `hotel_name`, `hotel_type`, `rooms`, `address`, `package`) VALUES
(5, ' HA2', '', 'HOTEL', 'ac', 10, 'Kuttikol', 'silver'),
(8, 'BHIT', '', 'pingara', 'non ac', 23, 'puttur', 'silver'),
(10, 'osa', '', 'kalakkaras', 'ac', 60, 'Kuttikol', 'silver'),
(13, ' DS5', '', 'kalakkaras', 'ac', 10, 'paduppu', 'silver'),
(14, 'HA1', '', 'kalakkara', 'ac', 10, 'bismi', 'silver'),
(15, 'EEH', 'nikhilkalakkara05@gmail.com', 'kalakkara', 'AC', 11, 'bandadka', 'gold'),
(17, '', 'abhijithvvl725@gmail.com', 'HOTEL Taj', 'ac', 12, 'valavvu', 'brounce'),
(18, 'BHITS', 'aneesh@gmail.com', 'sooryas', 'ac', 87, 'calicut', 'gold'),
(20, 'OSA', 'pokki@gmail.com', 'paradise', 'AC', 100, 'sullia', 'gold'),
(21, ' HA1', 'jurij@gmail.com', 'HOTEL Taj', 'AC', 50, 'valavvu', 'silver'),
(22, 'SSA', 'abijith05@gmail.com', 'bismi', 'NON-AC', 80, 'valavvu', 'brounce'),
(23, 'AAB', 'abcd@gmail.com', 'paradise', 'AC', 23, 'bandadka', 'gold');

--
-- Triggers `hotel_details`
--
DELIMITER $$
CREATE TRIGGER `Insert` AFTER INSERT ON `hotel_details` FOR EACH ROW INSERT INTO trig
VALUES(null,NEW.hcode,NEW.hotel_name,NEW.rooms,NEW.package,'INSERTED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Update` AFTER UPDATE ON `hotel_details` FOR EACH ROW INSERT INTO trig
VALUES(null,NEW.hcode,NEW.hotel_name,NEW.rooms,NEW.package,'UPDATED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete` BEFORE DELETE ON `hotel_details` FOR EACH ROW INSERT INTO trig
VALUES(null,OLD.hcode,OLD.hotel_name,OLD.rooms,OLD.package,'DELETED',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `id` int(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pack_type` varchar(20) NOT NULL,
  `pname` varchar(20) NOT NULL,
  `start` varchar(20) NOT NULL,
  `destination` varchar(20) NOT NULL,
  `hcode` varchar(30) NOT NULL,
  `hotel_name` varchar(20) NOT NULL,
  `persons` int(50) NOT NULL,
  `cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`id`, `email`, `pack_type`, `pname`, `start`, `destination`, `hcode`, `hotel_name`, `persons`, `cost`) VALUES
(1, '', 'gold', 'kulu-manali', 'kerala', 'manali', ' BHIT', 'victory', 10, 20000),
(2, '', 'silver', 'Ranipuram', 'Bandadka', 'Ranipuram', ' HA2', 'pingere', 20, 3000),
(3, '', 'brounce', 'Konakad', 'Rajapuram', 'Konnakad', 'HA1', 'Kalakkara', 8, 1500),
(4, '', 'silver', 'Bekal', 'Bandadka', 'Pallikara', 'BHIT', 'victory', 5, 2500),
(5, '', 'silver', 'Bekal', 'Bandadka', 'Pallikara', 'BHIT', 'Grand', 5, 4000),
(6, '', 'silver', 'Goa Explore', 'Kerala', 'Goa', 'osa', 'Bismi', 25, 40000),
(7, 'aneesh@gmail.com', 'gold', 'jaikashmir', 'goa', 'jammukasmeer', 'BHIT', 'bismi', 30, 40000),
(9, 'pokki@gmail.com', 'gold', 'kovalams', 'kasargod', 'kovalam', 'HA2', 'victory', 14, 6000),
(11, 'nikhilkalakkara05@gmail.com', 'gold', 'Thaliparambbu', 'sullia', 'kotakunnu', 'EEH', 'kalakkara', 10, 2000),
(12, 'abcd@gmail.com', 'gold', 'kaveri', 'Bandadka', 'kaveri', 'AAB', 'paradise', 10, 20000);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id_no` varchar(30) NOT NULL,
  `ac_charge` int(10) NOT NULL,
  `food_charge` int(10) NOT NULL,
  `cust_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `upi_id` int(30) NOT NULL,
  `upi_pin` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `upi_id`, `upi_pin`, `email`, `phone`) VALUES
(5, 987451, 52145, 'nikhilkalakkara05@gmail.com', '956224875'),
(6, 545655, 3444, 'nikhilkalakkara05@gmail.com', '9654785214'),
(7, 54434, 54444, 'nikhilkalakkara05@gmail.com', '9654785214'),
(8, 54434, 54444, 'nikhilkalakkara05@gmail.com', '9654785214'),
(9, 54434, 54444, 'nikhilkalakkara05@gmail.com', '9654785214'),
(10, 54434, 54444, 'nikhilkalakkara05@gmail.com', '9654785214'),
(11, 34567, 4566, 'nikhilkalakkara05@gmail.com', '9654785214'),
(12, 45675, 456, 'nikhilkalakkara05@gmail.com', '9654785214'),
(13, 4555655, 4454455, 'nikhilkalakkara05@gmail.com', '0996115615'),
(14, 434544, 55444, 'nikhilkalakkara05@gmail.com', '9961156160'),
(15, 56556, 5454, 'nikhilkalakkara05@gmail.com', '6075095622'),
(16, 4546466, 44466, 'nikhilkalakkara05@gmail.com', 'None'),
(17, 34567, 7654, 'nikhilkalakkara05@gmail.com', 'None'),
(18, 456466, 654455, 'nikhilkalakkara05@gmail.com', 'None'),
(19, 4566, 5666, 'nikhilkalakkara05@gmail.com', 'None'),
(20, 657657, 56556, 'nikhilkalakkara05@gmail.com', 'None'),
(21, 3433333, 4565, 'aneesh@gmail.com', 'None'),
(22, 33455, 456, 'aneesh@gmail.com', 'None'),
(23, 56788, 567, 'aneesh@gmail.com', 'None'),
(24, 567866, 678, 'aneesh@gmail.com', 'None'),
(25, 6565, 545, 'nikhilkalakkara05@gmail.com', 'None'),
(26, 5566767, 9877, 'sss@gmail.com', 'None'),
(27, 3455, 543, 'nikhilkalakkara05@gmail.com', 'None'),
(28, 5577, 45646, 'nikhilkalakkara05@gmail.com', 'None'),
(29, 54466, 45456, 'nikhilkalakkara05@gmail.com', 'None'),
(30, 54466, 45456, 'nikhilkalakkara05@gmail.com', 'None'),
(31, 54466, 45456, 'nikhilkalakkara05@gmail.com', 'None'),
(32, 54466, 45456, 'nikhilkalakkara05@gmail.com', 'None'),
(33, 54466, 45456, 'nikhilkalakkara05@gmail.com', 'None'),
(34, 54466, 45456, 'nikhilkalakkara05@gmail.com', 'None'),
(35, 54545, 5454, 'nikhilkalakkara05@gmail.com', 'None'),
(36, 54545, 5454, 'nikhilkalakkara05@gmail.com', 'None'),
(37, 54545, 5454, 'nikhilkalakkara05@gmail.com', 'None'),
(38, 43435, 33535, 'nikhilkalakkara05@gmail.com', 'None'),
(39, 3523, 343, 'nikhilkalakkara05@gmail.com', 'None'),
(40, 3523, 343, 'nikhilkalakkara05@gmail.com', 'None'),
(41, 35435, 353535, 'nikhilkalakkara05@gmail.com', 'None'),
(42, 345, 2345234, 'nikhilkalakkara05@gmail.com', 'None'),
(43, 454544, 4544, 'nikhilkalakkara05@gmail.com', 'None'),
(44, 544666, 456, 'nikhilkalakkara05@gmail.com', 'None'),
(45, 5666, 6556, 'nikhilkalakkara05@gmail.com', 'None'),
(46, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(47, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(48, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(49, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(50, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(51, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(52, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(53, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(54, 43535, 35534, 'nikhilkalakkara05@gmail.com', 'None'),
(55, 5678900, 4567, 'nikhilkalakkara05@gmail.com', 'None'),
(56, 565433, 4567, 'nikhilkalakkara05@gmail.com', 'None'),
(57, 543344, 5443, 'nikhilkalakkara05@gmail.com', 'None'),
(58, 46546, 55462, 'nikhilkalakkara05@gmail.com', 'None'),
(59, 587456, 25478, 'nikhilkalakkara05@gmail.com', 'None'),
(60, 5487, 52147, 'nikhilkalakkara05@gmail.com', 'None'),
(61, 854521, 2587455, 'nikhilkalakkara@gmail.com', 'None'),
(62, 65656255, 25417, 'asif@gmail.com', 'None');

-- --------------------------------------------------------

--
-- Table structure for table `trig`
--

CREATE TABLE `trig` (
  `id` int(11) NOT NULL,
  `hcode` varchar(30) NOT NULL,
  `hotel_name` varchar(20) NOT NULL,
  `rooms` int(11) NOT NULL,
  `package` varchar(10) NOT NULL,
  `querys` varchar(50) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trig`
--

INSERT INTO `trig` (`id`, `hcode`, `hotel_name`, `rooms`, `package`, `querys`, `date`) VALUES
(1, ' HA1', 'kalakkara', 20, 'gold', 'INSERTED', '2022-01-20'),
(2, ' HA1', 'kalakkara', 20, 'gold', 'UPDATED', '2022-01-20'),
(3, 'HA3', 'kalakkara', 35, 'gold', 'DELETED', '2022-01-20'),
(4, ' HA1', 'kalakkara', 10, 'silver', 'INSERTED', '2022-01-22'),
(5, ' HA1', 'kalakkara', 10, 'silver', 'UPDATED', '2022-01-22'),
(6, ' HA1', 'kalakkara', 10, 'silver', 'DELETED', '2022-01-22'),
(7, ' HA1', 'kalakkara', 10, 'silver', 'INSERTED', '2022-01-22'),
(8, ' HA1', 'kalakkara', 10, 'silver', 'UPDATED', '2022-01-22'),
(9, ' HA1', 'kalakkara', 10, 'silver', 'INSERTED', '2022-01-22'),
(10, ' HA1', 'kalakkara', 10, 'silver', 'UPDATED', '2022-01-22'),
(11, ' HA1', 'kalakkara', 10, 'gold', 'INSERTED', '2022-01-22'),
(12, 'HH6', 'kalakkara', 10, 'gold', 'UPDATED', '2022-01-22'),
(13, ' HA1', 'HOTEL Taj', 12, 'brounce', 'INSERTED', '2022-01-29'),
(14, ' HA1', 'HOTEL Taj', 12, 'brounce', 'UPDATED', '2022-01-29'),
(15, 'HA6', 'HOTEL', 115, 'brounce', 'UPDATED', '2022-01-29'),
(16, 'HA6', 'HOTEL', 115, 'brounce', 'DELETED', '2022-01-29'),
(17, ' HA1', 'HOTEL Taj', 12, 'brounce', 'INSERTED', '2022-01-29'),
(18, 'HH6', 'kalakkara', 10, 'gold', 'UPDATED', '2022-01-29'),
(19, 'HH6', 'kalakkara', 11, 'gold', 'UPDATED', '2022-01-29'),
(20, 'MM1', 'soorya', 50, 'gold', 'INSERTED', '2022-01-29'),
(21, 'MM1', 'soorya', 55, 'gold', 'UPDATED', '2022-01-29'),
(22, 'PLACEHOLDER=\"ENTER', 'sooryas', 70, 'gold', 'UPDATED', '2022-01-29'),
(23, 'BHIT', 'sooryas', 70, 'gold', 'UPDATED', '2022-01-29'),
(24, ' HA1', 'kalakkara', 24, 'silver', 'INSERTED', '2022-01-29'),
(25, 'BHIT', 'sooryas', 80, 'gold', 'UPDATED', '2022-01-29'),
(26, ' HA1', 'kalakkara', 24, 'silver', 'DELETED', '2022-01-29'),
(27, 'BHITS', 'sooryas', 87, 'gold', 'UPDATED', '2022-01-29'),
(28, 'RR3', 'paradise', 87, 'gold', 'INSERTED', '2022-01-29'),
(29, ' HA2', 'HOTEL', 10, 'silver', 'UPDATED', '2022-01-31'),
(30, 'BHIT', 'pingara', 23, 'silver', 'UPDATED', '2022-01-31'),
(31, 'osa', 'kalakkaras', 60, 'silver', 'UPDATED', '2022-01-31'),
(32, ' DS5', 'kalakkaras', 10, 'silver', 'UPDATED', '2022-01-31'),
(33, 'HA1', 'kalakkara', 10, 'silver', 'UPDATED', '2022-01-31'),
(34, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-01-31'),
(35, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-01-31'),
(36, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-01-31'),
(37, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-01-31'),
(38, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-01-31'),
(39, ' HA1', 'HOTEL Taj', 50, 'silver', 'INSERTED', '2022-02-01'),
(40, 'SSA', 'bismi', 80, 'brounce', 'INSERTED', '2022-02-02'),
(41, 'SSA', 'bismi', 80, 'brounce', 'UPDATED', '2022-02-02'),
(42, 'EEH', 'kalakkara', 11, 'gold', 'UPDATED', '2022-02-02'),
(43, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-02-02'),
(44, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-02-02'),
(45, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-02-03'),
(46, 'RR3', 'paradise', 100, 'gold', 'UPDATED', '2022-02-03'),
(47, 'OSA', 'paradise', 100, 'gold', 'UPDATED', '2022-03-25'),
(48, 'OSA', 'paradise', 100, 'gold', 'UPDATED', '2022-03-25'),
(49, 'OSA', 'paradise', 100, 'gold', 'UPDATED', '2022-03-26'),
(50, 'AAB', 'paradise', 23, 'gold', 'INSERTED', '2022-03-30');

-- --------------------------------------------------------

--
-- Table structure for table `trig2`
--

CREATE TABLE `trig2` (
  `id` int(11) NOT NULL,
  `customer_id` int(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `querys` varchar(50) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trig2`
--

INSERT INTO `trig2` (`id`, `customer_id`, `username`, `phone`, `email`, `querys`, `date`) VALUES
(1, 128, 'pokki', '9961156155', 'pokki@gmail.com', 'INSERTED', '2022-01-20'),
(2, 160, 'pokkiichi', '9961156160', 'pokki@gmail.com', 'UPDATED', '2022-01-20'),
(3, 160, 'pokkiichi', '9961156160', 'pokki@gmail.com', 'DELETED', '2022-01-22'),
(4, 257, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-01-22'),
(5, 123, 'abijith', '+919961156', 'abhi123@gmail.com', 'INSERTED', '2022-01-29'),
(6, 123, 'koi', '9400582858', 'abijith05@gmail.com', 'DELETED', '2022-01-29'),
(7, 123, 'abijith', '+919961156', 'abhi123@gmail.com', 'DELETED', '2022-01-29'),
(8, 123, 'abijith', '+919961156', 'abhijithvvl725@gmail.com', 'INSERTED', '2022-01-29'),
(9, 123, 'abijith', '+919961156', 'abhijithvvl725@gmail.com', 'UPDATED', '2022-01-29'),
(10, 123, 'abijith', '+919961156', 'abhijithvvl725@gmail.com', 'UPDATED', '2022-01-29'),
(11, 257, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-01-31'),
(12, 123, 'Nikhil', '+919400582', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-01-31'),
(13, 123, 'Nikhil', '9819400582', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-01-31'),
(14, 123, 'Nikhil', '+919562260', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-01-31'),
(15, 123, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-01'),
(16, 123, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-01'),
(17, 123, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-01'),
(18, 2345, 'anees', '9961156155', 'aneesh@gmail.com', 'INSERTED', '2022-02-01'),
(19, 554, 'Nikhil', '9400582858', 'sss@gmail.com', 'INSERTED', '2022-02-02'),
(20, 554, 'Nikhil', '9400582858', 'sss@gmail.com', 'UPDATED', '2022-02-02'),
(21, 5, 'sundru', '9587451236', 'sanku@gmail.com', 'INSERTED', '2022-02-02'),
(22, 5, 'sundru', '9587451236', 'sanku@gmail.com', 'UPDATED', '2022-02-02'),
(23, 5, 'sundru', '9587451236', 'sanku@gmail.com', 'UPDATED', '2022-02-02'),
(24, 5, 'sundru', '9587451236', 'sanku@gmail.com', 'UPDATED', '2022-02-02'),
(25, 5, 'sundru', '9587451236', 'sanku@gmail.com', 'DELETED', '2022-02-02'),
(26, 6, 'saranya', '0940058285', 'ssss@gmail.com', 'INSERTED', '2022-02-02'),
(27, 7, 'saranya', '9562260750', 'sanku@gmail.com', 'INSERTED', '2022-02-02'),
(28, 7, 'saranya', '9562260750', 'sanku@gmail.com', 'UPDATED', '2022-02-02'),
(29, 7, 'saranyadda', '9562260750', 'sanku@gmail.com', 'UPDATED', '2022-02-02'),
(30, 7, 'saranyadda', '9562260750', 'sanku@gmail.com', 'UPDATED', '2022-02-02'),
(31, 2, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-02'),
(32, 8, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-02'),
(33, 8, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-02'),
(34, 9, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-02'),
(35, 9, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-02'),
(36, 10, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-02'),
(37, 10, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-02'),
(38, 10, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-02'),
(39, 11, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-02'),
(40, 11, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-02'),
(41, 12, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-02'),
(42, 12, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-02'),
(43, 13, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-02'),
(44, 13, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-02'),
(45, 13, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-02'),
(46, 13, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-02'),
(47, 14, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-02'),
(48, 14, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-03'),
(49, 14, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-03'),
(50, 14, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-03'),
(51, 14, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-03'),
(52, 14, 'Nikhil', '+919400582', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-03'),
(53, 14, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-03'),
(54, 14, 'Nikhil', '9400582858', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-03'),
(55, 15, 'Nikhil', '9961156155', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-03'),
(56, 15, 'Nikhil', '9961156155', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-04'),
(57, 15, 'Nikhil', '9961156155', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-02-04'),
(58, 15, 'Nikhil', '9961156155', 'nikhilkalakkara05@gmail.com', 'DELETED', '2022-02-05'),
(59, 16, 'Nikhil', '9961156155', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-02-05'),
(60, 3, 'anees', '9961156155', 'aneesh@gmail.com', 'UPDATED', '2022-02-10'),
(61, 1, 'abijith', '9919961156', 'abhijithvvl725@gmail.com', 'UPDATED', '2022-02-10'),
(62, 4, 'Nikhil', '9400582858', 'sss@gmail.com', 'DELETED', '2022-02-10'),
(63, 17, 'nikhil', '9562260750', 'nikhilkalakkara@gmail.com', 'INSERTED', '2022-03-26'),
(64, 17, 'nikhil', '9562260750', 'nikhilkalakkara@gmail.com', 'UPDATED', '2022-03-26'),
(65, 16, 'Nikhil', '9961156155', 'nikhil@gmail.com', 'UPDATED', '2022-03-29'),
(66, 18, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'INSERTED', '2022-03-29'),
(67, 19, 'abcd', '9961156155', 'abcd@gmail.com', 'INSERTED', '2022-03-30'),
(68, 19, 'abcd', '9961156155', 'abcd@gmail.com', 'DELETED', '2022-03-30'),
(69, 18, 'Nikhil', '9562260750', 'nikhilkalakkara05@gmail.com', 'UPDATED', '2022-03-31'),
(70, 20, 'asif', '9562260750', 'asif@gmail.com', 'INSERTED', '2023-07-21');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(50) NOT NULL,
  `srfid` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dob` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `srfid`, `email`, `dob`) VALUES
(5, 'KV10082001', 'nikhilkalakkara05@gmail.com', 'pbkdf2:sha256:260000$wgbHLFpOdcVPKxnO$54dca1f790019e070bc05ba8d5075e444fe1df37765ac2425a74e56560d49e61'),
(9, '12345678', 'abijith05@gmail.com', 'pbkdf2:sha256:260000$VXVHYV1AHiGmEzp2$fe7dcce1a1c44bbf784cc74f62e548b41999209f5b00531c45c130cc0c256322'),
(10, '11111111', 'jurij@gmail.com', 'pbkdf2:sha256:260000$7eLjVgZbzGb2cGaH$03dfe73022bcb68e4311dd4e3cd5857e47af9bba5254f72cf648b37aadcafa63'),
(12, '4KV001', 'aneesh@gmail.com', 'pbkdf2:sha256:260000$0b7KziP4BgB27TOZ$7662f151e5be8b0199e2bcd2dc3727b9dd16bec84b7cee795fd9074d70361a81'),
(13, 'ssa', 'aa@gmail.com', 'pbkdf2:sha256:260000$K4W5yssrgD1mBfJx$15fb90e445b4487d4b4b5bb23fb7cb3150f22380302fd87918a1a4993d27d6ed'),
(14, 'sss', 'sss@gmail.com', 'pbkdf2:sha256:260000$Y92wMogdoRO9e2ZV$5caa5c3c27691b43fea5ed70aba938db0bea5da0d371dc5d982c7be5aa54bc88'),
(15, 'kkk', 'sanku@gmail.com', 'pbkdf2:sha256:260000$xEHAeFDVD7wrUgFE$f693eec1839cae45c1096a70a63c38b04a7ba3d5d34171186878af0a9b7f4b45'),
(16, 'nikhil', 'nikhilkalakkara@gmail.com', 'pbkdf2:sha256:260000$mYRkBGikNwKvn987$1550dc1185e3fa35bd924585ece40e5fdbe342c5b1c95d5b879c5fd780f44873'),
(18, 'Asif', 'asif@gmail.com', 'pbkdf2:sha256:260000$w4djyKvveR3DIy2k$e532b682b79b682b8bf93f7502b918f8204a8300308c1c1a0b04fd00db455db7');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking_package`
--
ALTER TABLE `booking_package`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `srfid` (`srfid`),
  ADD KEY `hcode` (`hcode`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `hoteluser`
--
ALTER TABLE `hoteluser`
  ADD PRIMARY KEY (`id`,`hcode`),
  ADD UNIQUE KEY `hcode` (`hcode`);

--
-- Indexes for table `hotel_details`
--
ALTER TABLE `hotel_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`id`,`pack_type`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id_no`),
  ADD KEY `payment_fr` (`cust_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trig`
--
ALTER TABLE `trig`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trig2`
--
ALTER TABLE `trig2`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`,`srfid`),
  ADD UNIQUE KEY `srfid` (`srfid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking_package`
--
ALTER TABLE `booking_package`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `hoteluser`
--
ALTER TABLE `hoteluser`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `hotel_details`
--
ALTER TABLE `hotel_details`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `trig`
--
ALTER TABLE `trig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `trig2`
--
ALTER TABLE `trig2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking_package`
--
ALTER TABLE `booking_package`
  ADD CONSTRAINT `booking_package_ibfk_1` FOREIGN KEY (`srfid`) REFERENCES `user` (`srfid`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
