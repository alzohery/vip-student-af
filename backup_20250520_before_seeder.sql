-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: vip_student
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_log_translations`
--

DROP TABLE IF EXISTS `admin_log_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_log_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `admin_log_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'الإجراء مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_log_trans_unique` (`admin_log_id`,`locale`),
  KEY `admin_log_trans_locale_foreign` (`locale`),
  CONSTRAINT `admin_log_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `admin_log_translations_admin_log_id_foreign` FOREIGN KEY (`admin_log_id`) REFERENCES `admin_logs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_log_translations`
--

LOCK TABLES `admin_log_translations` WRITE;
/*!40000 ALTER TABLE `admin_log_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_log_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_logs`
--

DROP TABLE IF EXISTS `admin_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `admin_logs_admin_id_index` (`admin_id`),
  CONSTRAINT `admin_logs_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_logs`
--

LOCK TABLES `admin_logs` WRITE;
/*!40000 ALTER TABLE `admin_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `answer_text` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `answers_question_id_index` (`question_id`),
  KEY `answers_student_id_index` (`student_id`),
  CONSTRAINT `answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `answers_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendances` (
  `student_id` bigint unsigned NOT NULL,
  `lesson_id` bigint unsigned NOT NULL,
  `attended_at` timestamp NULL DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`student_id`,`lesson_id`),
  KEY `attendances_lesson_id_index` (`lesson_id`),
  CONSTRAINT `attendances_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendances_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log_translations`
--

DROP TABLE IF EXISTS `audit_log_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `audit_log_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'الإجراء مترجم',
  `old_value` text COLLATE utf8mb4_unicode_ci COMMENT 'القيمة القديمة مترجمة',
  `new_value` text COLLATE utf8mb4_unicode_ci COMMENT 'القيمة الجديدة مترجمة',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `audit_log_translations_audit_log_id_locale_unique` (`audit_log_id`,`locale`),
  KEY `audit_log_translations_locale_foreign` (`locale`),
  CONSTRAINT `audit_log_translations_audit_log_id_foreign` FOREIGN KEY (`audit_log_id`) REFERENCES `audit_logs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `audit_log_translations_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log_translations`
--

LOCK TABLES `audit_log_translations` WRITE;
/*!40000 ALTER TABLE `audit_log_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم الجدول الذي تم تعديله',
  `record_id` bigint unsigned NOT NULL COMMENT 'معرف السجل الذي تم تعديله',
  `changed_by` bigint unsigned NOT NULL,
  `changed_at` timestamp NOT NULL COMMENT 'وقت التعديل',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `audit_logs_changed_by_index` (`changed_by`),
  KEY `audit_logs_table_name_record_id_index` (`table_name`,`record_id`),
  CONSTRAINT `audit_logs_changed_by_foreign` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_translations`
--

DROP TABLE IF EXISTS `category_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم التصنيف مترجم',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'وصف التصنيف مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_trans_unique` (`category_id`,`locale`),
  KEY `category_trans_locale_foreign` (`locale`),
  CONSTRAINT `category_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_translations`
--

LOCK TABLES `category_translations` WRITE;
/*!40000 ALTER TABLE `category_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `country_id` bigint unsigned DEFAULT NULL COMMENT 'معرف الدولة (يمكن إضافته لاحقًا إذا لزم)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,NULL,'2025-05-12 14:08:51','2025-05-12 14:08:51'),(2,NULL,'2025-05-12 14:08:51','2025-05-12 14:08:51');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city_translations`
--

DROP TABLE IF EXISTS `city_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `city_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم المدينة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `city_trans_unique` (`city_id`,`locale`),
  KEY `city_trans_locale_foreign` (`locale`),
  CONSTRAINT `city_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `city_translations_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_translations`
--

LOCK TABLES `city_translations` WRITE;
/*!40000 ALTER TABLE `city_translations` DISABLE KEYS */;
INSERT INTO `city_translations` VALUES (1,1,'ar','القاهرة','2025-05-12 14:08:51','2025-05-12 14:08:51'),(2,1,'en','Cairo','2025-05-12 14:08:51','2025-05-12 14:08:51'),(3,2,'ar','الرياض','2025-05-12 14:08:51','2025-05-12 14:08:51'),(4,2,'en','Riyadh','2025-05-12 14:08:51','2025-05-12 14:08:51');
/*!40000 ALTER TABLE `city_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_categories`
--

DROP TABLE IF EXISTS `course_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_categories` (
  `course_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`course_id`,`category_id`),
  KEY `course_categories_category_id_foreign` (`category_id`),
  CONSTRAINT `course_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_categories_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_categories`
--

LOCK TABLES `course_categories` WRITE;
/*!40000 ALTER TABLE `course_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_comment_translations`
--

DROP TABLE IF EXISTS `course_comment_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_comment_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_comment_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'محتوى التعليق مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_comment_trans_unique` (`course_comment_id`,`locale`),
  KEY `course_comment_trans_locale_foreign` (`locale`),
  CONSTRAINT `course_comment_trans_id_foreign` FOREIGN KEY (`course_comment_id`) REFERENCES `course_comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_comment_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_comment_translations`
--

LOCK TABLES `course_comment_translations` WRITE;
/*!40000 ALTER TABLE `course_comment_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_comment_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_comments`
--

DROP TABLE IF EXISTS `course_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `rating_id` bigint unsigned DEFAULT NULL,
  `parent_comment_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `course_comments_course_id_foreign` (`course_id`),
  KEY `course_comments_user_id_foreign` (`user_id`),
  KEY `course_comments_rating_id_foreign` (`rating_id`),
  KEY `course_comments_parent_id_foreign` (`parent_comment_id`),
  CONSTRAINT `course_comments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_comments_parent_id_foreign` FOREIGN KEY (`parent_comment_id`) REFERENCES `course_comments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `course_comments_rating_id_foreign` FOREIGN KEY (`rating_id`) REFERENCES `ratings` (`id`) ON DELETE SET NULL,
  CONSTRAINT `course_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_comments`
--

LOCK TABLES `course_comments` WRITE;
/*!40000 ALTER TABLE `course_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_file_translations`
--

DROP TABLE IF EXISTS `course_file_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_file_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_file_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم الملف مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_file_trans_unique` (`course_file_id`,`locale`),
  KEY `course_file_trans_locale_foreign` (`locale`),
  CONSTRAINT `course_file_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `course_file_translations_course_file_id_foreign` FOREIGN KEY (`course_file_id`) REFERENCES `course_files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_file_translations`
--

LOCK TABLES `course_file_translations` WRITE;
/*!40000 ALTER TABLE `course_file_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_file_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_files`
--

DROP TABLE IF EXISTS `course_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'يجب حماية المسار',
  `uploaded_at` timestamp NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `course_files_course_id_index` (`course_id`),
  CONSTRAINT `course_files_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_files`
--

LOCK TABLES `course_files` WRITE;
/*!40000 ALTER TABLE `course_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_prices`
--

DROP TABLE IF EXISTS `course_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_prices` (
  `course_id` bigint unsigned NOT NULL,
  `currency_id` bigint unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`course_id`,`currency_id`),
  KEY `course_prices_currency_id_index` (`currency_id`),
  CONSTRAINT `course_prices_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_prices_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_prices`
--

LOCK TABLES `course_prices` WRITE;
/*!40000 ALTER TABLE `course_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_sub_categories`
--

DROP TABLE IF EXISTS `course_sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_sub_categories` (
  `course_id` bigint unsigned NOT NULL,
  `sub_category_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`course_id`,`sub_category_id`),
  KEY `course_sub_categories_sub_category_id_foreign` (`sub_category_id`),
  CONSTRAINT `course_sub_categories_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_sub_categories_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_sub_categories`
--

LOCK TABLES `course_sub_categories` WRITE;
/*!40000 ALTER TABLE `course_sub_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_tags`
--

DROP TABLE IF EXISTS `course_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_tags` (
  `course_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`course_id`,`tag_id`),
  KEY `course_tags_tag_id_foreign` (`tag_id`),
  CONSTRAINT `course_tags_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_tags`
--

LOCK TABLES `course_tags` WRITE;
/*!40000 ALTER TABLE `course_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_translations`
--

DROP TABLE IF EXISTS `course_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'عنوان الدورة مترجم',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'وصف الدورة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_trans_unique` (`course_id`,`locale`),
  KEY `course_trans_locale_foreign` (`locale`),
  CONSTRAINT `course_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `course_translations_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_translations`
--

LOCK TABLES `course_translations` WRITE;
/*!40000 ALTER TABLE `course_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_unit_translations`
--

DROP TABLE IF EXISTS `course_unit_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_unit_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_unit_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'عنوان الوحدة مترجم',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'وصف الوحدة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_unit_trans_unique` (`course_unit_id`,`locale`),
  KEY `course_unit_trans_locale_foreign` (`locale`),
  CONSTRAINT `course_unit_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `course_unit_translations_course_unit_id_foreign` FOREIGN KEY (`course_unit_id`) REFERENCES `course_units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_unit_translations`
--

LOCK TABLES `course_unit_translations` WRITE;
/*!40000 ALTER TABLE `course_unit_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_unit_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_units`
--

DROP TABLE IF EXISTS `course_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_units` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `order` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `course_units_course_id_index` (`course_id`),
  CONSTRAINT `course_units_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_units`
--

LOCK TABLES `course_units` WRITE;
/*!40000 ALTER TABLE `course_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint unsigned NOT NULL,
  `subject_id` bigint unsigned NOT NULL,
  `educational_system` enum('egyptian','british') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'egyptian',
  `registration_start_date` timestamp NULL DEFAULT NULL,
  `registration_end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `courses_institute_id_index` (`institute_id`),
  KEY `courses_subject_id_index` (`subject_id`),
  CONSTRAINT `courses_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `courses_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'هل هذه هي العملة الأساسية؟',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_translations`
--

DROP TABLE IF EXISTS `currency_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'رمز العملة (مثل USD, EGP)',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم العملة مترجم',
  `symbol` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رمز العملة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency_trans_unique` (`currency_id`,`locale`),
  KEY `currency_trans_locale_foreign` (`locale`),
  CONSTRAINT `currency_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `currency_translations_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_translations`
--

LOCK TABLES `currency_translations` WRITE;
/*!40000 ALTER TABLE `currency_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `currency_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `course_id` bigint unsigned NOT NULL,
  `enrollment_start_date` timestamp NULL DEFAULT NULL,
  `enrollment_end_date` timestamp NULL DEFAULT NULL,
  `enrollment_fee` decimal(8,2) DEFAULT NULL COMMENT 'قيمة الاشتراك بالعملة المحلية',
  `enrollment_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `enrollments_user_id_index` (`user_id`),
  KEY `enrollments_course_id_index` (`course_id`),
  CONSTRAINT `enrollments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_results`
--

DROP TABLE IF EXISTS `exam_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_results` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `exam_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `total_score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `exam_results_exam_id_index` (`exam_id`),
  KEY `exam_results_student_id_index` (`student_id`),
  CONSTRAINT `exam_results_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_results_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_results`
--

LOCK TABLES `exam_results` WRITE;
/*!40000 ALTER TABLE `exam_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_translations`
--

DROP TABLE IF EXISTS `exam_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `exam_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'عنوان الاختبار مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_trans_unique` (`exam_id`,`locale`),
  KEY `exam_trans_locale_foreign` (`locale`),
  CONSTRAINT `exam_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `exam_translations_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_translations`
--

LOCK TABLES `exam_translations` WRITE;
/*!40000 ALTER TABLE `exam_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `lesson_id` bigint unsigned DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `test_type` enum('multiple','true_or_false','text') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'multiple',
  `number_of_questions` int DEFAULT NULL,
  `passing_grade` decimal(5,2) DEFAULT NULL,
  `final_score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `exams_course_id_index` (`course_id`),
  KEY `exams_lesson_id_index` (`lesson_id`),
  CONSTRAINT `exams_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exams_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq_translations`
--

DROP TABLE IF EXISTS `faq_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `faq_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'السؤال مترجم',
  `answer` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'الإجابة مترجمة',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `faq_trans_unique` (`faq_id`,`locale`),
  KEY `faq_trans_locale_foreign` (`locale`),
  CONSTRAINT `faq_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `faq_translations_faq_id_foreign` FOREIGN KEY (`faq_id`) REFERENCES `faqs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq_translations`
--

LOCK TABLES `faq_translations` WRITE;
/*!40000 ALTER TABLE `faq_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `favorite_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `favorite_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_favorite` (`user_id`,`favorite_type`,`favorite_id`),
  CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guardian_student`
--

DROP TABLE IF EXISTS `guardian_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guardian_student` (
  `guardian_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`guardian_id`,`student_id`),
  KEY `guardian_student_student_id_foreign` (`student_id`),
  CONSTRAINT `guardian_student_guardian_id_foreign` FOREIGN KEY (`guardian_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `guardian_student_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guardian_student`
--

LOCK TABLES `guardian_student` WRITE;
/*!40000 ALTER TABLE `guardian_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `guardian_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_announcement_translations`
--

DROP TABLE IF EXISTS `institute_announcement_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_announcement_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_announcement_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'عنوان الإعلان مترجم',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'وصف مختصر للإعلان مترجم',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT 'محتوى الإعلان مترجم',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رابط لصورة الإعلان مترجم إذا لزم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inst_announce_trans_unique` (`institute_announcement_id`,`locale`),
  KEY `inst_announce_trans_locale_foreign` (`locale`),
  CONSTRAINT `inst_announce_trans_id_foreign` FOREIGN KEY (`institute_announcement_id`) REFERENCES `institute_announcements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inst_announce_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_announcement_translations`
--

LOCK TABLES `institute_announcement_translations` WRITE;
/*!40000 ALTER TABLE `institute_announcement_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_announcement_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_announcements`
--

DROP TABLE IF EXISTS `institute_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_announcements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint unsigned NOT NULL,
  `target_audience` enum('students','parents','all') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all' COMMENT 'الجمهور المستهدف من الإعلان',
  `priority` int NOT NULL DEFAULT '0' COMMENT 'أولوية العرض (الأعلى أولاً)',
  `published_at` timestamp NULL DEFAULT NULL COMMENT 'وقت نشر الإعلان',
  `expiry_date` timestamp NULL DEFAULT NULL COMMENT 'تاريخ انتهاء صلاحية الإعلان',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'حالة الإعلان (نشط أو غير نشط)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `institute_announcements_institute_id_index` (`institute_id`),
  CONSTRAINT `institute_announcements_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_announcements`
--

LOCK TABLES `institute_announcements` WRITE;
/*!40000 ALTER TABLE `institute_announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_certificate_translations`
--

DROP TABLE IF EXISTS `institute_certificate_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_certificate_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_certificate_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `certificate_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم الشهادة مترجم',
  `certificate_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رابط أو مسار الملف مترجم إذا لزم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inst_cert_trans_unique` (`institute_certificate_id`,`locale`),
  KEY `inst_cert_trans_locale_foreign` (`locale`),
  CONSTRAINT `inst_cert_trans_cert_id_foreign` FOREIGN KEY (`institute_certificate_id`) REFERENCES `institute_certificates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inst_cert_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_certificate_translations`
--

LOCK TABLES `institute_certificate_translations` WRITE;
/*!40000 ALTER TABLE `institute_certificate_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_certificate_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_certificates`
--

DROP TABLE IF EXISTS `institute_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_certificates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint unsigned NOT NULL,
  `issued_at` date DEFAULT NULL,
  `expires_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `institute_certificates_institute_id_index` (`institute_id`),
  CONSTRAINT `institute_certificates_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_certificates`
--

LOCK TABLES `institute_certificates` WRITE;
/*!40000 ALTER TABLE `institute_certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_communication_translations`
--

DROP TABLE IF EXISTS `institute_communication_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_communication_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_communication_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'قيمة وسيلة التواصل مترجمة إذا لزم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inst_comm_trans_unique` (`institute_communication_id`,`locale`),
  KEY `inst_comm_trans_locale_foreign` (`locale`),
  CONSTRAINT `inst_comm_trans_comm_id_foreign` FOREIGN KEY (`institute_communication_id`) REFERENCES `institute_communications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inst_comm_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_communication_translations`
--

LOCK TABLES `institute_communication_translations` WRITE;
/*!40000 ALTER TABLE `institute_communication_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_communication_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_communications`
--

DROP TABLE IF EXISTS `institute_communications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_communications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint unsigned NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'مثل email, phone, website',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `institute_communications_institute_id_index` (`institute_id`),
  CONSTRAINT `institute_communications_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_communications`
--

LOCK TABLES `institute_communications` WRITE;
/*!40000 ALTER TABLE `institute_communications` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_communications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_owners`
--

DROP TABLE IF EXISTS `institute_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_owners` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `institute_owners_institute_id_index` (`institute_id`),
  KEY `institute_owners_user_id_index` (`user_id`),
  CONSTRAINT `institute_owners_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `institute_owners_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_owners`
--

LOCK TABLES `institute_owners` WRITE;
/*!40000 ALTER TABLE `institute_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute_translations`
--

DROP TABLE IF EXISTS `institute_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم المعهد مترجم',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'وصف المعهد مترجم',
  `fixed_address` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'العنوان الثابت مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inst_trans_unique` (`institute_id`,`locale`),
  KEY `inst_trans_locale_foreign` (`locale`),
  CONSTRAINT `inst_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `institute_translations_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute_translations`
--

LOCK TABLES `institute_translations` WRITE;
/*!40000 ALTER TABLE `institute_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `institute_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutes`
--

DROP TABLE IF EXISTS `institutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institutes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `city_id` bigint unsigned DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رابط شعار المعهد',
  `location_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رابط الموقع الجغرافي',
  `training_license` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رخصة مزاولة نشاط تدريبي',
  `commercial_registry` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'سجل تجاري ساري',
  `operating_license` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رخصة تشغيل المكان',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `institutes_city_id_foreign` (`city_id`),
  CONSTRAINT `institutes_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutes`
--

LOCK TABLES `institutes` WRITE;
/*!40000 ALTER TABLE `institutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `institutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_profiles`
--

DROP TABLE IF EXISTS `instructor_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `experience_years` int DEFAULT NULL,
  `experience_start_year` year DEFAULT NULL,
  `introduction_video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `instructor_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `instructor_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_profiles`
--

LOCK TABLES `instructor_profiles` WRITE;
/*!40000 ALTER TABLE `instructor_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_qualification_translations`
--

DROP TABLE IF EXISTS `instructor_qualification_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_qualification_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `instructor_qualification_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qualification_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم المؤهل مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inst_qual_trans_unique` (`instructor_qualification_id`,`locale`),
  KEY `inst_qual_trans_locale_foreign` (`locale`),
  CONSTRAINT `inst_qual_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `inst_qual_trans_qual_id_foreign` FOREIGN KEY (`instructor_qualification_id`) REFERENCES `instructor_qualifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_qualification_translations`
--

LOCK TABLES `instructor_qualification_translations` WRITE;
/*!40000 ALTER TABLE `instructor_qualification_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_qualification_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_qualifications`
--

DROP TABLE IF EXISTS `instructor_qualifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_qualifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `instructor_profile_id` bigint unsigned NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year_obtained` year DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `instructor_qualifications_instructor_profile_id_index` (`instructor_profile_id`),
  CONSTRAINT `instructor_qualifications_instructor_profile_id_foreign` FOREIGN KEY (`instructor_profile_id`) REFERENCES `instructor_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_qualifications`
--

LOCK TABLES `instructor_qualifications` WRITE;
/*!40000 ALTER TABLE `instructor_qualifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_qualifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_report_translations`
--

DROP TABLE IF EXISTS `instructor_report_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_report_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `instructor_report_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'اسم المادة مترجم',
  `performance_analysis` text COLLATE utf8mb4_unicode_ci COMMENT 'تحليل الأداء مترجم',
  `teacher_notes` text COLLATE utf8mb4_unicode_ci COMMENT 'ملاحظات المعلم مترجمة',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inst_report_trans_unique` (`instructor_report_id`,`locale`),
  KEY `inst_report_trans_locale_foreign` (`locale`),
  CONSTRAINT `inst_report_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `instructor_report_translations_instructor_report_id_foreign` FOREIGN KEY (`instructor_report_id`) REFERENCES `instructor_reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_report_translations`
--

LOCK TABLES `instructor_report_translations` WRITE;
/*!40000 ALTER TABLE `instructor_report_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_report_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_reports`
--

DROP TABLE IF EXISTS `instructor_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `instructor_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `course_id` bigint unsigned NOT NULL,
  `subject_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `instructor_reports_instructor_id_index` (`instructor_id`),
  KEY `instructor_reports_student_id_index` (`student_id`),
  KEY `instructor_reports_course_id_index` (`course_id`),
  KEY `instructor_reports_subject_id_index` (`subject_id`),
  CONSTRAINT `instructor_reports_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `instructor_reports_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `instructor_reports_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `instructor_reports_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_reports`
--

LOCK TABLES `instructor_reports` WRITE;
/*!40000 ALTER TABLE `instructor_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_subjects`
--

DROP TABLE IF EXISTS `instructor_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor_subjects` (
  `instructor_profile_id` bigint unsigned NOT NULL,
  `subject_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`instructor_profile_id`,`subject_id`),
  KEY `instructor_subjects_subject_id_foreign` (`subject_id`),
  CONSTRAINT `instructor_subjects_instructor_profile_id_foreign` FOREIGN KEY (`instructor_profile_id`) REFERENCES `instructor_profiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `instructor_subjects_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_subjects`
--

LOCK TABLES `instructor_subjects` WRITE;
/*!40000 ALTER TABLE `instructor_subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'رمز اللغة (مثل en, ar)',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم اللغة (مثل English, العربية)',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `languages_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'en','English',1,'2025-05-12 14:08:51','2025-05-12 14:08:51'),(2,'ar','العربية',0,'2025-05-12 14:08:51','2025-05-12 14:08:51');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_stage_translations`
--

DROP TABLE IF EXISTS `learning_stage_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_stage_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `learning_stage_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم المرحلة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `learn_stage_trans_unique` (`learning_stage_id`,`locale`),
  KEY `learn_stage_trans_locale_foreign` (`locale`),
  CONSTRAINT `learn_stage_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `learning_stage_translations_learning_stage_id_foreign` FOREIGN KEY (`learning_stage_id`) REFERENCES `learning_stages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_stage_translations`
--

LOCK TABLES `learning_stage_translations` WRITE;
/*!40000 ALTER TABLE `learning_stage_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_stage_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_stages`
--

DROP TABLE IF EXISTS `learning_stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_stages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_stages`
--

LOCK TABLES `learning_stages` WRITE;
/*!40000 ALTER TABLE `learning_stages` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_stages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson_translations`
--

DROP TABLE IF EXISTS `lesson_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lesson_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'عنوان الدرس مترجم',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'وصف الدرس مترجم',
  `lesson_venue` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'مكان الدرس مترجم إذا لزم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lesson_trans_unique` (`lesson_id`,`locale`),
  KEY `lesson_trans_locale_foreign` (`locale`),
  CONSTRAINT `lesson_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `lesson_translations_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson_translations`
--

LOCK TABLES `lesson_translations` WRITE;
/*!40000 ALTER TABLE `lesson_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `lesson_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lessons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_unit_id` bigint unsigned NOT NULL,
  `instructor_id` bigint unsigned NOT NULL,
  `learning_stage_id` bigint unsigned DEFAULT NULL,
  `study_level_id` bigint unsigned DEFAULT NULL,
  `section_id` bigint unsigned DEFAULT NULL,
  `lesson_type` enum('online','offline','recorded','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'online',
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'يجب حماية المسار',
  `lesson_duration` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `lessons_learning_stage_id_foreign` (`learning_stage_id`),
  KEY `lessons_study_level_id_foreign` (`study_level_id`),
  KEY `lessons_section_id_foreign` (`section_id`),
  KEY `lessons_course_unit_id_index` (`course_unit_id`),
  KEY `lessons_instructor_id_index` (`instructor_id`),
  CONSTRAINT `lessons_course_unit_id_foreign` FOREIGN KEY (`course_unit_id`) REFERENCES `course_units` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lessons_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lessons_learning_stage_id_foreign` FOREIGN KEY (`learning_stage_id`) REFERENCES `learning_stages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lessons_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lessons_study_level_id_foreign` FOREIGN KEY (`study_level_id`) REFERENCES `study_levels` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons`
--

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;
/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (183,'0001_01_01_000001_create_cache_table',1),(184,'0001_01_01_000002_create_jobs_table',1),(185,'2025_05_07_092301_create_languages_table',1),(186,'2025_05_07_092302_create_cities_table',1),(187,'2025_05_07_092303_create_city_translations_table',1),(188,'2025_05_07_092305_create_roles_table',1),(189,'2025_05_07_092306_create_role_translations_table',1),(190,'2025_05_07_092307_create_permissions_table',1),(191,'2025_05_07_092308_create_permission_translations_table',1),(192,'2025_05_07_092310_create_role_permissions_table',1),(193,'2025_05_07_092312_create_permission_grants_table',1),(194,'2025_05_07_092313_create_learning_stages_table',1),(195,'2025_05_07_092316_create_learning_stage_translations_table',1),(196,'2025_05_07_092317_create_study_levels_table',1),(197,'2025_05_07_092319_create_study_level_translations_table',1),(198,'2025_05_07_092320_create_sections_table',1),(199,'2025_05_07_092322_create_section_translations_table',1),(200,'2025_05_07_092323_create_institutes_table',1),(201,'2025_05_07_092324_create_institute_translations_table',1),(202,'2025_05_07_092325_create_institute_certificates_table',1),(203,'2025_05_07_092327_create_institute_certificate_translations_table',1),(204,'2025_05_07_092328_create_institute_communications_table',1),(205,'2025_05_07_092329_create_institute_communication_translations_table',1),(206,'2025_05_07_092330_create_subjects_table',1),(207,'2025_05_07_092331_create_subject_translations_table',1),(208,'2025_05_07_092332_create_users_table',1),(209,'2025_05_07_092334_create_institute_owners_table',1),(210,'2025_05_07_092335_create_student_profiles_table',1),(211,'2025_05_07_092336_create_instructor_profiles_table',1),(212,'2025_05_07_092337_create_instructor_qualifications_table',1),(213,'2025_05_07_092339_create_instructor_qualification_translations_table',1),(214,'2025_05_07_092340_create_instructor_subjects_table',1),(215,'2025_05_07_092341_create_courses_table',1),(216,'2025_05_07_092342_create_course_translations_table',1),(217,'2025_05_07_092343_create_course_units_table',1),(218,'2025_05_07_092345_create_course_unit_translations_table',1),(219,'2025_05_07_092346_create_lessons_table',1),(220,'2025_05_07_092347_create_lesson_translations_table',1),(221,'2025_05_07_092349_create_enrollments_table',1),(222,'2025_05_07_092350_create_guardian_student_table',1),(223,'2025_05_07_092352_create_instructor_reports_table',1),(224,'2025_05_07_092354_create_instructor_report_translations_table',1),(225,'2025_05_07_092355_create_exams_table',1),(226,'2025_05_07_092357_create_exam_translations_table',1),(227,'2025_05_07_092358_create_questions_table',1),(228,'2025_05_07_092359_create_question_translations_table',1),(229,'2025_05_07_092401_create_question_options_table',1),(230,'2025_05_07_092402_create_question_option_translations_table',1),(231,'2025_05_07_092403_create_answers_table',1),(232,'2025_05_07_092403_create_exam_results_table',1),(233,'2025_05_07_092405_create_currencies_table',1),(234,'2025_05_07_092406_create_currency_translations_table',1),(235,'2025_05_07_092407_create_payments_table',1),(236,'2025_05_07_092409_create_favorites_table',1),(237,'2025_05_07_092410_create_notifications_table',1),(238,'2025_05_07_092411_create_notification_translations_table',1),(239,'2025_05_07_092412_create_pages_table',1),(240,'2025_05_07_092414_create_page_translations_table',1),(241,'2025_05_07_092415_create_faqs_table',1),(242,'2025_05_07_092416_create_faq_translations_table',1),(243,'2025_05_07_092417_create_support_tickets_table',1),(244,'2025_05_07_092419_create_support_ticket_translations_table',1),(245,'2025_05_07_092420_create_ticket_messages_table',1),(246,'2025_05_07_092421_create_ticket_message_translations_table',1),(247,'2025_05_07_092423_create_admin_logs_table',1),(248,'2025_05_07_092424_create_admin_log_translations_table',1),(249,'2025_05_07_092425_create_site_settings_table',1),(250,'2025_05_07_092426_create_site_setting_translations_table',1),(251,'2025_05_07_092428_create_attendances_table',1),(252,'2025_05_07_092429_create_ratings_table',1),(253,'2025_05_07_092430_create_schedules_table',1),(254,'2025_05_07_092432_create_schedule_translations_table',1),(255,'2025_05_07_092433_create_course_files_table',1),(256,'2025_05_07_092434_create_course_file_translations_table',1),(257,'2025_05_07_092435_create_institute_announcements_table',1),(258,'2025_05_07_092437_create_institute_announcement_translations_table',1),(259,'2025_05_07_092438_create_course_comments_table',1),(260,'2025_05_07_092439_create_course_comment_translations_table',1),(261,'2025_05_07_092441_create_course_prices_table',1),(262,'2025_05_07_092442_create_categories_table',1),(263,'2025_05_07_092443_create_category_translations_table',1),(264,'2025_05_07_092445_create_sub_categories_table',1),(265,'2025_05_07_092446_create_sub_category_translations_table',1),(266,'2025_05_07_092447_create_tags_table',1),(267,'2025_05_07_092448_create_tag_translations_table',1),(268,'2025_05_07_092450_create_course_categories_table',1),(269,'2025_05_07_092451_create_course_sub_categories_table',1),(270,'2025_05_07_092452_create_course_tags_table',1),(271,'2025_05_07_092454_create_audit_logs_table',1),(272,'2025_05_07_092718_create_audit_log_translations_table',1),(273,'2025_05_10_090055_create_sessions_table',1),(274,'2025_05_19_141146_create_spatie_permission_tables',2),(275,'2025_05_19_162032_add_guard_name_to_roles_and_permissions_tables',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_type_model_id_index` (`model_type`,`model_id`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_type_model_id_index` (`model_type`,`model_id`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_translations`
--

DROP TABLE IF EXISTS `notification_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'محتوى الإشعار مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `notif_trans_unique` (`notification_id`,`locale`),
  KEY `notif_trans_locale_foreign` (`locale`),
  CONSTRAINT `notif_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `notification_translations_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_translations`
--

LOCK TABLES `notification_translations` WRITE;
/*!40000 ALTER TABLE `notification_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_index` (`user_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_translations`
--

DROP TABLE IF EXISTS `page_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `page_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'عنوان الصفحة مترجم',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Slug مترجم للروابط (مثل about, عنا)',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT 'محتوى الصفحة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `page_trans_unique` (`page_id`,`locale`),
  KEY `page_trans_locale_foreign` (`locale`),
  KEY `page_translations_slug_index` (`slug`),
  CONSTRAINT `page_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `page_translations_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_translations`
--

LOCK TABLES `page_translations` WRITE;
/*!40000 ALTER TABLE `page_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL COMMENT 'المبلغ المدفوع بالعملة المناسبة',
  `currency_id` bigint unsigned NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `payments_user_id_index` (`user_id`),
  KEY `payments_currency_id_index` (`currency_id`),
  CONSTRAINT `payments_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_grants`
--

DROP TABLE IF EXISTS `permission_grants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_grants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `permission_id` bigint unsigned NOT NULL,
  `granted_by_role_id` bigint unsigned NOT NULL,
  `granted_at` timestamp NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `permission_grants_role_id_index` (`role_id`),
  KEY `permission_grants_permission_id_index` (`permission_id`),
  KEY `permission_grants_granted_by_role_id_index` (`granted_by_role_id`),
  CONSTRAINT `permission_grants_granted_by_role_id_foreign` FOREIGN KEY (`granted_by_role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_grants_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_grants_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_grants`
--

LOCK TABLES `permission_grants` WRITE;
/*!40000 ALTER TABLE `permission_grants` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_grants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_translations`
--

DROP TABLE IF EXISTS `permission_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم الصلاحية مترجم',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'وصف الصلاحية مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `perm_trans_unique` (`permission_id`,`locale`),
  KEY `perm_trans_locale_foreign` (`locale`),
  CONSTRAINT `perm_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `permission_translations_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_translations`
--

LOCK TABLES `permission_translations` WRITE;
/*!40000 ALTER TABLE `permission_translations` DISABLE KEYS */;
INSERT INTO `permission_translations` VALUES (3,3,'en','Edit Users',NULL,'2025-05-19 13:47:59','2025-05-19 13:47:59'),(4,3,'ar','تعديل المستخدمين',NULL,'2025-05-19 13:47:59','2025-05-19 13:47:59');
/*!40000 ALTER TABLE `permission_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (2,'web','2025-05-19 09:24:17','2025-05-19 13:47:39'),(3,'web','2025-05-19 10:47:38','2025-05-19 13:47:39');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_option_translations`
--

DROP TABLE IF EXISTS `question_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_option_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question_option_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_text` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'نص الخيار مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_opt_trans_unique` (`question_option_id`,`locale`),
  KEY `question_opt_trans_locale_foreign` (`locale`),
  CONSTRAINT `question_opt_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `question_option_translations_question_option_id_foreign` FOREIGN KEY (`question_option_id`) REFERENCES `question_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_option_translations`
--

LOCK TABLES `question_option_translations` WRITE;
/*!40000 ALTER TABLE `question_option_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_option_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_options`
--

DROP TABLE IF EXISTS `question_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint unsigned NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `question_options_question_id_index` (`question_id`),
  CONSTRAINT `question_options_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_options`
--

LOCK TABLES `question_options` WRITE;
/*!40000 ALTER TABLE `question_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_translations`
--

DROP TABLE IF EXISTS `question_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'نص السؤال مترجم',
  `correct_answer` text COLLATE utf8mb4_unicode_ci COMMENT 'الإجابة الصحيحة مترجمة',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_trans_unique` (`question_id`,`locale`),
  KEY `question_trans_locale_foreign` (`locale`),
  CONSTRAINT `question_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `question_translations_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_translations`
--

LOCK TABLES `question_translations` WRITE;
/*!40000 ALTER TABLE `question_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `exam_id` bigint unsigned NOT NULL,
  `question_type` enum('multiple_choice','true_false','text') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'multiple_choice',
  `score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `questions_exam_id_index` (`exam_id`),
  CONSTRAINT `questions_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'معرف التقييم',
  `course_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `rating` tinyint unsigned NOT NULL COMMENT 'قيمة التقييم (1-5)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ratings_user_course_unique` (`user_id`,`course_id`),
  KEY `ratings_course_id_foreign` (`course_id`),
  CONSTRAINT `ratings_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_id` bigint unsigned NOT NULL,
  `permission_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `role_permissions_permission_id_foreign` (`permission_id`),
  CONSTRAINT `role_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (1,3,'2025-05-19 16:06:15','2025-05-19 16:06:15'),(9,2,'2025-05-19 12:24:17','2025-05-19 12:24:17');
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_translations`
--

DROP TABLE IF EXISTS `role_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم الدور مترجم (مثل Admin, مدير)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_trans_unique` (`role_id`,`locale`),
  KEY `role_trans_locale_foreign` (`locale`),
  CONSTRAINT `role_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `role_translations_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_translations`
--

LOCK TABLES `role_translations` WRITE;
/*!40000 ALTER TABLE `role_translations` DISABLE KEYS */;
INSERT INTO `role_translations` VALUES (1,1,'ar','مدير','2025-05-12 14:08:51','2025-05-12 14:08:51'),(2,1,'en','Admin','2025-05-12 14:08:51','2025-05-12 14:08:51'),(3,2,'ar','مدرب','2025-05-12 14:08:51','2025-05-12 14:08:51'),(4,2,'en','Instructor','2025-05-12 14:08:51','2025-05-12 14:08:51'),(5,3,'ar','طالب','2025-05-12 14:08:51','2025-05-12 14:08:51'),(6,3,'en','Student','2025-05-12 14:08:51','2025-05-12 14:08:51'),(7,5,'en','Admin','2025-05-18 11:17:01','2025-05-18 11:17:01'),(8,5,'ar','مدير','2025-05-18 11:17:13','2025-05-18 11:17:13'),(9,8,'en','Admin','2025-05-18 11:36:18','2025-05-18 11:36:18'),(10,8,'ar','مدير','2025-05-18 11:36:51','2025-05-18 11:36:51'),(11,10,'en','Admin','2025-05-19 12:27:27','2025-05-19 12:27:27');
/*!40000 ALTER TABLE `role_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `level` int NOT NULL COMMENT 'مستوى الدور في الهيكل الإداري (الأقل قيمة للأعلى)',
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,1,'web','2025-05-12 14:08:51','2025-05-19 13:47:33'),(2,2,'web','2025-05-12 14:08:51','2025-05-19 13:47:33'),(3,3,'web','2025-05-12 14:08:51','2025-05-19 13:47:33'),(4,1,'web','2025-05-18 07:57:20','2025-05-19 13:47:33'),(5,1,'web','2025-05-18 07:58:52','2025-05-19 13:47:33'),(6,1,'web','2025-05-18 08:00:50','2025-05-19 13:47:33'),(7,2,'web','2025-05-18 08:27:40','2025-05-19 13:47:33'),(8,1,'web','2025-05-18 08:29:22','2025-05-19 13:47:33'),(9,1,'web','2025-05-19 09:24:16','2025-05-19 13:47:33'),(10,1,'web','2025-05-19 09:24:52','2025-05-19 13:47:33');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_translations`
--

DROP TABLE IF EXISTS `schedule_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'الموقع مترجم إذا لزم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `schedule_trans_unique` (`schedule_id`,`locale`),
  KEY `schedule_trans_locale_foreign` (`locale`),
  CONSTRAINT `schedule_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `schedule_translations_schedule_id_foreign` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_translations`
--

LOCK TABLES `schedule_translations` WRITE;
/*!40000 ALTER TABLE `schedule_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lesson_id` bigint unsigned NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `schedules_lesson_start_unique` (`lesson_id`,`start_time`),
  KEY `schedules_time_idx` (`start_time`,`end_time`),
  CONSTRAINT `schedules_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_translations`
--

DROP TABLE IF EXISTS `section_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `section_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم القسم مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `section_trans_unique` (`section_id`,`locale`),
  KEY `section_trans_locale_foreign` (`locale`),
  CONSTRAINT `section_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `section_translations_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_translations`
--

LOCK TABLES `section_translations` WRITE;
/*!40000 ALTER TABLE `section_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `section_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `level_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `sections_level_id_index` (`level_id`),
  CONSTRAINT `sections_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `study_levels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_setting_translations`
--

DROP TABLE IF EXISTS `site_setting_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_setting_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_setting_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'مفتاح الإعداد مترجم',
  `value` text COLLATE utf8mb4_unicode_ci COMMENT 'قيمة الإعداد مترجمة إذا لزم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_setting_trans_unique` (`site_setting_id`,`locale`),
  KEY `site_setting_trans_locale_foreign` (`locale`),
  CONSTRAINT `site_setting_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `site_setting_translations_site_setting_id_foreign` FOREIGN KEY (`site_setting_id`) REFERENCES `site_settings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_setting_translations`
--

LOCK TABLES `site_setting_translations` WRITE;
/*!40000 ALTER TABLE `site_setting_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_setting_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_settings`
--

DROP TABLE IF EXISTS `site_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_settings`
--

LOCK TABLES `site_settings` WRITE;
/*!40000 ALTER TABLE `site_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_profiles`
--

DROP TABLE IF EXISTS `student_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `learning_stage_id` bigint unsigned DEFAULT NULL,
  `study_level_id` bigint unsigned DEFAULT NULL,
  `section_id` bigint unsigned DEFAULT NULL,
  `national_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'للأولياء أو الطلاب',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `student_profiles_user_id_foreign` (`user_id`),
  KEY `student_profiles_learning_stage_id_index` (`learning_stage_id`),
  KEY `student_profiles_study_level_id_index` (`study_level_id`),
  KEY `student_profiles_section_id_index` (`section_id`),
  CONSTRAINT `student_profiles_learning_stage_id_foreign` FOREIGN KEY (`learning_stage_id`) REFERENCES `learning_stages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `student_profiles_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE SET NULL,
  CONSTRAINT `student_profiles_study_level_id_foreign` FOREIGN KEY (`study_level_id`) REFERENCES `study_levels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `student_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_profiles`
--

LOCK TABLES `student_profiles` WRITE;
/*!40000 ALTER TABLE `student_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_level_translations`
--

DROP TABLE IF EXISTS `study_level_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_level_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `study_level_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم المستوى مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `study_level_trans_unique` (`study_level_id`,`locale`),
  KEY `study_level_trans_locale_foreign` (`locale`),
  CONSTRAINT `study_level_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `study_level_translations_study_level_id_foreign` FOREIGN KEY (`study_level_id`) REFERENCES `study_levels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_level_translations`
--

LOCK TABLES `study_level_translations` WRITE;
/*!40000 ALTER TABLE `study_level_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `study_level_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_levels`
--

DROP TABLE IF EXISTS `study_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_levels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stage_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `study_levels_stage_id_index` (`stage_id`),
  CONSTRAINT `study_levels_stage_id_foreign` FOREIGN KEY (`stage_id`) REFERENCES `learning_stages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_levels`
--

LOCK TABLES `study_levels` WRITE;
/*!40000 ALTER TABLE `study_levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `study_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `sub_categories_category_id_index` (`category_id`),
  CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_category_translations`
--

DROP TABLE IF EXISTS `sub_category_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_category_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sub_category_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم التصنيف الفرعي مترجم',
  `description` text COLLATE utf8mb4_unicode_ci COMMENT 'وصف التصنيف الفرعي مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_category_trans_unique` (`sub_category_id`,`locale`),
  KEY `sub_category_trans_locale_foreign` (`locale`),
  CONSTRAINT `sub_category_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `sub_category_translations_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_category_translations`
--

LOCK TABLES `sub_category_translations` WRITE;
/*!40000 ALTER TABLE `sub_category_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_category_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_translations`
--

DROP TABLE IF EXISTS `subject_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم المادة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_trans_unique` (`subject_id`,`locale`),
  KEY `subject_trans_locale_foreign` (`locale`),
  CONSTRAINT `subject_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `subject_translations_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_translations`
--

LOCK TABLES `subject_translations` WRITE;
/*!40000 ALTER TABLE `subject_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `section_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `subjects_section_id_index` (`section_id`),
  CONSTRAINT `subjects_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_ticket_translations`
--

DROP TABLE IF EXISTS `support_ticket_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_ticket_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `support_ticket_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'موضوع التذكرة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `support_ticket_trans_unique` (`support_ticket_id`,`locale`),
  KEY `support_ticket_trans_locale_foreign` (`locale`),
  CONSTRAINT `support_ticket_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `support_ticket_translations_support_ticket_id_foreign` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_ticket_translations`
--

LOCK TABLES `support_ticket_translations` WRITE;
/*!40000 ALTER TABLE `support_ticket_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_ticket_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `support_tickets_user_id_index` (`user_id`),
  CONSTRAINT `support_tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_tickets`
--

LOCK TABLES `support_tickets` WRITE;
/*!40000 ALTER TABLE `support_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_translations`
--

DROP TABLE IF EXISTS `tag_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'اسم الوسم مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_trans_unique` (`tag_id`,`locale`),
  KEY `tag_trans_locale_foreign` (`locale`),
  CONSTRAINT `tag_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE,
  CONSTRAINT `tag_translations_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_translations`
--

LOCK TABLES `tag_translations` WRITE;
/*!40000 ALTER TABLE `tag_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_message_translations`
--

DROP TABLE IF EXISTS `ticket_message_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_message_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_message_id` bigint unsigned NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'نص الرسالة مترجم',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_msg_trans_unique` (`ticket_message_id`,`locale`),
  KEY `ticket_msg_trans_locale_foreign` (`locale`),
  CONSTRAINT `ticket_message_translations_ticket_message_id_foreign` FOREIGN KEY (`ticket_message_id`) REFERENCES `ticket_messages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_msg_trans_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `languages` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_message_translations`
--

LOCK TABLES `ticket_message_translations` WRITE;
/*!40000 ALTER TABLE `ticket_message_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_message_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_messages`
--

DROP TABLE IF EXISTS `ticket_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `sender_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  KEY `ticket_messages_ticket_id_index` (`ticket_id`),
  KEY `ticket_messages_sender_id_index` (`sender_id`),
  CONSTRAINT `ticket_messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_messages_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `support_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_messages`
--

LOCK TABLES `ticket_messages` WRITE;
/*!40000 ALTER TABLE `ticket_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `institute_id` bigint unsigned DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'يجب تشفير كلمة المرور',
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `city_id` bigint unsigned DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ الإنشاء',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'تاريخ التحديث',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_index` (`role_id`),
  KEY `users_institute_id_index` (`institute_id`),
  KEY `users_city_id_index` (`city_id`),
  CONSTRAINT `users_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL,
  CONSTRAINT `users_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,NULL,'Admin User','admin@vipstudent.com','$2y$12$HrJYFQg4pVbLrM4M/tUv/OooeGPfxKhzrQcjaN3QNg7OLoh4lgomS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-12 14:08:51','2025-05-12 14:08:51'),(2,1,NULL,'Test User','test@example.com','$2y$12$RpehYdpO4kBQKr0aWL8SG.ecxYkfCq/3aHBMz5IJBPTVjq8NC83VK',NULL,NULL,NULL,NULL,NULL,'+1234567890',NULL,NULL,'2025-05-18 07:56:38','2025-05-18 07:56:38'),(5,8,NULL,'Test User tow','test_tow@example.com','$2y$12$HrEkuoidzQLrdpF6kfIEo.5HV0wvFhuCJhF.RkH9s1PRfL0A8TOG2',NULL,NULL,NULL,NULL,NULL,'+1234567890',NULL,NULL,'2025-05-18 08:49:55','2025-05-18 08:49:55'),(7,1,NULL,'Test User three','testthree@example.com','$2y$12$uTzp6eU2CJxPcIkdDDeu2ue3bcScQWpwhW.8fhjRS9srzaLibQX2q',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-19 09:21:37','2025-05-19 09:21:37');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20 13:08:25
