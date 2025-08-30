-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 30, 2025 at 06:04 AM
-- Server version: 8.0.42-0ubuntu0.22.04.1
-- PHP Version: 8.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bdland`
--

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_all_surveys`
--

CREATE TABLE `dlrms_all_surveys` (
  `id` int UNSIGNED NOT NULL COMMENT 'Primary identifier for the survey type',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Local (Bengali) name of the survey',
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English name of the survey',
  `key_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Short key/code for the survey (e.g., CS, RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_districts`
--

CREATE TABLE `dlrms_districts` (
  `id` int UNSIGNED NOT NULL COMMENT 'Primary identifier for the district',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Local (Bengali) name of the district',
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English name of the district',
  `bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'BBS code for the district',
  `division_bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BBS code for the parent division (redundant but provided)',
  `row_status` tinyint(1) DEFAULT '1',
  `division_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the division',
  `division_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Local (Bengali) name of the division (redundant)',
  `division_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English name of the division (redundant)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_divisions`
--

CREATE TABLE `dlrms_divisions` (
  `id` int UNSIGNED NOT NULL COMMENT 'Primary identifier for the division',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Local (Bengali) name of the division',
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English name of the division',
  `bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'BBS code for the division',
  `row_status` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians`
--

CREATE TABLE `dlrms_khatians` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza (redundant with jl_number_id link, but provided)',
  `khatian_no` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers associated with the Khatian',
  `owners` text COLLATE utf8mb4_unicode_ci COMMENT 'List of owners associated with the Khatian (often includes parentage/spouse info)',
  `guardians` text COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians, if applicable',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area associated with the Khatian (unit depends on context, likely acres or decimals)',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area, if applicable',
  `agoto_khatian_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number, if applicable (e.g., from previous survey)',
  `next_khatian_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number, if applicable (e.g., due to split)',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Type code for organization ownership (e.g., 2 might mean Govt)',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Status code related to segregation/partition',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Flag indicating if the Khatian record is locked (0 = No, 1 = Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'JSON array of message IDs related to non-deliverability',
  `canonical_khatian_no` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'A normalized or standard Khatian number',
  `survey_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type string used in request (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_BDS`
--

CREATE TABLE `dlrms_khatians_BDS` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_BRS`
--

CREATE TABLE `dlrms_khatians_BRS` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_BS`
--

CREATE TABLE `dlrms_khatians_BS` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_CS`
--

CREATE TABLE `dlrms_khatians_CS` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_CS_missing`
--

CREATE TABLE `dlrms_khatians_CS_missing` (
  `id` int UNSIGNED NOT NULL,
  `stat` int DEFAULT '0',
  `data` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_DIARA`
--

CREATE TABLE `dlrms_khatians_DIARA` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_PETY`
--

CREATE TABLE `dlrms_khatians_PETY` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_RS`
--

CREATE TABLE `dlrms_khatians_RS` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatians_SA`
--

CREATE TABLE `dlrms_khatians_SA` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Primary identifier for the Khatian index record',
  `jl_number_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The Khatian number (can be alphanumeric)',
  `office_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the land office',
  `khatian_entry_id` bigint UNSIGNED DEFAULT NULL COMMENT 'Specific entry ID for the Khatian',
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Dag (plot) numbers',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'List of guardians',
  `total_land` decimal(15,4) DEFAULT NULL COMMENT 'Total land area',
  `remaining_land` decimal(15,4) DEFAULT NULL COMMENT 'Remaining land area',
  `agoto_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous Khatian number',
  `next_khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Next Khatian number',
  `organization_type` tinyint DEFAULT NULL COMMENT 'Organization ownership type code',
  `segregation_status` tinyint DEFAULT NULL COMMENT 'Segregation/partition status code',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT 'Is locked (0=No, 1=Yes)',
  `non_deliverable_message_ids` json DEFAULT NULL COMMENT 'Non-deliverable message IDs',
  `canonical_khatian_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Standard Khatian number',
  `survey_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type (e.g., RS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatian_data`
--

CREATE TABLE `dlrms_khatian_data` (
  `id` int NOT NULL,
  `application_id` int NOT NULL COMMENT 'Unique ID from the API URL, for finding/updating records',
  `khatian_no` varchar(100) DEFAULT NULL,
  `survey_id` int DEFAULT NULL,
  `mouza_id` int DEFAULT NULL,
  `jl_number_id` int DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `raw_full_json` json DEFAULT NULL COMMENT 'Stores the complete, original JSON response',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_khatian_data_log`
--

CREATE TABLE `dlrms_khatian_data_log` (
  `id` int UNSIGNED NOT NULL,
  `startrange` bigint UNSIGNED NOT NULL,
  `endrange` bigint UNSIGNED NOT NULL,
  `stat` int DEFAULT '0',
  `aplid` int NOT NULL DEFAULT '0',
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_mouza_jl_numbers`
--

CREATE TABLE `dlrms_mouza_jl_numbers` (
  `id` int UNSIGNED NOT NULL COMMENT 'Unique identifier for this specific Mouza-JL Number-Survey combination',
  `mouza_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the Mouza',
  `ldtax_mouja_id` int NOT NULL DEFAULT '0',
  `mouza_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the Mouza (often in Bengali)',
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'UUID associated with the Mouza record',
  `jl_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Juristic List (JL) Number for the Mouza within the survey',
  `division_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the Division (often in Bengali)',
  `district_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the District (often in Bengali)',
  `upazila_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the Upazila (often in Bengali)',
  `survey_id` int UNSIGNED NOT NULL COMMENT 'Foreign key linking to the survey type',
  `mutation_survey_id` int UNSIGNED DEFAULT NULL COMMENT 'Identifier for the mutation survey, if applicable',
  `survey_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Local (Bengali) name of the survey (redundant but provided)',
  `survey_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English name of the survey (redundant but provided)',
  `mutation_survey_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Local (Bengali) name of the mutation survey',
  `mutation_survey_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English name of the mutation survey',
  `district_bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BBS Code for the District (from request)',
  `upazila_bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'BBS Code for the Upazila (from request)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `moustat` int NOT NULL DEFAULT '0',
  `ldtcon` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_mouza_jl_numbers_missing`
--

CREATE TABLE `dlrms_mouza_jl_numbers_missing` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'The missing ID from the parent table',
  `stat` int NOT NULL DEFAULT '0' COMMENT '0=Pending, 1=Success, 2=Processing, 4xx=Error',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'JSON response data from the API',
  `survey` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_mutation_khlist`
--

CREATE TABLE `dlrms_mutation_khlist` (
  `id` int UNSIGNED NOT NULL,
  `stat` tinyint DEFAULT '0',
  `time` int DEFAULT '0',
  `div8` int NOT NULL DEFAULT '0',
  `onl` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_src_names`
--

CREATE TABLE `dlrms_src_names` (
  `id` int NOT NULL,
  `survey_id` int NOT NULL DEFAULT '0',
  `owner` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `guardian` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `district_bbs_code` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `upazila_bbs_code` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resp` mediumtext COLLATE utf8mb4_general_ci,
  `time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_surveys`
--

CREATE TABLE `dlrms_surveys` (
  `survey_id` int UNSIGNED NOT NULL COMMENT 'Primary identifier for the survey type (e.g., 2 for RS)',
  `local_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Local (Bengali) name of the survey',
  `en_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `survey_order` int DEFAULT NULL COMMENT 'Ordering preference for the survey',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dlrms_upazilas`
--

CREATE TABLE `dlrms_upazilas` (
  `id` int UNSIGNED NOT NULL COMMENT 'Primary identifier for the upazila/circle',
  `lams_id` int UNSIGNED DEFAULT NULL COMMENT 'Specific ID from LAMS system, if applicable',
  `is_circle` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag: 1 if it is a Revenue Circle, 0 if regular Upazila',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Local (Bengali) name of the upazila/circle',
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English name of the upazila/circle',
  `bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'BBS code for the upazila/circle',
  `row_status` tinyint(1) DEFAULT '1',
  `division_bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Parent Division BBS code (redundant)',
  `division_id` int UNSIGNED NOT NULL COMMENT 'Foreign key to the division',
  `division_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Parent Division name (redundant)',
  `division_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Parent Division English name (redundant)',
  `district_bbs_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Parent District BBS code (redundant)',
  `district_id` int UNSIGNED NOT NULL COMMENT 'Foreign key to the district',
  `district_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Parent District name (redundant)',
  `district_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Parent District English name (redundant)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `time` int NOT NULL DEFAULT '0',
  `khtype` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mouzastat` int NOT NULL DEFAULT '0',
  `namjaristat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emouza_districts`
--

CREATE TABLE `emouza_districts` (
  `id` int NOT NULL,
  `division_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `google_drive_district_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stat` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emouza_divisions`
--

CREATE TABLE `emouza_divisions` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stat` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emouza_map_files`
--

CREATE TABLE `emouza_map_files` (
  `id` int NOT NULL,
  `survey_type_id` int NOT NULL,
  `mouza_id` int DEFAULT NULL,
  `jl_number_ref` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gdrive_folder_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_drive_file_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint DEFAULT NULL,
  `thumbnail_link` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stat` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emouza_mouzas`
--

CREATE TABLE `emouza_mouzas` (
  `id` int NOT NULL,
  `upazila_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jl_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stat` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emouza_survey_types`
--

CREATE TABLE `emouza_survey_types` (
  `id` int NOT NULL,
  `upazila_id` int NOT NULL,
  `folder_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `google_drive_folder_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stat` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emouza_upazilas`
--

CREATE TABLE `emouza_upazilas` (
  `id` int NOT NULL,
  `district_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `google_drive_upazila_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stat` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_core`
--

CREATE TABLE `holdings_core` (
  `id` bigint NOT NULL,
  `holding_no` varchar(100) DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `union_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `khotian_no` varchar(100) DEFAULT NULL,
  `holding_type` int DEFAULT '0',
  `status` tinyint DEFAULT '1',
  `is_archive` tinyint DEFAULT '0',
  `is_locked` tinyint DEFAULT '0',
  `is_hold` tinyint DEFAULT '0',
  `is_approve` tinyint DEFAULT '0',
  `paid_year` varchar(10) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `json_created_at` datetime DEFAULT NULL,
  `json_updated_at` datetime DEFAULT NULL,
  `json_modified_at` datetime DEFAULT NULL,
  `stat` int DEFAULT '1',
  `db_created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_details_main`
--

CREATE TABLE `holdings_details_main` (
  `auto_id` int NOT NULL,
  `json_source_id` varchar(50) DEFAULT NULL,
  `core_holding_id` bigint DEFAULT NULL,
  `holding_no` varchar(100) DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `district_name` varchar(255) DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `upazila_name` varchar(255) DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `mouja_name` varchar(255) DEFAULT NULL,
  `is_approve` tinyint DEFAULT '0',
  `tax_clear_year` varchar(10) DEFAULT NULL,
  `no_of_tax_pending_year` int DEFAULT '0',
  `due_demand` decimal(12,2) DEFAULT '0.00',
  `due_demand_interest` decimal(12,2) DEFAULT '0.00',
  `due_interest` decimal(12,2) DEFAULT '0.00',
  `total_demand` decimal(12,2) DEFAULT '0.00',
  `yearly_demand` decimal(12,2) DEFAULT '0.00',
  `current_demand` decimal(12,2) DEFAULT '0.00',
  `details_jwt` text,
  `citizen_id` bigint DEFAULT NULL,
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_districts`
--

CREATE TABLE `holdings_districts` (
  `id` int NOT NULL,
  `division_id` int DEFAULT NULL,
  `district_bbs_code` varchar(10) DEFAULT NULL,
  `name_bn` varchar(255) DEFAULT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT '0',
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_land_schedules`
--

CREATE TABLE `holdings_land_schedules` (
  `id` bigint NOT NULL,
  `holding_id` bigint DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `khotian_no` varchar(100) DEFAULT NULL,
  `dag_no` varchar(100) DEFAULT NULL,
  `land_type` varchar(50) DEFAULT NULL,
  `amount_of_land` decimal(12,4) DEFAULT '0.0000',
  `comments` text,
  `status` tinyint DEFAULT '1',
  `land_type_name` varchar(255) DEFAULT NULL,
  `json_created` datetime DEFAULT NULL,
  `json_modified` datetime DEFAULT NULL,
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_land_usage_tax`
--

CREATE TABLE `holdings_land_usage_tax` (
  `id` bigint NOT NULL,
  `holding_id` bigint DEFAULT NULL,
  `schedule_id` bigint DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `land_type` int DEFAULT NULL,
  `amount` decimal(12,4) DEFAULT '0.0000',
  `current_demand` decimal(12,2) DEFAULT '0.00',
  `before_third_year_dues` decimal(12,2) DEFAULT '0.00',
  `third_last_year_dues` decimal(12,2) DEFAULT '0.00',
  `second_last_year_dues` decimal(12,2) DEFAULT '0.00',
  `last_year_dues` decimal(12,2) DEFAULT '0.00',
  `current_year_dues` decimal(12,2) DEFAULT '0.00',
  `before_third_year_interest` decimal(12,2) DEFAULT '0.00',
  `third_last_year_interest` decimal(12,2) DEFAULT '0.00',
  `second_last_year_interest` decimal(12,2) DEFAULT '0.00',
  `last_year_interest` decimal(12,2) DEFAULT '0.00',
  `start_year` varchar(10) DEFAULT NULL,
  `end_year` varchar(10) DEFAULT NULL,
  `is_demand_calculated` tinyint DEFAULT '0',
  `json_created` datetime DEFAULT NULL,
  `json_modified` datetime DEFAULT NULL,
  `json_updated_at` datetime DEFAULT NULL,
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_moujas`
--

CREATE TABLE `holdings_moujas` (
  `id` int NOT NULL,
  `dglr_code` varchar(50) DEFAULT NULL,
  `name_bd` varchar(255) DEFAULT NULL,
  `jl_no` varchar(50) DEFAULT NULL,
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_offices`
--

CREATE TABLE `holdings_offices` (
  `id` int NOT NULL,
  `title_bn` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `office_type_name` varchar(100) DEFAULT NULL,
  `status` tinyint DEFAULT '0',
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_owners`
--

CREATE TABLE `holdings_owners` (
  `id` bigint NOT NULL,
  `ldtax_holding_id` bigint DEFAULT NULL,
  `citizen_id` bigint DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `address` text,
  `mobile_no` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nid` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `land_portion` decimal(10,4) DEFAULT '1.0000',
  `tax_clear_year` varchar(10) DEFAULT NULL,
  `json_created` datetime DEFAULT NULL,
  `json_modified` datetime DEFAULT NULL,
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holdings_upazilas`
--

CREATE TABLE `holdings_upazilas` (
  `id` int NOT NULL,
  `bbs_code` varchar(10) DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `name_bd` varchar(255) DEFAULT NULL,
  `name_en` varchar(255) DEFAULT NULL,
  `district_name` varchar(255) DEFAULT NULL,
  `division_name` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT '0',
  `stat` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `land_districts`
--

CREATE TABLE `land_districts` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'District Code from API',
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_bn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'FK to land_divisions.code',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `upzstat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Administrative Districts';

-- --------------------------------------------------------

--
-- Table structure for table `land_divisions`
--

CREATE TABLE `land_divisions` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Division Code from API',
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_bn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `drstat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Administrative Divisions';

-- --------------------------------------------------------

--
-- Table structure for table `land_mauzas`
--

CREATE TABLE `land_mauzas` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Mauza Code from API (JL No included)',
  `name_en` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_bn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `m_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Map Code (e.g., DHA_DHA, MYM_MYM)',
  `division_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Parent Division Code (from API)',
  `district_code` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Parent District Code (from API)',
  `thana_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'FK to land_thanas.code',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mouzdastat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Administrative Mauzas';

-- --------------------------------------------------------

--
-- Table structure for table `land_plots`
--

CREATE TABLE `land_plots` (
  `id` bigint UNSIGNED NOT NULL,
  `mauza_code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'FK to land_mauzas.code',
  `sht_no_en` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Sheet number within the Mauza',
  `plot_no_en` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Plot number/identifier English',
  `label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Plot Label Bengali',
  `jl_no_en` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JL Number from plot data (often part of mauza name)',
  `m_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Map Code (e.g., MYM_MYM_HAL_006_001_RS)',
  `gid` int UNSIGNED DEFAULT NULL COMMENT 'Original GID from source data',
  `geom` geometry NOT NULL COMMENT 'Plot geometry (requires MySQL spatial extensions)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Land Plots (Dag)';

-- --------------------------------------------------------

--
-- Table structure for table `land_sheets`
--

CREATE TABLE `land_sheets` (
  `id` bigint UNSIGNED NOT NULL,
  `mauza_code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'FK to land_mauzas.code',
  `sht_no_en` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Sheet Number English',
  `sht_label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Sheet Label Bengali',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Map Sheets within a Mauza';

-- --------------------------------------------------------

--
-- Table structure for table `land_thanas`
--

CREATE TABLE `land_thanas` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Thana/Upazila Code from API',
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_bn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Parent Division Code (from API)',
  `district_code` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'FK to land_districts.code',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `moustat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Administrative Thanas/Upazilas';

-- --------------------------------------------------------

--
-- Table structure for table `land_tools`
--

CREATE TABLE `land_tools` (
  `id` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'fa-solid fa-toolbox',
  `icon_color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'text-gray-500',
  `requires_login` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax2_holdings`
--

CREATE TABLE `ldtax2_holdings` (
  `id` bigint UNSIGNED NOT NULL,
  `holding_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `office_id` int DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `union_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `khotian_no` int DEFAULT '0',
  `survey` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holding_type` tinyint DEFAULT NULL,
  `entry_source` tinyint DEFAULT NULL,
  `land_manage_type` tinyint DEFAULT NULL,
  `housing_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `housing_sector` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `housing_block` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `housing_road` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `parent_holding_ids` text COLLATE utf8mb4_unicode_ci,
  `is_archive` tinyint DEFAULT NULL,
  `is_locked` tinyint DEFAULT NULL,
  `is_locked_back` tinyint DEFAULT NULL,
  `is_hold` tinyint DEFAULT NULL,
  `land_limit_crossed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_approve_bac` tinyint DEFAULT NULL,
  `is_approve` tinyint DEFAULT NULL,
  `edit_permission` tinyint DEFAULT NULL,
  `is_calculation` tinyint DEFAULT NULL,
  `is_result` tinyint DEFAULT NULL,
  `update_status` tinyint DEFAULT NULL,
  `reason_of_hold` text COLLATE utf8mb4_unicode_ci,
  `changes_of_rules` text COLLATE utf8mb4_unicode_ci,
  `comments` text COLLATE utf8mb4_unicode_ci,
  `paid_year` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `user_type_id` int DEFAULT NULL,
  `ownership_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `approved_date` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `stat` int NOT NULL DEFAULT '0',
  `dlen` int NOT NULL DEFAULT '0',
  `hstat` int NOT NULL DEFAULT '0',
  `dl_good` int NOT NULL DEFAULT '0',
  `tmpstat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax2_land_usage_info_tax`
--

CREATE TABLE `ldtax2_land_usage_info_tax` (
  `id` bigint UNSIGNED NOT NULL,
  `holding_id` bigint UNSIGNED NOT NULL,
  `schedule_id` bigint DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `land_type` int DEFAULT NULL,
  `upper` decimal(10,2) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `current_demand` decimal(10,2) DEFAULT NULL,
  `before_third_year_dues` decimal(10,2) DEFAULT NULL,
  `third_last_year_dues` decimal(10,2) DEFAULT NULL,
  `second_last_year_dues` decimal(10,2) DEFAULT NULL,
  `last_year_dues` decimal(10,2) DEFAULT NULL,
  `current_year_dues` decimal(10,2) DEFAULT NULL,
  `before_third_year_interest` decimal(10,2) DEFAULT NULL,
  `third_last_year_interest` decimal(10,2) DEFAULT NULL,
  `second_last_year_interest` decimal(10,2) DEFAULT NULL,
  `last_year_interest` decimal(10,2) DEFAULT NULL,
  `start_year` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_year` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `is_update` tinyint DEFAULT NULL,
  `is_demand_calculated` tinyint DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax2_moujas`
--

CREATE TABLE `ldtax2_moujas` (
  `id` int UNSIGNED NOT NULL,
  `dglr_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_bd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jl_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax2_representative_payment_requests`
--

CREATE TABLE `ldtax2_representative_payment_requests` (
  `id` bigint UNSIGNED NOT NULL,
  `holding_id` bigint UNSIGNED NOT NULL,
  `division_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `upazila_id` int DEFAULT NULL,
  `union_id` int DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `mouja_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `citizen_id` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_status` tinyint DEFAULT NULL,
  `is_approve` tinyint DEFAULT NULL,
  `cancel_reasons` text COLLATE utf8mb4_unicode_ci,
  `cancel_reasons_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax2_upazilas`
--

CREATE TABLE `ldtax2_upazilas` (
  `id` int UNSIGNED NOT NULL,
  `bbs_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `district_bbs_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division_id` int DEFAULT NULL,
  `division_bbs_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_bd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tmp_target_holding` int DEFAULT NULL,
  `status` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax_districts`
--

CREATE TABLE `ldtax_districts` (
  `id` int NOT NULL,
  `district_id` int NOT NULL COMMENT 'Source ID from ldtax website',
  `division_id` int NOT NULL COMMENT 'FK referencing ldtax_divisions.division_id',
  `district_bbs_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax_divisions`
--

CREATE TABLE `ldtax_divisions` (
  `id` int NOT NULL,
  `division_id` int NOT NULL COMMENT 'Source ID from ldtax website',
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax_moujas`
--

CREATE TABLE `ldtax_moujas` (
  `id` int NOT NULL,
  `mouja_id` int NOT NULL COMMENT 'Source ID from ldtax website',
  `dlrms_mouza_id` int NOT NULL DEFAULT '0',
  `dlrms_jl_number_id` int NOT NULL DEFAULT '0',
  `office_id` int NOT NULL COMMENT 'FK referencing ldtax_offices.office_id',
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Mapped from name_bd in JSON',
  `jl_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dglr_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stat` int NOT NULL DEFAULT '0',
  `upazila_id` int DEFAULT '0',
  `district_id` int DEFAULT '0',
  `division_id` int DEFAULT '0',
  `district_bbs_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division_bbs_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upazila_bbs_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxholdingid` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax_offices`
--

CREATE TABLE `ldtax_offices` (
  `id` int NOT NULL,
  `office_id` int NOT NULL COMMENT 'Source ID from ldtax website',
  `upazila_id` int DEFAULT NULL COMMENT 'FK referencing ldtax_upazilas.upazila_id',
  `district_id` int DEFAULT NULL COMMENT 'FK referencing ldtax_districts.district_id',
  `division_id` int DEFAULT NULL COMMENT 'FK referencing ldtax_divisions.division_id',
  `parent_office_id` int DEFAULT NULL COMMENT 'Source parent ID',
  `title_bn` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_en` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_office_id` int DEFAULT NULL,
  `layer_id` int DEFAULT NULL,
  `org_ibas_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `office_type_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_type_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_layer_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_layer_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_data_json` json DEFAULT NULL COMMENT 'Store the raw JSON for fields not explicitly mapped',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ldtax_upazilas`
--

CREATE TABLE `ldtax_upazilas` (
  `id` int NOT NULL,
  `upazila_id` int NOT NULL COMMENT 'Source ID from ldtax website',
  `district_id` int NOT NULL COMMENT 'FK referencing ldtax_districts.district_id',
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Mapped from name_bd in JSON',
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maps_files_eklas`
--

CREATE TABLE `maps_files_eklas` (
  `id` int NOT NULL,
  `google_file_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `parent_folder_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_folder` tinyint(1) NOT NULL DEFAULT '0',
  `size_bytes` bigint DEFAULT NULL,
  `google_modified_time` datetime DEFAULT NULL,
  `last_checked_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `totalfiles` int NOT NULL DEFAULT '0',
  `totalsize` bigint NOT NULL DEFAULT '0',
  `downloaded` int NOT NULL DEFAULT '0',
  `local` int NOT NULL DEFAULT '0',
  `local_path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maps_files_list`
--

CREATE TABLE `maps_files_list` (
  `id` int NOT NULL,
  `google_file_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_path` text COLLATE utf8mb4_unicode_ci,
  `parent_folder_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_folder` tinyint(1) NOT NULL DEFAULT '0',
  `size_bytes` bigint DEFAULT NULL,
  `google_modified_time` datetime DEFAULT NULL,
  `last_checked_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `totalfiles` int NOT NULL DEFAULT '0',
  `totalsize` bigint NOT NULL DEFAULT '0',
  `downloaded` int NOT NULL DEFAULT '0',
  `local` int NOT NULL DEFAULT '0',
  `local_path` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mouzamaptech_files`
--

CREATE TABLE `mouzamaptech_files` (
  `pk_id` int NOT NULL,
  `item_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(812) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `file_extension` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `download_link` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mouzamaptech_items`
--

CREATE TABLE `mouzamaptech_items` (
  `pk_id` int NOT NULL,
  `path` varchar(812) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_item_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_type` enum('folder','file') COLLATE utf8mb4_unicode_ci NOT NULL,
  `modified_time` datetime DEFAULT NULL,
  `drive_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `stat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mutation_khdl`
--

CREATE TABLE `mutation_khdl` (
  `id` int NOT NULL,
  `divid` int NOT NULL,
  `aid` int NOT NULL,
  `stat` int NOT NULL DEFAULT '0',
  `size` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `namjari_khatians`
--

CREATE TABLE `namjari_khatians` (
  `id` bigint UNSIGNED NOT NULL,
  `source_khatian_id` bigint DEFAULT NULL COMMENT 'ID from the source API Khatian item',
  `jl_number_id` int DEFAULT NULL COMMENT 'JL_NUMBER_ID from API, links to namjari_mouzas.source_id',
  `mouza_id` int DEFAULT NULL COMMENT 'MOUZA_ID from the source API (can be redundant)',
  `khatian_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  `khatian_entry_id` bigint DEFAULT NULL,
  `dags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of DAGs',
  `owners` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Owners',
  `guardians` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Comma-separated list of Guardians',
  `total_land` decimal(15,4) DEFAULT NULL,
  `remaining_land` decimal(15,4) DEFAULT NULL,
  `agoto_khatian_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_khatian_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_type` smallint DEFAULT NULL,
  `segregation_status` smallint DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT '0',
  `non_deliverable_message_ids_json` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON encoded array of message IDs',
  `canonical_khatian_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `survey_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey type used in the API request (e.g., MUTATION)',
  `fetch_page_no` int DEFAULT NULL COMMENT 'Page number fetched from the API',
  `fetch_page_size` int DEFAULT NULL COMMENT 'Page size used for the API fetch',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `namjari_mouzas`
--

CREATE TABLE `namjari_mouzas` (
  `id` bigint UNSIGNED NOT NULL,
  `source_id` int DEFAULT NULL COMMENT 'ID from the source API',
  `mouza_id` int DEFAULT NULL COMMENT 'MOUZA_ID from the source API',
  `mouza_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jl_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upazila_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `survey_id` int DEFAULT NULL,
  `mutation_survey_id` int DEFAULT NULL,
  `survey_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `survey_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mutation_survey_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mutation_survey_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `division_bbs_code` int NOT NULL DEFAULT '0',
  `district_bbs_code` int DEFAULT NULL COMMENT 'Context: District BBS code used for fetch',
  `upazila_bbs_code` int DEFAULT NULL COMMENT 'Context: Upazila BBS code used for fetch',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `khstat` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_districts`
--

CREATE TABLE `settlement_districts` (
  `id` int NOT NULL,
  `division_unitcod` varchar(50) DEFAULT NULL,
  `slnum` varchar(50) DEFAULT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `unitcod` varchar(50) NOT NULL,
  `unitnam` varchar(255) DEFAULT NULL,
  `unittype` varchar(100) DEFAULT NULL,
  `unitrefs` varchar(255) DEFAULT NULL,
  `ursstatus` varchar(50) DEFAULT NULL,
  `resanum` varchar(50) DEFAULT NULL,
  `geocode` varchar(50) DEFAULT NULL,
  `areatype` varchar(50) DEFAULT NULL,
  `areatypedes` varchar(255) DEFAULT NULL,
  `rowid` int DEFAULT NULL,
  `unitcod1` varchar(50) DEFAULT NULL,
  `unitdesc1` varchar(255) DEFAULT NULL,
  `unitdesc2` varchar(255) DEFAULT NULL,
  `fbold` varchar(50) DEFAULT NULL,
  `fcolor` varchar(50) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_divisions`
--

CREATE TABLE `settlement_divisions` (
  `id` int NOT NULL,
  `slnum` varchar(50) DEFAULT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `unitcod` varchar(50) NOT NULL,
  `unitnam` varchar(255) DEFAULT NULL,
  `unittype` varchar(100) DEFAULT NULL,
  `unitrefs` varchar(255) DEFAULT NULL,
  `ursstatus` varchar(50) DEFAULT NULL,
  `resanum` varchar(50) DEFAULT NULL,
  `geocode` varchar(50) DEFAULT NULL,
  `areatype` varchar(50) DEFAULT NULL,
  `areatypedes` varchar(255) DEFAULT NULL,
  `rowid` int DEFAULT NULL,
  `unitcod1` varchar(50) DEFAULT NULL,
  `unitdesc1` varchar(255) DEFAULT NULL,
  `unitdesc2` varchar(255) DEFAULT NULL,
  `fbold` varchar(50) DEFAULT NULL,
  `fcolor` varchar(50) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_khatian_headers`
--

CREATE TABLE `settlement_khatian_headers` (
  `id` int NOT NULL,
  `mouza_unitcod` varchar(50) NOT NULL,
  `survey_rsnum` varchar(50) NOT NULL,
  `khatnum` varchar(50) NOT NULL,
  `slnum1` int DEFAULT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `distdes` varchar(255) DEFAULT NULL,
  `thanades` varchar(255) DEFAULT NULL,
  `mouzades` varchar(255) DEFAULT NULL,
  `khtnumb` varchar(50) DEFAULT NULL,
  `ekhtnum` varchar(50) DEFAULT NULL,
  `pkhtnum` varchar(50) DEFAULT NULL,
  `shetnum` varchar(50) DEFAULT NULL,
  `ltcode` varchar(10) DEFAULT NULL,
  `ptitle` varchar(255) DEFAULT NULL,
  `kremark` text,
  `khtnote` text,
  `khtstatus` varchar(100) DEFAULT NULL,
  `khtnum1` decimal(10,2) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_khatian_owners`
--

CREATE TABLE `settlement_khatian_owners` (
  `id` int NOT NULL,
  `khatian_header_id` int DEFAULT NULL,
  `mouza_unitcod` varchar(50) NOT NULL,
  `survey_rsnum` varchar(50) NOT NULL,
  `khatnum_ref` varchar(50) NOT NULL,
  `slnum1` int DEFAULT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `ownrgrp` int DEFAULT NULL,
  `ownrnum` int DEFAULT NULL,
  `ownname` text,
  `nidnum` varchar(100) DEFAULT NULL,
  `bregnum` varchar(100) DEFAULT NULL,
  `fathernam` text,
  `mothernam` text,
  `spousenam` text,
  `phone01` varchar(50) DEFAULT NULL,
  `email01` varchar(100) DEFAULT NULL,
  `address01` text,
  `ownrarea` decimal(10,5) DEFAULT NULL,
  `khtnum1` decimal(10,2) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_khatian_plots`
--

CREATE TABLE `settlement_khatian_plots` (
  `id` int NOT NULL,
  `khatian_header_id` int DEFAULT NULL,
  `mouza_unitcod` varchar(50) NOT NULL,
  `survey_rsnum` varchar(50) NOT NULL,
  `khatnum_ref` varchar(50) NOT NULL,
  `slnum1` int DEFAULT NULL,
  `plot_slnum` varchar(50) NOT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `pltnum` varchar(50) DEFAULT NULL,
  `lucode` varchar(50) DEFAULT NULL,
  `lutype` varchar(100) DEFAULT NULL,
  `luname` varchar(255) DEFAULT NULL,
  `tpltarea` decimal(10,5) DEFAULT NULL,
  `khtshare` decimal(10,5) DEFAULT NULL,
  `kpltarea` decimal(10,5) DEFAULT NULL,
  `kpltrmrk` text,
  `skhtnum` varchar(50) DEFAULT NULL,
  `spltnum` varchar(50) DEFAULT NULL,
  `cpltnum` varchar(50) DEFAULT NULL,
  `khtnum1` decimal(10,2) DEFAULT NULL,
  `pltnum1` decimal(10,2) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_mouzas`
--

CREATE TABLE `settlement_mouzas` (
  `id` int NOT NULL,
  `thana_upzcod` varchar(50) DEFAULT NULL,
  `survey_rsnum` varchar(50) DEFAULT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `unitcod` varchar(50) NOT NULL,
  `unitnam` varchar(255) DEFAULT NULL,
  `upzcod` varchar(50) DEFAULT NULL,
  `upazila` varchar(255) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_sheets`
--

CREATE TABLE `settlement_sheets` (
  `id` int NOT NULL,
  `mouza_unitcod` varchar(50) DEFAULT NULL,
  `survey_rsnum` varchar(50) DEFAULT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `shetnum` varchar(50) NOT NULL,
  `mapref` text,
  `mapurl` text,
  `rsnumb` varchar(50) DEFAULT NULL,
  `shetnumb` varchar(50) DEFAULT NULL,
  `shetdesc` varchar(255) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_surveys`
--

CREATE TABLE `settlement_surveys` (
  `id` int NOT NULL,
  `district_unitcod` varchar(50) DEFAULT NULL,
  `district_comcod` varchar(10) DEFAULT NULL,
  `slnum` varchar(50) DEFAULT NULL,
  `rsnum` varchar(50) NOT NULL,
  `rsnumb` varchar(50) DEFAULT NULL,
  `rsname` varchar(255) DEFAULT NULL,
  `rsdesc` text,
  `rsstatus` varchar(100) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settlement_thanas`
--

CREATE TABLE `settlement_thanas` (
  `id` int NOT NULL,
  `district_unitcod` varchar(50) DEFAULT NULL,
  `survey_rsnum` varchar(50) DEFAULT NULL,
  `comcod` varchar(10) DEFAULT NULL,
  `unitcod` varchar(50) NOT NULL,
  `unitnam` varchar(255) DEFAULT NULL,
  `upzcod` varchar(50) DEFAULT NULL,
  `upazila` varchar(255) DEFAULT NULL,
  `stat` int DEFAULT '0',
  `fetched_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dlrms_all_surveys`
--
ALTER TABLE `dlrms_all_surveys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key_code_UNIQUE` (`key_code`);

--
-- Indexes for table `dlrms_districts`
--
ALTER TABLE `dlrms_districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bbs_code_UNIQUE` (`bbs_code`,`division_id`),
  ADD KEY `fk_districts_divisions_idx` (`division_id`);

--
-- Indexes for table `dlrms_divisions`
--
ALTER TABLE `dlrms_divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bbs_code_UNIQUE` (`bbs_code`);

--
-- Indexes for table `dlrms_khatians`
--
ALTER TABLE `dlrms_khatians`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx` (`jl_number_id`),
  ADD KEY `idx_khatian_no` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id` (`khatian_entry_id`);

--
-- Indexes for table `dlrms_khatians_BDS`
--
ALTER TABLE `dlrms_khatians_BDS`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_BDS` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatians_BRS`
--
ALTER TABLE `dlrms_khatians_BRS`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_BRS` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatians_BS`
--
ALTER TABLE `dlrms_khatians_BS`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_BS` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatians_CS`
--
ALTER TABLE `dlrms_khatians_CS`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_CS` ADD FULLTEXT KEY `ft_owners` (`owners`);
ALTER TABLE `dlrms_khatians_CS` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatians_CS_missing`
--
ALTER TABLE `dlrms_khatians_CS_missing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dlrms_khatians_DIARA`
--
ALTER TABLE `dlrms_khatians_DIARA`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_DIARA` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatians_PETY`
--
ALTER TABLE `dlrms_khatians_PETY`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_PETY` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatians_RS`
--
ALTER TABLE `dlrms_khatians_RS`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_RS` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatians_SA`
--
ALTER TABLE `dlrms_khatians_SA`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_khatians_mouza_jl_numbers_idx_CS` (`jl_number_id`),
  ADD KEY `idx_khatian_no_CS` (`khatian_no`),
  ADD KEY `idx_mouza_id_khatian_CS` (`mouza_id`),
  ADD KEY `idx_khatian_entry_id_CS` (`khatian_entry_id`);
ALTER TABLE `dlrms_khatians_SA` ADD FULLTEXT KEY `idx_owners_guardians` (`owners`,`guardians`);

--
-- Indexes for table `dlrms_khatian_data`
--
ALTER TABLE `dlrms_khatian_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `application_id` (`application_id`),
  ADD KEY `idx_khatian_no` (`khatian_no`),
  ADD KEY `idx_survey_id` (`survey_id`),
  ADD KEY `idx_mouza_id` (`mouza_id`),
  ADD KEY `idx_jl_number_id` (`jl_number_id`),
  ADD KEY `idx_office_id` (`office_id`);

--
-- Indexes for table `dlrms_khatian_data_log`
--
ALTER TABLE `dlrms_khatian_data_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dlrms_mouza_jl_numbers`
--
ALTER TABLE `dlrms_mouza_jl_numbers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mouza_jl_numbers_surveys_idx` (`survey_id`),
  ADD KEY `idx_mouza_id` (`mouza_id`),
  ADD KEY `idx_jl_number` (`jl_number`),
  ADD KEY `idx_uuid` (`uuid`);

--
-- Indexes for table `dlrms_mouza_jl_numbers_missing`
--
ALTER TABLE `dlrms_mouza_jl_numbers_missing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stat` (`stat`);

--
-- Indexes for table `dlrms_mutation_khlist`
--
ALTER TABLE `dlrms_mutation_khlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stat` (`stat`);

--
-- Indexes for table `dlrms_src_names`
--
ALTER TABLE `dlrms_src_names`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name_loc_search` (`survey_id`,`owner`(100),`guardian`(100),`district_bbs_code`,`upazila_bbs_code`);

--
-- Indexes for table `dlrms_surveys`
--
ALTER TABLE `dlrms_surveys`
  ADD PRIMARY KEY (`survey_id`);

--
-- Indexes for table `dlrms_upazilas`
--
ALTER TABLE `dlrms_upazilas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_upazila_identity` (`district_bbs_code`,`division_bbs_code`,`bbs_code`),
  ADD KEY `fk_upazilas_districts_idx` (`district_id`),
  ADD KEY `fk_upazilas_divisions_idx` (`division_id`),
  ADD KEY `idx_bbs_code_district` (`bbs_code`,`district_id`);

--
-- Indexes for table `emouza_districts`
--
ALTER TABLE `emouza_districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_district_in_division` (`division_id`,`name`);

--
-- Indexes for table `emouza_divisions`
--
ALTER TABLE `emouza_divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_division_name` (`name`);

--
-- Indexes for table `emouza_map_files`
--
ALTER TABLE `emouza_map_files`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_gdrive_file_id` (`google_drive_file_id`),
  ADD KEY `survey_type_id` (`survey_type_id`);

--
-- Indexes for table `emouza_mouzas`
--
ALTER TABLE `emouza_mouzas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_mouza_in_upazila` (`upazila_id`,`jl_number`);

--
-- Indexes for table `emouza_survey_types`
--
ALTER TABLE `emouza_survey_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_gdrive_folder_id` (`google_drive_folder_id`),
  ADD UNIQUE KEY `unique_folder_in_upazila` (`upazila_id`,`folder_name`);

--
-- Indexes for table `emouza_upazilas`
--
ALTER TABLE `emouza_upazilas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_upazila_in_district` (`district_id`,`name`);

--
-- Indexes for table `holdings_core`
--
ALTER TABLE `holdings_core`
  ADD PRIMARY KEY (`id`),
  ADD KEY `office_id` (`office_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `upazila_id` (`upazila_id`),
  ADD KEY `mouja_id` (`mouja_id`);

--
-- Indexes for table `holdings_details_main`
--
ALTER TABLE `holdings_details_main`
  ADD PRIMARY KEY (`auto_id`),
  ADD UNIQUE KEY `unique_json_source` (`json_source_id`,`core_holding_id`),
  ADD KEY `core_holding_id` (`core_holding_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `upazila_id` (`upazila_id`),
  ADD KEY `mouja_id` (`mouja_id`),
  ADD KEY `office_id` (`office_id`);

--
-- Indexes for table `holdings_districts`
--
ALTER TABLE `holdings_districts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holdings_land_schedules`
--
ALTER TABLE `holdings_land_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `holding_id` (`holding_id`);

--
-- Indexes for table `holdings_land_usage_tax`
--
ALTER TABLE `holdings_land_usage_tax`
  ADD PRIMARY KEY (`id`),
  ADD KEY `holding_id` (`holding_id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `holdings_moujas`
--
ALTER TABLE `holdings_moujas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holdings_offices`
--
ALTER TABLE `holdings_offices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holdings_owners`
--
ALTER TABLE `holdings_owners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ldtax_holding_id` (`ldtax_holding_id`);

--
-- Indexes for table `holdings_upazilas`
--
ALTER TABLE `holdings_upazilas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `district_id` (`district_id`);

--
-- Indexes for table `land_districts`
--
ALTER TABLE `land_districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_district_code` (`code`),
  ADD KEY `idx_district_division_code` (`division_code`);

--
-- Indexes for table `land_divisions`
--
ALTER TABLE `land_divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_division_code` (`code`);

--
-- Indexes for table `land_mauzas`
--
ALTER TABLE `land_mauzas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_mauza_code` (`code`),
  ADD KEY `idx_mauza_thana_code` (`thana_code`),
  ADD KEY `idx_mauza_m_code` (`m_code`),
  ADD KEY `idx_mauza_division_code` (`division_code`),
  ADD KEY `idx_mauza_district_code` (`district_code`);

--
-- Indexes for table `land_plots`
--
ALTER TABLE `land_plots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_plot_mauza_sheet_plotno` (`mauza_code`,`sht_no_en`,`plot_no_en`),
  ADD KEY `idx_plot_mauza_code` (`mauza_code`),
  ADD KEY `idx_plot_sht_no_en` (`sht_no_en`),
  ADD KEY `idx_plot_m_code` (`m_code`),
  ADD SPATIAL KEY `idx_plot_geom` (`geom`);

--
-- Indexes for table `land_sheets`
--
ALTER TABLE `land_sheets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sheet_mauza_no` (`mauza_code`,`sht_no_en`);

--
-- Indexes for table `land_thanas`
--
ALTER TABLE `land_thanas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_thana_code` (`code`),
  ADD KEY `idx_thana_district_code` (`district_code`),
  ADD KEY `idx_thana_division_code` (`division_code`);

--
-- Indexes for table `land_tools`
--
ALTER TABLE `land_tools`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `ldtax2_holdings`
--
ALTER TABLE `ldtax2_holdings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_office_id` (`office_id`),
  ADD KEY `idx_division_id` (`division_id`),
  ADD KEY `idx_district_id` (`district_id`),
  ADD KEY `idx_upazila_id` (`upazila_id`),
  ADD KEY `idx_mouja_id` (`mouja_id`);

--
-- Indexes for table `ldtax2_land_usage_info_tax`
--
ALTER TABLE `ldtax2_land_usage_info_tax`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_holding_id_luit` (`holding_id`);

--
-- Indexes for table `ldtax2_moujas`
--
ALTER TABLE `ldtax2_moujas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ldtax2_representative_payment_requests`
--
ALTER TABLE `ldtax2_representative_payment_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_holding_id_rpr` (`holding_id`);

--
-- Indexes for table `ldtax2_upazilas`
--
ALTER TABLE `ldtax2_upazilas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ldtax_districts`
--
ALTER TABLE `ldtax_districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `district_id` (`district_id`),
  ADD KEY `idx_district_division_id` (`division_id`);

--
-- Indexes for table `ldtax_divisions`
--
ALTER TABLE `ldtax_divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `division_id` (`division_id`);

--
-- Indexes for table `ldtax_moujas`
--
ALTER TABLE `ldtax_moujas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mouja_id` (`mouja_id`),
  ADD KEY `idx_mouja_office_id` (`office_id`),
  ADD KEY `dlrms_mouza_id` (`dlrms_mouza_id`);

--
-- Indexes for table `ldtax_offices`
--
ALTER TABLE `ldtax_offices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `office_id` (`office_id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `uuid` (`uuid`),
  ADD KEY `idx_office_upazila_id` (`upazila_id`),
  ADD KEY `idx_office_district_id` (`district_id`),
  ADD KEY `idx_office_division_id` (`division_id`),
  ADD KEY `idx_office_parent_office_id` (`parent_office_id`),
  ADD KEY `idx_office_code` (`code`),
  ADD KEY `idx_office_uuid` (`uuid`);

--
-- Indexes for table `ldtax_upazilas`
--
ALTER TABLE `ldtax_upazilas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `upazila_id` (`upazila_id`),
  ADD KEY `idx_upazila_district_id` (`district_id`);

--
-- Indexes for table `maps_files_eklas`
--
ALTER TABLE `maps_files_eklas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `google_file_id` (`google_file_id`),
  ADD KEY `idx_google_file_id` (`google_file_id`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_parent_folder_id_is_folder` (`parent_folder_id`,`is_folder`);

--
-- Indexes for table `maps_files_list`
--
ALTER TABLE `maps_files_list`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `google_file_id` (`google_file_id`),
  ADD KEY `idx_google_file_id` (`google_file_id`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_parent_folder_id_is_folder` (`parent_folder_id`,`is_folder`);

--
-- Indexes for table `mouzamaptech_files`
--
ALTER TABLE `mouzamaptech_files`
  ADD PRIMARY KEY (`pk_id`),
  ADD UNIQUE KEY `item_id` (`item_id`);

--
-- Indexes for table `mouzamaptech_items`
--
ALTER TABLE `mouzamaptech_items`
  ADD PRIMARY KEY (`pk_id`),
  ADD UNIQUE KEY `item_id` (`item_id`),
  ADD KEY `parent_item_id_idx` (`parent_item_id`),
  ADD KEY `type_idx` (`item_type`);

--
-- Indexes for table `mutation_khdl`
--
ALTER TABLE `mutation_khdl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aid` (`aid`),
  ADD KEY `divid` (`divid`);

--
-- Indexes for table `namjari_khatians`
--
ALTER TABLE `namjari_khatians`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_khatian_identifier` (`jl_number_id`,`khatian_no`,`survey_type`),
  ADD KEY `idx_khatian_jl_number_id` (`jl_number_id`),
  ADD KEY `idx_khatian_mouza_id` (`mouza_id`),
  ADD KEY `idx_khatian_no` (`khatian_no`),
  ADD KEY `idx_khatian_canonical_no` (`canonical_khatian_no`),
  ADD KEY `idx_khatian_office_id` (`office_id`);

--
-- Indexes for table `namjari_mouzas`
--
ALTER TABLE `namjari_mouzas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_mouza_identifier` (`district_bbs_code`,`upazila_bbs_code`,`mouza_id`,`jl_number`,`mutation_survey_id`),
  ADD KEY `idx_location_bbs` (`district_bbs_code`,`upazila_bbs_code`),
  ADD KEY `idx_mouza_id` (`mouza_id`),
  ADD KEY `idx_jl_number` (`jl_number`),
  ADD KEY `idx_division_bbs` (`division_bbs_code`);

--
-- Indexes for table `settlement_districts`
--
ALTER TABLE `settlement_districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unitcod` (`unitcod`);

--
-- Indexes for table `settlement_divisions`
--
ALTER TABLE `settlement_divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unitcod` (`unitcod`);

--
-- Indexes for table `settlement_khatian_headers`
--
ALTER TABLE `settlement_khatian_headers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mouza_rs_khat` (`mouza_unitcod`,`survey_rsnum`,`khatnum`);

--
-- Indexes for table `settlement_khatian_owners`
--
ALTER TABLE `settlement_khatian_owners`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `owner_key` (`mouza_unitcod`,`survey_rsnum`,`khatnum_ref`,`ownrgrp`,`ownrnum`);

--
-- Indexes for table `settlement_khatian_plots`
--
ALTER TABLE `settlement_khatian_plots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plot_key` (`mouza_unitcod`,`survey_rsnum`,`khatnum_ref`,`plot_slnum`);

--
-- Indexes for table `settlement_mouzas`
--
ALTER TABLE `settlement_mouzas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unitcod` (`unitcod`);

--
-- Indexes for table `settlement_sheets`
--
ALTER TABLE `settlement_sheets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mouza_rs_shet` (`mouza_unitcod`,`survey_rsnum`,`shetnum`);

--
-- Indexes for table `settlement_surveys`
--
ALTER TABLE `settlement_surveys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dist_rsnum` (`district_unitcod`,`rsnum`);

--
-- Indexes for table `settlement_thanas`
--
ALTER TABLE `settlement_thanas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unitcod` (`unitcod`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dlrms_khatian_data`
--
ALTER TABLE `dlrms_khatian_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dlrms_khatian_data_log`
--
ALTER TABLE `dlrms_khatian_data_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dlrms_src_names`
--
ALTER TABLE `dlrms_src_names`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emouza_districts`
--
ALTER TABLE `emouza_districts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emouza_divisions`
--
ALTER TABLE `emouza_divisions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emouza_map_files`
--
ALTER TABLE `emouza_map_files`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emouza_mouzas`
--
ALTER TABLE `emouza_mouzas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emouza_survey_types`
--
ALTER TABLE `emouza_survey_types`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emouza_upazilas`
--
ALTER TABLE `emouza_upazilas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holdings_details_main`
--
ALTER TABLE `holdings_details_main`
  MODIFY `auto_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_districts`
--
ALTER TABLE `land_districts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_divisions`
--
ALTER TABLE `land_divisions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_mauzas`
--
ALTER TABLE `land_mauzas`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_plots`
--
ALTER TABLE `land_plots`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_sheets`
--
ALTER TABLE `land_sheets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_thanas`
--
ALTER TABLE `land_thanas`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_tools`
--
ALTER TABLE `land_tools`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ldtax_districts`
--
ALTER TABLE `ldtax_districts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ldtax_divisions`
--
ALTER TABLE `ldtax_divisions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ldtax_moujas`
--
ALTER TABLE `ldtax_moujas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ldtax_offices`
--
ALTER TABLE `ldtax_offices`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ldtax_upazilas`
--
ALTER TABLE `ldtax_upazilas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maps_files_eklas`
--
ALTER TABLE `maps_files_eklas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maps_files_list`
--
ALTER TABLE `maps_files_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mouzamaptech_files`
--
ALTER TABLE `mouzamaptech_files`
  MODIFY `pk_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mouzamaptech_items`
--
ALTER TABLE `mouzamaptech_items`
  MODIFY `pk_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mutation_khdl`
--
ALTER TABLE `mutation_khdl`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `namjari_khatians`
--
ALTER TABLE `namjari_khatians`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `namjari_mouzas`
--
ALTER TABLE `namjari_mouzas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_districts`
--
ALTER TABLE `settlement_districts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_divisions`
--
ALTER TABLE `settlement_divisions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_khatian_headers`
--
ALTER TABLE `settlement_khatian_headers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_khatian_owners`
--
ALTER TABLE `settlement_khatian_owners`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_khatian_plots`
--
ALTER TABLE `settlement_khatian_plots`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_mouzas`
--
ALTER TABLE `settlement_mouzas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_sheets`
--
ALTER TABLE `settlement_sheets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_surveys`
--
ALTER TABLE `settlement_surveys`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settlement_thanas`
--
ALTER TABLE `settlement_thanas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dlrms_districts`
--
ALTER TABLE `dlrms_districts`
  ADD CONSTRAINT `fk_districts_divisions` FOREIGN KEY (`division_id`) REFERENCES `dlrms_divisions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `dlrms_khatians`
--
ALTER TABLE `dlrms_khatians`
  ADD CONSTRAINT `fk_khatians_mouza_jl_numbers` FOREIGN KEY (`jl_number_id`) REFERENCES `dlrms_mouza_jl_numbers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `dlrms_khatians_CS`
--
ALTER TABLE `dlrms_khatians_CS`
  ADD CONSTRAINT `fk_khatians_mouza_jl_numbers_CS` FOREIGN KEY (`jl_number_id`) REFERENCES `dlrms_mouza_jl_numbers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `dlrms_mouza_jl_numbers`
--
ALTER TABLE `dlrms_mouza_jl_numbers`
  ADD CONSTRAINT `fk_mouza_jl_numbers_surveys` FOREIGN KEY (`survey_id`) REFERENCES `dlrms_surveys` (`survey_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `dlrms_upazilas`
--
ALTER TABLE `dlrms_upazilas`
  ADD CONSTRAINT `fk_upazilas_districts` FOREIGN KEY (`district_id`) REFERENCES `dlrms_districts` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_upazilas_divisions` FOREIGN KEY (`division_id`) REFERENCES `dlrms_divisions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `emouza_districts`
--
ALTER TABLE `emouza_districts`
  ADD CONSTRAINT `emouza_districts_ibfk_1` FOREIGN KEY (`division_id`) REFERENCES `emouza_divisions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `emouza_map_files`
--
ALTER TABLE `emouza_map_files`
  ADD CONSTRAINT `emouza_map_files_ibfk_1` FOREIGN KEY (`survey_type_id`) REFERENCES `emouza_survey_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `emouza_mouzas`
--
ALTER TABLE `emouza_mouzas`
  ADD CONSTRAINT `emouza_mouzas_ibfk_1` FOREIGN KEY (`upazila_id`) REFERENCES `emouza_upazilas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `emouza_survey_types`
--
ALTER TABLE `emouza_survey_types`
  ADD CONSTRAINT `emouza_survey_types_ibfk_1` FOREIGN KEY (`upazila_id`) REFERENCES `emouza_upazilas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `emouza_upazilas`
--
ALTER TABLE `emouza_upazilas`
  ADD CONSTRAINT `emouza_upazilas_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `emouza_districts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `holdings_core`
--
ALTER TABLE `holdings_core`
  ADD CONSTRAINT `holdings_core_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `holdings_offices` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `holdings_core_ibfk_2` FOREIGN KEY (`district_id`) REFERENCES `holdings_districts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `holdings_core_ibfk_3` FOREIGN KEY (`upazila_id`) REFERENCES `holdings_upazilas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `holdings_core_ibfk_4` FOREIGN KEY (`mouja_id`) REFERENCES `holdings_moujas` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `holdings_details_main`
--
ALTER TABLE `holdings_details_main`
  ADD CONSTRAINT `holdings_details_main_ibfk_1` FOREIGN KEY (`core_holding_id`) REFERENCES `holdings_core` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `holdings_details_main_ibfk_2` FOREIGN KEY (`district_id`) REFERENCES `holdings_districts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `holdings_details_main_ibfk_3` FOREIGN KEY (`upazila_id`) REFERENCES `holdings_upazilas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `holdings_details_main_ibfk_4` FOREIGN KEY (`mouja_id`) REFERENCES `holdings_moujas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `holdings_details_main_ibfk_5` FOREIGN KEY (`office_id`) REFERENCES `holdings_offices` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `holdings_land_schedules`
--
ALTER TABLE `holdings_land_schedules`
  ADD CONSTRAINT `holdings_land_schedules_ibfk_1` FOREIGN KEY (`holding_id`) REFERENCES `holdings_core` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `holdings_land_usage_tax`
--
ALTER TABLE `holdings_land_usage_tax`
  ADD CONSTRAINT `holdings_land_usage_tax_ibfk_1` FOREIGN KEY (`holding_id`) REFERENCES `holdings_core` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `holdings_land_usage_tax_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `holdings_land_schedules` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `holdings_owners`
--
ALTER TABLE `holdings_owners`
  ADD CONSTRAINT `holdings_owners_ibfk_1` FOREIGN KEY (`ldtax_holding_id`) REFERENCES `holdings_core` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `holdings_upazilas`
--
ALTER TABLE `holdings_upazilas`
  ADD CONSTRAINT `holdings_upazilas_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `holdings_districts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `land_districts`
--
ALTER TABLE `land_districts`
  ADD CONSTRAINT `fk_district_division` FOREIGN KEY (`division_code`) REFERENCES `land_divisions` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `land_mauzas`
--
ALTER TABLE `land_mauzas`
  ADD CONSTRAINT `fk_mauza_thana` FOREIGN KEY (`thana_code`) REFERENCES `land_thanas` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `land_plots`
--
ALTER TABLE `land_plots`
  ADD CONSTRAINT `fk_plot_mauza` FOREIGN KEY (`mauza_code`) REFERENCES `land_mauzas` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `land_sheets`
--
ALTER TABLE `land_sheets`
  ADD CONSTRAINT `fk_sheet_mauza` FOREIGN KEY (`mauza_code`) REFERENCES `land_mauzas` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `land_thanas`
--
ALTER TABLE `land_thanas`
  ADD CONSTRAINT `fk_thana_district` FOREIGN KEY (`district_code`) REFERENCES `land_districts` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `mouzamaptech_files`
--
ALTER TABLE `mouzamaptech_files`
  ADD CONSTRAINT `fk_files_to_items` FOREIGN KEY (`item_id`) REFERENCES `mouzamaptech_items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
