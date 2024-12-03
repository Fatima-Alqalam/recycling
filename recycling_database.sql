-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 03, 2024 at 08:18 AM
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
-- Database: `recycling`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
                         `id` int NOT NULL,
                         `name` varchar(100) NOT NULL,
                         `email` varchar(100) NOT NULL,
                         `password` varchar(100) NOT NULL,
                         `role` varchar(50) DEFAULT NULL,
                         `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `password`, `role`, `phone`) VALUES
    (1, 'admin4', 'admin@admin.com', '$2y$10$pxn/kPAvjhTN1IhJdi1W7OKWqcKFeqCYw3H0JhQodvbHXujR2f8fy', 'admin', '966569598521');

-- --------------------------------------------------------

--
-- Table structure for table `crafter`
--

CREATE TABLE `crafter` (
                           `id` int NOT NULL,
                           `name` varchar(100) NOT NULL,
                           `email` varchar(100) NOT NULL,
                           `password` varchar(100) NOT NULL,
                           `phone` varchar(20) DEFAULT NULL,
                           `address` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `crafter`
--

INSERT INTO `crafter` (`id`, `name`, `email`, `password`, `phone`, `address`) VALUES
                                                                                  (1, 'Crafter One', 'cr@recy.com', '$2y$10$8Y.NMP0Mra2VW0ixpBMJ9uPNXR9cChKwHggPYYuf9fLKLj0oWl8f6', '966569598522', 'jubial'),
                                                                                  (2, 'Crafter Two', 'fa@gmail.com', '$2y$10$GbfCqpXQYr42VJJ8H8VchecdI5cs2yVWVnlmauhduI8RK8riWNzn.', '966569598528', 'ddddd');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
                            `id` int NOT NULL,
                            `name` varchar(100) NOT NULL,
                            `email` varchar(100) NOT NULL,
                            `password` varchar(100) NOT NULL,
                            `phone` varchar(20) DEFAULT NULL,
                            `address` text,
                            `reward_points` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `name`, `email`, `password`, `phone`, `address`, `reward_points`) VALUES
                                                                                                    (1, 'Fatamah', 'f@customer.com', '$2y$10$kyIlBxyqXNoIRVMdN6Dx5OrZMWB9egiZ/vatEtApDyS466A0XVNPe', '966569598521', 'jubail', 60),
                                                                                                    (2, 'raghad', 'admin@admin11.com', '$2y$10$4TkBh4EYv6FsohYZQdKYYezg.4JYBNk.CDrgwBxTq72xru1YZcZ.K', '966569598467', 'jic', 0),
                                                                                                    (3, 'Debra Cooke', 'syhyhume@mailinator.com', '$2y$10$3Ao/yyiPKqFhSHM2KZqv.udHr8NxT3zNtddxmGd8R4kWFY3biT/eO', '0545454544', 'qwefe', 30),
                                                                                                    (4, 'Norah', 'n@customer.com', '$2y$10$ZNw4lB2Pab3tYH7yo4SpIejwS.uOSZ.iYDJLnSM/vgq7uHW/9LRhm', '0565654333', 'sdfsdf', 30),
                                                                                                    (5, 'Haya', 'miss7heeo0on@gmail.com', '$2y$10$.Td8NJURrG4MmU1kDL2WLePzqXysnSpSCToPpZDQWRcKnVFh8dK0m', '0594561808', 'jubail', 30);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
                         `id` int NOT NULL,
                         `customer_id` int DEFAULT NULL,
                         `crafter_id` int DEFAULT NULL,
                         `order_date` date DEFAULT NULL,
                         `status` varchar(50) DEFAULT NULL,
                         `plactic_amount` int DEFAULT NULL,
                         `points_earned` int DEFAULT '0',
                         `payment_status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `customer_id`, `crafter_id`, `order_date`, `status`, `plactic_amount`, `points_earned`, `payment_status`) VALUES
                                                                                                                                         (1, 2, 1, '2024-09-28', 'delivered', 12, 5, 'paid'),
                                                                                                                                         (2, 2, 1, '2024-10-11', 'shipping', 3, 5, 'paid'),
                                                                                                                                         (16, 1, 1, '2024-11-12', 'pickup', 283, 30, 'not_required'),
                                                                                                                                         (17, 1, 1, '2024-11-12', 'pickup', 0, 30, 'not_required'),
                                                                                                                                         (18, 1, 1, '2024-11-22', 'shipping', 283, 30, 'paid'),
                                                                                                                                         (19, 1, 2, '2024-11-22', 'pickup', 0, 30, 'not_required'),
                                                                                                                                         (20, 1, 2, '2024-11-22', 'shipping', 232, 30, 'paid'),
                                                                                                                                         (21, 1, 1, '2024-11-24', 'pending', 0, 30, 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `order_product`
--

CREATE TABLE `order_product` (
                                 `id` int NOT NULL,
                                 `order_id` int NOT NULL,
                                 `product_id` int NOT NULL,
                                 `quantity` int NOT NULL DEFAULT '1',
                                 `plactic_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `order_product`
--

INSERT INTO `order_product` (`id`, `order_id`, `product_id`, `quantity`, `plactic_amount`) VALUES
                                                                                               (1, 1, 5, 1, '400.00'),
                                                                                               (2, 2, 3, 1, '192.00'),
                                                                                               (6, 16, 1, 1, '283.00'),
                                                                                               (7, 17, 3, 1, '192.00'),
                                                                                               (8, 18, 1, 1, '283.00'),
                                                                                               (9, 19, 2, 1, '230.00'),
                                                                                               (10, 20, 2, 1, '230.00'),
                                                                                               (11, 20, 6, 1, '2.30'),
                                                                                               (12, 21, 3, 1, '192.00');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
                           `id` int NOT NULL,
                           `order_id` int DEFAULT NULL,
                           `amount` decimal(10,2) DEFAULT NULL,
                           `payment_date` date DEFAULT NULL,
                           `payment_method` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `order_id`, `amount`, `payment_date`, `payment_method`) VALUES
    (3, 21, '50.00', '2024-11-24', 'visa_card');

-- --------------------------------------------------------

--
-- Table structure for table `plastic_collection`
--

CREATE TABLE `plastic_collection` (
                                      `id` int NOT NULL,
                                      `customer_id` int DEFAULT NULL,
                                      `quantity` decimal(10,2) DEFAULT NULL,
                                      `collection_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `plastic_collection`
--

INSERT INTO `plastic_collection` (`id`, `customer_id`, `quantity`, `collection_date`) VALUES
                                                                                          (1, 1, '9484.70', '2024-11-24'),
                                                                                          (2, 2, '5000.00', '2024-11-02'),
                                                                                          (3, 3, '0.00', '2024-11-22'),
                                                                                          (4, 4, '30.00', '2024-11-22');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
                           `id` int NOT NULL,
                           `name` varchar(100) NOT NULL,
                           `description` text,
                           `image` varchar(195) DEFAULT NULL,
                           `crafter_id` int DEFAULT NULL,
                           `required_plastic_quantity` decimal(10,2) DEFAULT NULL,
                           `stock_quantity` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `image`, `crafter_id`, `required_plastic_quantity`, `stock_quantity`) VALUES
                                                                                                                              (1, 'Vase', '<div class=\"product-description\"><p>A sleek design, perfect for enhancing home decor.</p><p><strong>Suitable Age:</strong> 18+ due to its fragile nature.</p></div>', 'up/1.jpeg', 1, '283.00', 100),
                                                                                                                              (2, 'Toy Airplane', 'A small recycled plastic airplane designed for young children to enjoy.', 'up/2.jpeg', 2, '230.00', 90),
                                                                                                                              (3, 'Magnet', '<div class=\"product-description\"><p>Set of small, durable magnets ideal for organizing and decorating spaces.</p><p><strong>Suitable Age:</strong> Ages 12+</p></div>* PP type of plastic is widely used because it is flexible and easy to recycle', 'up/3.jpeg', 1, '192.00', 100),
                                                                                                                              (4, 'Robot-building toy', '<div class=\"product-description\"><p>Lets kids create and assemble their own robots, encouraging creativity and problem-solving as they bring their robot ideas to life.</p><p><strong>Suitable Age:</strong> Ages 7+</p></div>', 'up/4.jpeg', 2, '250.00', 11),
                                                                                                                              (5, 'Colourful plastic cup', '<div class=\"product-description\"><p>Come in a variety of designs and sizes, made of lightweight plastic material, perfect for outdoor occasions. Ideal for use at picnics, barbecues, and sporting events.</p><p><strong>Suitable Age:</strong> 18+</p></div>', 'up/5.jpeg', 1, '400.00', 22),
                                                                                                                              (6, 'Dinosaur Toy', 'A fun and friendly dinosaur figurine made from recycled plastic.', 'up/6.jpeg', 2, '2.30', 33),
                                                                                                                              (7, 'Lego Toy', '<div class=\"product-description\"><p>A LEGO toy set includes colorful, interlocking bricks that kids can use to build endless structures, vehicles, and scenes, encouraging creativity and fine motor skills in a fun, hands-on way.</p><p><strong>Suitable Age:</strong> Ages 10+</p></div>', 'up/7.jpeg', 1, '400.00', 55),
                                                                                                                              (8, 'Toy Helicopter', 'A helicopter toy made from recycled plastic, designed for little aviators.', 'up/8.jpeg', 2, '2.70', 66),
                                                                                                                              (9, 'Boy Toy', 'A sturdy toy truck crafted from recycled plastic, ideal for indoor and outdoor play.', 'up/9.jpeg', 1, '3.10', 77),
                                                                                                                              (10, 'Airplane small toy', 'A 10-piece puzzle made from recycled plastic, designed for early learning.', 'up/10.jpeg', 2, '192.00', 88);

-- --------------------------------------------------------

--
-- Table structure for table `product_requirements`
--

CREATE TABLE `product_requirements` (
                                        `id` int NOT NULL,
                                        `product_id` int DEFAULT NULL,
                                        `quantity` int DEFAULT NULL,
                                        `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `product_requirements`
--

INSERT INTO `product_requirements` (`id`, `product_id`, `quantity`, `description`) VALUES
                                                                                       (10, 2, 2, 'Plastic used for the body of the Toy Airplane'),
                                                                                       (11, 2, 1, 'Plastic material used in wings'),
                                                                                       (12, 2, 1, 'Plastic for small components in the Toy Airplane'),
                                                                                       (13, 2, 2, 'Used in the tail of the airplane'),
                                                                                       (14, 2, 3, 'Material used in the propeller'),
                                                                                       (15, 3, 24, 'Bottle of water'),
                                                                                       (20, 4, 1, 'Plastic used in the body of the toy boat'),
                                                                                       (21, 4, 2, 'Material used in the sail of the toy boat'),
                                                                                       (22, 4, 1, 'Plastic for the accessories of the toy boat'),
                                                                                       (23, 4, 2, 'Material used in the hull of the boat'),
                                                                                       (24, 4, 1, 'Plastic used for small components');

-- --------------------------------------------------------

--
-- Table structure for table `revenue`
--

CREATE TABLE `revenue` (
                           `id` int NOT NULL,
                           `crafter_id` int DEFAULT NULL,
                           `system_share` decimal(10,2) DEFAULT NULL,
                           `crafter_share` decimal(10,2) DEFAULT NULL,
                           `total_revenue` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `revenue`
--

INSERT INTO `revenue` (`id`, `crafter_id`, `system_share`, `crafter_share`, `total_revenue`) VALUES
                                                                                                 (1, 2, '5.00', '472.30', '477.30'),
                                                                                                 (2, 1, '9.00', '2010.50', '2019.50');

-- --------------------------------------------------------

--
-- Table structure for table `reward`
--

CREATE TABLE `reward` (
                          `id` int NOT NULL,
                          `customer_id` int DEFAULT NULL,
                          `order_id` int DEFAULT NULL,
                          `reward_points` int DEFAULT NULL,
                          `reward_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `reward`
--

INSERT INTO `reward` (`id`, `customer_id`, `order_id`, `reward_points`, `reward_date`) VALUES
                                                                                           (8, 1, 16, 30, '2024-11-12'),
                                                                                           (9, 1, 17, 30, '2024-11-13'),
                                                                                           (10, 1, 18, 30, '2024-11-22'),
                                                                                           (11, 1, 19, 30, '2024-11-22'),
                                                                                           (12, 1, 20, 30, '2024-11-22'),
                                                                                           (13, 1, 20, 30, '2024-11-22'),
                                                                                           (14, 1, 21, 30, '2024-11-24');

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

CREATE TABLE `shipment` (
                            `id` int NOT NULL,
                            `order_id` int DEFAULT NULL,
                            `shipping_date` date DEFAULT NULL,
                            `delivery_date` date DEFAULT NULL,
                            `delivery_time` varchar(255) DEFAULT '13:00',
                            `shipping_company_id` int DEFAULT NULL,
                            `address` varchar(255) DEFAULT NULL,
                            `phone` varchar(191) DEFAULT NULL,
                            `email` varchar(191) DEFAULT NULL,
                            `shipping_price` double(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `shipment`
--

INSERT INTO `shipment` (`id`, `order_id`, `shipping_date`, `delivery_date`, `delivery_time`, `shipping_company_id`, `address`, `phone`, `email`, `shipping_price`) VALUES
    (4, 21, '2024-11-24', '2024-11-30', '13:00', 2, 'jubail', '966569598521', 'f@customer.com', 50.00);

-- --------------------------------------------------------

--
-- Table structure for table `shipping_company`
--

CREATE TABLE `shipping_company` (
                                    `id` int NOT NULL,
                                    `company_name` varchar(191) NOT NULL,
                                    `phone` varchar(191) DEFAULT NULL,
                                    `address` varchar(191) DEFAULT NULL,
                                    `commercial_register` varchar(191) NOT NULL,
                                    `shipping_price` double(8,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `shipping_company`
--

INSERT INTO `shipping_company` (`id`, `company_name`, `phone`, `address`, `commercial_register`, `shipping_price`) VALUES
                                                                                                                       (1, 'SMSA', '966569598529', 'sddsdzdsa', '434354353', 30.00),
                                                                                                                       (2, 'Aramix', '966569598524', 'sdsdsfds', '4567687600', 50.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `crafter`
--
ALTER TABLE `crafter`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
    ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
    ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `crafter_id` (`crafter_id`);

--
-- Indexes for table `order_product`
--
ALTER TABLE `order_product`
    ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
    ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `plastic_collection`
--
ALTER TABLE `plastic_collection`
    ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
    ADD PRIMARY KEY (`id`),
  ADD KEY `crafter_id` (`crafter_id`);

--
-- Indexes for table `product_requirements`
--
ALTER TABLE `product_requirements`
    ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `revenue`
--
ALTER TABLE `revenue`
    ADD PRIMARY KEY (`id`),
  ADD KEY `crafter_id` (`crafter_id`);

--
-- Indexes for table `reward`
--
ALTER TABLE `reward`
    ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
    ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `shipping_company_id` (`shipping_company_id`);

--
-- Indexes for table `shipping_company`
--
ALTER TABLE `shipping_company`
    ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `crafter`
--
ALTER TABLE `crafter`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `order_product`
--
ALTER TABLE `order_product`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `plastic_collection`
--
ALTER TABLE `plastic_collection`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product_requirements`
--
ALTER TABLE `product_requirements`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `revenue`
--
ALTER TABLE `revenue`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reward`
--
ALTER TABLE `reward`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `shipment`
--
ALTER TABLE `shipment`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shipping_company`
--
ALTER TABLE `shipping_company`
    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order`
--
ALTER TABLE `order`
    ADD CONSTRAINT `order_crafter_fk` FOREIGN KEY (`crafter_id`) REFERENCES `crafter` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `order_customer_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `order_product`
--
ALTER TABLE `order_product`
    ADD CONSTRAINT `order_product_order_fk` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `order_product_product_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
    ADD CONSTRAINT `payment_order_fk` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);

--
-- Constraints for table `plastic_collection`
--
ALTER TABLE `plastic_collection`
    ADD CONSTRAINT `plastic_collection_customer_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
    ADD CONSTRAINT `product_crafter_fk` FOREIGN KEY (`crafter_id`) REFERENCES `crafter` (`id`);

--
-- Constraints for table `product_requirements`
--
ALTER TABLE `product_requirements`
    ADD CONSTRAINT `product_requirements_product_fk` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `revenue`
--
ALTER TABLE `revenue`
    ADD CONSTRAINT `revenue_crafter_fk` FOREIGN KEY (`crafter_id`) REFERENCES `crafter` (`id`);

--
-- Constraints for table `reward`
--
ALTER TABLE `reward`
    ADD CONSTRAINT `reward_customer_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `reward_order_fk` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `shipment`
--
ALTER TABLE `shipment`
    ADD CONSTRAINT `shipment_order_fk` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `shipment_shipping_company_fk` FOREIGN KEY (`shipping_company_id`) REFERENCES `shipping_company` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
