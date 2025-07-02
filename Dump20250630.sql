-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: cxalloytq
-- ------------------------------------------------------
-- Server version	9.3.0-commercial

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_person__owner` int unsigned DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `timezone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_master_demo` tinyint(1) DEFAULT '0',
  `is_demo` tinyint(1) DEFAULT '0',
  `stripe_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_trial` tinyint(1) DEFAULT '0',
  `d_trial_end` date DEFAULT NULL,
  `is_active` tinyint unsigned NOT NULL DEFAULT '1',
  `is_enterprise` tinyint unsigned NOT NULL DEFAULT '0',
  `days_until_due` int unsigned DEFAULT '14',
  `attribute_verified_count` int unsigned NOT NULL DEFAULT '2',
  `rate` int unsigned NOT NULL DEFAULT '0',
  `tier` int DEFAULT NULL,
  `cheapest_tier` int DEFAULT NULL,
  `projects_charged` int NOT NULL,
  `d_last_charged` date DEFAULT NULL,
  `is_delinquent` tinyint unsigned NOT NULL DEFAULT '0',
  `wants_premium` tinyint unsigned NOT NULL DEFAULT '0',
  `d_premium_charged` date DEFAULT NULL,
  `has_white_labeling` tinyint unsigned NOT NULL DEFAULT '0',
  `line_defaults` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `project_limit` int unsigned DEFAULT NULL,
  `services` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `projects` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `important` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `has_logo` tinyint unsigned NOT NULL DEFAULT '0',
  `logo` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `billing_note` text COLLATE utf8mb4_unicode_ci,
  `billing_model` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vision_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enterprise_billing_notes` text COLLATE utf8mb4_unicode_ci,
  `payment_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_source` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `d_period_start` date DEFAULT NULL,
  `d_period_end` date DEFAULT NULL,
  `distributor` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `has_sections` tinyint(1) NOT NULL DEFAULT '0',
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `uses_custom_phases` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_person`
--

DROP TABLE IF EXISTS `account_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_person` (
  `account_person_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_person` int unsigned NOT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `is_account_admin` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`account_person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66053 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annotation`
--

DROP TABLE IF EXISTS `annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `annotation` (
  `annotation_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int NOT NULL,
  `fk_file` int NOT NULL,
  `ek_annotation` varchar(36) NOT NULL,
  `content` text,
  `is_callout` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`annotation_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_file` (`fk_file`),
  KEY `ek_annotation` (`ek_annotation`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute` (
  `attribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `units` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` enum('asset','issue') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'asset',
  `fk_project` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`attribute_id`),
  KEY `attribute-person__created` (`fk_person__created`),
  KEY `attribute-person__modified` (`fk_person__modified`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_account` (`fk_account`),
  KEY `type` (`type`),
  CONSTRAINT `attribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `attribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4039561 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtest`
--

DROP TABLE IF EXISTS `automatedtest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtest` (
  `automatedtest_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int unsigned DEFAULT NULL,
  `fk_equipment` int unsigned DEFAULT NULL,
  `fk_system` int unsigned DEFAULT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `fk_role` int unsigned DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `estimated_time` varchar(255) NOT NULL,
  `note` text,
  `tools` text,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `nat_name` varchar(256) DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtest_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_phase` (`fk_phase`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_system` (`fk_system`),
  KEY `fk_campus` (`fk_campus`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_zone` (`fk_zone`),
  KEY `fk_type` (`fk_type`),
  KEY `fk_person` (`fk_person`),
  KEY `fk_company` (`fk_company`),
  KEY `fk_role` (`fk_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtestrun`
--

DROP TABLE IF EXISTS `automatedtestrun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtestrun` (
  `automatedtestrun_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_automatedtest` int unsigned NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_automatedtestrunstatus` int unsigned DEFAULT NULL,
  `fk_automatedtesttemplate` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `automatedtesttemplate_version` int unsigned DEFAULT NULL,
  `automatedtesttemplate_version_ts` varchar(30) DEFAULT NULL,
  `has_structurally_changed` int unsigned NOT NULL DEFAULT '0',
  `automatedtesttemplate_version_ts_signatures` varchar(30) DEFAULT NULL,
  `has_structurally_changed_signatures` int unsigned NOT NULL DEFAULT '0',
  `number` int unsigned NOT NULL,
  `witnesses` text,
  `date` date DEFAULT NULL,
  `is_closed` tinyint unsigned NOT NULL DEFAULT '0',
  `d_closed` date DEFAULT NULL,
  `fk_person__status_change` int unsigned DEFAULT NULL,
  `d_status_change` date DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtestrun_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtest` (`fk_automatedtest`),
  KEY `fk_automatedtestrunstatus` (`fk_automatedtestrunstatus`),
  KEY `fk_autoamtedtesttemplate` (`fk_automatedtesttemplate`),
  KEY `fk_person__status_change` (`fk_person__status_change`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtestrunblock`
--

DROP TABLE IF EXISTS `automatedtestrunblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtestrunblock` (
  `automatedtestrunblock_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_automatedtestrun` int unsigned NOT NULL,
  `fk_automatedtesttemplateblock` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `time` int unsigned DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `number` int unsigned DEFAULT NULL,
  `point_data` text,
  `attribute_data` text,
  `copied_from` int unsigned NOT NULL DEFAULT '0',
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtestrunblock_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtestrun` (`fk_automatedtestrun`),
  KEY `fk_automatedtesttemplateblock` (`fk_automatedtesttemplateblock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtestrunblockpoint`
--

DROP TABLE IF EXISTS `automatedtestrunblockpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtestrunblockpoint` (
  `automatedtestrunblockpoint_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_automatedtestrunblock` int unsigned NOT NULL,
  `fk_equipmentpoint` int unsigned NOT NULL,
  `value` text,
  `value_ids` text,
  `data` text,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtestrunblockpoint_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtestrunblock` (`fk_automatedtestrunblock`),
  KEY `fk_equipmentpoint` (`fk_equipmentpoint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtestrunline`
--

DROP TABLE IF EXISTS `automatedtestrunline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtestrunline` (
  `automatedtestrunline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_automatedtestrunblock` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `fk_automatedtesttemplateline` int unsigned DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `configuration` mediumtext,
  `value` text,
  `attribute_value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `attribute_unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int unsigned DEFAULT NULL,
  `title` text,
  `description` mediumtext NOT NULL,
  `answer` enum('yes','no','na') DEFAULT NULL,
  `copied_from` int unsigned NOT NULL DEFAULT '0',
  `note` mediumtext,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `is_bold` tinyint unsigned NOT NULL DEFAULT '0',
  `is_italic` tinyint unsigned NOT NULL DEFAULT '0',
  `is_indented` tinyint unsigned NOT NULL DEFAULT '0',
  `is_header` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtestrunline_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtestrunblock` (`fk_automatedtestrunblock`),
  KEY `fk_attribute` (`fk_attribute`),
  KEY `fk_automatedtesttemplateline` (`fk_automatedtesttemplateline`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtestrunstatus`
--

DROP TABLE IF EXISTS `automatedtestrunstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtestrunstatus` (
  `automatedtestrunstatus_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_automatedtestrunstatus__next` int unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `color` varchar(20) NOT NULL DEFAULT 'gray',
  `roworder` int unsigned DEFAULT NULL,
  `permissiontype` enum('manager','responder','specific') NOT NULL DEFAULT 'responder',
  `is_locking` tinyint unsigned NOT NULL DEFAULT '0',
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtestrunstatus_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtestrunstatus__next` (`fk_automatedtestrunstatus__next`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtesttemplate`
--

DROP TABLE IF EXISTS `automatedtesttemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtesttemplate` (
  `automatedtesttemplate_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_folder` int unsigned DEFAULT NULL,
  `fk_automatedtesttemplate` int unsigned DEFAULT NULL,
  `parent_version` int unsigned DEFAULT NULL,
  `version` int unsigned NOT NULL DEFAULT '1',
  `parent_version_ts` varchar(30) DEFAULT NULL,
  `version_ts` varchar(30) DEFAULT '1587262061.5189',
  `version_ts_signatures` varchar(30) DEFAULT '1628020234',
  `parent_version_ts_signatures` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtesttemplate_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_folder` (`fk_folder`),
  KEY `fk_automatedtesttemplate` (`fk_automatedtesttemplate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtesttemplateblock`
--

DROP TABLE IF EXISTS `automatedtesttemplateblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtesttemplateblock` (
  `automatedtesttemplateblock_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_automatedtesttemplate` int unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `time` int unsigned DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtesttemplateblock_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtesttemplate` (`fk_automatedtesttemplate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtesttemplateblockpoint`
--

DROP TABLE IF EXISTS `automatedtesttemplateblockpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtesttemplateblockpoint` (
  `automatedtesttemplateblockpoint_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_automatedtesttemplateblock` int unsigned NOT NULL,
  `fk_point` int unsigned NOT NULL,
  `value` text,
  `value_ids` text,
  `data` text,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtesttemplateblockpoint_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtesttemplateblock` (`fk_automatedtesttemplateblock`),
  KEY `fk_point` (`fk_point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automatedtesttemplateline`
--

DROP TABLE IF EXISTS `automatedtesttemplateline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatedtesttemplateline` (
  `automatedtesttemplateline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_automatedtesttemplateblock` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `configuration` mediumtext,
  `number` int unsigned NOT NULL,
  `title` text,
  `description` text NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `is_bold` tinyint unsigned NOT NULL DEFAULT '0',
  `is_italic` tinyint unsigned NOT NULL DEFAULT '0',
  `is_indented` tinyint unsigned NOT NULL DEFAULT '0',
  `is_header` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`automatedtesttemplateline_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_automatedtesttemplateblock` (`fk_automatedtesttemplateblock`),
  KEY `fk_attribute` (`fk_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `building_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`building_id`),
  KEY `building-person__created` (`fk_person__created`),
  KEY `building-person__modified` (`fk_person__modified`),
  KEY `project-deleted` (`fk_project`,`is_deleted`),
  KEY `fk_campus` (`fk_campus`),
  CONSTRAINT `building-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `building-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8475 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buildingattribute`
--

DROP TABLE IF EXISTS `buildingattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buildingattribute` (
  `buildingattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_building` int unsigned NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`buildingattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_building` (`fk_building`),
  KEY `buildingattribute-person__created` (`fk_person__created`),
  KEY `buildingattribute-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `buildingattribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `buildingattribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `campus_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` mediumtext,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `nat_name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`campus_id`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campusattribute`
--

DROP TABLE IF EXISTS `campusattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campusattribute` (
  `campusattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_campus` int unsigned NOT NULL,
  `name` varchar(256) NOT NULL,
  `value` varchar(256) DEFAULT NULL,
  `unit` varchar(256) DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`campusattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_campus` (`fk_campus`),
  KEY `fk_attribute` (`fk_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklist` (
  `checklist_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int DEFAULT NULL,
  `fk_checklisttype` int unsigned DEFAULT NULL,
  `fk_equipment` int unsigned DEFAULT NULL,
  `fk_system` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tools` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`checklist_id`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `checklist-person__created` (`fk_person__created`),
  KEY `checklist-person__modified` (`fk_person__modified`),
  KEY `is_deleted` (`is_deleted`),
  KEY `fk_checklisttype` (`fk_checklisttype`),
  KEY `fk_system` (`fk_system`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_zone` (`fk_zone`),
  KEY `fk_type` (`fk_type`),
  KEY `fk_phase` (`fk_phase`),
  CONSTRAINT `checklist-equipment` FOREIGN KEY (`fk_equipment`) REFERENCES `equipment` (`equipment_id`),
  CONSTRAINT `checklist-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklist-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1270918 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklistsection`
--

DROP TABLE IF EXISTS `checklistsection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklistsection` (
  `checklistsection_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int DEFAULT NULL,
  `fk_checklist` int unsigned DEFAULT NULL,
  `fk_checklisttype` int unsigned DEFAULT NULL,
  `fk_checklistsectionstatus` int unsigned DEFAULT NULL,
  `fk_equipment` int unsigned DEFAULT NULL,
  `fk_system` int unsigned DEFAULT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `fk_role` int unsigned DEFAULT NULL,
  `fk_checklisttemplatesection` int unsigned DEFAULT NULL,
  `checklisttemplatesection_version` int unsigned DEFAULT NULL,
  `checklisttemplatesection_version_ts` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `has_structurally_changed` int unsigned NOT NULL DEFAULT '0',
  `checklisttemplatesection_version_ts_signatures` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `has_structurally_changed_signatures` int unsigned NOT NULL DEFAULT '0',
  `number` float unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nat_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `tools` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `d_closed` date DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__status_change` int unsigned DEFAULT NULL,
  `d_status_change` date DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklistsection_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_checklist` (`fk_checklist`),
  KEY `checklistsection-person__created` (`fk_person__created`),
  KEY `checklistsection-person__modified` (`fk_person__modified`),
  KEY `fk_person` (`fk_person`),
  KEY `fk_checklisttype` (`fk_checklisttype`),
  KEY `fk_checklistsectionstatus` (`fk_checklistsectionstatus`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_system` (`fk_system`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_zone` (`fk_zone`),
  KEY `fk_type` (`fk_type`),
  KEY `fk_company` (`fk_company`),
  KEY `fk_role` (`fk_role`),
  KEY `fk_phase` (`fk_phase`),
  KEY `fk_campus` (`fk_campus`),
  CONSTRAINT `checklistsection-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklistsection-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3777087 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklistsectionline`
--

DROP TABLE IF EXISTS `checklistsectionline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklistsectionline` (
  `checklistsectionline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_checklistsection` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fk_checklisttemplatesectionline` int unsigned DEFAULT NULL,
  `attribute_value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `attribute_unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `answer` enum('yes','no','na') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_bold` tinyint(1) NOT NULL DEFAULT '0',
  `is_italic` tinyint(1) NOT NULL DEFAULT '0',
  `is_indented` tinyint(1) NOT NULL DEFAULT '0',
  `is_header` tinyint(1) NOT NULL DEFAULT '0',
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklistsectionline_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_checklistsection` (`fk_checklistsection`),
  KEY `checklistsectionline-person__created` (`fk_person__created`),
  KEY `checklistsectionline-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `checklistsectionline-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklistsectionline-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66777324 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklistsectionline_lt`
--

DROP TABLE IF EXISTS `checklistsectionline_lt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklistsectionline_lt` (
  `checklistsectionline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_checklistsection` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `fk_checklisttemplatesectionline` int unsigned DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `attribute_value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `attribute_unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `answer` enum('yes','no','na') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_italic` tinyint(1) NOT NULL DEFAULT '0',
  `is_indented` tinyint(1) NOT NULL DEFAULT '0',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0',
  `is_header` tinyint(1) NOT NULL DEFAULT '0',
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklistsectionline_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_checklistsection` (`fk_checklistsection`),
  KEY `fk_attribute` (`fk_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklistsectionstatus`
--

DROP TABLE IF EXISTS `checklistsectionstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklistsectionstatus` (
  `checklistsectionstatus_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_checklistsectionstatus__next` int DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'gray',
  `roworder` int DEFAULT NULL,
  `permissiontype` enum('manager','responder','specific') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'responder',
  `is_locking` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklistsectionstatus_id`),
  KEY `checklistsectionstatus-person__created` (`fk_person__created`),
  KEY `checklistsectionstatus-person__modified` (`fk_person__modified`),
  CONSTRAINT `checklistsectionstatus-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklistsectionstatus-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklistsignatureline`
--

DROP TABLE IF EXISTS `checklistsignatureline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklistsignatureline` (
  `checklistsignatureline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklistsignatureline_id`),
  KEY `checklistsignatureline-person__created` (`fk_person__created`),
  KEY `checklistsignatureline-person__modified` (`fk_person__modified`),
  CONSTRAINT `checklistsignatureline-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklistsignatureline-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklisttemplate`
--

DROP TABLE IF EXISTS `checklisttemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklisttemplate` (
  `checklisttemplate_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklisttemplate_id`),
  KEY `fk_project` (`fk_project`),
  KEY `checklisttemplate-person__created` (`fk_person__created`),
  KEY `checklisttemplate-person__modified` (`fk_person__modified`),
  KEY `fk_account` (`fk_account`),
  CONSTRAINT `checklisttemplate-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklisttemplate-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=118705 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklisttemplatesection`
--

DROP TABLE IF EXISTS `checklisttemplatesection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklisttemplatesection` (
  `checklisttemplatesection_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_folder` int unsigned DEFAULT NULL,
  `fk_checklisttemplate` int unsigned DEFAULT NULL,
  `fk_checklisttemplatesection` int unsigned DEFAULT NULL,
  `parent_version` int unsigned DEFAULT NULL,
  `version` int unsigned NOT NULL DEFAULT '1',
  `parent_version_ts` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `version_ts` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1587262061.5189',
  `version_ts_signatures` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1623649274',
  `parent_version_ts_signatures` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklisttemplatesection_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_checklisttemplate` (`fk_checklisttemplate`),
  KEY `checklisttemplatesection-person__created` (`fk_person__created`),
  KEY `checklisttemplatesection-person__modified` (`fk_person__modified`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_folder` (`fk_folder`),
  CONSTRAINT `checklisttemplatesection-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklisttemplatesection-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=352400 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklisttemplatesectionline`
--

DROP TABLE IF EXISTS `checklisttemplatesectionline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklisttemplatesectionline` (
  `checklisttemplatesectionline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_checklisttemplatesection` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `number` int unsigned NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0',
  `is_italic` tinyint(1) NOT NULL DEFAULT '0',
  `is_indented` tinyint(1) NOT NULL DEFAULT '0',
  `is_header` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklisttemplatesectionline_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_checklisttemplatesection` (`fk_checklisttemplatesection`),
  KEY `checklisttemplatesectionline-person__created` (`fk_person__created`),
  KEY `checklisttemplatesectionline-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `checklisttemplatesectionline-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklisttemplatesectionline-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7473146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checklisttype`
--

DROP TABLE IF EXISTS `checklisttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklisttype` (
  `checklisttype_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`checklisttype_id`),
  KEY `fk_project` (`fk_project`),
  KEY `checklisttype-person__created` (`fk_person__created`),
  KEY `checklisttype-person__modified` (`fk_person__modified`),
  CONSTRAINT `checklisttype-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `checklisttype-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `company_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `street` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `zip` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7846 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_project`
--

DROP TABLE IF EXISTS `company_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_project` (
  `company_project_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_company` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`company_project_id`),
  KEY `company_project-person__created` (`fk_person__created`),
  KEY `company_project-person__modified` (`fk_person__modified`),
  KEY `company_project-company` (`fk_company`),
  CONSTRAINT `company_project-company` FOREIGN KEY (`fk_company`) REFERENCES `company` (`company_id`),
  CONSTRAINT `company_project-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `company_project-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connection`
--

DROP TABLE IF EXISTS `connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connection` (
  `connection_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `domain` varchar(256) NOT NULL DEFAULT '',
  `strategy` varchar(11) DEFAULT NULL,
  `client_id` varchar(150) NOT NULL DEFAULT '',
  `client_secret` varchar(256) DEFAULT NULL,
  `is_enabled` tinyint(1) DEFAULT '0',
  `provider` varchar(256) NOT NULL DEFAULT '',
  `fk_account` int unsigned NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `fk_person__created` int DEFAULT NULL,
  `fk_person__modified` int DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`connection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discipline`
--

DROP TABLE IF EXISTS `discipline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discipline` (
  `discipline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`discipline_id`),
  KEY `fk_project` (`fk_project`),
  KEY `discipline-person__created` (`fk_person__created`),
  KEY `discipline-person__modified` (`fk_person__modified`),
  CONSTRAINT `discipline-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `discipline-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108874 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `fk_discipline` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_equipmentstatus` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dt_ready` datetime DEFAULT NULL,
  `ready_status` enum('approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `d_closed` date DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ek_skyspark` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`equipment_id`),
  KEY `fk_type` (`fk_type`),
  KEY `fk_space` (`fk_space`),
  KEY `equipment-person__created` (`fk_person__created`),
  KEY `equipment-person__modified` (`fk_person__modified`),
  CONSTRAINT `equipment-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `equipment-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1616681 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment_system`
--

DROP TABLE IF EXISTS `equipment_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_system` (
  `equipment_system_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_equipment` int unsigned NOT NULL,
  `fk_system` int unsigned NOT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`equipment_system_id`),
  UNIQUE KEY `equipment_system_unique` (`fk_equipment`,`fk_system`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_system` (`fk_system`),
  KEY `equipment_system-person__created` (`fk_person__created`),
  KEY `equipment_system-person__modified` (`fk_person__modified`),
  CONSTRAINT `equipment_system-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `equipment_system-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1137612 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipmentattribute`
--

DROP TABLE IF EXISTS `equipmentattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipmentattribute` (
  `equipmentattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_equipment` int unsigned NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`equipmentattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `equipmentattribute-person__created` (`fk_person__created`),
  KEY `equipmentattribute-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `equipmentattribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `equipmentattribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5794868 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipmentcomment`
--

DROP TABLE IF EXISTS `equipmentcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipmentcomment` (
  `equipmentcomment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_equipment` int unsigned NOT NULL,
  `number` int unsigned NOT NULL,
  `comment` mediumtext,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`equipmentcomment_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_equipment` (`fk_equipment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipmentpoint`
--

DROP TABLE IF EXISTS `equipmentpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipmentpoint` (
  `equipmentpoint_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_point` int unsigned NOT NULL,
  `fk_gateway` int unsigned NOT NULL,
  `fk_equipment` int unsigned NOT NULL,
  `ek_skyspark` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`equipmentpoint_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_point` (`fk_point`),
  KEY `fk_gateway` (`fk_gateway`),
  KEY `fk_equipment` (`fk_equipment`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipmentstatus`
--

DROP TABLE IF EXISTS `equipmentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipmentstatus` (
  `equipmentstatus_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_equipmentstatus__next` int DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'gray',
  `roworder` int DEFAULT NULL,
  `permissiontype` enum('manager','responder','specific') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'responder',
  `is_locking` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`equipmentstatus_id`),
  KEY `equipmentstatus-person__created` (`fk_person__created`),
  KEY `equipmentstatus-person__modified` (`fk_person__modified`),
  CONSTRAINT `equipmentstatus-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `equipmentstatus-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56034 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featureflag`
--

DROP TABLE IF EXISTS `featureflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `featureflag` (
  `featureflag_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `feature_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_enabled` tinyint unsigned NOT NULL DEFAULT '0',
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`featureflag_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_person` (`fk_person`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldobservation`
--

DROP TABLE IF EXISTS `fieldobservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldobservation` (
  `fieldobservation_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_fieldobservationtype` int unsigned DEFAULT NULL,
  `d_observed` date DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `present` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `weather` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_draft` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`fieldobservation_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_fieldobservationtype` (`fk_fieldobservationtype`),
  KEY `fieldobservation-person__created` (`fk_person__created`),
  KEY `fieldobservation-person__modified` (`fk_person__modified`),
  KEY `fk_phase` (`fk_phase`),
  CONSTRAINT `fieldobservation-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `fieldobservation-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46317 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldobservationcomment`
--

DROP TABLE IF EXISTS `fieldobservationcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldobservationcomment` (
  `fieldobservationcomment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_fieldobservation` int unsigned NOT NULL,
  `number` int unsigned NOT NULL,
  `comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`fieldobservationcomment_id`),
  KEY `fieldobservationcomment-person__created` (`fk_person__created`),
  KEY `fieldobservationcomment-person__modified` (`fk_person__modified`),
  CONSTRAINT `fieldobservationcomment-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `fieldobservationcomment-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=145065 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldobservationtype`
--

DROP TABLE IF EXISTS `fieldobservationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldobservationtype` (
  `fieldobservationtype_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`fieldobservationtype_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fieldobservationtype-person__created` (`fk_person__created`),
  KEY `fieldobservationtype-person__modified` (`fk_person__modified`),
  CONSTRAINT `fieldobservationtype-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `fieldobservationtype-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `file_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_folder` int DEFAULT NULL,
  `fk_project` int unsigned NOT NULL,
  `fk_issue` int unsigned DEFAULT NULL,
  `fk_fieldobservationcomment` int unsigned DEFAULT NULL,
  `fk_test` int unsigned DEFAULT NULL,
  `fk_equipment` int unsigned DEFAULT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `fk_system` int unsigned DEFAULT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_review` int unsigned DEFAULT NULL,
  `fk_reviewcomment` int unsigned DEFAULT NULL,
  `fk_fieldobservation` int unsigned DEFAULT NULL,
  `fk_checklist` int unsigned DEFAULT NULL,
  `fk_checklistsection` int unsigned DEFAULT NULL,
  `fk_checklistsectionline` int unsigned DEFAULT NULL,
  `fk_testattemptline` int unsigned DEFAULT NULL,
  `fk_automatedtest` int unsigned DEFAULT NULL,
  `fk_automatedtestrunline` int unsigned DEFAULT NULL,
  `fk_meeting` int unsigned DEFAULT NULL,
  `fk_progressreport` int unsigned DEFAULT NULL,
  `number` int NOT NULL DEFAULT '0',
  `temp_guid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `upload_status` enum('unuploaded','uploading','uploaded') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'unuploaded',
  `thumbnail_status` enum('ignore','unprocessed','processed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ignore',
  `sizes` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pdf_status` enum('ignore','unprocessed','processing','processed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ignore',
  `pdf_version` int DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `extension` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `filesize` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `uploadtime` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pages` smallint NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `v3_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `v3_id` int unsigned DEFAULT NULL,
  `v3_folders` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `instant_json_layer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `instant_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `instant_json_conversion_parameters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`file_id`),
  KEY `fk_issue` (`fk_issue`),
  KEY `file-person__created` (`fk_person__created`),
  KEY `file-person__modified` (`fk_person__modified`),
  KEY `project-deleted` (`fk_project`,`is_deleted`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_type` (`fk_type`),
  KEY `fk_system` (`fk_system`),
  KEY `fk_checklist` (`fk_checklist`),
  KEY `fk_test` (`fk_test`),
  KEY `fk_fieldobservationcomment` (`fk_fieldobservationcomment`),
  KEY `fk_review` (`fk_review`),
  KEY `fk_folder` (`fk_folder`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_zone` (`fk_zone`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_meeting` (`fk_meeting`),
  KEY `fk_checklistsectionline` (`fk_checklistsectionline`),
  KEY `fk_testattemptline` (`fk_testattemptline`),
  KEY `fk_fieldobservation` (`fk_fieldobservation`),
  KEY `fk_checklistsection` (`fk_checklistsection`),
  KEY `fk_campus` (`fk_campus`),
  KEY `fk_reviewcomment` (`fk_reviewcomment`),
  KEY `fk_progressreport` (`fk_progressreport`),
  KEY `fk_automatedtest` (`fk_automatedtest`),
  KEY `fk_automatedtestrunline` (`fk_automatedtestrunline`),
  CONSTRAINT `file-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `file-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2140173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_tag`
--

DROP TABLE IF EXISTS `file_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_tag` (
  `file_tag_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_file` int unsigned NOT NULL,
  `fk_tag` int unsigned NOT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`file_tag_id`),
  UNIQUE KEY `file_tag_unique` (`fk_file`,`fk_tag`),
  KEY `file_tag-person__created` (`fk_person__created`),
  KEY `file_tag-person__modified` (`fk_person__modified`),
  CONSTRAINT `file_tag-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `file_tag-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13019 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `floor` (
  `floor_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`floor_id`),
  KEY `floor-person__created` (`fk_person__created`),
  KEY `floor-person__modified` (`fk_person__modified`),
  KEY `project-deleted-building` (`fk_project`,`is_deleted`,`fk_building`),
  CONSTRAINT `floor-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `floor-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14919 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `floorattribute`
--

DROP TABLE IF EXISTS `floorattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `floorattribute` (
  `floorattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_floor` int unsigned NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`floorattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_floor` (`fk_floor`),
  KEY `floorattribute-person__created` (`fk_person__created`),
  KEY `floorattribute-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `floorattribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `floorattribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `folder`
--

DROP TABLE IF EXISTS `folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folder` (
  `folder_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `type` enum('file','checklisttemplate','testtemplate') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'file',
  `fk_folder` int DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`folder_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_folder` (`fk_folder`),
  KEY `folder-person__created` (`fk_person__created`),
  KEY `folder-person__modified` (`fk_person__modified`),
  KEY `fk_account` (`fk_account`),
  KEY `type` (`type`),
  CONSTRAINT `folder-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `folder-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33585 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gateway`
--

DROP TABLE IF EXISTS `gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gateway` (
  `gateway_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL DEFAULT '0',
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sim` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `configuration` text COLLATE utf8mb4_unicode_ci,
  `location` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`gateway_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gatewayrequest`
--

DROP TABLE IF EXISTS `gatewayrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gatewayrequest` (
  `gatewayrequest_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_gateway` int unsigned DEFAULT NULL,
  `status` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipient` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity_requested` int unsigned NOT NULL DEFAULT '1',
  `package_width` int unsigned NOT NULL DEFAULT '6',
  `package_height` int unsigned NOT NULL DEFAULT '4',
  `package_length` int unsigned NOT NULL DEFAULT '10',
  `package_weight` int unsigned NOT NULL DEFAULT '3',
  `street` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_emails` text COLLATE utf8mb4_unicode_ci,
  `network` text COLLATE utf8mb4_unicode_ci,
  `expedite_shipping` tinyint unsigned NOT NULL DEFAULT '0',
  `tracking_status` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracking_number` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracking_url_provider` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_carrier` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_label_url` text COLLATE utf8mb4_unicode_ci,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`gatewayrequest_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_gateway` (`fk_gateway`),
  KEY `tracking_number` (`tracking_number`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `history_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `before` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `after` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `changed` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `id` int unsigned DEFAULT NULL,
  `group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `device_record_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `group` (`group`(2)),
  KEY `history-device_record_id` (`device_record_id`(8)),
  KEY `project-table` (`fk_project`,`table`),
  KEY `dt_created` (`dt_created`),
  KEY `fk_person-dt_created` (`fk_person`,`dt_created`),
  KEY `fk_project-dt_created` (`fk_project`,`dt_created`),
  KEY `fk_account-dt_created` (`fk_account`,`dt_created`),
  KEY `fk_account-fk_project-dt_created` (`fk_account`,`fk_project`,`dt_created`),
  KEY `table-id-dt_created` (`table`,`id`,`dt_created`)
) ENGINE=InnoDB AUTO_INCREMENT=130270 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_new`
--

DROP TABLE IF EXISTS `history_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_new` (
  `history_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `before` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `after` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `changed` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `id` int unsigned DEFAULT NULL,
  `group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `device_record_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `dt_created` (`dt_created`),
  KEY `fk_account-dt_created` (`fk_account`,`dt_created`)
) ENGINE=InnoDB AUTO_INCREMENT=1653536137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import`
--

DROP TABLE IF EXISTS `import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import` (
  `import_id` int unsigned NOT NULL AUTO_INCREMENT,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `target` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `filepath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sheet` int unsigned DEFAULT '0',
  `update_existing` tinyint(1) DEFAULT '0',
  `unmatched_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `format_headers` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`import_id`)
) ENGINE=InnoDB AUTO_INCREMENT=159302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `importcell`
--

DROP TABLE IF EXISTS `importcell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `importcell` (
  `importcell_id` int unsigned NOT NULL AUTO_INCREMENT,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `requires_insert` tinyint(1) DEFAULT '0',
  `fk_import` int unsigned DEFAULT NULL,
  `fk_importcolumn` int unsigned DEFAULT NULL,
  `fk_importrow` int unsigned DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `importable_value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `format` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `multi_value_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`importcell_id`),
  KEY `fk_importcolumn` (`fk_importcolumn`),
  KEY `fk_importrow` (`fk_importrow`),
  KEY `fk_import` (`fk_import`)
) ENGINE=InnoDB AUTO_INCREMENT=98121271 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `importcolumn`
--

DROP TABLE IF EXISTS `importcolumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `importcolumn` (
  `importcolumn_id` int unsigned NOT NULL AUTO_INCREMENT,
  `number` int unsigned DEFAULT NULL,
  `is_ready` tinyint(1) DEFAULT '0',
  `fk_import` int unsigned DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `attribute_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `requires_map` tinyint(1) DEFAULT '0',
  `is_primary` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`importcolumn_id`),
  KEY `importcolumn-import` (`fk_import`),
  KEY `fk_import` (`fk_import`),
  CONSTRAINT `importcolumn-import` FOREIGN KEY (`fk_import`) REFERENCES `import` (`import_id`)
) ENGINE=InnoDB AUTO_INCREMENT=980550 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `importrow`
--

DROP TABLE IF EXISTS `importrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `importrow` (
  `importrow_id` int unsigned NOT NULL AUTO_INCREMENT,
  `number` int unsigned DEFAULT NULL,
  `skip` tinyint unsigned DEFAULT '0',
  `fk_import` int unsigned DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `update_existing` tinyint(1) DEFAULT '0',
  `update_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`importrow_id`),
  KEY `fk_import` (`fk_import`)
) ENGINE=InnoDB AUTO_INCREMENT=10427751 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issue`
--

DROP TABLE IF EXISTS `issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue` (
  `issue_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int DEFAULT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_system` int unsigned DEFAULT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `section` enum('design','construction') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'design',
  `fk_equipment` int unsigned DEFAULT NULL,
  `fk_checklist` int unsigned DEFAULT NULL,
  `fk_checklistsection` int unsigned DEFAULT NULL,
  `fk_checklistsectionline` int unsigned DEFAULT NULL,
  `fk_discipline` int unsigned DEFAULT NULL,
  `fk_issuetype` int unsigned DEFAULT NULL,
  `fk_issuestatus` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `fk_role` int unsigned DEFAULT NULL,
  `fk_issuepriority` int unsigned DEFAULT NULL,
  `fk_review` int unsigned DEFAULT NULL,
  `fk_fieldobservation` int unsigned DEFAULT NULL,
  `fk_test` int unsigned DEFAULT NULL,
  `fk_testattemptline` int unsigned DEFAULT NULL,
  `fk_automatedtest` int unsigned DEFAULT NULL,
  `fk_automatedtestrunline` int unsigned DEFAULT NULL,
  `fk_meeting` int unsigned DEFAULT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `d_closed` date DEFAULT NULL,
  `d_due` date DEFAULT NULL,
  `name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `drawing` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `is_draft` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `report_number` smallint unsigned NOT NULL,
  `report_type` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `ek_procore` int unsigned DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_checklist` (`fk_checklist`),
  KEY `fk_checklistsectionline` (`fk_checklistsectionline`),
  KEY `fk_discipline` (`fk_discipline`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_issuestatus` (`fk_issuestatus`),
  KEY `fk_person` (`fk_person`),
  KEY `fk_company` (`fk_company`),
  KEY `fk_role` (`fk_role`),
  KEY `fk_issuepriority` (`fk_issuepriority`),
  KEY `fk_review` (`fk_review`),
  KEY `fk_fieldobservation` (`fk_fieldobservation`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_system` (`fk_system`),
  KEY `fk_test` (`fk_test`),
  KEY `fk_testattemptline` (`fk_testattemptline`),
  KEY `fk_type` (`fk_type`),
  KEY `issue-person__created` (`fk_person__created`),
  KEY `issue-person__modified` (`fk_person__modified`),
  KEY `is_deleted` (`is_deleted`),
  KEY `fk_checklistsection` (`fk_checklistsection`),
  KEY `ek_procore` (`ek_procore`),
  KEY `fk_phase` (`fk_phase`),
  KEY `fk_campus` (`fk_campus`),
  KEY `fk_issuetype` (`fk_issuetype`),
  KEY `fk_automatedtest` (`fk_automatedtest`),
  KEY `fk_automatedtestrunline` (`fk_automatedtestrunline`),
  CONSTRAINT `issue-company` FOREIGN KEY (`fk_company`) REFERENCES `company` (`company_id`),
  CONSTRAINT `issue-person` FOREIGN KEY (`fk_person`) REFERENCES `person` (`person_id`),
  CONSTRAINT `issue-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `issue-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`),
  CONSTRAINT `issue-role` FOREIGN KEY (`fk_role`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=859520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issueattribute`
--

DROP TABLE IF EXISTS `issueattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issueattribute` (
  `issueattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_issue` int unsigned NOT NULL,
  `value` mediumtext,
  `unit` varchar(255) DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`issueattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_issue` (`fk_issue`),
  KEY `fk_attribute` (`fk_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuecomment`
--

DROP TABLE IF EXISTS `issuecomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuecomment` (
  `issuecomment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_issue` int unsigned NOT NULL,
  `fk_meeting` int unsigned DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `ek_procore` int unsigned DEFAULT NULL,
  PRIMARY KEY (`issuecomment_id`),
  KEY `issuecomment-person__created` (`fk_person__created`),
  KEY `issuecomment-person__modified` (`fk_person__modified`),
  KEY `issuecomment-issue` (`fk_issue`),
  KEY `ek_procore` (`ek_procore`),
  CONSTRAINT `issuecomment-issue` FOREIGN KEY (`fk_issue`) REFERENCES `issue` (`issue_id`),
  CONSTRAINT `issuecomment-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `issuecomment-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=961736 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuepreset`
--

DROP TABLE IF EXISTS `issuepreset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuepreset` (
  `issuepreset_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_system` int unsigned DEFAULT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `fk_equipment` int unsigned DEFAULT NULL,
  `fk_discipline` int unsigned DEFAULT NULL,
  `fk_issuetype` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `fk_role` int unsigned DEFAULT NULL,
  `fk_issuepriority` int unsigned DEFAULT NULL,
  `days_until_due` int unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` mediumtext,
  `drawing` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`issuepreset_id`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_discipline` (`fk_discipline`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_person` (`fk_person`),
  KEY `fk_company` (`fk_company`),
  KEY `fk_role` (`fk_role`),
  KEY `fk_issuepriority` (`fk_issuepriority`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_system` (`fk_system`),
  KEY `fk_type` (`fk_type`),
  KEY `is_deleted` (`is_deleted`),
  KEY `fk_campus` (`fk_campus`),
  KEY `fk_issuetype` (`fk_issuetype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuepresetattribute`
--

DROP TABLE IF EXISTS `issuepresetattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuepresetattribute` (
  `issuepresetattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_issuepreset` int unsigned NOT NULL,
  `value` mediumtext,
  `unit` varchar(255) DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`issuepresetattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_issuepreset` (`fk_issuepreset`),
  KEY `fk_attribute` (`fk_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuepriority`
--

DROP TABLE IF EXISTS `issuepriority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuepriority` (
  `issuepriority_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'gray',
  `order` int DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`issuepriority_id`),
  KEY `issuepriority-person__created` (`fk_person__created`),
  KEY `issuepriority-person__modified` (`fk_person__modified`),
  CONSTRAINT `issuepriority-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `issuepriority-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41214 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuestatus`
--

DROP TABLE IF EXISTS `issuestatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuestatus` (
  `issuestatus_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'gray',
  `roworder` int DEFAULT NULL,
  `permissiontype` enum('manager','responder','specific') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'responder',
  `is_locking` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_issuestatus__next` int DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`issuestatus_id`),
  KEY `issuestatus-person__created` (`fk_person__created`),
  KEY `issuestatus-person__modified` (`fk_person__modified`),
  KEY `fk_project` (`fk_project`),
  CONSTRAINT `issuestatus-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `issuestatus-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49985 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issuetype`
--

DROP TABLE IF EXISTS `issuetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuetype` (
  `issuetype_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`issuetype_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_account` (`fk_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `key`
--

DROP TABLE IF EXISTS `key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `key` (
  `key_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int NOT NULL,
  `identifier` varchar(65) NOT NULL DEFAULT '',
  `description` text,
  `secret` varchar(65) NOT NULL DEFAULT '',
  `is_active` tinyint NOT NULL DEFAULT '1',
  `request_count` int unsigned NOT NULL DEFAULT '0',
  `hour_started` int unsigned DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `identifier` (`identifier`),
  KEY `fk_account` (`fk_account`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting` (
  `meeting_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `agenda` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `minutes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `phase` enum('design','construction') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_draft` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`meeting_id`),
  KEY `fk_project` (`fk_project`),
  KEY `meeting-person__created` (`fk_person__created`),
  KEY `meeting-person__modified` (`fk_person__modified`),
  KEY `fk_phase` (`fk_phase`),
  CONSTRAINT `meeting-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `meeting-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2719 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meeting_person`
--

DROP TABLE IF EXISTS `meeting_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting_person` (
  `meeting_person_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_meeting` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `did_attend` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`meeting_person_id`),
  KEY `fk_project` (`fk_project`),
  KEY `meeting_person-person__created` (`fk_person__created`),
  KEY `meeting_person-person__modified` (`fk_person__modified`),
  CONSTRAINT `meeting_person-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `meeting_person-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25853 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meetingreference`
--

DROP TABLE IF EXISTS `meetingreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetingreference` (
  `meetingreference_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_meeting` int unsigned NOT NULL,
  `part` enum('agenda','minutes') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `position` int unsigned DEFAULT NULL,
  `fk_issue` int unsigned DEFAULT NULL,
  `fk_issuecomment` int unsigned DEFAULT NULL,
  `fk_task` int unsigned DEFAULT NULL,
  `fk_taskcomment` int unsigned DEFAULT NULL,
  `fk_file` int unsigned DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`meetingreference_id`),
  KEY `fk_project` (`fk_project`),
  KEY `meetingreference-person__created` (`fk_person__created`),
  KEY `meetingreference-person__modified` (`fk_person__modified`),
  KEY `fk_file` (`fk_file`),
  CONSTRAINT `meetingreference-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `meetingreference-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21718 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `version` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestone`
--

DROP TABLE IF EXISTS `milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestone` (
  `milestone_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_milestonecollection` int unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `color` varchar(6) NOT NULL DEFAULT 'C2C2C2',
  `order` int unsigned DEFAULT NULL,
  `d_start` date DEFAULT NULL,
  `d_baseline_target` date DEFAULT NULL,
  `d_target` date DEFAULT NULL,
  `dt_complete` datetime DEFAULT NULL,
  `rules` mediumtext,
  `is_invalid_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_manually_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `item_count_cache` int unsigned DEFAULT NULL,
  `complete_count_cache` int unsigned DEFAULT NULL,
  `dt_last_cache_update` datetime DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestone_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_milestonecollection` (`fk_milestonecollection`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestonecollection`
--

DROP TABLE IF EXISTS `milestonecollection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestonecollection` (
  `milestonecollection_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_milestonegroup` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `section` varchar(25) DEFAULT NULL,
  `color` varchar(6) NOT NULL DEFAULT 'C2C2C2',
  `d_start` date DEFAULT NULL,
  `d_baseline_target` date DEFAULT NULL,
  `d_target` date DEFAULT NULL,
  `dt_complete` datetime DEFAULT NULL,
  `invalid_handling` varchar(25) DEFAULT 'clear',
  `is_invalid_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_manually_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `filters` text,
  `item_count_cache` int unsigned DEFAULT NULL,
  `complete_count_cache` int unsigned DEFAULT NULL,
  `dt_last_cache_update` datetime DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestonecollection_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_milestonegroup` (`fk_milestonegroup`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestonecollectioncomment`
--

DROP TABLE IF EXISTS `milestonecollectioncomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestonecollectioncomment` (
  `milestonecollectioncomment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_milestonecollection` int unsigned NOT NULL,
  `number` int unsigned NOT NULL,
  `comment` mediumtext,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestonecollectioncomment_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_milestonecollection` (`fk_milestonecollection`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestonecollectionpreset`
--

DROP TABLE IF EXISTS `milestonecollectionpreset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestonecollectionpreset` (
  `milestonecollectionpreset_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `section` varchar(25) DEFAULT NULL,
  `color` varchar(6) NOT NULL DEFAULT 'C2C2C2',
  `filters` mediumtext,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestonecollectionpreset_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestonegroup`
--

DROP TABLE IF EXISTS `milestonegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestonegroup` (
  `milestonegroup_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `color` varchar(6) NOT NULL DEFAULT 'C2C2C2',
  `d_start` date DEFAULT NULL,
  `d_baseline_target` date DEFAULT NULL,
  `d_target` date DEFAULT NULL,
  `dt_complete` datetime DEFAULT NULL,
  `is_invalid_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_manually_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `item_count_cache` int unsigned DEFAULT NULL,
  `complete_count_cache` int unsigned DEFAULT NULL,
  `dt_last_cache_update` datetime DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestonegroup_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestonegroupcomment`
--

DROP TABLE IF EXISTS `milestonegroupcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestonegroupcomment` (
  `milestonegroupcomment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_milestonegroup` int unsigned NOT NULL,
  `number` int unsigned NOT NULL,
  `comment` mediumtext,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestonegroupcomment_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_milestonegroup` (`fk_milestonegroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestoneitem`
--

DROP TABLE IF EXISTS `milestoneitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestoneitem` (
  `milestoneitem_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_milestone` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `table` varchar(50) NOT NULL,
  `id` int unsigned NOT NULL,
  `d_target` date DEFAULT NULL,
  `dt_complete` datetime DEFAULT NULL,
  `is_disabled` tinyint unsigned NOT NULL DEFAULT '0',
  `is_invalid_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_manually_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestoneitem_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_milestone` (`fk_milestone`),
  KEY `table-id` (`table`,`id`),
  KEY `fk_project-table-id` (`fk_project`,`table`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestonepreset`
--

DROP TABLE IF EXISTS `milestonepreset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestonepreset` (
  `milestonepreset_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_milestonecollectionpreset` int unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `color` varchar(6) NOT NULL DEFAULT 'C2C2C2',
  `order` int unsigned DEFAULT NULL,
  `rules` mediumtext,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestonepreset_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_milestonecollectionpreset` (`fk_milestonecollectionpreset`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `milestonestatistic`
--

DROP TABLE IF EXISTS `milestonestatistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestonestatistic` (
  `milestonestatistic_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_milestone` int unsigned NOT NULL,
  `fk_milestonecollection` int unsigned DEFAULT NULL,
  `fk_milestonegroup` int unsigned DEFAULT NULL,
  `item_count` int DEFAULT NULL,
  `complete_count` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`milestonestatistic_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_milestone` (`fk_milestone`),
  KEY `fk_milestonecollection` (`fk_milestonecollection`),
  KEY `fk_milestonegroup` (`fk_milestonegroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notification_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned DEFAULT NULL,
  `entity_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `entity_id` int unsigned DEFAULT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  UNIQUE KEY `fk_project` (`fk_project`,`entity_type`,`entity_id`,`type`),
  KEY `notification-person__created` (`fk_person__created`),
  KEY `notification-person__modified` (`fk_person__modified`),
  CONSTRAINT `notification-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `notification-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otto_equipmentpoint`
--

DROP TABLE IF EXISTS `otto_equipmentpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otto_equipmentpoint` (
  `equipmentpoint_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned DEFAULT NULL,
  `ek_project` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_equipment` int unsigned NOT NULL,
  `ek_equipment` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_point` int unsigned NOT NULL,
  `ek_point` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_gateway` int unsigned NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `ek_ss_project` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ek_skyspark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`equipmentpoint_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_point` (`fk_point`),
  KEY `ek_skyspark` (`ek_skyspark`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otto_gateway`
--

DROP TABLE IF EXISTS `otto_gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otto_gateway` (
  `gateway_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL DEFAULT '0',
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sim` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `mac` varchar(50) DEFAULT NULL,
  `configuration` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `location` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`gateway_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otto_gatewayrequest`
--

DROP TABLE IF EXISTS `otto_gatewayrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otto_gatewayrequest` (
  `gatewayrequest_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_gateway` int unsigned DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'requested',
  `recipient` varchar(100) DEFAULT NULL,
  `network` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `quantity_requested` int unsigned NOT NULL DEFAULT '1',
  `package_width` int unsigned DEFAULT '6',
  `package_height` int unsigned DEFAULT '4',
  `package_length` int unsigned DEFAULT '10',
  `package_weight` int unsigned DEFAULT '3',
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `zip` varchar(12) DEFAULT NULL,
  `country` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `notification_emails` text,
  `expedite_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `tracking_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tracking_url_provider` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `shipping_carrier` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `shipping_label_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`gatewayrequest_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_gateway` (`fk_gateway`),
  KEY `tracking_number` (`tracking_number`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otto_point`
--

DROP TABLE IF EXISTS `otto_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otto_point` (
  `point_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`point_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `permission_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_phase` int DEFAULT NULL,
  `p_role_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `p_role_id` int unsigned DEFAULT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'user id or company_id',
  `resource` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'resource id, or string',
  `privileges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'serialized string of access levels',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`permission_id`),
  KEY `permission-project` (`fk_project`),
  KEY `project-role_type` (`fk_project`,`p_role_type`),
  KEY `resource` (`resource`),
  KEY `role` (`role`),
  KEY `fk_phase` (`fk_phase`)
) ENGINE=InnoDB AUTO_INCREMENT=4700382 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `person_id` int unsigned NOT NULL AUTO_INCREMENT,
  `contact_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name_first` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name_last` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'MD5',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lang` enum('en','es','fr','zh','ar','fi') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'en',
  `preferences` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `default_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `street` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `zip` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `token` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_used_token` tinyint(1) DEFAULT '0',
  `is_invited` tinyint(1) DEFAULT '0',
  `new_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_product_admin` tinyint unsigned NOT NULL DEFAULT '0',
  `assign_edited` tinyint(1) NOT NULL DEFAULT '1',
  `assign_status` tinyint(1) NOT NULL DEFAULT '1',
  `assign_assigned` tinyint(1) NOT NULL DEFAULT '1',
  `assign_commented` tinyint(1) NOT NULL DEFAULT '1',
  `watch_edited` tinyint(1) NOT NULL DEFAULT '1',
  `watch_status` tinyint(1) NOT NULL DEFAULT '1',
  `watch_assigned` tinyint(1) NOT NULL DEFAULT '1',
  `watch_commented` tinyint(1) NOT NULL DEFAULT '1',
  `create_edited` tinyint(1) NOT NULL DEFAULT '1',
  `create_status` tinyint(1) NOT NULL DEFAULT '1',
  `create_assigned` tinyint(1) NOT NULL DEFAULT '1',
  `create_commented` tinyint(1) NOT NULL DEFAULT '1',
  `notification_frequency` enum('immediately','once','twice') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'immediately',
  `dt_last_notification_run` datetime DEFAULT NULL,
  `first_run` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `api_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dt_api_token` datetime DEFAULT NULL,
  `box_access_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dt_box_access_token` datetime DEFAULT NULL,
  `box_refresh_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `mobile_phone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `work_phone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fax` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59863 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_project`
--

DROP TABLE IF EXISTS `person_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_project` (
  `person_project_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_person` int unsigned NOT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `fk_role` int unsigned DEFAULT NULL,
  `digest_emails` tinyint(1) NOT NULL DEFAULT '1',
  `is_contact` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`person_project_id`),
  KEY `fk_person` (`fk_person`),
  KEY `fk_company` (`fk_company`),
  KEY `person_project-person__created` (`fk_person__created`),
  KEY `person_project-person__modified` (`fk_person__modified`),
  KEY `person_project-role` (`fk_role`),
  CONSTRAINT `person_project-company` FOREIGN KEY (`fk_company`) REFERENCES `company` (`company_id`),
  CONSTRAINT `person_project-person` FOREIGN KEY (`fk_person`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_project-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_project-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_project-role` FOREIGN KEY (`fk_role`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=173145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phase`
--

DROP TABLE IF EXISTS `phase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phase` (
  `phase_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`phase_id`),
  UNIQUE KEY `account_project_name` (`fk_account`,`fk_project`,`name`),
  UNIQUE KEY `account_project_prefix` (`fk_account`,`fk_project`,`prefix`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `point`
--

DROP TABLE IF EXISTS `point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `point` (
  `point_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`point_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` tinyint unsigned NOT NULL DEFAULT '1',
  `fk_project__demo` int unsigned DEFAULT NULL,
  `additional_revenue` int NOT NULL,
  `announcement` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `notifications_running` tinyint unsigned NOT NULL DEFAULT '0',
  `external` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `dt_last_notification_run_immediately` datetime DEFAULT NULL,
  `dt_last_notification_run_twice` datetime DEFAULT NULL,
  `dt_last_notification_run_once` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `progressreport`
--

DROP TABLE IF EXISTS `progressreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progressreport` (
  `progressreport_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `d_reported` date DEFAULT NULL,
  `d_from` date DEFAULT NULL,
  `d_to` date DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `actions` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `upcoming` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`progressreport_id`),
  KEY `progressreport-person__created` (`fk_person__created`),
  KEY `progressreport-person__modified` (`fk_person__modified`),
  CONSTRAINT `progressreport-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `progressreport-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4861 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `project_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `timezone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `hour_of_digest` int NOT NULL DEFAULT '7',
  `is_active` tinyint(1) DEFAULT '0',
  `is_trial` tinyint unsigned NOT NULL DEFAULT '0',
  `is_demo` tinyint unsigned NOT NULL DEFAULT '0',
  `next_checklist_number` int unsigned NOT NULL DEFAULT '1',
  `next_issue_number` int unsigned NOT NULL DEFAULT '1',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `short_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `client` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `building_owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cost` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phase` enum('Design','Construction','Operations') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Design',
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `project_admin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `leed_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `leed_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `leed_provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `days_until_due` int unsigned DEFAULT NULL,
  `attribute_verified_count` int unsigned NOT NULL DEFAULT '2',
  `plan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `rate` int unsigned NOT NULL DEFAULT '0',
  `d_last_charged` date DEFAULT NULL,
  `line_defaults` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `has_logo` tinyint unsigned NOT NULL DEFAULT '0',
  `logo` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ready_digest_emails` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ready_digest_hour` tinyint unsigned DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `scope` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `box_folder` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `has_sections` tinyint(1) NOT NULL DEFAULT '0',
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `uses_custom_phases` int NOT NULL DEFAULT '0',
  `ek_fm` int DEFAULT NULL,
  `ek_procore` int unsigned DEFAULT NULL,
  `ek_skyspark_old` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ek_skyspark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `integrations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `dt_milestone_last_cache_update` datetime DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `ek_procore` (`ek_procore`),
  KEY `fk_account` (`fk_account`)
) ENGINE=InnoDB AUTO_INCREMENT=35571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `report_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `settings` mediumtext,
  `is_deleted` int NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportfile`
--

DROP TABLE IF EXISTS `reportfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportfile` (
  `reportfile_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_report` int unsigned DEFAULT NULL,
  `fk_project` int unsigned NOT NULL,
  `status` enum('not_started','started','error','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'not_started',
  `settings` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `filesize` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`reportfile_id`),
  KEY `report-person__created` (`fk_person__created`),
  KEY `report-person__modified` (`fk_person__modified`),
  CONSTRAINT `report-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `report-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17661 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportsection`
--

DROP TABLE IF EXISTS `reportsection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportsection` (
  `reportsection_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_report` int unsigned DEFAULT NULL,
  `fk_project` int unsigned NOT NULL,
  `section` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `roworder` int DEFAULT NULL,
  `settings` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`reportsection_id`),
  KEY `reportsection-person__created` (`fk_person__created`),
  KEY `reportsection-person__modified` (`fk_person__modified`),
  CONSTRAINT `reportsection-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `reportsection-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34498 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int DEFAULT NULL,
  `fk_reviewtype` int unsigned DEFAULT NULL,
  `fk_reviewremark` int unsigned DEFAULT NULL,
  `section` enum('design','construction') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'design',
  `number` int unsigned NOT NULL,
  `d_reviewed` date DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `submittal_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_draft` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `fk_reviewtype` (`fk_reviewtype`),
  KEY `review-person__created` (`fk_person__created`),
  KEY `review-person__modified` (`fk_person__modified`),
  KEY `project-deleted-draft-section` (`fk_project`,`is_deleted`,`is_draft`,`section`),
  KEY `fk_phase` (`fk_phase`),
  CONSTRAINT `review-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `review-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23442 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reviewcomment`
--

DROP TABLE IF EXISTS `reviewcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewcomment` (
  `reviewcomment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_review` int unsigned NOT NULL,
  `number` int unsigned NOT NULL,
  `comment` text,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`reviewcomment_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_review` (`fk_review`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reviewremark`
--

DROP TABLE IF EXISTS `reviewremark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewremark` (
  `reviewremark_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_phase` int DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `section` enum('design','construction') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'design',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`reviewremark_id`),
  KEY `fk_project` (`fk_project`),
  KEY `reviewremark-person__created` (`fk_person__created`),
  KEY `reviewremark-person__modified` (`fk_person__modified`),
  KEY `fk_phase` (`fk_phase`),
  CONSTRAINT `reviewremark-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `reviewremark-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49351 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reviewtype`
--

DROP TABLE IF EXISTS `reviewtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewtype` (
  `reviewtype_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_phase` int DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `section` enum('design','construction') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'design',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`reviewtype_id`),
  KEY `fk_project` (`fk_project`),
  KEY `reviewtype-person__created` (`fk_person__created`),
  KEY `reviewtype-person__modified` (`fk_person__modified`),
  KEY `fk_phase` (`fk_phase`),
  CONSTRAINT `reviewtype-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `reviewtype-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  KEY `role-person__created` (`fk_person__created`),
  KEY `role-person__modified` (`fk_person__modified`),
  KEY `project-deleted` (`fk_project`,`is_deleted`),
  CONSTRAINT `role-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `role-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140548 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `served`
--

DROP TABLE IF EXISTS `served`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `served` (
  `served_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_equipment` int unsigned NOT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`served_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_zone` (`fk_zone`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_campus` (`fk_campus`)
) ENGINE=InnoDB AUTO_INCREMENT=37497 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signature`
--

DROP TABLE IF EXISTS `signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `signature` (
  `signature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_checklistsection` int unsigned DEFAULT NULL,
  `fk_testattempt` int unsigned DEFAULT NULL,
  `fk_templatesignature` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `order` int unsigned NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`signature_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_checklistsection` (`fk_checklistsection`),
  KEY `fk_testattempt` (`fk_testattempt`),
  KEY `fk_templatesignature` (`fk_templatesignature`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signaturefile`
--

DROP TABLE IF EXISTS `signaturefile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `signaturefile` (
  `signaturefile_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_signature` int unsigned NOT NULL,
  `dt_signed` datetime DEFAULT NULL,
  `is_uploaded` tinyint unsigned NOT NULL DEFAULT '0',
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`signaturefile_id`),
  KEY `fk_signature` (`fk_signature`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `space`
--

DROP TABLE IF EXISTS `space`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `space` (
  `space_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`space_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_floor` (`fk_floor`),
  KEY `space-person__created` (`fk_person__created`),
  KEY `space-person__modified` (`fk_person__modified`),
  KEY `project-deleted-floor` (`fk_project`,`is_deleted`,`fk_floor`),
  CONSTRAINT `space-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `space-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=569255 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `space_zone`
--

DROP TABLE IF EXISTS `space_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `space_zone` (
  `space_zone_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_space` int unsigned NOT NULL,
  `fk_zone` int unsigned NOT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`space_zone_id`),
  UNIQUE KEY `space_zone_unique` (`fk_space`,`fk_zone`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_zone` (`fk_zone`),
  KEY `space_zone-person__created` (`fk_person__created`),
  KEY `space_zone-person__modified` (`fk_person__modified`),
  CONSTRAINT `space_zone-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `space_zone-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138464 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spaceattribute`
--

DROP TABLE IF EXISTS `spaceattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spaceattribute` (
  `spaceattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_space` int unsigned NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`spaceattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_space` (`fk_space`),
  KEY `spaceattribute-person__created` (`fk_person__created`),
  KEY `spaceattribute-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `spaceattribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `spaceattribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137827 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssoconnection`
--

DROP TABLE IF EXISTS `ssoconnection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ssoconnection` (
  `ssoconnection_id` int unsigned NOT NULL AUTO_INCREMENT,
  `ek_auth0` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `strategy` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `domain` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email_domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_enabled` tinyint unsigned NOT NULL DEFAULT '0',
  `is_tested` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_account` int unsigned NOT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`ssoconnection_id`),
  KEY `fk_account` (`fk_account`),
  KEY `domain` (`domain`(255)),
  KEY `ek_auth0` (`ek_auth0`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statistic`
--

DROP TABLE IF EXISTS `statistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statistic` (
  `statistic_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_account` int unsigned DEFAULT NULL,
  `domain` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dimension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dimension_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `subdimension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `subdimension_value` int unsigned DEFAULT NULL,
  `total` int unsigned DEFAULT '0',
  `date` date NOT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`statistic_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_account` (`fk_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system` (
  `system_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_discipline` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`system_id`),
  KEY `fk_building` (`fk_building`),
  KEY `system-person__created` (`fk_person__created`),
  KEY `system-person__modified` (`fk_person__modified`),
  KEY `project-deleted` (`fk_project`,`is_deleted`),
  CONSTRAINT `system-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `system-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73351 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemattribute`
--

DROP TABLE IF EXISTS `systemattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemattribute` (
  `systemattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_system` int unsigned NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`systemattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_system` (`fk_system`),
  KEY `systemattribute-person__created` (`fk_person__created`),
  KEY `systemattribute-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `systemattribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `systemattribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42343 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tag_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `fk_project` (`fk_project`),
  KEY `tag-person__created` (`fk_person__created`),
  KEY `tag-person__modified` (`fk_person__modified`),
  CONSTRAINT `tag-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `tag-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4790 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `task_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_phase` int DEFAULT NULL,
  `fk_meeting` int unsigned DEFAULT NULL,
  `fk_taskstatus` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `fk_role` int unsigned DEFAULT NULL,
  `number` int unsigned DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `d_due` date DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `is_draft` tinyint(1) DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `fk_project` (`fk_project`),
  KEY `task-person__created` (`fk_person__created`),
  KEY `task-person__modified` (`fk_person__modified`),
  KEY `fk_phase` (`fk_phase`),
  CONSTRAINT `task-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `task-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4771 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taskcomment`
--

DROP TABLE IF EXISTS `taskcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskcomment` (
  `taskcomment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_task` int unsigned NOT NULL,
  `fk_meeting` int unsigned DEFAULT NULL,
  `comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`taskcomment_id`),
  KEY `fk_project` (`fk_project`),
  KEY `taskcomment-person__created` (`fk_person__created`),
  KEY `taskcomment-person__modified` (`fk_person__modified`),
  CONSTRAINT `taskcomment-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `taskcomment-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1496 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taskstatus`
--

DROP TABLE IF EXISTS `taskstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taskstatus` (
  `taskstatus_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_taskstatus__next` int unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT 'gray',
  `roworder` int unsigned DEFAULT NULL,
  `permissiontype` enum('manager','responder','specific') NOT NULL DEFAULT 'responder',
  `is_locking` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`taskstatus_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatesignature`
--

DROP TABLE IF EXISTS `templatesignature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatesignature` (
  `templatesignature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_checklisttemplatesection` int unsigned DEFAULT NULL,
  `fk_testtemplate` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `order` int unsigned DEFAULT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`templatesignature_id`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_checklisttemplatesection` (`fk_checklisttemplatesection`),
  KEY `fk_testtemplate` (`fk_testtemplate`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `test_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_equipment` int unsigned DEFAULT NULL,
  `fk_system` int unsigned DEFAULT NULL,
  `fk_campus` int unsigned DEFAULT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `fk_floor` int unsigned DEFAULT NULL,
  `fk_space` int unsigned DEFAULT NULL,
  `fk_zone` int unsigned DEFAULT NULL,
  `fk_type` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_company` int unsigned DEFAULT NULL,
  `fk_role` int unsigned DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `supervisor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `estimated_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `tools` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`test_id`),
  KEY `fk_project` (`fk_project`),
  KEY `test-person__created` (`fk_person__created`),
  KEY `test-person__modified` (`fk_person__modified`),
  KEY `is_deleted` (`is_deleted`),
  KEY `fk_equipment` (`fk_equipment`),
  KEY `fk_system` (`fk_system`),
  KEY `fk_building` (`fk_building`),
  KEY `fk_floor` (`fk_floor`),
  KEY `fk_space` (`fk_space`),
  KEY `fk_zone` (`fk_zone`),
  KEY `fk_type` (`fk_type`),
  KEY `fk_person` (`fk_person`),
  KEY `fk_company` (`fk_company`),
  KEY `fk_role` (`fk_role`),
  KEY `fk_campus` (`fk_campus`),
  CONSTRAINT `test-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `test-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=596524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testattempt`
--

DROP TABLE IF EXISTS `testattempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testattempt` (
  `testattempt_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_test` int unsigned NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_testattemptstatus` int unsigned DEFAULT NULL,
  `fk_testtemplate` int unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `testtemplate_version` int unsigned DEFAULT NULL,
  `testtemplate_version_ts` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `has_structurally_changed` int unsigned NOT NULL DEFAULT '0',
  `testtemplate_version_ts_signatures` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `has_structurally_changed_signatures` int unsigned NOT NULL DEFAULT '0',
  `number` int unsigned NOT NULL,
  `witnesses` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `date` date DEFAULT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `d_closed` date DEFAULT NULL,
  `fk_person__status_change` int unsigned DEFAULT NULL,
  `d_status_change` date DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`testattempt_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_test` (`fk_test`),
  KEY `testattempt-person__created` (`fk_person__created`),
  KEY `testattempt-person__modified` (`fk_person__modified`),
  KEY `is_deleted` (`is_deleted`),
  CONSTRAINT `testattempt-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `testattempt-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=695899 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testattemptline`
--

DROP TABLE IF EXISTS `testattemptline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testattemptline` (
  `testattemptline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_testattempt` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fk_testtemplateline` int unsigned DEFAULT NULL,
  `attribute_value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `attribute_unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `answer` enum('yes','no','na') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `copied_from` int NOT NULL DEFAULT '0',
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0',
  `is_italic` tinyint(1) NOT NULL DEFAULT '0',
  `is_indented` tinyint(1) NOT NULL DEFAULT '0',
  `is_header` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`testattemptline_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_testattempt` (`fk_testattempt`),
  KEY `testattemptline-person__created` (`fk_person__created`),
  KEY `testattemptline-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `testattemptline-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `testattemptline-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57091515 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testattemptline_lt`
--

DROP TABLE IF EXISTS `testattemptline_lt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testattemptline_lt` (
  `testattemptline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_testattempt` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `fk_testtemplateline` int unsigned DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `attribute_value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `attribute_unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `answer` enum('yes','no','na') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `copied_from` int NOT NULL DEFAULT '0',
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0',
  `is_italic` tinyint(1) NOT NULL DEFAULT '0',
  `is_indented` tinyint(1) NOT NULL DEFAULT '0',
  `is_header` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`testattemptline_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_testattempt` (`fk_testattempt`),
  KEY `fk_attribute` (`fk_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testattemptstatus`
--

DROP TABLE IF EXISTS `testattemptstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testattemptstatus` (
  `testattemptstatus_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_testattemptstatus__next` int DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'gray',
  `roworder` int DEFAULT NULL,
  `permissiontype` enum('manager','responder','specific') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'responder',
  `is_locking` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`testattemptstatus_id`),
  KEY `testattemptstatus-person__created` (`fk_person__created`),
  KEY `testattemptstatus-person__modified` (`fk_person__modified`),
  CONSTRAINT `testattemptstatus-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `testattemptstatus-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testsignatureline`
--

DROP TABLE IF EXISTS `testsignatureline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testsignatureline` (
  `testsignatureline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `name` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`testsignatureline_id`),
  KEY `testsignatureline-person__created` (`fk_person__created`),
  KEY `testsignatureline-person__modified` (`fk_person__modified`),
  CONSTRAINT `testsignatureline-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `testsignatureline-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testtemplate`
--

DROP TABLE IF EXISTS `testtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testtemplate` (
  `testtemplate_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_folder` int unsigned DEFAULT NULL,
  `fk_testtemplate` int unsigned DEFAULT NULL,
  `parent_version` int unsigned DEFAULT NULL,
  `version` int unsigned NOT NULL DEFAULT '1',
  `parent_version_ts` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `version_ts` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1587262061.5189',
  `version_ts_signatures` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1623649274',
  `parent_version_ts_signatures` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`testtemplate_id`),
  KEY `fk_project` (`fk_project`),
  KEY `testtemplate-person__created` (`fk_person__created`),
  KEY `testtemplate-person__modified` (`fk_person__modified`),
  KEY `fk_account` (`fk_account`),
  KEY `fk_folder` (`fk_folder`),
  CONSTRAINT `testtemplate-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `testtemplate-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97020 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testtemplateline`
--

DROP TABLE IF EXISTS `testtemplateline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testtemplateline` (
  `testtemplateline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `fk_project` int unsigned DEFAULT NULL,
  `fk_testtemplate` int unsigned NOT NULL,
  `fk_attribute` int unsigned DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `number` int unsigned NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` tinyint unsigned NOT NULL DEFAULT '0',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0',
  `is_italic` tinyint(1) NOT NULL DEFAULT '0',
  `is_indented` tinyint(1) NOT NULL DEFAULT '0',
  `is_header` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`testtemplateline_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_testtemplate` (`fk_testtemplate`),
  KEY `testtemplateline-person__created` (`fk_person__created`),
  KEY `testtemplateline-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `testtemplateline-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `testtemplateline-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9711204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tier`
--

DROP TABLE IF EXISTS `tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tier` (
  `tier_id` int unsigned NOT NULL DEFAULT '0',
  `fk_account` int unsigned DEFAULT NULL,
  `number` int DEFAULT NULL,
  `base_projects` int DEFAULT NULL,
  `base_price` int DEFAULT NULL,
  `additional_projects_price` int DEFAULT NULL,
  `features_price` int DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tier_new`
--

DROP TABLE IF EXISTS `tier_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tier_new` (
  `tier_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `number` int DEFAULT NULL,
  `base_projects` int DEFAULT NULL,
  `base_price` int DEFAULT NULL,
  `additional_projects_price` int DEFAULT NULL,
  `features_price` int DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`tier_id`),
  KEY `tier-person__created` (`fk_person__created`),
  KEY `tier-person__modified` (`fk_person__modified`),
  CONSTRAINT `tier-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `tier-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tier_prod`
--

DROP TABLE IF EXISTS `tier_prod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tier_prod` (
  `tier_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned DEFAULT NULL,
  `number` int DEFAULT NULL,
  `base_projects` int DEFAULT NULL,
  `base_price` int DEFAULT NULL,
  `additional_projects_price` int DEFAULT NULL,
  `features_price` int DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`tier_id`),
  KEY `tier-person__created` (`fk_person__created`),
  KEY `tier-person__modified` (`fk_person__modified`),
  CONSTRAINT `tier_prod_ibfk_1` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `tier_prod_ibfk_2` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tierhistory`
--

DROP TABLE IF EXISTS `tierhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tierhistory` (
  `tierhistory_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_account` int unsigned NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `record_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tier` int unsigned DEFAULT NULL,
  `project_limit` int unsigned DEFAULT NULL,
  `billing_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int unsigned DEFAULT NULL,
  `base_projects` int unsigned DEFAULT NULL,
  `base_price` int unsigned DEFAULT NULL,
  `additional_products_price` int unsigned DEFAULT NULL,
  `features_price` int unsigned DEFAULT NULL,
  `days_in_force` int GENERATED ALWAYS AS ((to_days(cast(`end_date` as date)) - to_days(cast(`start_date` as date)))) STORED,
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`tierhistory_id`),
  KEY `fk_account` (`fk_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tierhistory_backup`
--

DROP TABLE IF EXISTS `tierhistory_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tierhistory_backup` (
  `tierhistory_id` int NOT NULL AUTO_INCREMENT,
  `fk_account` int NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `record_type` varchar(30) DEFAULT NULL,
  `description` text NOT NULL,
  `tier` int DEFAULT NULL,
  `project_limit` int DEFAULT NULL,
  `number` int DEFAULT NULL,
  `base_projects` int DEFAULT NULL,
  `base_price` int DEFAULT NULL,
  `additional_products_price` int DEFAULT NULL,
  `features_price` int DEFAULT NULL,
  `billing_method` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`tierhistory_id`),
  KEY `fk_account` (`fk_account`)
) ENGINE=InnoDB AUTO_INCREMENT=3595 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `refresh_token` varchar(255) NOT NULL,
  `access_token` varchar(255) NOT NULL,
  `expires_at` bigint NOT NULL,
  `expires_in` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `type_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_discipline` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `model_number` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`type_id`),
  KEY `type-person__created` (`fk_person__created`),
  KEY `type-person__modified` (`fk_person__modified`),
  KEY `project-deleted` (`fk_project`,`is_deleted`),
  CONSTRAINT `type-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `type-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `typeattribute`
--

DROP TABLE IF EXISTS `typeattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `typeattribute` (
  `typeattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_type` int unsigned NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`typeattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_type` (`fk_type`),
  KEY `typeattribute-person__created` (`fk_person__created`),
  KEY `typeattribute-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `typeattribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `typeattribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watch`
--

DROP TABLE IF EXISTS `watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `watch` (
  `watch_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `table` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `id` int unsigned DEFAULT NULL,
  `fk_person` int unsigned DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`watch_id`),
  KEY `watch-person__created` (`fk_person__created`),
  KEY `watch-person__modified` (`fk_person__modified`),
  KEY `project-table-person` (`fk_project`,`table`(191),`fk_person`),
  CONSTRAINT `watch-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `watch-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zone`
--

DROP TABLE IF EXISTS `zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zone` (
  `zone_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_building` int unsigned DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  `nat_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`zone_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_building` (`fk_building`),
  KEY `zone-person__created` (`fk_person__created`),
  KEY `zone-person__modified` (`fk_person__modified`),
  CONSTRAINT `zone-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `zone-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9320 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zoneattribute`
--

DROP TABLE IF EXISTS `zoneattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zoneattribute` (
  `zoneattribute_id` int unsigned NOT NULL AUTO_INCREMENT,
  `fk_project` int unsigned NOT NULL,
  `fk_attribute` int unsigned NOT NULL,
  `fk_zone` int unsigned NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `force_verified` tinyint unsigned NOT NULL DEFAULT '0',
  `force_verified_comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fk_person__created` int unsigned DEFAULT NULL,
  `fk_person__modified` int unsigned DEFAULT NULL,
  `dt_created` datetime DEFAULT NULL,
  `dt_modified` datetime DEFAULT NULL,
  `ts_created` datetime DEFAULT NULL,
  `ts_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`zoneattribute_id`),
  KEY `fk_project` (`fk_project`),
  KEY `fk_zone` (`fk_zone`),
  KEY `zoneattribute-person__created` (`fk_person__created`),
  KEY `zoneattribute-person__modified` (`fk_person__modified`),
  KEY `fk_attribute` (`fk_attribute`),
  CONSTRAINT `zoneattribute-person__created` FOREIGN KEY (`fk_person__created`) REFERENCES `person` (`person_id`),
  CONSTRAINT `zoneattribute-person__modified` FOREIGN KEY (`fk_person__modified`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-30 16:04:13
