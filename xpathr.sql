-- phpMyAdmin SQL Dump
-- version 3.3.7deb5build0.10.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 12 ott, 2011 at 03:25 PM
-- Versione MySQL: 5.1.49
-- Versione PHP: 5.3.3-1ubuntu9.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `xpathr`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries`
--

CREATE TABLE IF NOT EXISTS `sym_entries` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `section_id` int(11) unsigned NOT NULL,
  `author_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `creation_date_gmt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `section_id` (`section_id`),
  KEY `author_id` (`author_id`),
  KEY `creation_date` (`creation_date`),
  KEY `creation_date_gmt` (`creation_date_gmt`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_1`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_1` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_1`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_2`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_2` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_2`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_3`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_3` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_3`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_4`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_4` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` varchar(80) DEFAULT NULL,
  `local` int(11) DEFAULT NULL,
  `gmt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_4`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_5`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_5` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_5`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_6`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_6` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext,
  `value_formatted` mediumtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_6`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_7`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_7` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_7`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_8`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_8` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `relation_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `relation_id` (`relation_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_8`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_9`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_9` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext,
  `value_formatted` mediumtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_9`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_10`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_10` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` mediumtext,
  `value_formatted` mediumtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  FULLTEXT KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_10`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_entries_data_11`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_11` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `value` (`value`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_entries_data_11`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_extensions`
--

CREATE TABLE IF NOT EXISTS `sym_extensions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `status` enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
  `version` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dump dei dati per la tabella `sym_extensions`
--

INSERT INTO `sym_extensions` (`id`, `name`, `status`, `version`) VALUES
(1, 'selectbox_link_field', 'enabled', '1.20'),
(2, 'xpathr', 'enabled', '0.1'),
(3, 'debugdevkit', 'enabled', '1.2.1'),
(4, 'githuboauth', 'enabled', '0.1.0');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_extensions_delegates`
--

CREATE TABLE IF NOT EXISTS `sym_extensions_delegates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `extension_id` int(11) NOT NULL,
  `page` varchar(100) NOT NULL,
  `delegate` varchar(100) NOT NULL,
  `callback` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `extension_id` (`extension_id`),
  KEY `page` (`page`),
  KEY `delegate` (`delegate`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dump dei dati per la tabella `sym_extensions_delegates`
--

INSERT INTO `sym_extensions_delegates` (`id`, `extension_id`, `page`, `delegate`, `callback`) VALUES
(1, 3, '/frontend/', 'FrontendDevKitResolve', 'frontendDevKitResolve'),
(2, 3, '/frontend/', 'ManipulateDevKitNavigation', 'manipulateDevKitNavigation'),
(3, 4, '/system/preferences/', 'AddCustomPreferenceFieldsets', 'appendPreferences'),
(4, 4, '/system/preferences/', 'Save', 'savePreferences'),
(5, 4, '/frontend/', 'FrontendProcessEvents', 'appendEventXML'),
(6, 4, '/frontend/', 'FrontendParamsResolve', 'appendAccessToken'),
(7, 4, '/frontend/', 'FrontendPageResolved', 'frontendPageResolved');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields`
--

CREATE TABLE IF NOT EXISTS `sym_fields` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `element_name` varchar(50) NOT NULL,
  `type` varchar(32) NOT NULL,
  `parent_section` int(11) NOT NULL DEFAULT '0',
  `required` enum('yes','no') NOT NULL DEFAULT 'yes',
  `sortorder` int(11) NOT NULL DEFAULT '1',
  `location` enum('main','sidebar') NOT NULL DEFAULT 'main',
  `show_column` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `index` (`element_name`,`type`,`parent_section`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dump dei dati per la tabella `sym_fields`
--

INSERT INTO `sym_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES
(1, 'Gist id', 'gist-id', 'input', 1, 'no', 0, 'main', 'yes'),
(2, 'User', 'user', 'input', 1, 'no', 2, 'main', 'yes'),
(3, 'Sha1', 'sha1', 'input', 2, 'no', 0, 'main', 'yes'),
(4, 'Created at', 'created-at', 'date', 2, 'no', 1, 'sidebar', 'yes'),
(5, 'Filename', 'filename', 'input', 3, 'yes', 0, 'main', 'yes'),
(6, 'Content', 'content', 'textarea', 3, 'no', 1, 'main', 'no'),
(7, 'Gist', 'gist', 'selectbox_link', 2, 'yes', 2, 'main', 'yes'),
(8, 'Revision', 'revision', 'selectbox_link', 3, 'yes', 2, 'main', 'yes'),
(9, 'Revisions list', 'revisions-list', 'textarea', 1, 'no', 3, 'main', 'no'),
(10, 'Forks list', 'forks-list', 'textarea', 1, 'no', 4, 'main', 'no'),
(11, 'Title', 'title', 'input', 1, 'no', 1, 'main', 'yes');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_author`
--

CREATE TABLE IF NOT EXISTS `sym_fields_author` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_author_change` enum('yes','no') NOT NULL,
  `allow_multiple_selection` enum('yes','no') NOT NULL DEFAULT 'no',
  `default_to_current_user` enum('yes','no') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_author`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_checkbox`
--

CREATE TABLE IF NOT EXISTS `sym_fields_checkbox` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `default_state` enum('on','off') NOT NULL DEFAULT 'on',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_checkbox`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_date`
--

CREATE TABLE IF NOT EXISTS `sym_fields_date` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `pre_populate` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `sym_fields_date`
--

INSERT INTO `sym_fields_date` (`id`, `field_id`, `pre_populate`) VALUES
(2, 4, 'yes');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_input`
--

CREATE TABLE IF NOT EXISTS `sym_fields_input` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dump dei dati per la tabella `sym_fields_input`
--

INSERT INTO `sym_fields_input` (`id`, `field_id`, `validator`) VALUES
(13, 1, NULL),
(15, 2, NULL),
(7, 3, NULL),
(8, 5, NULL),
(14, 11, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_select`
--

CREATE TABLE IF NOT EXISTS `sym_fields_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') NOT NULL DEFAULT 'no',
  `show_association` enum('yes','no') NOT NULL DEFAULT 'yes',
  `sort_options` enum('yes','no') NOT NULL DEFAULT 'no',
  `static_options` text,
  `dynamic_options` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_select`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_selectbox_link`
--

CREATE TABLE IF NOT EXISTS `sym_fields_selectbox_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `allow_multiple_selection` enum('yes','no') NOT NULL DEFAULT 'no',
  `show_association` enum('yes','no') NOT NULL DEFAULT 'yes',
  `related_field_id` varchar(255) NOT NULL,
  `limit` int(4) unsigned NOT NULL DEFAULT '20',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `sym_fields_selectbox_link`
--

INSERT INTO `sym_fields_selectbox_link` (`id`, `field_id`, `allow_multiple_selection`, `show_association`, `related_field_id`, `limit`) VALUES
(1, 7, 'no', 'yes', '1', 20),
(2, 8, 'no', 'yes', '3', 20);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_taglist`
--

CREATE TABLE IF NOT EXISTS `sym_fields_taglist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `validator` varchar(255) DEFAULT NULL,
  `pre_populate_source` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`),
  KEY `pre_populate_source` (`pre_populate_source`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_taglist`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_textarea`
--

CREATE TABLE IF NOT EXISTS `sym_fields_textarea` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `formatter` varchar(100) DEFAULT NULL,
  `size` int(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dump dei dati per la tabella `sym_fields_textarea`
--

INSERT INTO `sym_fields_textarea` (`id`, `field_id`, `formatter`, `size`) VALUES
(2, 6, NULL, 10),
(6, 9, NULL, 10),
(7, 10, NULL, 10);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_fields_upload`
--

CREATE TABLE IF NOT EXISTS `sym_fields_upload` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `destination` varchar(255) NOT NULL,
  `validator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `sym_fields_upload`
--


-- --------------------------------------------------------

--
-- Struttura della tabella `sym_pages`
--

CREATE TABLE IF NOT EXISTS `sym_pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `handle` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `data_sources` text,
  `events` text,
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dump dei dati per la tabella `sym_pages`
--

INSERT INTO `sym_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`) VALUES
(1, NULL, 'New Gist', 'new', NULL, NULL, NULL, 'create_gist', 1),
(2, NULL, 'View Gist', 'view', NULL, 'gist-id/sha1', 'files_by_revision,gist_by_id,revision_by_sha1', 'update_gist', 2),
(3, NULL, 'Process Gist', 'process', NULL, 'gist-id/sha1', 'files_by_revision,gist_by_id,process_gist_by_id,revision_by_sha1', NULL, 3),
(4, NULL, 'Authenticate', 'authenticate', NULL, NULL, NULL, 'github_authenticate', 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_pages_types`
--

CREATE TABLE IF NOT EXISTS `sym_pages_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`,`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `sym_pages_types`
--

INSERT INTO `sym_pages_types` (`id`, `page_id`, `type`) VALUES
(3, 1, 'index');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_sections`
--

CREATE TABLE IF NOT EXISTS `sym_sections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `handle` varchar(255) NOT NULL,
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `entry_order` varchar(7) DEFAULT NULL,
  `entry_order_direction` enum('asc','desc') DEFAULT 'asc',
  `hidden` enum('yes','no') NOT NULL DEFAULT 'no',
  `navigation_group` varchar(255) NOT NULL DEFAULT 'Content',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `sym_sections`
--

INSERT INTO `sym_sections` (`id`, `name`, `handle`, `sortorder`, `entry_order`, `entry_order_direction`, `hidden`, `navigation_group`) VALUES
(1, 'Gist', 'gist', 1, NULL, 'asc', 'no', 'Content'),
(2, 'Revision', 'revision', 2, '4', 'asc', 'no', 'Content'),
(3, 'Files', 'files', 3, NULL, 'asc', 'no', 'Content');

-- --------------------------------------------------------

--
-- Struttura della tabella `sym_sections_association`
--

CREATE TABLE IF NOT EXISTS `sym_sections_association` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_section_id` int(11) unsigned NOT NULL,
  `parent_section_field_id` int(11) unsigned DEFAULT NULL,
  `child_section_id` int(11) unsigned NOT NULL,
  `child_section_field_id` int(11) unsigned NOT NULL,
  `hide_association` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `parent_section_id` (`parent_section_id`,`child_section_id`,`child_section_field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `sym_sections_association`
--

INSERT INTO `sym_sections_association` (`id`, `parent_section_id`, `parent_section_field_id`, `child_section_id`, `child_section_field_id`, `hide_association`) VALUES
(1, 1, 1, 2, 7, 'no'),
(2, 2, 3, 3, 8, 'no');
