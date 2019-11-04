CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `discordId` bigint(11) DEFAULT NULL,
  `firebaseId` varchar(30) DEFAULT NULL,
  `alias` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;