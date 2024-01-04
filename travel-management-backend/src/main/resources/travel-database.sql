-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 04, 2024 at 02:46 PM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travel`
--

-- --------------------------------------------------------

--
-- Table structure for table `demande`
--

CREATE TABLE `demande` (
  `id` int(11) NOT NULL,
  `date_debut` datetime(6) DEFAULT NULL,
  `date_fin` datetime(6) DEFAULT NULL,
  `etat` varchar(255) DEFAULT NULL,
  `frais` float NOT NULL,
  `motif` text,
  `moyen_transport` varchar(255) DEFAULT NULL,
  `ville` varchar(255) DEFAULT NULL,
  `demandeur_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `demande`
--

INSERT INTO `demande` (`id`, `date_debut`, `date_fin`, `etat`, `frais`, `motif`, `moyen_transport`, `ville`, `demandeur_id`) VALUES
(1, '2024-01-05 01:00:00.000000', '2024-01-10 01:00:00.000000', 'en cours de traitement', 400, 'Text messaging, or texting, is the act of composing and sending electronic messages, typically consisting of alphabetic and numeric characters', 'voiture', 'Marrakech', 2),
(2, '2024-01-11 01:00:00.000000', '2024-01-20 01:00:00.000000', 'en cours de traitement', 340, 'Text.app is a simple text editor for Chrome OS and Chrome. It\'s fast, lets you open multiple files at once, has syntax highlighting', 'Voiture personnel', 'Casablanca', 2);

-- --------------------------------------------------------

--
-- Table structure for table `demandeur`
--

CREATE TABLE `demandeur` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `id` int(11) NOT NULL,
  `expired` bit(1) NOT NULL,
  `revoked` bit(1) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_type` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`id`, `expired`, `revoked`, `token`, `token_type`, `user_id`) VALUES
(1, b'1', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkZXYuZWxtb3VkZW5lQGdtYWlsLmNvbSIsImlhdCI6MTcwMzc3OTYzNCwiZXhwIjoxNzAzODY2MDM0fQ.A4iHY80RwwxTDpMAQVjL6Goj-vdGIhyF316jrgy8lyw', 'Bearer', 2),
(2, b'1', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWRyQGdtYWlsLmNvbSIsImlhdCI6MTcwMzc4MTM2NCwiZXhwIjoxNzAzODY3NzY0fQ.7twpHj_6VoXhJjBCohBqAyUrAeVCzbg4SmxrmdumO_A', 'Bearer', 3);

-- --------------------------------------------------------

--
-- Table structure for table `token_seq`
--

CREATE TABLE `token_seq` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `token_seq`
--

INSERT INTO `token_seq` (`next_val`) VALUES
(101);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_type` varchar(31) NOT NULL,
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_type`, `id`, `email`, `first_name`, `last_name`, `password`, `role`, `tel`, `username`) VALUES
('', 1, 'admin@gmail.com', 'admin', 'admin', '12345', 'ADMIN', '0605120314', 'admin@gmail.com'),
('User', 2, 'dev.elmoudene@gmail.com', 'Youssef', 'EL MOUDENE', '12345', 'Demandeur', '+212605120314', 'dev.elmoudene@gmail.com'),
('User', 3, 'badr@gmail.com', 'badr', 'hammou', '12345', 'Demandeur', '', 'badr@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `demande`
--
ALTER TABLE `demande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKr287jrjaiqgbnqnsfx4od3fr` (`demandeur_id`);

--
-- Indexes for table `demandeur`
--
ALTER TABLE `demandeur`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_pddrhgwxnms2aceeku9s2ewy5` (`token`),
  ADD KEY `FKj8rfw4x0wjjyibfqq566j4qng` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `demande`
--
ALTER TABLE `demande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `demande`
--
ALTER TABLE `demande`
  ADD CONSTRAINT `FKr287jrjaiqgbnqnsfx4od3fr` FOREIGN KEY (`demandeur_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `demandeur`
--
ALTER TABLE `demandeur`
  ADD CONSTRAINT `FK21rjum49r1qg6l6gwvxot79ke` FOREIGN KEY (`id`) REFERENCES `users` (`id`);

--
-- Constraints for table `manager`
--
ALTER TABLE `manager`
  ADD CONSTRAINT `FKmqwhyh7lyvaoxegkx6nwj5u43` FOREIGN KEY (`id`) REFERENCES `users` (`id`);

--
-- Constraints for table `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `FKj8rfw4x0wjjyibfqq566j4qng` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
