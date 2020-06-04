/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 10.4.11-MariaDB : Database - django_project
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`django_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `django_project`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add records',1,'add_records'),
(2,'Can change records',1,'change_records'),
(3,'Can delete records',1,'delete_records'),
(4,'Can view records',1,'view_records'),
(5,'Can add log entry',2,'add_logentry'),
(6,'Can change log entry',2,'change_logentry'),
(7,'Can delete log entry',2,'delete_logentry'),
(8,'Can view log entry',2,'view_logentry'),
(9,'Can add permission',3,'add_permission'),
(10,'Can change permission',3,'change_permission'),
(11,'Can delete permission',3,'delete_permission'),
(12,'Can view permission',3,'view_permission'),
(13,'Can add group',4,'add_group'),
(14,'Can change group',4,'change_group'),
(15,'Can delete group',4,'delete_group'),
(16,'Can view group',4,'view_group'),
(17,'Can add user',5,'add_user'),
(18,'Can change user',5,'change_user'),
(19,'Can delete user',5,'delete_user'),
(20,'Can view user',5,'view_user'),
(21,'Can add content type',6,'add_contenttype'),
(22,'Can change content type',6,'change_contenttype'),
(23,'Can delete content type',6,'delete_contenttype'),
(24,'Can view content type',6,'view_contenttype'),
(25,'Can add session',7,'add_session'),
(26,'Can change session',7,'change_session'),
(27,'Can delete session',7,'delete_session'),
(28,'Can view session',7,'view_session'),
(29,'Can add records',8,'add_records'),
(30,'Can change records',8,'change_records'),
(31,'Can delete records',8,'delete_records'),
(32,'Can view records',8,'view_records');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$180000$M17MbqBjK652$iSjyEhVsaKYEnkWFzWwUxg9m9OJYeQV7wPGgfWvqsJI=','2020-06-02 14:49:43.326136',1,'luka','','','',1,1,'2020-04-08 08:42:34.580666');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values 
(1,'2020-04-08 21:02:06.864521','1','Luka',1,'[{\"added\": {}}]',1,1),
(2,'2020-05-05 18:11:58.297714','23','Proba',1,'[{\"added\": {}}]',1,1),
(3,'2020-05-05 18:19:27.582139','23','Proba',3,'',1,1),
(4,'2020-05-10 09:18:02.255532','2','Matija',1,'[{\"added\": {}}]',1,1),
(5,'2020-05-10 09:38:31.003012','3','Biljana',1,'[{\"added\": {}}]',1,1),
(6,'2020-05-10 09:46:47.643072','3','Biljana',3,'',1,1),
(7,'2020-05-13 12:11:48.316643','1','Luka',1,'[{\"added\": {}}]',8,1),
(8,'2020-05-22 12:33:25.804246','4','Nikola',1,'[{\"added\": {}}]',8,1),
(9,'2020-06-02 14:52:26.762097','432','Ljubica',1,'[{\"added\": {}}]',8,1),
(10,'2020-06-02 21:33:10.654042','1','Luka',3,'',8,1),
(11,'2020-06-02 21:33:45.398207','1','Luka',1,'[{\"added\": {}}]',8,1),
(12,'2020-06-02 21:34:11.383886','432','Ljubica',2,'[{\"changed\": {\"fields\": [\"Last name\", \"Bio\"]}}]',8,1),
(13,'2020-06-02 21:34:34.933618','4','Nikola',2,'[{\"changed\": {\"fields\": [\"Last name\", \"Residence\", \"Bio\"]}}]',8,1),
(14,'2020-06-02 21:34:40.998939','432','Ljubica',2,'[{\"changed\": {\"fields\": [\"Bio\"]}}]',8,1),
(15,'2020-06-02 21:34:46.086396','1','Luka',2,'[]',8,1),
(16,'2020-06-03 10:12:10.427129','123','Nataša',1,'[{\"added\": {}}]',8,1);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(2,'admin','logentry'),
(4,'auth','group'),
(3,'auth','permission'),
(5,'auth','user'),
(6,'contenttypes','contenttype'),
(8,'face_recognition','records'),
(1,'records','records'),
(7,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2020-04-07 21:28:03.834786'),
(2,'auth','0001_initial','2020-04-07 21:28:04.170832'),
(3,'admin','0001_initial','2020-04-07 21:28:05.174479'),
(4,'admin','0002_logentry_remove_auto_add','2020-04-07 21:28:05.358080'),
(5,'admin','0003_logentry_add_action_flag_choices','2020-04-07 21:28:05.368037'),
(6,'contenttypes','0002_remove_content_type_name','2020-04-07 21:28:05.485446'),
(7,'auth','0002_alter_permission_name_max_length','2020-04-07 21:28:05.574269'),
(8,'auth','0003_alter_user_email_max_length','2020-04-07 21:28:05.603180'),
(9,'auth','0004_alter_user_username_opts','2020-04-07 21:28:05.616146'),
(10,'auth','0005_alter_user_last_login_null','2020-04-07 21:28:05.706981'),
(11,'auth','0006_require_contenttypes_0002','2020-04-07 21:28:05.712000'),
(12,'auth','0007_alter_validators_add_error_messages','2020-04-07 21:28:05.719941'),
(13,'auth','0008_alter_user_username_max_length','2020-04-07 21:28:05.749901'),
(14,'auth','0009_alter_user_last_name_max_length','2020-04-07 21:28:05.777821'),
(15,'auth','0010_alter_group_name_max_length','2020-04-07 21:28:05.818677'),
(16,'auth','0011_update_proxy_permissions','2020-04-07 21:28:05.835668'),
(17,'records','0001_initial','2020-04-07 21:28:05.893473'),
(18,'sessions','0001_initial','2020-04-07 21:28:05.932365'),
(19,'records','0002_auto_20200407_2328','2020-04-07 21:28:29.930100'),
(20,'face_recognition','0001_initial','2020-05-13 12:07:09.018754'),
(21,'face_recognition','0002_auto_20200407_2328','2020-05-13 12:07:09.024721');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('17b4twra5sfiio966drknbtq5su2ayjd','NjNhZjIyN2JjMjI5NGY2M2IwOGY0NjFiODc4M2Q1ZDA4YTEwNDA1MTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1MTVjODdkN2JkZDFiMGU1Y2ZkMDM4N2JmYmZiNTYxYzFkN2I5OTQzIn0=','2020-05-27 12:10:07.877945'),
('8ze8haq417zh1c7043n924dvoq3smp5j','YTllNzI3MzEyNWFkOTE5YjRjNzFlYzg5YTVhZGM3MGNjODg2NzBmOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5M2JkY2ExYTZhOTVjNzFhNDhlYmUxZWRjZDhkNjFiNjYxZTg2Nzc5In0=','2020-04-22 08:43:07.340786'),
('hi5rl5s04xxe4wt4p0vc692qevou42rl','YTllNzI3MzEyNWFkOTE5YjRjNzFlYzg5YTVhZGM3MGNjODg2NzBmOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5M2JkY2ExYTZhOTVjNzFhNDhlYmUxZWRjZDhkNjFiNjYxZTg2Nzc5In0=','2020-05-12 15:16:02.524337'),
('ku1pff3468vfl4uaqfpzd8a4hgvlqosd','NjNhZjIyN2JjMjI5NGY2M2IwOGY0NjFiODc4M2Q1ZDA4YTEwNDA1MTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1MTVjODdkN2JkZDFiMGU1Y2ZkMDM4N2JmYmZiNTYxYzFkN2I5OTQzIn0=','2020-06-16 14:49:43.339168');

/*Table structure for table `face_recognition_records` */

DROP TABLE IF EXISTS `face_recognition_records`;

CREATE TABLE `face_recognition_records` (
  `id` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `residence` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `education` varchar(150) DEFAULT NULL,
  `occupation` varchar(150) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `bio` longtext NOT NULL,
  `recorded_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `face_recognition_records` */

insert  into `face_recognition_records`(`id`,`first_name`,`last_name`,`residence`,`country`,`education`,`occupation`,`marital_status`,`bio`,`recorded_at`) values 
('1','Luka','Šćekić','Belgrade','Serbia','Faculty of Organizational Sciences','Student','Single','Student at University of Belgrade.','2020-06-02 23:33:12.000000'),
('123','Nataša','Jovanović','Belgrade','Serbia','Faculty of Organizational Sciences','Student','Single','Student at University of Belgrade.','2020-06-03 12:11:09.000000'),
('4','Nikola','Madić','Čačak','Serbia','Faculty of Organizational Sciences','Student','Single','Student at University of Belgrade.','2020-05-22 14:32:35.000000'),
('432','Ljubica','Ljubisavljević','Belgrade','Serbia','Faculty of Organizational Sciences','Student','Single','Student at University of Belgrade.','2020-06-02 16:50:44.000000');

/*Table structure for table `records_records` */

DROP TABLE IF EXISTS `records_records`;

CREATE TABLE `records_records` (
  `id` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `residence` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `education` varchar(150) DEFAULT NULL,
  `occupation` varchar(150) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `bio` longtext NOT NULL,
  `recorded_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `records_records` */

insert  into `records_records`(`id`,`first_name`,`last_name`,`residence`,`country`,`education`,`occupation`,`marital_status`,`bio`,`recorded_at`) values 
('1','Luka','Šćekić','Belgrade','Serbia','Faculty of Organizational Studies','Student','Single','Student of the final year of Faculty of Organizational Studies at University of Belgrade.','2020-04-08 22:59:19.000000');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
