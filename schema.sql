CREATE TABLE `user` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `alias` varchar(50) UNIQUE NOT NULL,
  `hash_password` varchar(100) NOT NULL,
  `verify_token` varchar(50),
  `discord_id` varchar(50),
  `discord_username` varchar(50),
  `github_username` varchar(50),
  `job_title` varchar(50),
  `job_company` varchar(50),
  `access_token` varchar(50),
  `access_token_expire_on` bigint,
  `email` varchar(100) UNIQUE NOT NULL,
  `avatar_link` varchar(100),
  `disabled` boolean NOT NULL DEFAULT 0,
  `role_id` bigint,
  `biography` varchar(255),
  `country_id` bigint,
  `join_date` bigint NOT NULL
);

CREATE TABLE `user_award` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `code` varchar(100) UNIQUE NOT NULL COMMENT 'Machine friendly name',
  `description` varchar(255) NOT NULL,
  `label` varchar(50) NOT NULL COMMENT 'Pretty name label'
);

CREATE TABLE `user_to_user_award` (
  `user_id` bigint NOT NULL,
  `user_award_id` bigint NOT NULL
);

CREATE TABLE `role` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `code` varchar(20) UNIQUE NOT NULL COMMENT 'Machine friendly name',
  `label` varchar(20) NOT NULL COMMENT 'Pretty name label'
);

CREATE TABLE `permission` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `code` varchar(20) UNIQUE NOT NULL COMMENT 'Machine friendly name',
  `label` varchar(20) NOT NULL COMMENT 'Pretty name label'
);

CREATE TABLE `role_to_permission` (
  `role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL
);

CREATE TABLE `user_to_permission` (
  `user_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL
);

CREATE TABLE `country` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `code` varchar(2) UNIQUE NOT NULL COMMENT 'Machine friendly name',
  `label` varchar(50) NOT NULL COMMENT 'Pretty name label'
);

CREATE TABLE `tag_set` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE `tag` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `label` varchar(50) UNIQUE NOT NULL
);

CREATE TABLE `tag_set_to_tag` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `tag_id` bigint NOT NULL,
  `tag_set_id` bigint NOT NULL
);

CREATE TABLE `article_revision` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `description` varchar(255) NOT NULL,
  `content` blob NOT NULL,
  `tag_set_id` bigint NOT NULL,
  `created_by` bigint NOT NULL,
  `created_on` bigint NOT NULL
);

CREATE TABLE `article` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `revision_id` bigint,
  `title` varchar(50) UNIQUE NOT NULL,
  `created_by` bigint NOT NULL,
  `created_on` bigint NOT NULL,
  `updated_by` bigint NOT NULL,
  `updated_on` bigint NOT NULL
);

CREATE TABLE `image_reference` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `revision_id` bigint NOT NULL,
  `image_name` varchar(30) UNIQUE NOT NULL
);

CREATE TABLE `showcase` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `approved` boolean NOT NULL DEFAULT 0,
  `tag_set_id` bigint NOT NULL,
  `contributor_list_id` bigint NOT NULL,
  `created_by` bigint,
  `created_on` bigint,
  `updated_by` bigint,
  `updated_on` bigint
);

CREATE TABLE `contributor` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `alias` varchar(50) COMMENT 'Either alias or user_id is supplied',
  `user_id` bigint COMMENT 'Either alias or user_id is supplied',
  `contributor_list_id` bigint
);

CREATE TABLE `contributor_list` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT
);

ALTER TABLE `user` ADD FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

ALTER TABLE `user_to_user_award` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_to_user_award` ADD FOREIGN KEY (`user_award_id`) REFERENCES `user_award` (`id`);

ALTER TABLE `user_to_permission` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `user_to_permission` ADD FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`);

ALTER TABLE `role_to_permission` ADD FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

ALTER TABLE `role_to_permission` ADD FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`);

ALTER TABLE `user` ADD FOREIGN KEY (`country_id`) REFERENCES `country` (`id`);

ALTER TABLE `tag_set_to_tag` ADD FOREIGN KEY (`tag_set_id`) REFERENCES `tag_set` (`id`);

ALTER TABLE `tag_set_to_tag` ADD FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`);

ALTER TABLE `article` ADD FOREIGN KEY (`revision_id`) REFERENCES `article_revision` (`id`);

ALTER TABLE `article` ADD FOREIGN KEY (`created_by`) REFERENCES `user` (`id`);

ALTER TABLE `article` ADD FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`);

ALTER TABLE `article_revision` ADD FOREIGN KEY (`article_id`) REFERENCES `article` (`id`);

ALTER TABLE `article_revision` ADD FOREIGN KEY (`tag_set_id`) REFERENCES `tag_set` (`id`);

ALTER TABLE `article_revision` ADD FOREIGN KEY (`created_by`) REFERENCES `user` (`id`);

ALTER TABLE `image_reference` ADD FOREIGN KEY (`revision_id`) REFERENCES `article_revision` (`id`);

ALTER TABLE `showcase` ADD FOREIGN KEY (`created_by`) REFERENCES `user` (`id`);

ALTER TABLE `showcase` ADD FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`);

ALTER TABLE `showcase` ADD FOREIGN KEY (`tag_set_id`) REFERENCES `tag_set` (`id`);

ALTER TABLE `showcase` ADD FOREIGN KEY (`contributor_list_id`) REFERENCES `contributor_list` (`id`);

ALTER TABLE `contributor` ADD FOREIGN KEY (`contributor_list_id`) REFERENCES `contributor_list` (`id`);

ALTER TABLE `contributor` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
