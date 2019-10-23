CREATE TABLE `userProfiles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `bio` varchar(140) DEFAULT NULL,
  `git` varchar(25) DEFAULT NULL,
  `countryId` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;