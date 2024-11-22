-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 22, 2024 at 02:47 PM
-- Server version: 8.0.30
-- PHP Version: 8.2.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recycling2`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminId` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AdminId`, `Name`, `Email`, `Password`, `Role`, `Phone`) VALUES
(1, 'admin4', 'admin@admin.com', '$2y$10$pxn/kPAvjhTN1IhJdi1W7OKWqcKFeqCYw3H0JhQodvbHXujR2f8fy', 'admin', '966569598521');

-- --------------------------------------------------------

--
-- Stand-in structure for view `admins`
-- (See below for the actual view)
--
CREATE TABLE `admins` (
`email` varchar(100)
,`id` int
,`name` varchar(100)
,`password` varchar(100)
,`phone` varchar(20)
,`role` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `crafter`
--

CREATE TABLE `crafter` (
  `CrafterId` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `crafter`
--

INSERT INTO `crafter` (`CrafterId`, `Name`, `Email`, `Password`, `Phone`, `Address`) VALUES
(1, 'Carfter One', 'cr@recy.com', '$2y$10$8Y.NMP0Mra2VW0ixpBMJ9uPNXR9cChKwHggPYYuf9fLKLj0oWl8f6', '966569598522', 'jubial'),
(2, 'Carfter Two', 'fa@gmail.com', '$2y$10$GbfCqpXQYr42VJJ8H8VchecdI5cs2yVWVnlmauhduI8RK8riWNzn.', '966569598528', 'ddddd');

-- --------------------------------------------------------

--
-- Stand-in structure for view `crafters`
-- (See below for the actual view)
--
CREATE TABLE `crafters` (
`address` text
,`email` varchar(100)
,`id` int
,`name` varchar(100)
,`password` varchar(100)
,`phone` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerId` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` text,
  `RewardPoints` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerId`, `Name`, `Email`, `Password`, `Phone`, `Address`, `RewardPoints`) VALUES
(1, 'Fatamah', 'f@customer.com', '$2y$10$kyIlBxyqXNoIRVMdN6Dx5OrZMWB9egiZ/vatEtApDyS466A0XVNPe', '966569598521', 'jubaail', 110),
(2, 'raghad', 'admin@admin11.com', '$2y$10$4TkBh4EYv6FsohYZQdKYYezg.4JYBNk.CDrgwBxTq72xru1YZcZ.K', '966569598467', 'jic', 0),
(3, 'Debra Cooke', 'syhyhume@mailinator.com', '$2y$10$3Ao/yyiPKqFhSHM2KZqv.udHr8NxT3zNtddxmGd8R4kWFY3biT/eO', '0545454544', 'qwefe', 30),
(4, 'Norah', 'n@customer.com', '$2y$10$ZNw4lB2Pab3tYH7yo4SpIejwS.uOSZ.iYDJLnSM/vgq7uHW/9LRhm', '0565654333', 'sdfsdf', 30);

-- --------------------------------------------------------

--
-- Stand-in structure for view `customers`
-- (See below for the actual view)
--
CREATE TABLE `customers` (
`address` text
,`email` varchar(100)
,`id` int
,`name` varchar(100)
,`password` varchar(100)
,`phone` varchar(20)
,`reward_points` int
);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `OrderId` int NOT NULL,
  `CustomerId` int DEFAULT NULL,
  `CrafterId` int DEFAULT NULL,
  `OrderDate` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `PlasticAmount` int DEFAULT NULL,
  `PointsEarned` int DEFAULT '0',
  `PaymentStatus` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`OrderId`, `CustomerId`, `CrafterId`, `OrderDate`, `Status`, `PlasticAmount`, `PointsEarned`, `PaymentStatus`) VALUES
(1, 2, 1, '2024-09-28', 'delivered', 12, 5, 'paid'),
(2, 2, 1, '2024-10-11', 'shipping', 3, 5, 'paid'),
(16, 1, 1, '2024-11-12', 'pickup', 283, 30, 'not_required'),
(17, 1, 1, '2024-11-12', 'pickup', 0, 30, 'not_required'),
(18, 1, 1, '2024-11-22', 'shipping', 283, 30, 'paid'),
(19, 1, 2, '2024-11-22', 'pickup', 0, 30, 'not_required'),
(20, 1, 2, '2024-11-22', 'shipping', 232, 30, 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `orderproduct`
--

CREATE TABLE `orderproduct` (
  `OrderProductId` int NOT NULL,
  `OrderId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  `PlasticAmount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orderproduct`
--

INSERT INTO `orderproduct` (`OrderProductId`, `OrderId`, `ProductId`, `Quantity`, `PlasticAmount`) VALUES
(1, 1, 5, 1, '400.00'),
(2, 2, 3, 1, '192.00'),
(6, 16, 1, 1, '283.00'),
(7, 17, 3, 1, '192.00'),
(8, 18, 1, 1, '283.00'),
(9, 19, 2, 1, '230.00'),
(10, 20, 2, 1, '230.00'),
(11, 20, 6, 1, '2.30');

-- --------------------------------------------------------

--
-- Stand-in structure for view `orders`
-- (See below for the actual view)
--
CREATE TABLE `orders` (
`crafter_id` int
,`customer_id` int
,`id` int
,`order_date` date
,`payment_status` varchar(50)
,`plactic_amount` int
,`points_earned` int
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `order_product`
-- (See below for the actual view)
--
CREATE TABLE `order_product` (
`id` int
,`order_id` int
,`plactic_amount` decimal(10,2)
,`product_id` int
,`quantity` int
);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `PaymentId` int NOT NULL,
  `OrderId` int DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `PaymentDate` date DEFAULT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentId`, `OrderId`, `Amount`, `PaymentDate`, `PaymentMethod`) VALUES
(2, 14, '30.00', '2024-11-12', 'paypal'),
(3, 18, '50.00', '2024-11-22', 'visa_card'),
(4, 20, '30.00', '2024-11-22', 'master_card');

-- --------------------------------------------------------

--
-- Stand-in structure for view `payments`
-- (See below for the actual view)
--
CREATE TABLE `payments` (
`amount` decimal(10,2)
,`id` int
,`order_id` int
,`payment_date` date
,`payment_method` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `plasticcollection`
--

CREATE TABLE `plasticcollection` (
  `PlasticCollectionId` int NOT NULL,
  `CustomerId` int DEFAULT NULL,
  `Quantity` decimal(10,2) DEFAULT NULL,
  `CollectionDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `plasticcollection`
--

INSERT INTO `plasticcollection` (`PlasticCollectionId`, `CustomerId`, `Quantity`, `CollectionDate`) VALUES
(1, 1, '9484.70', '2024-11-22'),
(2, 2, '5000.00', '2024-11-02'),
(3, 3, '0.00', '2024-11-22'),
(4, 4, '30.00', '2024-11-22');

-- --------------------------------------------------------

--
-- Stand-in structure for view `plastic_collection`
-- (See below for the actual view)
--
CREATE TABLE `plastic_collection` (
`collection_date` date
,`customer_id` int
,`id` int
,`quantity` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productId` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Description` text,
  `Image` varchar(195) DEFAULT NULL,
  `CrafterId` int DEFAULT NULL,
  `RequiredPlasticQuantity` decimal(10,2) DEFAULT NULL,
  `StockQuantity` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productId`, `Name`, `Description`, `Image`, `CrafterId`, `RequiredPlasticQuantity`, `StockQuantity`) VALUES
(1, 'Vase', '<div class=\"product-description\">\r\n    <p>A sleek design, perfect for enhancing home decor.</p>\r\n    <p><strong>Suitable Age:</strong> 18+ due to its fragile nature.</p>\r\n</div>', 'up/1.jpeg', 1, '283.00', 100),
(2, 'Toy Airplane', 'A small recycled plastic airplane designed for young children to enjoy.', 'up/2.jpeg', 2, '230.00', 90),
(3, 'Magnet', '<div class=\"product-description\">\n    <p>Set of small, durable magnets ideal for organizing and decorating spaces.</p>\n    <p><strong>Suitable Age:</strong> Ages 12+</p>\n</div>\n* PP type of plastic is widely used because it is flexible and easy to recycle', 'up/3.jpeg', 1, '192.00', 100),
(4, 'Robot-building toy \n', '<div class=\"product-description\">\n    <p>Lets kids create and assemble their own robots, encouraging creativity and problem-solving as they bring their robot ideas to life.</p>\n    <p><strong>Suitable Age:</strong> Ages 7+</p>\n</div>\n', 'up/4.jpeg', 2, '250.00', 11),
(5, 'Colourful plastic cup\n', '<div class=\"product-description\">\n    <p>Come in a variety of designs and sizes, made of lightweight plastic material, perfect for outdoor occasions. Ideal for use at picnics, barbecues, and sporting events.</p>\n    <p><strong>Suitable Age:</strong> 18+</p>\n</div>\n', 'up/5.jpeg', 1, '400.00', 22),
(6, 'Dinosaur Toy', 'A fun and friendly dinosaur figurine made from recycled plastic.', 'up/6.jpeg', 2, '2.30', 33),
(7, 'Lego Toy', '<div class=\"product-description\">\n    <p>A LEGO toy set includes colorful, interlocking bricks that kids can use to build endless structures, vehicles, and scenes, encouraging creativity and fine motor skills in a fun, hands-on way.</p>\n    <p><strong>Suitable Age:</strong> Ages 10+</p>\n</div>\n', 'up/7.jpeg', 1, '400.00', 55),
(8, 'Toy Helicopter', 'A helicopter toy made from recycled plastic, designed for little aviators.', 'up/8.jpeg', 2, '2.70', 66),
(9, 'Boy Toy', 'A sturdy toy truck crafted from recycled plastic, ideal for indoor and outdoor play.', 'up/9.jpeg', 1, '3.10', 77),
(10, 'Airplane small toy\n', 'A 10-piece puzzle made from recycled plastic, designed for early learning.', 'up/10.jpeg', 2, '192.00', 88);

-- --------------------------------------------------------

--
-- Table structure for table `productrequirements`
--

CREATE TABLE `productrequirements` (
  `ProductRequirementsId` int NOT NULL,
  `ProductId` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `productrequirements`
--

INSERT INTO `productrequirements` (`ProductRequirementsId`, `ProductId`, `Quantity`, `Description`) VALUES
(10, 2, 2, 'Plastic used for the body of the Toy Airplane'),
(11, 2, 1, 'Plastic material used in wings'),
(12, 2, 1, 'Plastic for small components in the Toy Airplane'),
(13, 2, 2, 'Used in the tail of the airplane'),
(14, 2, 3, 'Material used in the propeller'),
(15, 3, 24, 'potile of water'),
(20, 4, 1, 'Plastic used in the body of the toy boat'),
(21, 4, 2, 'Material used in the sail of the toy boat'),
(22, 4, 1, 'Plastic for the accessories of the toy boat'),
(23, 4, 2, 'Material used in the hull of the boat'),
(24, 4, 1, 'Plastic used for small components'),
(26, 5, 50, '50 water bottles'),
(30, 6, 2, 'Plastic used for the dinosaur body'),
(31, 6, 1, 'Material used for dinosaur tail'),
(32, 6, 2, 'Plastic for small parts of the toy'),
(33, 6, 3, 'Plastic material used for the feet of the dinosaur'),
(34, 6, 2, 'Plastic used for small accessories'),
(40, 8, 2, 'Plastic used in the helicopter body'),
(41, 8, 2, 'Material used for helicopter blades'),
(42, 8, 2, 'Plastic used for the wheels of the helicopter'),
(43, 8, 1, 'Plastic used for small parts of the toy'),
(44, 8, 3, 'Material used in the tail of the helicopter'),
(45, 9, 3, 'Plastic used in the truck body'),
(46, 9, 2, 'Material used for truck wheels'),
(47, 9, 1, 'Plastic used for the truck accessories'),
(48, 9, 2, 'Plastic used for the truck cabin'),
(49, 9, 3, 'Plastic material used for the bed of the truck'),
(50, 10, 1, 'Plastic used for the puzzle pieces'),
(51, 10, 2, 'Material for small puzzle parts'),
(52, 10, 2, 'Plastic used for the puzzle base'),
(53, 10, 2, 'Plastic used for the puzzle edges'),
(54, 10, 1, 'Material used for special puzzle components'),
(55, 7, 3, 'Plastic used in the robot body'),
(56, 7, 2, 'Material used for the arms of the robot'),
(57, 7, 2, 'Plastic used for the robot head'),
(58, 7, 2, 'Plastic used for the feet of the robot'),
(59, 7, 3, 'Plastic for additional robot accessories'),
(65, 1, 3, 'Plastic material used for the Toy Car body'),
(66, 1, 100, 'Additional component for the Toy Car'),
(67, 1, 80, 'Used in the wheels of the Toy Car'),
(68, 1, 50, 'Plastic used for the body of the Toy Car'),
(69, 1, 50, 'Plastic for small accessories');

-- --------------------------------------------------------

--
-- Stand-in structure for view `products`
-- (See below for the actual view)
--
CREATE TABLE `products` (
`crafter_id` int
,`description` text
,`id` int
,`image` varchar(195)
,`name` varchar(100)
,`required_plastic_quantity` decimal(10,2)
,`stock_quantity` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `product_requirements`
-- (See below for the actual view)
--
CREATE TABLE `product_requirements` (
`description` text
,`id` int
,`product_id` int
,`quantity` int
);

-- --------------------------------------------------------

--
-- Table structure for table `revenue`
--

CREATE TABLE `revenue` (
  `RevenueId` int NOT NULL,
  `CrafterId` int DEFAULT NULL,
  `SystemShare` decimal(10,2) DEFAULT NULL,
  `CrafterShare` decimal(10,2) DEFAULT NULL,
  `TotalRevenue` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `revenue`
--

INSERT INTO `revenue` (`RevenueId`, `CrafterId`, `SystemShare`, `CrafterShare`, `TotalRevenue`) VALUES
(1, 2, '5.00', '472.30', '477.30'),
(2, 1, '8.00', '1819.50', '1827.50');

-- --------------------------------------------------------

--
-- Stand-in structure for view `revenues`
-- (See below for the actual view)
--
CREATE TABLE `revenues` (
`crafter_id` int
,`crafter_share` decimal(10,2)
,`id` int
,`system_share` decimal(10,2)
,`total_revenue` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `reward`
--

CREATE TABLE `reward` (
  `RewardId` int NOT NULL,
  `CustomerId` int DEFAULT NULL,
  `OrderId` int DEFAULT NULL,
  `RewardPoints` int DEFAULT NULL,
  `RewardDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `reward`
--

INSERT INTO `reward` (`RewardId`, `CustomerId`, `OrderId`, `RewardPoints`, `RewardDate`) VALUES
(8, 1, 16, 30, '2024-11-12'),
(9, 1, 17, 30, '2024-11-13'),
(10, 1, 18, 30, '2024-11-22'),
(11, 1, 19, 30, '2024-11-22'),
(12, 1, 20, 30, '2024-11-22'),
(13, 1, 20, 30, '2024-11-22');

-- --------------------------------------------------------

--
-- Stand-in structure for view `rewards`
-- (See below for the actual view)
--
CREATE TABLE `rewards` (
`customer_id` int
,`id` int
,`order_id` int
,`reward_date` date
,`reward_points` int
);

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

CREATE TABLE `shipment` (
  `ShipmentId` int NOT NULL,
  `OrderId` int DEFAULT NULL,
  `ShippingDate` date DEFAULT NULL,
  `DeliveryDate` date DEFAULT NULL,
  `DeliveryTime` varchar(255) DEFAULT '13:00',
  `ShippingCompanyId` int DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(191) DEFAULT NULL,
  `Email` varchar(191) DEFAULT NULL,
  `ShippingPrice` double(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `shipment`
--

INSERT INTO `shipment` (`ShipmentId`, `OrderId`, `ShippingDate`, `DeliveryDate`, `DeliveryTime`, `ShippingCompanyId`, `Address`, `Phone`, `Email`, `ShippingPrice`) VALUES
(1, 1, '2024-09-28', '2024-09-28', '13:00', 1, 'jubail', NULL, NULL, 50.00),
(2, 2, '2024-10-11', '2024-10-31', '13:00', 2, 'jubail', '966569598467', 'admin@admin11.com', 50.00),
(3, 3, '2024-10-12', '2024-10-31', '13:00', 1, 'jubaail', '966569598521', 'f@customer.com', 30.00),
(5, 14, '2024-11-12', '2024-11-30', '13:00', 1, 'jubaail', '966569598521', 'f@customer.com', 30.00),
(6, 18, '2024-11-22', '2024-11-30', '13:00', 2, 'jubaail', '966569598521', 'f@customer.com', 50.00),
(7, 20, '2024-11-22', '2024-11-30', '13:00', 1, 'jubaail', '966569598521', 'f@customer.com', 30.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `shipments`
-- (See below for the actual view)
--
CREATE TABLE `shipments` (
`address` varchar(255)
,`delivery_date` date
,`delivery_time` varchar(255)
,`email` varchar(191)
,`id` int
,`order_id` int
,`phone` varchar(191)
,`shipping_company_id` int
,`shipping_date` date
,`shipping_price` double(8,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `shippingcompany`
--

CREATE TABLE `shippingcompany` (
  `ShippingCompanyId` int NOT NULL,
  `CompanyName` varchar(191) NOT NULL,
  `Phone` varchar(191) DEFAULT NULL,
  `Address` varchar(191) DEFAULT NULL,
  `CommercialRegister` varchar(191) NOT NULL,
  `ShippingPrice` double(8,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `shippingcompany`
--

INSERT INTO `shippingcompany` (`ShippingCompanyId`, `CompanyName`, `Phone`, `Address`, `CommercialRegister`, `ShippingPrice`) VALUES
(1, 'SMSA', '966569598529', 'sddsdzdsa', '434354353', 30.00),
(2, 'Aramix', '966569598524', 'sdsdsfds', '4567687600', 50.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `shipping_company`
-- (See below for the actual view)
--
CREATE TABLE `shipping_company` (
`address` varchar(191)
,`commercial_register` varchar(191)
,`company_name` varchar(191)
,`id` int
,`phone` varchar(191)
,`shipping_price` double(8,2)
);

-- --------------------------------------------------------

--
-- Structure for view `admins`
--
DROP TABLE IF EXISTS `admins`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `admins`  AS SELECT `admin`.`AdminId` AS `id`, `admin`.`Name` AS `name`, `admin`.`Email` AS `email`, `admin`.`Password` AS `password`, `admin`.`Role` AS `role`, `admin`.`Phone` AS `phone` FROM `admin``admin`  ;

-- --------------------------------------------------------

--
-- Structure for view `crafters`
--
DROP TABLE IF EXISTS `crafters`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `crafters`  AS SELECT `crafter`.`CrafterId` AS `id`, `crafter`.`Name` AS `name`, `crafter`.`Email` AS `email`, `crafter`.`Password` AS `password`, `crafter`.`Phone` AS `phone`, `crafter`.`Address` AS `address` FROM `crafter``crafter`  ;

-- --------------------------------------------------------

--
-- Structure for view `customers`
--
DROP TABLE IF EXISTS `customers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customers`  AS SELECT `customer`.`CustomerId` AS `id`, `customer`.`Name` AS `name`, `customer`.`Email` AS `email`, `customer`.`Password` AS `password`, `customer`.`Phone` AS `phone`, `customer`.`Address` AS `address`, `customer`.`RewardPoints` AS `reward_points` FROM `customer``customer`  ;

-- --------------------------------------------------------

--
-- Structure for view `orders`
--
DROP TABLE IF EXISTS `orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `orders`  AS SELECT `order`.`OrderId` AS `id`, `order`.`CustomerId` AS `customer_id`, `order`.`CrafterId` AS `crafter_id`, `order`.`OrderDate` AS `order_date`, `order`.`Status` AS `status`, `order`.`PlasticAmount` AS `plactic_amount`, `order`.`PointsEarned` AS `points_earned`, `order`.`PaymentStatus` AS `payment_status` FROM `order``order`  ;

-- --------------------------------------------------------

--
-- Structure for view `order_product`
--
DROP TABLE IF EXISTS `order_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_product`  AS SELECT `orderproduct`.`OrderProductId` AS `id`, `orderproduct`.`OrderId` AS `order_id`, `orderproduct`.`ProductId` AS `product_id`, `orderproduct`.`Quantity` AS `quantity`, `orderproduct`.`PlasticAmount` AS `plactic_amount` FROM `orderproduct``orderproduct`  ;

-- --------------------------------------------------------

--
-- Structure for view `payments`
--
DROP TABLE IF EXISTS `payments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `payments`  AS SELECT `payment`.`PaymentId` AS `id`, `payment`.`OrderId` AS `order_id`, `payment`.`Amount` AS `amount`, `payment`.`PaymentDate` AS `payment_date`, `payment`.`PaymentMethod` AS `payment_method` FROM `payment``payment`  ;

-- --------------------------------------------------------

--
-- Structure for view `plastic_collection`
--
DROP TABLE IF EXISTS `plastic_collection`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plastic_collection`  AS SELECT `plasticcollection`.`PlasticCollectionId` AS `id`, `plasticcollection`.`CustomerId` AS `customer_id`, `plasticcollection`.`Quantity` AS `quantity`, `plasticcollection`.`CollectionDate` AS `collection_date` FROM `plasticcollection``plasticcollection`  ;

-- --------------------------------------------------------

--
-- Structure for view `products`
--
DROP TABLE IF EXISTS `products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `products`  AS SELECT `product`.`productId` AS `id`, `product`.`Name` AS `name`, `product`.`Description` AS `description`, `product`.`Image` AS `image`, `product`.`CrafterId` AS `crafter_id`, `product`.`RequiredPlasticQuantity` AS `required_plastic_quantity`, `product`.`StockQuantity` AS `stock_quantity` FROM `product``product`  ;

-- --------------------------------------------------------

--
-- Structure for view `product_requirements`
--
DROP TABLE IF EXISTS `product_requirements`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_requirements`  AS SELECT `productrequirements`.`ProductRequirementsId` AS `id`, `productrequirements`.`ProductId` AS `product_id`, `productrequirements`.`Quantity` AS `quantity`, `productrequirements`.`Description` AS `description` FROM `productrequirements``productrequirements`  ;

-- --------------------------------------------------------

--
-- Structure for view `revenues`
--
DROP TABLE IF EXISTS `revenues`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `revenues`  AS SELECT `revenue`.`RevenueId` AS `id`, `revenue`.`CrafterId` AS `crafter_id`, `revenue`.`SystemShare` AS `system_share`, `revenue`.`CrafterShare` AS `crafter_share`, `revenue`.`TotalRevenue` AS `total_revenue` FROM `revenue``revenue`  ;

-- --------------------------------------------------------

--
-- Structure for view `rewards`
--
DROP TABLE IF EXISTS `rewards`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rewards`  AS SELECT `reward`.`RewardId` AS `id`, `reward`.`CustomerId` AS `customer_id`, `reward`.`OrderId` AS `order_id`, `reward`.`RewardPoints` AS `reward_points`, `reward`.`RewardDate` AS `reward_date` FROM `reward``reward`  ;

-- --------------------------------------------------------

--
-- Structure for view `shipments`
--
DROP TABLE IF EXISTS `shipments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shipments`  AS SELECT `shipment`.`ShipmentId` AS `id`, `shipment`.`OrderId` AS `order_id`, `shipment`.`ShippingDate` AS `shipping_date`, `shipment`.`DeliveryDate` AS `delivery_date`, `shipment`.`DeliveryTime` AS `delivery_time`, `shipment`.`ShippingCompanyId` AS `shipping_company_id`, `shipment`.`Address` AS `address`, `shipment`.`Phone` AS `phone`, `shipment`.`Email` AS `email`, `shipment`.`ShippingPrice` AS `shipping_price` FROM `shipment``shipment`  ;

-- --------------------------------------------------------

--
-- Structure for view `shipping_company`
--
DROP TABLE IF EXISTS `shipping_company`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shipping_company`  AS SELECT `shippingcompany`.`ShippingCompanyId` AS `id`, `shippingcompany`.`CompanyName` AS `company_name`, `shippingcompany`.`Phone` AS `phone`, `shippingcompany`.`Address` AS `address`, `shippingcompany`.`CommercialRegister` AS `commercial_register`, `shippingcompany`.`ShippingPrice` AS `shipping_price` FROM `shippingcompany``shippingcompany`  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminId`),
  ADD UNIQUE KEY `email` (`Email`);

--
-- Indexes for table `crafter`
--
ALTER TABLE `crafter`
  ADD PRIMARY KEY (`CrafterId`),
  ADD UNIQUE KEY `email` (`Email`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerId`),
  ADD UNIQUE KEY `email` (`Email`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`OrderId`),
  ADD KEY `customer_id` (`CustomerId`),
  ADD KEY `order_ibfk_222` (`CrafterId`);

--
-- Indexes for table `orderproduct`
--
ALTER TABLE `orderproduct`
  ADD PRIMARY KEY (`OrderProductId`),
  ADD KEY `order_ibfk_234` (`OrderId`),
  ADD KEY `order_ibfk_2343434` (`ProductId`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentId`),
  ADD KEY `order_id` (`OrderId`);

--
-- Indexes for table `plasticcollection`
--
ALTER TABLE `plasticcollection`
  ADD PRIMARY KEY (`PlasticCollectionId`),
  ADD KEY `customer_id` (`CustomerId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `crafter_id` (`CrafterId`);

--
-- Indexes for table `productrequirements`
--
ALTER TABLE `productrequirements`
  ADD PRIMARY KEY (`ProductRequirementsId`),
  ADD KEY `fk_product_id` (`ProductId`);

--
-- Indexes for table `revenue`
--
ALTER TABLE `revenue`
  ADD PRIMARY KEY (`RevenueId`),
  ADD KEY `crafter_id` (`CrafterId`);

--
-- Indexes for table `reward`
--
ALTER TABLE `reward`
  ADD PRIMARY KEY (`RewardId`),
  ADD KEY `customer_id` (`CustomerId`),
  ADD KEY `reward_ibfk_1234` (`OrderId`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`ShipmentId`),
  ADD KEY `order_id` (`OrderId`),
  ADD KEY `fk_shipping_company_id` (`ShippingCompanyId`);

--
-- Indexes for table `shippingcompany`
--
ALTER TABLE `shippingcompany`
  ADD PRIMARY KEY (`ShippingCompanyId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `crafter`
--
ALTER TABLE `crafter`
  MODIFY `CrafterId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `OrderId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `orderproduct`
--
ALTER TABLE `orderproduct`
  MODIFY `OrderProductId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `PaymentId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `plasticcollection`
--
ALTER TABLE `plasticcollection`
  MODIFY `PlasticCollectionId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `productrequirements`
--
ALTER TABLE `productrequirements`
  MODIFY `ProductRequirementsId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `revenue`
--
ALTER TABLE `revenue`
  MODIFY `RevenueId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reward`
--
ALTER TABLE `reward`
  MODIFY `RewardId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `shipment`
--
ALTER TABLE `shipment`
  MODIFY `ShipmentId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `shippingcompany`
--
ALTER TABLE `shippingcompany`
  MODIFY `ShippingCompanyId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`),
  ADD CONSTRAINT `order_ibfk_222` FOREIGN KEY (`CrafterId`) REFERENCES `crafter` (`CrafterId`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `orderproduct`
--
ALTER TABLE `orderproduct`
  ADD CONSTRAINT `order_ibfk_234` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `order_ibfk_2343434` FOREIGN KEY (`ProductId`) REFERENCES `product` (`productId`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`);

--
-- Constraints for table `plasticcollection`
--
ALTER TABLE `plasticcollection`
  ADD CONSTRAINT `plasticcollection_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`CrafterId`) REFERENCES `crafter` (`CrafterId`);

--
-- Constraints for table `productrequirements`
--
ALTER TABLE `productrequirements`
  ADD CONSTRAINT `fk_product_id` FOREIGN KEY (`ProductId`) REFERENCES `product` (`productId`);

--
-- Constraints for table `revenue`
--
ALTER TABLE `revenue`
  ADD CONSTRAINT `revenue_ibfk_1` FOREIGN KEY (`CrafterId`) REFERENCES `crafter` (`CrafterId`);

--
-- Constraints for table `reward`
--
ALTER TABLE `reward`
  ADD CONSTRAINT `reward_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`),
  ADD CONSTRAINT `reward_ibfk_1234` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `shipment`
--
ALTER TABLE `shipment`
  ADD CONSTRAINT `fk_shipping_company_id` FOREIGN KEY (`ShippingCompanyId`) REFERENCES `shippingcompany` (`ShippingCompanyId`),
  ADD CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `order` (`OrderId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
