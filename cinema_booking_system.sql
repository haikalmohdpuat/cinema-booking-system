-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2022 at 10:37 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinema_booking_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminID` varchar(10) NOT NULL,
  `adminName` varchar(255) NOT NULL,
  `adminEmail` varchar(50) NOT NULL,
  `adminPassword` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminID`, `adminName`, `adminEmail`, `adminPassword`) VALUES
('AD100', 'Encik Saiful Bin Mukhriz', 'saifulmukhriz@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `custID` varchar(10) NOT NULL,
  `custName` varchar(255) NOT NULL,
  `custEmail` varchar(50) NOT NULL,
  `custPassword` varchar(50) NOT NULL,
  `custBalance` int(11) NOT NULL,
  `custMobileNumber` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`custID`, `custName`, `custEmail`, `custPassword`, `custBalance`, `custMobileNumber`) VALUES
('S10000', 'Abdul Kasim Bin Rahman', 'abdulkarim@gmail.com', '1234', 1500, '012-345 6789'),
('S59419', 'Muhammad Haikal Aiman Bin Mohd Puat', 'haikal@gmail.com', '1234', 1470, '012-345 9090');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `foodID` int(11) NOT NULL,
  `foodImage` varchar(255) NOT NULL,
  `foodDescription` varchar(255) NOT NULL,
  `foodPrice` int(11) NOT NULL,
  `foodType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`foodID`, `foodImage`, `foodDescription`, `foodPrice`, `foodType`) VALUES
(100, 'https://cdn.kfc.com.my/images/menu/delivery/cheezy-twister-combo.jpg.webp', 'Cheezy Twister Combo', 16, 'combo'),
(101, 'https://cdn.kfc.com.my/images/menu/delivery/zinger-double-down-combo-2022.jpg.webp', 'Zinger Double Combo', 20, 'combo'),
(103, 'https://cdn.kfc.com.my/images/menu/delivery/6-pc-nuggets-lays-combo.jpg.webp', 'Nuggets And Lays', 15, 'combo'),
(104, 'https://cdn.kfc.com.my/images/menu/delivery/cheezilla-double-down-ala-carte-2022.jpg.webp', 'Zinger Double Down', 17, 'alacarte'),
(105, 'https://cdn.kfc.com.my/images/menu/delivery/cheezy-twister.jpg.webp', 'Cheezy Twister ', 12, 'alacarte'),
(106, 'https://cdn.kfc.com.my/images/menu/delivery/3-pc-tenders-a-la-carte-2022.png.webp', 'Crispy Tenders', 9, 'alacarte'),
(107, 'https://cdn.kfc.com.my/images/menu/delivery/ice-milo-R-v2.png.webp', 'Iced Milo (R)', 6, 'drinks'),
(108, 'https://cdn.kfc.com.my/images/menu/delivery/pepsi-black-L-v2.png.webp', 'Pepsi Black (L)', 5, 'drinks'),
(109, 'https://cdn.kfc.com.my/images/menu/delivery/ice-lemon-tea-R-v2.png.webp', 'Iced Lemon Tea', 4, 'drinks'),
(110, 'https://cdn.kfc.com.my/images/menu/delivery/delivery-cheesy-wedges(L).png.webp', 'Cheezy Wedges (L)', 7, 'snacks'),
(111, 'https://cdn.kfc.com.my/images/menu/delivery/loaded-potato-bowl-v2.jpg.webp', 'Loaded Potato Bowl', 8, 'snacks'),
(112, 'https://cdn.kfc.com.my/images/menu/delivery/popcorn-chicken-alacarte-v2.png.webp', 'Popcorn Chicken', 10, 'snacks');

-- --------------------------------------------------------

--
-- Table structure for table `food_order`
--

CREATE TABLE `food_order` (
  `id` int(11) NOT NULL,
  `ticketID` varchar(255) NOT NULL,
  `foodDetails` varchar(255) NOT NULL,
  `foodQuantity` int(11) NOT NULL,
  `pricePerFood` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food_order`
--

INSERT INTO `food_order` (`id`, `ticketID`, `foodDetails`, `foodQuantity`, `pricePerFood`) VALUES
(502, 'TIC-440277-XAH', 'Pepsi Black (L)', 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `hall`
--

CREATE TABLE `hall` (
  `hall_ID` varchar(255) NOT NULL,
  `hallName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hall`
--

INSERT INTO `hall` (`hall_ID`, `hallName`) VALUES
('A', 'Standard'),
('B', 'Deluxe'),
('C', 'Platinum');

-- --------------------------------------------------------

--
-- Table structure for table `inquiry`
--

CREATE TABLE `inquiry` (
  `inquiryID` varchar(255) NOT NULL,
  `custID` varchar(255) NOT NULL,
  `inquiryCategory` varchar(255) NOT NULL,
  `inquirySubCategory` varchar(255) NOT NULL,
  `inquiryMessage` varchar(255) NOT NULL,
  `inquiryStatus` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `inquiry`
--

INSERT INTO `inquiry` (`inquiryID`, `custID`, `inquiryCategory`, `inquirySubCategory`, `inquiryMessage`, `inquiryStatus`) VALUES
('INQ-943240', 'S59419', 'Profile Update', 'Phone Number', 'Update my phone number', 'Open');

-- --------------------------------------------------------

--
-- Table structure for table `inquiry_record`
--

CREATE TABLE `inquiry_record` (
  `id` int(11) NOT NULL,
  `inquiryID` varchar(255) NOT NULL,
  `userID` varchar(255) NOT NULL,
  `inquiryAnswer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movieID` varchar(255) NOT NULL,
  `movieName` varchar(255) NOT NULL,
  `movieGenre` varchar(255) NOT NULL,
  `movieDate` varchar(255) NOT NULL,
  `movieTime` varchar(255) NOT NULL,
  `movieLanguage` varchar(255) NOT NULL,
  `movieDuration` int(11) NOT NULL,
  `moviePrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movieID`, `movieName`, `movieGenre`, `movieDate`, `movieTime`, `movieLanguage`, `movieDuration`, `moviePrice`) VALUES
('MOV-AVE', 'The Avengers : Infinity War', 'Superhero', '12/07/2022', '10:00', 'English', 3, 25),
('MOV-SPO', 'The Way Back Home', 'Comedy', '16/07/2022', '12:00', 'Bahasa Melayu', 3, 30),
('MOV-STR', 'Dr Strange: Multiverse', 'Magic', '15/07/2022', '08:00', 'English', 3, 15),
('MOV-TTE', 'The Dark Knight', 'Fiction', '24/06/2022', '17:00', 'English', 2, 20),
('MOV-UPI', 'Upin Ipin : Musim 2', 'Comedy', '20/07/2022', '11:00', 'Bahasa Melayu', 2, 20),
('MOV-YBX', 'Forrest Gump', 'Comedy', '23/06/2022', '19:00', 'English', 3, 15);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `paymentID` int(11) NOT NULL,
  `custID` varchar(255) NOT NULL,
  `ticketID` varchar(255) NOT NULL,
  `paymentStatus` varchar(30) NOT NULL,
  `paymentAmount` int(11) NOT NULL,
  `currentBalance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`paymentID`, `custID`, `ticketID`, `paymentStatus`, `paymentAmount`, `currentBalance`) VALUES
(1263, 'S59419', 'TIC-440277-XAH', 'Ticket Payment', 30, 1470);

-- --------------------------------------------------------

--
-- Table structure for table `seat`
--

CREATE TABLE `seat` (
  `seatID` varchar(255) NOT NULL,
  `ticketID` varchar(255) NOT NULL,
  `hall_ID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seat`
--

INSERT INTO `seat` (`seatID`, `ticketID`, `hall_ID`) VALUES
('C12', 'TIC-440277-XAH', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticketID` varchar(255) NOT NULL,
  `movieID` varchar(255) NOT NULL,
  `custID` varchar(10) NOT NULL,
  `ticketDate` varchar(255) NOT NULL,
  `ticketTime` varchar(255) NOT NULL,
  `ticketType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticketID`, `movieID`, `custID`, `ticketDate`, `ticketTime`, `ticketType`) VALUES
('TIC-440277-XAH', 'MOV-AVE', 'S59419', '12/07/2022', '10:00', 'Single');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`custID`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`foodID`),
  ADD UNIQUE KEY `foodDescription` (`foodDescription`);

--
-- Indexes for table `food_order`
--
ALTER TABLE `food_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticketID` (`ticketID`),
  ADD KEY `foodDetails` (`foodDetails`);

--
-- Indexes for table `hall`
--
ALTER TABLE `hall`
  ADD PRIMARY KEY (`hall_ID`);

--
-- Indexes for table `inquiry`
--
ALTER TABLE `inquiry`
  ADD PRIMARY KEY (`inquiryID`),
  ADD KEY `custID` (`custID`);

--
-- Indexes for table `inquiry_record`
--
ALTER TABLE `inquiry_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inquiryID` (`inquiryID`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movieID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`paymentID`),
  ADD KEY `ticketID` (`ticketID`);

--
-- Indexes for table `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`seatID`,`ticketID`),
  ADD KEY `ticketID` (`ticketID`),
  ADD KEY `hall_ID` (`hall_ID`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticketID`),
  ADD KEY `movieID` (`movieID`),
  ADD KEY `custID` (`custID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `foodID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `food_order`
--
ALTER TABLE `food_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=503;

--
-- AUTO_INCREMENT for table `inquiry_record`
--
ALTER TABLE `inquiry_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `paymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1264;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `food_order`
--
ALTER TABLE `food_order`
  ADD CONSTRAINT `food_order_ibfk_1` FOREIGN KEY (`ticketID`) REFERENCES `ticket` (`ticketID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `food_order_ibfk_2` FOREIGN KEY (`foodDetails`) REFERENCES `food` (`foodDescription`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `inquiry`
--
ALTER TABLE `inquiry`
  ADD CONSTRAINT `inquiry_ibfk_2` FOREIGN KEY (`custID`) REFERENCES `customer` (`custID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inquiry_record`
--
ALTER TABLE `inquiry_record`
  ADD CONSTRAINT `inquiry_record_ibfk_1` FOREIGN KEY (`inquiryID`) REFERENCES `inquiry` (`inquiryID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `seat`
--
ALTER TABLE `seat`
  ADD CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`ticketID`) REFERENCES `ticket` (`ticketID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seat_ibfk_2` FOREIGN KEY (`hall_ID`) REFERENCES `hall` (`hall_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`custID`) REFERENCES `customer` (`custID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`movieID`) REFERENCES `movie` (`movieID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
