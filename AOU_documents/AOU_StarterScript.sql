DROP DATABASE  IF EXISTS `aou_project_schema`;

CREATE DATABASE  IF NOT EXISTS `aou_project_schema`;
USE `aou_project_schema`;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `bulk_order`;
CREATE TABLE `bulk_order` (
  `idbulk_order` int(11) NOT NULL AUTO_INCREMENT,
  `event_date` date NOT NULL,
  `bulkorder_desc` varchar(250) DEFAULT NULL,
  `bulk_order_cost` double NOT NULL,
  `bulkorder_status` varchar(45) DEFAULT NULL,
  `offer_code` varchar(45) DEFAULT NULL,
  `offer_desc` varchar(200) DEFAULT NULL,
  `offer_expiry` date DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`idbulk_order`),
  KEY `fk_bo_user_idx` (`user_id`),
  CONSTRAINT `fk_bo_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`idusers`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Container to store bulk order request details';

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `iditems` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(45) NOT NULL,
  `item_description` varchar(200) DEFAULT NULL,
  `item_price` double NOT NULL,
  `item_pic` longblob,
  `vendor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`iditems`),
  KEY `fk_item_vendor_idx` (`vendor_id`),
  CONSTRAINT `fk_item_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`idusers`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Container for items available with vendors';

DROP TABLE IF EXISTS `offers`;
CREATE TABLE `offers` (
  `idoffers` int(11) NOT NULL AUTO_INCREMENT,
  `offer_code` varchar(45) NOT NULL,
  `offer_desc` varchar(200) NOT NULL,
  `offer_expiry` date NOT NULL,
  `bulko_id` int(11) NOT NULL,
  PRIMARY KEY (`idoffers`),
  KEY `fk_bulk_offer_idx` (`bulko_id`),
  CONSTRAINT `fk_bulk_offer` FOREIGN KEY (`bulko_id`) REFERENCES `bulk_order` (`idbulk_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Container to store the offers provided to user';

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `idorders` int(11) NOT NULL AUTO_INCREMENT,
  `order_quantity` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `bulko_id` int(11) NOT NULL,
  PRIMARY KEY (`idorders`),
  KEY `fk_order_item_idx` (`item_id`),
  KEY `fk_bulko_order_idx` (`bulko_id`),
  CONSTRAINT `fk_bulko_order` FOREIGN KEY (`bulko_id`) REFERENCES `bulk_order` (`idbulk_order`),
  CONSTRAINT `fk_order_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`iditems`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Container for all orders';

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `idroles` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) NOT NULL,
  PRIMARY KEY (`idroles`),
  UNIQUE KEY `role_name_UNIQUE` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Container for all the roles supported by the application';

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `idusers` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `password` varchar(80) NOT NULL,
  `email` varchar(45) NOT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `vendor_category` varchar(45) DEFAULT NULL,
  `user_dp` longblob,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  KEY `fk_user_role_idx` (`role_id`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`idroles`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Container for all the users';
INSERT INTO `aou_project_schema`.`roles` (`idroles`, `role_name`) VALUES ('1', 'ROLE_ADMIN');
INSERT INTO `aou_project_schema`.`roles` (`idroles`, `role_name`) VALUES ('2', 'ROLE_USER');
INSERT INTO `aou_project_schema`.`roles` (`idroles`, `role_name`) VALUES ('3', 'ROLE_VENDOR');
-- BCRYPT ENCODED PASSWORD FOR Admin@123  --
INSERT INTO `aou_project_schema`.`users` (`idusers`, `user_name`, `password`, `email`, `zipcode`, `role_id`) VALUES ('1', 'Admin', '$2a$04$JJZwGIJWgNZQoF2LenSBoOz/kDTSUZX6l5X3i.t9ki0UjBVn5WmjW', 'admin@gmail.com', '02115', 1);
SET FOREIGN_KEY_CHECKS = 1;