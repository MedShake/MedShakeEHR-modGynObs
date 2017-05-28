-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 22 Mai 2017 à 08:57
-- Version du serveur :  5.7.18-0ubuntu0.16.04.1
-- Version de PHP :  7.0.15-0ubuntu0.16.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `ehr`
--

-- --------------------------------------------------------

--
-- Structure de la table `actes`
--

CREATE TABLE `actes` (
  `id` smallint(4) UNSIGNED NOT NULL,
  `cat` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `label` varchar(250) NOT NULL,
  `tarif` float NOT NULL DEFAULT '0',
  `depassement` float NOT NULL DEFAULT '0',
  `code` varchar(250) NOT NULL DEFAULT '',
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL DEFAULT '1000-01-01 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `actes`
--

INSERT INTO `actes` (`id`, `cat`, `label`, `tarif`, `depassement`, `code`, `fromID`, `creationDate`) VALUES
(1, 4, 'Consultation gynécologique ', 23, 22, 'CS', 0, '1000-01-01 00:00:00'),
(4, 4, 'Consultation gynécologique CMU', 28, 0, 'CS + MCS + MPC', 0, '1000-01-01 00:00:00'),
(5, 4, 'Consultation gynécologique et FCV', 27.82, 17.18, 'CS + JKHD001', 0, '1000-01-01 00:00:00'),
(6, 4, 'Consultation gynécologique et FCV - CMU', 32.82, 0, 'CS + MCS + MPC + JKHD001', 0, '1000-01-01 00:00:00'),
(7, 4, 'Consultation suivi de grossesse ', 23, 17, 'CS', 0, '1000-01-01 00:00:00'),
(8, 4, 'Consultation suivi de grossesse + FCV', 27.82, 12.18, 'CS + JKHD001', 0, '1000-01-01 00:00:00'),
(9, 4, 'Consultation suivi de grossesse CMU', 28, 0, 'CS + MCS + MPC', 0, '1000-01-01 00:00:00'),
(10, 4, 'Consultation suivi de grossesse + FCV - CMU', 32.82, 0, 'CS + MCS + MPC + JKHD001', 0, '1000-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `actes_cat`
--

CREATE TABLE `actes_cat` (
  `id` smallint(5) NOT NULL,
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `type` enum('base','user') NOT NULL DEFAULT 'user',
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL,
  `displayOrder` smallint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `actes_cat`
--

INSERT INTO `actes_cat` (`id`, `name`, `label`, `description`, `type`, `fromID`, `creationDate`, `displayOrder`) VALUES
(1, 'catActesContra', 'DIU & implant', '', 'user', 1, '2017-03-26 15:43:20', 3),
(2, 'catEchoGro', 'Echo obstétricale', '', 'user', 1, '2017-03-26 15:43:46', 4),
(3, 'catEchoGyn', 'Echo gynéco', '', 'user', 1, '2017-03-26 15:43:30', 5),
(4, 'catConsult', 'Consultations', '', 'user', 1, '2017-03-26 15:42:59', 1),
(5, 'catActesTechGyn', 'Actes techniques gynéco', '', 'user', 1, '2017-03-26 15:44:03', 8),
(6, 'catInsémination', 'Insémination', '', 'user', 1, '2017-03-26 15:43:54', 10);

-- --------------------------------------------------------

--
-- Structure de la table `data_cat`
--

CREATE TABLE `data_cat` (
  `id` smallint(5) NOT NULL,
  `groupe` enum('admin','medical','typecs','mail','doc','courrier','ordo','reglement','dicom','user') NOT NULL DEFAULT 'admin',
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `type` enum('base','user') NOT NULL DEFAULT 'user',
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `data_cat`
--

INSERT INTO `data_cat` (`id`, `groupe`, `name`, `label`, `description`, `type`, `fromID`, `creationDate`) VALUES
(1, 'admin', 'identity', 'Etat civil', 'Datas relatives à l\'identité d\'une personne', 'base', 1, '2016-12-15 12:22:35'),
(2, 'admin', 'addressPerso', 'Adresse personnelle', 'datas de l\'adresse personnelle', 'base', 1, '2017-03-26 15:12:14'),
(3, 'admin', 'internet', 'Internet', 'Datas liées aux services internet', 'base', 0, '1000-01-01 00:00:00'),
(24, 'admin', 'contact', 'Contact', 'Moyens de contact', 'user', 1, '2016-12-13 19:18:57'),
(25, 'admin', 'activity', 'Activités', 'Activités professionnelles et de loisir', 'user', 1, '2016-12-15 12:04:59'),
(26, 'admin', 'divers', 'Divers', 'Divers', 'user', 1, '2016-12-16 13:35:52'),
(27, 'medical', 'dataEcho12', 'Données formulaire Echo 12', 'Données pour échographie 12 SA', 'user', 1, '2017-03-13 20:06:44'),
(28, 'medical', 'dataCliniques', 'Données cliniques', 'Données cliniques', 'user', 1, '2017-03-09 22:06:04'),
(29, 'medical', 'atcd', 'Antécédents et synthèses', 'antécédents et synthèses', 'user', 1, '2017-03-10 18:05:49'),
(30, 'typecs', 'consultObs', 'Consultations obstétricales', 'consultations pendant grossesse', 'user', 1, '2017-03-13 10:40:52'),
(31, 'medical', 'dataBio', 'Données biologiques', 'Données biologiques habituelles', 'user', 1, '2017-03-10 10:06:07'),
(32, 'medical', 'grossesse', 'Grossesse', 'Données liées à la grossesse', 'user', 1, '2017-03-10 20:02:50'),
(33, 'typecs', 'csGyneco', 'Consultations gynécologiques', 'consultations possibles (hors grossesse)', 'user', 1, '2017-03-13 10:40:15'),
(35, 'medical', 'dataCsGyneco', 'Données formulaire Cs gynéco', '', 'user', 1, '2017-03-14 11:08:08'),
(36, 'admin', 'numAdmin', 'Numéros administratifs', 'RPPS et compagnie', 'user', 1, '2017-03-14 14:43:16'),
(37, 'courrier', 'courrierCertificat', 'Certificats', 'certificats divers', 'user', 1, '2017-03-15 16:10:14'),
(38, 'courrier', 'courrierCat', 'Courriers', 'modèles de courrier libres', 'user', 1, '2017-03-16 15:07:01'),
(39, 'mail', 'mailForm', 'Data mail', 'data pour les mails expédiés', 'user', 1, '2017-04-07 15:44:51'),
(40, 'medical', 'echoInf11', 'Données formulaire Echo inf 11SA', 'données pour l\'écho inf à 11SA', 'user', 1, '2017-03-17 12:23:05'),
(41, 'mail', 'porteursTech', 'Porteurs', 'porteurs pour les données enfants', 'user', 1, '2017-03-20 12:52:07'),
(42, 'doc', 'docForm', 'Data documents importés / créés', 'données pour le formulaire documents importés ou créés', 'user', 1, '2017-05-15 13:37:29'),
(43, 'doc', 'docPorteur', 'Porteur', 'porteur pour doc importés', 'user', 1, '2017-03-21 10:24:51'),
(44, 'ordo', 'poteursOrdo', 'Porteurs', 'porteurs ordonnance', 'user', 1, '2017-03-22 14:06:30'),
(45, 'reglement', 'porteursReglement', 'Porteurs', 'porteur d\'un règlement', 'user', 1, '2017-03-24 14:41:40'),
(46, 'reglement', 'reglementItems', 'Règlement', 'items d\'un réglement', 'user', 1, '2017-03-24 14:42:21'),
(47, 'admin', 'adressPro', 'Adresse professionnelle', 'Data de l\'adresse professionnelle', 'user', 1, '2017-03-26 15:13:00'),
(48, 'medical', 'catColpo', 'Données formulaire Cs colposcopie', 'données colposcopie', 'user', 1, '2017-04-01 18:17:52'),
(49, 'medical', 'datasIssueGrossesse', 'Données formulaire issue de grossesse', 'Données formulaire issue de grossesse', 'user', 1, '2017-04-03 10:37:15'),
(50, 'typecs', 'csAutres', 'Autres', 'autres', 'user', 1, '2017-05-16 11:22:48'),
(51, 'medical', 'echo22Data', 'Données formulaire Echo 22', 'données pour le formulaire de l\'écho 22', 'user', 1, '2017-04-06 15:21:33'),
(52, 'medical', 'dataEcho32', 'Données formulaire Echo 32', 'données pour l\'écho 32', 'user', 1, '2017-04-07 12:53:03'),
(53, 'medical', 'dataCsGro', 'Données formulaire Cs obstétricale', 'données formulaire Cs obstétricale', 'user', 1, '2017-04-07 15:27:44'),
(54, 'medical', 'dataEchoGyn', 'Données formulaire Echo gynéco', '', 'user', 1, '2017-04-10 16:42:29'),
(55, 'dicom', 'idDicom', 'ID Dicom', 'ID du dicom', 'user', 1, '2017-04-13 14:24:10'),
(56, 'user', 'dicom', 'Dicom', 'Paramètres DICOM', 'user', 1, '2017-04-25 20:26:19'),
(57, 'typecs', 'declencheur', 'Déclencheur', '', 'user', 1, '2017-05-14 21:50:26'),
(58, 'courrier', 'modelesMailPatient', 'Mails aux patients', 'modèles de mail', 'user', 1, '2017-05-15 09:03:46'),
(59, 'courrier', 'modeleMailsPros', 'Mails aux praticiens', 'modèles de mails pour les praticien (apicrypt)', 'user', 1, '2017-05-15 09:04:40'),
(60, 'medical', 'dataMarqueursT21', 'Données formulaire marqueurs sériques maternels', 'donnée pour formulaire dépistage T21', 'user', 1, '2017-05-16 09:49:29');

-- --------------------------------------------------------

--
-- Structure de la table `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `groupe` enum('admin','medical','typecs','mail','doc','courrier','ordo','reglement','dicom','user') NOT NULL DEFAULT 'admin',
  `name` varchar(60) NOT NULL,
  `placeholder` varchar(255) NOT NULL,
  `label` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `validationRules` varchar(255) NOT NULL,
  `validationErrorMsg` varchar(255) NOT NULL,
  `formType` enum('','date','email','lcc','number','select','submit','tel','text','textarea') NOT NULL,
  `formValues` text NOT NULL,
  `type` enum('base','user') NOT NULL DEFAULT 'user',
  `cat` smallint(5) UNSIGNED NOT NULL,
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL,
  `durationLife` int(9) UNSIGNED NOT NULL DEFAULT '86400',
  `displayOrder` tinyint(3) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `data_types`
--

INSERT INTO `data_types` (`id`, `groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
(0, 'admin', 'submit', '', '', '', '', '', 'submit', '', 'base', 0, 0, '1000-01-01 00:00:00', 3600, 1),
(1, 'admin', 'birthname', 'nom de jeune-fille', 'Nom de jeune-fille', 'Nom porté avant mariage éventuel', 'identite', 'Le nom de jeune-fille est indispensable et ne doit pas contenir de caractères interdits', 'text', '', 'base', 1, 1, '2016-12-17 16:04:17', 3600, 1),
(2, 'admin', 'lastname', 'nom', 'Nom', 'Nom utilisé au quotidien', 'identite', 'Le nom ne doit pas contenir de caractères interdits', 'text', '', 'base', 1, 1, '2016-12-17 16:00:48', 3600, 1),
(3, 'admin', 'given', 'prénom', 'Prénom', 'Prénom figurant sur la pièce d\'identité', 'identite', 'Le prénom est indispensable et ne doit pas contenir de caractères interdits', 'text', '', 'base', 1, 1, '2016-12-18 15:17:58', 3600, 1),
(4, 'admin', 'personalEmail', 'email@domain.ext', 'Email personnelle', 'Adresse email personnelle', 'valid_email', 'L\'adresse email n\'est pas correcte. Elle doit être de la forme email@domain.net', 'email', '', 'base', 24, 1, '2017-03-10 12:02:13', 3600, 1),
(5, 'admin', 'profesionnalEmail', 'email@domain.ext', 'Email professionnelle', 'Adresse email professionnelle', 'valid_email', 'L\'adresse email n\'est pas correcte. Elle doit être de la forme email@domain.net', 'email', '', 'base', 24, 1, '2016-12-14 16:21:28', 3600, 1),
(6, 'admin', 'twitterAccount', '', 'Twitter', 'Compte twitter', 'twitterAccount', '', 'text', '', 'user', 3, 1, '2016-12-13 19:17:36', 3600, 1),
(7, 'admin', 'mobilePhone', '06 xx xx xx xx', 'Téléphone mobile', 'Numéro de téléphone commençant par 06 ou 07', 'mobilphone', 'Le numéro de téléphone mobile est incorrect', 'tel', '', 'user', 24, 1, '2016-12-16 15:34:13', 3600, 1),
(8, 'admin', 'birthdate', 'dd/mm/YYYY', 'Date de naissance', 'Date de naissance au format dd/mm/YYYY', 'validedate,\'d/m/Y\'', 'La date de naissance indiquée n\'est pas valide', 'date', '', 'user', 1, 1, '2017-03-10 20:37:23', 3600, 1),
(9, 'admin', 'streetNumber', 'numéro dans la rue', 'Numéro', 'Adresse perso : numéro dans la rue', 'alpha_space', 'Le numéro de rue est incorrect', 'text', '', 'user', 2, 1, '2017-03-09 15:58:39', 3600, 1),
(10, 'admin', 'homePhone', '0x xx xx xx xx', 'Téléphone domicile', 'Téléphone du domicile de la forme 0x xx xx xx xx', 'phone', 'Le numéro de téléphone du domicile n\'est pas correct', 'tel', '', 'user', 24, 1, '2016-12-31 11:33:02', 3600, 1),
(11, 'admin', 'street', 'rue', 'Rue', 'Adresse perso : rue', '', '', 'text', '', 'user', 2, 1, '2017-03-09 16:14:08', 3600, 1),
(12, 'admin', 'city', 'ville', 'Ville', 'Adresse perso : ville', '', '', 'text', '', 'user', 2, 1, '2017-03-09 15:59:04', 3600, 1),
(13, 'admin', 'postalCodePerso', 'code postal', 'Code postal', 'Adresse perso : code postal', '', 'Le code postal n\'est pas correct', 'text', '', 'user', 2, 1, '2017-03-31 15:35:04', 3600, 1),
(14, 'admin', 'administrativeGenderCode', '', 'Sexe', 'Sexe', '', '', 'select', 'F: \'Femme\'\nM: \'Homme\'\nU: \'Inconnu\'', 'user', 1, 1, '2016-12-18 15:17:45', 3600, 1),
(15, 'admin', 'website', '', 'Site web', 'Site web', 'url', '', 'text', '', 'user', 3, 1, '2016-12-13 20:00:15', 3600, 1),
(19, 'admin', 'job', 'activité professionnelle', 'Activité professionnelle', 'Activité professionnelle', '', 'L\'activité professionnelle n\'est pas correcte', 'text', '', 'user', 25, 1, '2017-03-10 12:42:48', 3600, 1),
(20, 'admin', 'sport', 'sport exercé', 'Sport', 'Sport exercé', '', 'Le sport indiqué n\'est pas correct', 'text', '', 'user', 25, 1, '2016-12-15 12:07:34', 3600, 1),
(21, 'admin', 'notes', 'notes', 'Notes', 'Zone de notes', '', '', 'textarea', '', 'user', 26, 1, '2016-12-16 13:36:46', 3600, 1),
(22, 'admin', 'othersfirstname', 'liste des prénoms secondaires', 'Autres prénoms', 'Les autres prénoms d\'une personne', '', '', 'text', '', 'user', 1, 1, '2016-12-16 18:01:37', 3600, 1),
(31, 'medical', 'lccA', '', 'LCC - A', 'lcc (mm) du foetus A', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:26:09', 3600, 1),
(32, 'typecs', 'csGyn', '', 'Consultation gynécologique', 'support parent pour la consultation gynécologique', '', '', '', '10', 'user', 33, 1, '2017-05-04 20:36:31', 86400, 1),
(33, 'typecs', 'echo12', '', 'Echographie 1er trimestre', 'support parent pour l\'échographie de 12 SA', '', '', '', '9', 'user', 30, 1, '2017-05-04 20:37:30', 86400, 1),
(34, 'medical', 'poids', 'kg', 'Poids', 'poids du patient', '', '', 'text', '', 'user', 28, 1, '2017-03-10 09:59:48', 3600, 1),
(35, 'medical', 'taillePatient', 'cm', 'Taille', 'taille du patient', '', '', 'text', '', 'user', 28, 1, '2017-04-04 11:08:28', 3600, 1),
(36, 'medical', 'toxoStatut', '', 'Toxo.', 'statut toxoplasmose', '', '', 'select', '\'toxoIco\' : \'?\'\n\'toxo+\' : \'Toxo +\'\n\'toxo-\' : \'Toxo neg\'', 'user', 31, 1, '2017-04-04 17:57:44', 3600, 1),
(37, 'medical', 'groupeSanguin', '', 'Groupe sg', 'groupe sanguin patient', '', '', 'select', '\'groupeSangIndeter\' : \'?\'\n\'A+\' : \'A+\'\n\'A-\' : \'A-\'\n\'B+\' : \'B+\'\n\'B-\' : \'B-\'\n\'AB+\' : \'AB+\'\n\'AB-\' : \'AB-\'\n\'O+\' : \'O+\'\n\'O-\' : \'O-\'', 'user', 31, 1, '2017-04-04 17:57:55', 3600, 1),
(38, 'medical', 'atcdFamiliaux', 'Antécédents familiaux', 'Antécédents familiaux', 'Antécédents familiaux', '', '', 'textarea', '', 'user', 29, 1, '2017-03-10 10:17:21', 3600, 1),
(39, 'medical', 'atcdPersoGyneco', 'Antécédents personnels gynécologiques', 'Antécédents gynécologiques', 'Antécédents personnels gynécologiques', '', '', 'textarea', '', 'user', 29, 1, '2017-03-10 10:21:02', 3600, 1),
(40, 'medical', 'atcdObs', 'Antécédents obstétricaux personnels', 'Antécédents obstétricaux', 'Antécédents obstétricaux personnels', '', '', 'textarea', '', 'user', 29, 1, '2017-03-10 10:24:57', 3600, 1),
(41, 'medical', 'atcdMedicChir', 'Antécédents médico-chirugicaux personnels', 'Antécédents médico-chirugicaux', 'Antécédents médico-chirugicaux personnels', '', '', 'textarea', '', 'user', 29, 1, '2017-03-10 10:27:22', 3600, 1),
(42, 'medical', 'toxiques', 'tabac et drogues', 'Toxiques', 'habitudes de consommation', '', '', 'text', '', 'user', 29, 1, '2017-03-10 16:32:25', 3600, 1),
(43, 'medical', 'imc', 'imc', 'IMC', 'IMC (autocalcule)', '', '', 'text', '', 'user', 28, 1, '2017-03-10 16:41:12', 3600, 1),
(44, 'medical', 'synthese', 'synthèse sur la patiente', 'Synthèse gynécologique', 'Synthèse sur la patiente', '', '', 'textarea', '', 'user', 29, 1, '2017-03-10 23:49:02', 3600, 1),
(45, 'medical', 'DDR', 'ddr', 'DDR', 'date des dernières règles', '', 'validedate,\'d/m/Y\'', 'date', '00/00/0000', 'user', 32, 1, '2017-03-11 22:30:41', 3600, 1),
(46, 'typecs', 'nouvelleGrossesse', '', 'Nouvelle grossesse', 'support parent pour nouvelle grossesse', '', '', '', '6', 'user', 57, 1, '2017-05-14 21:50:38', 86400, 1),
(47, 'medical', 'syntheseGrossesse', 'synthèse grossesse', 'Synthèse grossesse', 'Synthèse sur la grossesse', '', '', 'textarea', '', 'user', 32, 1, '2017-03-10 23:29:54', 3600, 1),
(48, 'medical', 'ddg', 'ddg', 'DDG (théorique)', 'date de début de grossesse', '', '', 'text', '', 'user', 32, 1, '2017-03-24 10:28:04', 3600, 1),
(49, 'medical', 'ddgReel', '', 'DDG (retenue)', 'date de début de grossesse corrigé', '', '', 'date', '', 'user', 32, 1, '2017-03-11 22:31:16', 3600, 1),
(50, 'medical', 'termeDuJour', '', 'Terme du jour', 'terme du jour', '', '', 'text', '', 'user', 32, 1, '2017-03-10 23:46:26', 3600, 1),
(51, 'admin', 'titre', 'Dr, Pr ...', 'Titre', 'Titre du pro de santé', '', '', 'text', '', 'user', 1, 1, '2017-03-12 21:21:47', 3600, 1),
(53, 'admin', 'codePostalPro', 'code postal', 'Code postal', 'Adresse pro : code postal', 'alpha_space', 'Le code postal n\'est pas conforme', 'text', '', 'user', 47, 1, '2017-03-26 15:13:34', 3600, 1),
(54, 'admin', 'numAdressePro', 'n°', 'Numéro', 'Adresse pro : numéro dans la rue', 'alpha_space', 'Le numero n\'est pas conforme', 'text', '', 'user', 47, 1, '2017-03-26 15:13:46', 3600, 1),
(55, 'admin', 'rueAdressePro', 'rue', 'Rue', 'Adresse pro : rue', '', '', 'text', '', 'user', 47, 1, '2017-03-26 15:13:53', 3600, 1),
(56, 'admin', 'villeAdressePro', 'ville', 'Ville', 'Adresse pro : ville', '', '', 'text', '', 'user', 47, 1, '2017-03-26 15:14:01', 3600, 1),
(57, 'admin', 'telPro', 'téléphone professionnel', 'Téléphone professionnel', 'Téléphone pro.', 'phone', '', 'tel', '', 'user', 24, 1, '2017-03-12 21:33:56', 3600, 1),
(58, 'admin', 'faxPro', 'fax professionel', 'Fax professionnel', 'FAx pro', 'phone', '', 'tel', '', 'user', 24, 1, '2017-03-12 21:34:44', 3600, 1),
(59, 'admin', 'emailApicrypt', 'adresse mail apicript', 'Email apicrypt', 'Email apicrypt', 'valid_email', '', 'email', '', 'user', 24, 1, '2017-03-12 23:01:07', 3600, 1),
(60, 'typecs', 'echo22sa', '', 'Echographie 2e trimestre', 'support parent pour l\'échographie de 22 SA', '', '', '', '23', 'user', 30, 1, '2017-05-04 20:37:43', 86400, 1),
(61, 'typecs', 'echo32sa', '', 'Echographie 3e trimestre', 'support parent pour l\'échographie de 32 SA', '', '', '', '24', 'user', 30, 1, '2017-05-04 20:37:55', 86400, 1),
(62, 'typecs', 'echoDatation', '', 'Echographie inf. 11 SA', 'support parent pour l\'échographie à moins de 11 SA', '', '', '', '12', 'user', 30, 1, '2017-05-04 20:38:21', 86400, 0),
(63, 'typecs', 'colposcopieCs', '', 'Colposcopie', 'support parent pour la consultation de colposcopie', '', '', '', '20', 'user', 33, 1, '2017-05-04 20:36:21', 86400, 1),
(64, 'typecs', 'csMensuelleGro', '', 'Consultation grossesse', 'support parent pour la consultation grossesse', '', '', '', '26', 'user', 30, 1, '2017-05-04 20:37:05', 86400, 1),
(65, 'typecs', 'finDeGrossesse', '', 'Issue de grossesse', 'support parent pour l\'issue de grossesse', '', '', '', '21', 'user', 30, 1, '2017-05-04 20:38:48', 86400, 20),
(66, 'medical', 'allergies', 'allergies et intolérances', 'Allergies', 'Allergies et intolérances du patient', '', '', 'textarea', '', 'user', 29, 1, '2017-03-13 11:01:36', 3600, 1),
(67, 'medical', 'indicEcho12', '', 'Indication', 'indication de l\'écho de 12', '', '', 'select', '\'A\' : \'dépistage du 1er trimestre\'\n\'B\' : \'contrôle d\\\'évolutivité\'\n\'C\' : \'complément à un premier examen difficile\'\n\'D\' : \'douleurs pelviennes\'\n\'E\' : \'échographie de seconde intention\'', 'user', 27, 1, '2017-04-25 22:14:50', 3600, 1),
(68, 'medical', 'voieExamEcho12', '', 'Voie d\'examen', 'voie d\'examen pour l\'écho 12', '', '', 'select', '\'A\' : \'abdominale\'\n\'B\' : \'vaginale\'\n\'C\' : \'abdominale et vaginale\'', 'user', 27, 1, '2017-03-13 12:36:48', 3600, 1),
(69, 'medical', 'conditionsEcho12', 'bonnes, difficiles ...', 'Conditions de réalisation', 'Conditions de l\'examen : bonnes, difficiles ...', '', '', 'select', '\'A\' : \'bonnes\'\n\'B\' : \'limitées par l\\\'échogénicité pariétale\'\n\'C\' : \'limitées par la position foetale\'\n\'D\' : \'limitées par l\\\'échogénicité pariétale et  la position foetale\'\n\'E\' : \'difficiles\'\n\'F\' : \'limitées par la position utérine\'\n\'G\' : \'limitées par la quantité de liquide amniotique\'\n\'H\' : \'limitée par les mouvements foetaux\'', 'user', 27, 1, '2017-04-30 21:09:35', 3600, 1),
(70, 'medical', 'nbFoetusEcho12', '', 'Nombre de foetus', 'nombre de foetus à l\'écho 12', '', '', 'number', '1', 'user', 27, 1, '2017-03-13 17:45:53', 3600, 1),
(71, 'medical', 'actiCardioFA', '', 'Activité cardiaque - A', 'Activité cardique du foetus A', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'absente\'\n\'C\' : \'difficile à visualiser\'', 'user', 27, 1, '2017-04-25 22:35:14', 3600, 1),
(72, 'medical', 'rcfFA', '', 'RCF - A', 'rcf foetus A', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:26:56', 3600, 1),
(73, 'medical', 'mafFA', '', 'MAF - A', 'MAF du foetus A', '', '', 'text', 'présents et normaux', 'user', 27, 1, '2017-03-13 18:12:23', 3600, 1),
(74, 'medical', 'bipFA', '', 'BIP - A', 'BIP du foetus A', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:24:40', 3600, 1),
(75, 'medical', 'paFA', '', 'PA - A', 'PA du foetus A', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:26:33', 3600, 1),
(76, 'medical', 'cnFA', '', 'Clarté nuque - A', 'clarté nuque du foetus A', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:25:03', 3600, 1),
(77, 'medical', 'morphoCephaFA', '', 'Morpho du pôle céphalique - A', 'morpho du pôle céphalique du foetus A', '', '', 'textarea', 'les contours de la boîte crânienne ont un aspect habituel. La ligne médiane est en place. On distingue deux hémisphères d\'aspect habituel. La fosse postérieure a un aspect habituel pour le terme. ', 'user', 27, 1, '2017-04-13 08:58:05', 3600, 1),
(78, 'medical', 'abdoFA', '', 'Abdomen - A', 'aspect abdomen foetus A', '', '', 'textarea', 'la paroi abdominale est normalement fermée. L\'estomac est vu en position intra-abdominale. La vessie est vue.', 'user', 27, 1, '2017-04-13 08:53:00', 3600, 1),
(79, 'medical', 'membresFA', '', 'Aspect des membres - A', 'aspect des membres du foetus A', '', '', 'textarea', 'quatre membres vus avec chacun 3 segments.', 'user', 27, 1, '2017-04-13 08:55:33', 3600, 1),
(80, 'medical', 'actiCardioFB', '', 'Activité cardiaque - B', 'Activité cardique du foetus B', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'absente\'\n\'C\' : \'difficile à visualiser\'', 'user', 27, 1, '2017-04-25 22:35:21', 3600, 1),
(81, 'medical', 'rcfFB', '', 'RCF - B', 'rcf foetus B', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:27:03', 3600, 1),
(82, 'medical', 'mafFB', '', 'MAF - B', 'MAF du foetus B', '', '', 'text', 'présents et normaux', 'user', 27, 1, '2017-03-13 18:12:30', 3600, 1),
(83, 'medical', 'bipFB', '', 'BIP - B', 'BIP du foetus B', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:24:48', 3600, 1),
(84, 'medical', 'paFB', '', 'PA - B', 'PA du foetus B', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:26:40', 3600, 1),
(85, 'medical', 'cnFB', '', 'Clarté nuque - B', 'clarté nuque du foetus B', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:25:10', 3600, 1),
(86, 'medical', 'morphoCephaFB', '', 'Morpho du pôle céphalique - B', 'morpho du pôle céphalique du foetus B', '', '', 'textarea', 'les contours de la boîte crânienne ont un aspect habituel. La ligne médiane est en place. On distingue deux hémisphères d\'aspect habituel. La fosse postérieure a un aspect habituel pour le terme.', 'user', 27, 1, '2017-04-13 08:58:19', 3600, 1),
(87, 'medical', 'abdoFB', '', 'Abdomen - B', 'aspect abdomen foetus B', '', '', 'textarea', 'la paroi abdominale est normalement fermée. L\'estomac est vu en position intra-abdominale. La vessie est vue.', 'user', 27, 1, '2017-04-13 08:53:11', 3600, 1),
(88, 'medical', 'membresFB', '', 'Aspect des membres - B', 'aspect des membres du foetus B', '', '', 'textarea', 'quatre membres vus avec chacun 3 segments.', 'user', 27, 1, '2017-04-13 08:55:46', 3600, 1),
(89, 'medical', 'lccB', '', 'LCC - B', 'LCC du foetus B', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:26:16', 3600, 1),
(90, 'medical', 'actiCardioFC', '', 'Activité cardiaque - C', 'Activité cardique du foetus C', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'absente\'\n\'C\' : \'difficile à visualiser\'', 'user', 27, 1, '2017-04-25 22:35:29', 3600, 1),
(91, 'medical', 'rcfFC', '', 'RCF - C', 'rcf foetus C', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:27:10', 3600, 1),
(92, 'medical', 'mafFC', '', 'MAF - C', 'MAF du foetus C', '', '', 'text', 'présents et normaux', 'user', 27, 1, '2017-03-13 18:12:15', 3600, 1),
(93, 'medical', 'bipFC', '', 'BIP - C', 'BIP du foetus C', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:24:56', 3600, 1),
(94, 'medical', 'paFC', '', 'PA - C', 'PA du foetus C', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:26:49', 3600, 1),
(95, 'medical', 'cnFC', '', 'Clarté nuque - C', 'clarté nuque du foetus C', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:25:18', 3600, 1),
(96, 'medical', 'morphoCephaFC', '', 'Morpho du pôle céphalique - C', 'morpho du pôle céphalique du foetus C', '', '', 'textarea', 'les contours de la boîte crânienne ont un aspect habituel. La ligne médiane est en place. On distingue deux hémisphères d\'aspect habituel. La fosse postérieure a un aspect habituel pour le terme.', 'user', 27, 1, '2017-04-13 08:58:28', 3600, 1),
(97, 'medical', 'abdoFC', '', 'Abdomen - C', 'aspect abdomen foetus C', '', '', 'textarea', 'la paroi abdominale est normalement fermée. L\'estomac est vu en position intra-abdominale. La vessie est vue.', 'user', 27, 1, '2017-04-13 08:53:18', 3600, 1),
(98, 'medical', 'membresFC', '', 'Aspect des membres - C', 'aspect des membres du foetus C', '', '', 'textarea', 'quatre membres vus avec chacun 3 segments.', 'user', 27, 1, '2017-04-13 08:55:54', 3600, 1),
(99, 'medical', 'lccC', '', 'LCC - C', 'LCC du foetus C', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:26:24', 3600, 1),
(100, 'medical', 'conclusionE12', 'conclusion', 'Conclusion', 'conclusion écho 12', '', '', 'textarea', 'Grossesse unique intra-utérine évolutive.\nAbsence d\'anomalie morphologique décelée au cours de cet examen.\nMarqueurs sériques pour le dépistage de la trisomie 21 prescrits.', 'user', 27, 1, '2017-03-13 22:23:12', 3600, 1),
(101, 'medical', 'examenGynDuJour', 'examen gynécologique du jour', 'Examen gynécologique du jour', 'examen gynécologique du jour', '', '', 'textarea', 'Examen normal\nFCV fait ce jour\nCoup d’œil écho RAS \nSeins RAS', 'user', 35, 1, '2017-05-14 21:13:03', 3600, 1),
(102, 'medical', 'motifCsGyneco', 'motif de consultation', 'Motif', 'motif de la consultation', '', '', 'text', '', 'user', 35, 1, '2017-03-14 11:07:56', 3600, 1),
(103, 'admin', 'rpps', 'rpps', 'RPPS', 'rpps', 'numeric', '', 'number', '', 'user', 36, 1, '2017-03-14 14:46:29', 3600, 1),
(104, 'admin', 'adeli', 'adeli', 'Adeli', 'n° adeli', '', '', 'text', '', 'user', 36, 1, '2017-03-14 14:48:26', 3600, 1),
(105, 'courrier', 'pratiqueSportive', '', 'Certificat de pratique sportive', 'autorisation pratique sportive', '', '', '', 'certif-pratiqueSportive', 'user', 37, 1, '2017-04-10 16:14:31', 3600, 1),
(106, 'courrier', 'certifPresenceConsultation', '', 'Certificat présence à la consultation', 'certificat présence à la consultation', '', '', '', 'certif-presence', 'user', 37, 1, '2017-05-15 09:15:17', 3600, 1),
(107, 'courrier', 'modeleCourrierVierge', '', 'Courrier', 'modèle de courrier vierge', '', '', '', 'courrier-courrierVierge', 'user', 38, 1, '2017-04-10 16:14:47', 3600, 0),
(108, 'courrier', 'modeleCertifVierge', '', 'Certificat', 'modèle de certificat vierge', '', '', '', 'certif-certificatVierge', 'user', 37, 1, '2017-04-10 16:13:45', 3600, 0),
(109, 'mail', 'mailFrom', 'email@domain.net', 'De', 'mail from', '', '', 'email', '', 'user', 39, 1, '2017-03-21 10:20:08', 1576800000, 1),
(110, 'mail', 'mailTo', '', 'A', 'mail to', '', '', 'email', '', 'user', 39, 1, '2017-03-21 10:20:21', 1576800000, 1),
(111, 'mail', 'mailBody', 'texte du message', 'Message', 'texte du message', '', '', 'textarea', '', 'user', 39, 1, '2017-03-16 19:51:28', 1576800000, 1),
(112, 'mail', 'mailSujet', 'sujet du mail', 'Sujet', 'sujet du mail', '', '', 'text', '', 'user', 39, 1, '2017-03-16 19:52:04', 1576800000, 1),
(113, 'medical', 'termeLCCFA', '', 'Terme & DDG / LCC - A', 'terme estimé en fonction de la LCC - Foetus A', '', '', 'lcc', '', 'user', 27, 1, '2017-04-26 11:33:09', 3600, 1),
(114, 'medical', 'termeLCCFB', '', 'Terme & DDG / LCC - B', 'terme estimé en fonction de la LCC - Foetus B', '', '', 'lcc', '', 'user', 27, 1, '2017-04-26 11:52:03', 3600, 1),
(115, 'medical', 'termeLCCFC', '', 'Terme & DDG / LCC - C', 'terme estimé en fonction de la LCC - Foetus C', '', '', 'lcc', '', 'user', 27, 1, '2017-04-26 11:52:10', 3600, 1),
(117, 'medical', 'e11SGlocaFA', '', 'Sac gest. : localisation - A', 'localisation du sac gest. - foetus A', '', '', 'select', '\'A\' : \'intra-utérine\'\n\'B\' : \'corne utérine droite\'\n\'C\' : \'corne utérine gauche\'\n\'D\' : \'isthmique\'\n\'E\' : \'cervicale\'\n\'E\' : \'non vu\'', 'user', 40, 1, '2017-04-29 22:17:46', 3600, 1),
(118, 'medical', 'e11sgtoniciteFA', '', 'Sac gest. : tonicité - A', 'tonicité du sac gestationnel - foetus A', '', '', 'select', '\'A\' : \'normalement tonique\'\n\'B\' : \'hypotonique\'', 'user', 40, 1, '2017-04-29 22:37:31', 3600, 1),
(119, 'medical', 'e11sgtrophoFA', '', 'Sac gest. : trophoblaste - A', 'trophoblaste - foetus A', '', '', 'text', 'aspect habituel', 'user', 40, 1, '2017-04-29 22:24:10', 3600, 1),
(120, 'medical', 'e11sgdimlargFA', '', 'Sac gest. : largeur - A', 'largeur du sac gestationnel - foetus A', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(121, 'medical', 'e11sgdimlongFA', '', 'Sac gest. : longueur - A', 'longueur du sac gestationnel - foetus A', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(122, 'medical', 'e11sgdimhauteurFA', '', 'Sac gest. : hauteur - A', 'hauteur du sac gestationnel - foetus A', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(123, 'medical', 'e11sgdimdiametreFA', '', 'Sac gest. : diamètre - A', 'Diamètre du sac gestationnel - foetus A', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(124, 'medical', 'e11sgdecoFA', '', 'Sac gest. : décollement - A', 'décollement du sac gestationnel - foetus A', '', '', 'text', 'absence d\'image de décollement', 'user', 40, 1, '2017-04-29 22:25:19', 3600, 1),
(125, 'medical', 'e11embryLCCFA', '', 'LCC - A', 'LCC de l\'embryon - foetus A', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:42:50', 3600, 1),
(126, 'medical', 'e11EmbryBIPFA', '', 'BIP - A', 'BIP - foetus A', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:42:23', 3600, 1),
(127, 'medical', 'e11embryActiCardFA', '', 'Actvité cardiaque - A', 'activité cardiaque - foetus A', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'absente\'\n\'C\' : \'difficile à visualiser\'', 'user', 40, 1, '2017-04-29 22:11:18', 3600, 1),
(128, 'medical', 'e11morphoCephaFA', '', 'Morphologie de l\'extrémité céphalique - A', 'morphologie de l\'extrémité céphalique - foetus A', '', '', 'textarea', 'aspect habituel', 'user', 40, 1, '2017-04-29 22:13:45', 3600, 1),
(129, 'medical', 'e11morphoMembresFA', '', 'Morphologie des membres - A', 'morphologie des membres - foetus A', '', '', 'textarea', '4 ébauches vues', 'user', 40, 1, '2017-03-17 10:15:55', 3600, 1),
(130, 'medical', 'e11indic', 'motif de l\'échographie', 'Indication', 'motif écho', '', '', 'select', '\'A\' : \'datation\'\n\'B\' : \'contrôle d\\\'évolutivité\'\n\'C\' : \'contrôle de localisation\' \n\'D\' : \'douleurs pelviennes\'\n\'E\' : \'métrorragies\'', 'user', 40, 1, '2017-04-29 22:03:16', 3600, 1),
(131, 'medical', 'e11nbembryons', '', 'Nombre d\'embryons', 'nombre d\'embryons', '', '', 'number', '1', 'user', 40, 1, '2017-04-29 22:07:00', 3600, 1),
(132, 'medical', 'e11conditionEcho', '', 'Conditions de réalisation', 'conditions de réalisation de l\'écho', '', '', 'select', '\'A\' : \'bonnes\'\n\'B\' : \'limitées par l\\\'échogénicité pariétale\'\n\'C\' : \'limitées par la position foetale\'\n\'D\' : \'limitées par l\\\'échogénicité pariétale et  la position foetale\'\n\'E\' : \'difficiles\'\n\'F\' : \'limitées par la position utérine\'\n\'G\' : \'limitées par la quantité de liquide amniotique\'\n\'H\' : \'limitée par les mouvements foetaux\'', 'user', 40, 1, '2017-04-30 21:09:53', 3600, 1),
(133, 'medical', 'e11voieExamen', '', 'Voie d\'examen', 'voie d\'examen', '', '', 'select', '\'A\' : \'abdominale\'\n\'B\' : \'vaginale\'\n\'C\' : \'abdominale et vaginale\'', 'user', 40, 1, '2017-04-29 22:04:38', 3600, 1),
(134, 'medical', 'e11uterusposi', '', 'Uterus : position', 'position de l\'utérus', '', '', 'select', '\'A\' : \'antéversé\'\n\'B\' : \'rétroversé\'\n\'C\' : \'position intermédiaire\'', 'user', 40, 1, '2017-03-17 10:30:38', 3600, 1),
(135, 'medical', 'e11uteruscontours', '', 'Utérus : contours', 'contours de l\'utérus', '', '', 'select', '\'A\' : \'Réguliers\'\n\'B\' : \'Irréguliers\'\n\'C\' : \'Polymyomateux\'', 'user', 40, 1, '2017-03-17 10:33:50', 3600, 1),
(136, 'medical', 'e11uterusstructure', '', 'Utérus : structure', 'structure de l\'utérus', '', '', 'select', '\'A\' : \'homogène\'\n\'B\' : \'inhomogène\'\n\'C\' : \'polymyomateux\'', 'user', 40, 1, '2017-03-17 10:35:38', 3600, 1),
(137, 'medical', 'e11uterusTaille', '', 'Uterus : taille', 'taille de l\'utérus', '', '', 'text', 'x x', 'user', 40, 1, '2017-03-17 10:36:44', 3600, 1),
(138, 'medical', 'e11ovaireDt', '', 'Ovaire droit : taille', 'ovaire droit : taille', '', '', 'text', '', 'user', 40, 1, '2017-03-30 15:52:15', 3600, 1),
(139, 'medical', 'e11ovairedtaspect', '', 'Ovaire droit : aspect', 'aspect de l\'ovaire droit', '', '', 'textarea', 'Vu, aspect normal.', 'user', 40, 1, '2017-03-17 10:40:11', 3600, 1),
(140, 'medical', 'e11ovaireG', '', 'Ovaire gauche : taille', 'ovaire gauche : taille', '', '', 'text', '', 'user', 40, 1, '2017-03-30 15:52:25', 3600, 1),
(141, 'medical', 'e11ovairegaspect', '', 'Ovaire gauche : aspect', 'aspect de l\'ovaire gauche', '', '', 'textarea', 'Vu, aspect normal.', 'user', 40, 1, '2017-03-17 10:40:11', 3600, 1),
(142, 'medical', 'e11RCFFA', '', 'RCF - A', 'RCF - foetus A', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:43:18', 3600, 1),
(143, 'medical', 'e11SGlocaFB', '', 'Sac gest. : localisation - B', 'localisation du sac gest. - foetus B', '', '', 'select', '\'A\' : \'intra-utérine\'\n\'B\' : \'corne utérine droite\'\n\'C\' : \'corne utérine gauche\'\n\'D\' : \'isthmique\'\n\'E\' : \'cervicale\'\n\'E\' : \'non vu\'', 'user', 40, 1, '2017-04-29 22:17:59', 3600, 1),
(144, 'medical', 'e11sgtoniciteFB', '', 'Sac gest. : tonicité - B', 'tonicité du sac gestationnel - foetus B', '', '', 'select', '\'A\' : \'normalement tonique\'\n\'B\' : \'hypotonique\'', 'user', 40, 1, '2017-04-29 22:37:38', 3600, 1),
(145, 'medical', 'e11sgtrophoFB', '', 'Sac gest. : trophoblaste - B', 'trophoblaste - foetus B', '', '', 'text', 'aspect habituel', 'user', 40, 1, '2017-04-29 22:59:55', 3600, 1),
(146, 'medical', 'e11sgdimlargFB', '', 'Sac gest. : largeur - B', 'largeur du sac gestationnel - foetus B', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(147, 'medical', 'e11sgdimlongFB', '', 'Sac gest. : longueur - B', 'longueur du sac gestationnel - foetus B', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(148, 'medical', 'e11sgdimhauteurFB', '', 'Sac gest. : hauteur - B', 'hauteur du sac gestationnel - foetus B', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(149, 'medical', 'e11sgdimdiametreFB', '', 'Sac gest. : diamètre - B', 'Diamètre du sac gestationnel - foetus B', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(150, 'medical', 'e11sgdecoFB', '', 'Sac gest. : décollement - B', 'décollement du sac gestationnel - foetus B', '', '', 'text', 'absence d\'image de décollement', 'user', 40, 1, '2017-04-29 22:25:31', 3600, 1),
(151, 'medical', 'e11embryLCCFB', '', 'LCC - B', 'LCC de l\'embryon - foetus B', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:43:07', 3600, 1),
(152, 'medical', 'e11EmbryBIPFB', '', 'BIP - B', 'BIP - foetus B', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:42:40', 3600, 1),
(153, 'medical', 'e11embryActiCardFB', '', 'Actvité cardiaque - B', 'activité cardiaque - foetus B', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'absente\'\n\'C\' : \'difficile à visualiser\'', 'user', 40, 1, '2017-04-29 22:11:25', 3600, 1),
(154, 'medical', 'e11morphoCephaFB', '', 'Morphologie de l\'extrémité céphalique - B', 'morphologie de l\'extrémité céphalique - foetus B', '', '', 'textarea', 'aspect habituel', 'user', 40, 1, '2017-04-29 22:13:06', 3600, 1),
(155, 'medical', 'e11morphoMembresFB', '', 'Morphologie des membres - B', 'morphologie des membres - foetus B', '', '', 'textarea', '4 ébauches vues', 'user', 40, 1, '2017-03-17 10:15:55', 3600, 1),
(156, 'medical', 'e11RCFFB', '', 'RCF - B', 'RCF - foetus B', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:43:35', 3600, 1),
(157, 'medical', 'e11SGlocaFC', '', 'Sac gest. : localisation - C', 'localisation du sac gest. - foetus C', '', '', 'select', '\'A\' : \'intra-utérine\'\n\'B\' : \'corne utérine droite\'\n\'C\' : \'corne utérine gauche\'\n\'D\' : \'isthmique\'\n\'E\' : \'cervicale\'\n\'E\' : \'non vu\'', 'user', 40, 1, '2017-04-29 22:18:09', 3600, 1),
(158, 'medical', 'e11sgtoniciteFC', '', 'Sac gest. : tonicité - C', 'tonicité du sac gestationnel - foetus C', '', '', 'select', '\'A\' : \'normalement tonique\'\n\'B\' : \'hypotonique\'', 'user', 40, 1, '2017-04-29 22:37:45', 3600, 1),
(159, 'medical', 'e11sgtrophoFC', '', 'Sac gest. : trophoblaste - C', 'trophoblaste - foetus C', '', '', 'text', 'aspect habituel', 'user', 40, 1, '2017-04-29 23:00:06', 3600, 1),
(160, 'medical', 'e11sgdimlargFC', '', 'Sac gest. : largeur - C', 'largeur du sac gestationnel - foetus C', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(161, 'medical', 'e11sgdimlongFC', '', 'Sac gest. : longueur - C', 'longueur du sac gestationnel - foetus C', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(162, 'medical', 'e11sgdimhauteurFC', '', 'Sac gest. : hauteur - C', 'hauteur du sac gestationnel - foetus C', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(163, 'medical', 'e11sgdimdiametreFC', '', 'Sac gest. : diamètre - C', 'Diamètre du sac gestationnel - foetus C', '', '', 'text', '', 'user', 40, 1, '2017-03-17 10:01:47', 3600, 1),
(164, 'medical', 'e11sgdecoFC', '', 'Sac gest. : décollement - C', 'décollement du sac gestationnel - foetus C', '', '', 'text', 'absence d\'image de décollement', 'user', 40, 1, '2017-04-29 22:25:41', 3600, 1),
(165, 'medical', 'e11embryLCCFC', '', 'LCC - C', 'LCC de l\'embryon - foetus C', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:42:59', 3600, 1),
(166, 'medical', 'e11EmbryBIPFC', '', 'BIP - C', 'BIP - foetus C', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:42:31', 3600, 1),
(167, 'medical', 'e11embryActiCardFC', '', 'Actvité cardiaque - C', 'activité cardiaque - foetus C', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'absente\'\n\'C\' : \'difficile à visualiser\'', 'user', 40, 1, '2017-04-29 22:11:32', 3600, 1),
(168, 'medical', 'e11morphoCephaFC', '', 'Morphologie de l\'extrémité céphalique - C', 'morphologie de l\'extrémité céphalique - foetus C', '', '', 'textarea', 'aspect habituel', 'user', 40, 1, '2017-04-29 22:12:42', 3600, 1),
(169, 'medical', 'e11morphoMembresFC', '', 'Morphologie des membres - C', 'morphologie des membres - foetus C', '', '', 'textarea', '4 ébauches vues', 'user', 40, 1, '2017-03-17 10:15:55', 3600, 1),
(170, 'medical', 'e11RCFFC', '', 'RCF - C', 'RCF - foetus C', '', '', 'text', '', 'user', 40, 1, '2017-04-27 15:43:26', 3600, 1),
(171, 'medical', 'e11typeGro', '', 'Type de grossesse', 'type de grossesse', '', '', 'select', '\'A\' : \'unique\'\n\'B\' : \'bichoriale biamniotique\'\n\'C\' : \'monochoriale biamniotique\'\n\'D\' : \'monochoriale monoamniotique\'\n\'E\' : \'bichoriale biamniotique + 1\'\n\'F\' : \'monochoriale biamniotique + 1\'\n\'G\' : \'monochoriale monoamniotique +1\'\n\'H\' : \'trichoriale triamniotique\'', 'user', 40, 1, '2017-04-29 22:06:45', 3600, 1),
(172, 'medical', 'e11membrane', '', 'Membrane', 'aspect des mebranes', '', '', 'select', '\'A\' : \'signe du lambda\'\n\'B\' : \'fine insérée en T\'\n\'C\' : \'autre\'', 'user', 40, 1, '2017-04-29 22:08:01', 3600, 1),
(173, 'medical', 'e11foetusvuFA', '', 'Visibilité du foetus - A', 'visbilité du foetus A à l\'examen', '', '', 'select', '\'A\' : \'Vu\'\n\'B\' : \'Non vu\'', 'user', 40, 1, '2017-03-17 11:36:23', 3600, 1),
(174, 'medical', 'e11foetusvuFB', '', 'Visibilité du foetus - B', 'visbilité du foetus B à l\'examen', '', '', 'select', '\'A\' : \'Vu\'\r\n\'B\' : \'Non vu\'', 'user', 40, 1, '2017-03-17 11:36:23', 3600, 1),
(175, 'medical', 'e11foetusvuFC', '', 'Visibilité du foetus - C', 'visbilité du foetus C à l\'examen', '', '', 'select', '\'A\' : \'Vu\'\r\n\'B\' : \'Non vu\'', 'user', 40, 1, '2017-03-17 11:36:23', 3600, 1),
(176, 'medical', 'e11conclusion', '', 'Conclusion générale', 'conclusion de l\'echo 11', '', '', 'textarea', 'Grossesse unique intra-utérine évolutive.\nAbsence d\'anomalie décelée au cours de cet examen.\nProchaine échographie autour de 12 SA.', 'user', 40, 1, '2017-04-29 22:33:32', 3600, 1),
(177, 'mail', 'porteurMail', '', 'Mail', 'porteur pour les mails', '', '', '', '', 'user', 41, 1, '2017-03-20 12:53:14', 1576800000, 1),
(178, 'mail', 'pj1', '', 'ID pièce jointe', 'id de la pièce jointe au mail', '', '', '', '', 'user', 39, 1, '2017-03-20 13:03:35', 1576800000, 1),
(179, 'mail', 'aApicrypt', '', 'A (correspondant apicrypt)', 'Champ pour les correspondants apicrypt', '', '', 'email', '', 'user', 39, 1, '2017-03-21 10:20:33', 1576800000, 1),
(180, 'admin', 'nss', '', 'Numéro de sécu', 'numéro de sécurité sociale', '', '', 'text', '', 'user', 36, 1, '2017-03-20 15:05:17', 3600, 1),
(181, 'doc', 'docTitle', '', 'Titre', 'titre du document', '', '', '', '', 'user', 42, 1, '2017-03-21 11:57:32', 3600, 1),
(182, 'doc', 'docOrigine', '', 'Origine du document', 'origine du document : interne ou externe(null)', '', '', 'text', '', 'user', 42, 1, '2017-05-15 13:36:57', 3600, 1),
(183, 'doc', 'docType', '', 'Type du document', 'type du document importé', '', '', 'text', '', 'user', 42, 1, '2017-03-21 10:30:16', 3600, 1),
(184, 'doc', 'docPorteur', '', 'Document', 'porteur pour nouveau document importé', '', '', '', '', 'user', 43, 1, '2017-03-21 21:08:37', 1576800000, 1),
(185, 'doc', 'docOriginalName', '', 'Nom original', 'nom original du document', '', '', '', '', 'user', 42, 1, '2017-03-21 11:57:32', 3600, 1),
(186, 'ordo', 'porteurOrdo', '', 'Ordonnance', 'porteur ordonnance', '', '', '', '', 'user', 44, 1, '2017-03-23 10:56:41', 3600, 1),
(187, 'ordo', 'porteurCatPres1', '', 'Prescriptions médicamenteuses', '', '', '', 'select', '', 'user', 44, 1, '2017-04-01 12:24:38', 3600, 1),
(188, 'ordo', 'porteurPresNonMedic', '', 'Prescritpions non médicamenteuses', 'prescritpion non médicamenteuse', '', '', 'select', '', 'user', 44, 1, '2017-04-01 12:24:29', 3600, 1),
(189, 'ordo', 'ordoTypeFormImpression', '', 'Type ordonnance impression', 'type d\'ordonnance pour impression', '', '', '', '', 'user', 44, 1, '2017-03-22 15:52:54', 3600, 1),
(190, 'ordo', 'ligneOrdo', '', 'Ligne d\'ordonnance', 'porteur pour une ligne d\'ordo', '', '', '', '', 'user', 44, 1, '2017-03-22 16:06:35', 3600, 1),
(191, 'ordo', 'ligneOrdoALDouPas', '', 'Ligne d\'ordonnance : ald', '1 si ald', '', '', '', '', 'user', 44, 1, '2017-03-22 17:17:31', 3600, 1),
(192, 'reglement', 'porteurReglement', '', 'Règlement', '', '', '', '', '', 'user', 45, 1, '2017-03-27 08:39:41', 1576800000, 1),
(193, 'reglement', 'regleCheque', '', 'Chèque', 'montant versé en chèque', '', '', 'text', '', 'user', 46, 1, '2017-04-27 13:38:26', 1576800000, 1),
(194, 'reglement', 'regleCB', '', 'CB', 'montant versé en CB', '', '', 'text', '', 'user', 46, 1, '2017-04-27 13:38:21', 1576800000, 1),
(195, 'reglement', 'regleEspeces', '', 'Espèces', 'montant versé en espèce', '', '', 'text', '', 'user', 46, 1, '2017-04-27 13:38:47', 1576800000, 1),
(196, 'reglement', 'aFacturer', '', 'Facturé', 'facturé ce jour', '', '', 'text', '0', 'user', 46, 1, '2017-04-27 13:39:03', 1576800000, 1),
(197, 'reglement', 'regleType', '', 'Situation du patient', '', '', '', 'select', '\'G\' : \'Tout venant\'\n\'CMU\' : \'CMU\'\n\'TP\' : \'Tiers payant\'', 'user', 46, 1, '2017-03-27 10:27:04', 1576800000, 1),
(198, 'reglement', 'regleTarifCejour', '', 'Tarif SS', 'tarif SS appliqué ce jour', '', '', 'text', '', 'user', 46, 1, '2017-04-27 13:39:12', 1576800000, 1),
(199, 'reglement', 'regleDepaCejour', '', 'Dépassement', 'dépassement pratiqué ce jour', '', '', 'text', '', 'user', 46, 1, '2017-04-27 13:38:32', 1576800000, 1),
(200, 'reglement', 'regleTiersPayeur', '', 'Tiers', 'part du tiers', '', '', 'text', '', 'user', 46, 1, '2017-04-27 13:39:23', 1576800000, 1),
(201, 'typecs', 'echoGyneco', '', 'Echographie gynécologique', 'support parent pour l\'échographie gynécologique', '', '', '', '27', 'user', 33, 1, '2017-05-04 20:36:43', 86400, 1),
(202, 'medical', 'E11termeLCCFA', '', 'Terme & DDG / LCC - A', 'terme estimé en fonction de la LCC - Foetus A', '', '', 'lcc', '', 'user', 40, 1, '2017-04-26 13:46:26', 3600, 1),
(203, 'medical', 'E11termeLCCFB', '', 'Terme & DDG / LCC - B', 'terme estimé en fonction de la LCC - Foetus B', '', '', 'lcc', '', 'user', 40, 1, '2017-04-26 13:46:45', 3600, 1),
(204, 'medical', 'E11termeLCCFC', '', 'Terme & DDG / LCC - C', 'terme estimé en fonction de la LCC - Foetus C', '', '', 'lcc', '', 'user', 40, 1, '2017-04-26 13:47:05', 3600, 1),
(205, 'reglement', 'identiteCheque', 'si différent patient', 'Identité payeur', '', '', '', 'text', '', 'user', 46, 1, '2017-03-27 13:14:03', 1576800000, 1),
(206, 'medical', 'e12femurA', '', 'Fémur - A', 'longueur fémur', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:25:27', 3600, 1),
(207, 'medical', 'e12femurB', 'mm', 'Fémur - B', 'longueur fémur', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:25:41', 3600, 1),
(208, 'medical', 'e12femurC', '', 'Fémur - C', 'longueur fémur', '', '', 'text', '', 'user', 27, 1, '2017-04-27 15:25:59', 3600, 1),
(209, 'medical', 'e12typeGro', '', 'Type de grossesse', 'type de grossesse', '', '', 'select', '\'A\' : \'unique\'\n\'B\' : \'bichoriale biamniotique\'\n\'C\' : \'monochoriale biamniotique\'\n\'D\' : \'monochoriale monoamniotique\'\n\'E\' : \'bichoriale biamniotique + 1\'\n\'F\' : \'monochoriale biamniotique + 1\'\n\'G\' : \'monochoriale monoamniotique +1\'\n\'H\' : \'trichoriale triamniotique\'', 'user', 27, 1, '2017-04-29 21:53:36', 3600, 1),
(210, 'medical', 'e12membrane', '', 'Membrane', 'aspect des mebranes', '', '', 'select', '\'A\' : \'signe du lambda\'\n\'B\' : \'fine insérée en T\'\n\'C\' : \'autre\'', 'user', 27, 1, '2017-04-25 22:33:13', 3600, 1),
(211, 'medical', 'E12liquideA', '', 'Liquide amniotique - A', 'liquide amniotique foetus A', '', '', 'select', '\'A\' : \'abondance normale\'\n\'B\' : \'oligoamnios\'', 'user', 27, 1, '2017-04-29 21:21:15', 3600, 1),
(212, 'medical', 'E12liquideB', '', 'Liquide amniotique - B', 'liquide amniotique foetus B', '', '', 'select', '\'A\' : \'abondance normale\'\n\'B\' : \'oligoamnios\'', 'user', 27, 1, '2017-04-29 21:21:22', 3600, 1),
(213, 'medical', 'E12liquideC', '', 'Liquide amniotique - C', 'liquide amniotique foetus C', '', '', 'select', '\'A\' : \'abondance normale\'\n\'B\' : \'oligoamnios\'', 'user', 27, 1, '2017-04-29 21:21:28', 3600, 1),
(214, 'medical', 'e12trophoAspectFA', '', 'Trophoblaste : aspect - A', 'trophoblaste - foetus A', '', '', 'text', 'homogène', 'user', 27, 1, '2017-04-29 21:26:26', 3600, 1),
(215, 'medical', 'e12trophoFA', '', 'Trophoblaste : localisation - A', 'trophoblaste - foetus A', '', '', 'text', '', 'user', 27, 1, '2017-04-29 21:24:21', 3600, 1),
(216, 'medical', 'e12trophoFB', '', 'Trophoblaste : localisation - B', 'trophoblaste - foetus B', '', '', 'text', '', 'user', 27, 1, '2017-04-29 21:24:34', 3600, 1),
(217, 'medical', 'e12trophoFC', '', 'Trophoblaste : localisation - C', 'trophoblaste - foetus C', '', '', 'text', '', 'user', 27, 1, '2017-04-29 21:24:46', 3600, 1),
(218, 'medical', 'e12trophoAspectFB', '', 'Trophoblaste : aspect - B', 'trophoblaste - foetus B', '', '', 'text', 'homogène', 'user', 27, 1, '2017-04-29 21:26:48', 3600, 1),
(219, 'medical', 'e12trophoAspectFC', '', 'Trophoblaste : aspect - C', 'trophoblaste - foetus C', '', '', 'text', 'homogène', 'user', 27, 1, '2017-04-29 21:27:00', 3600, 1),
(220, 'medical', 'e12decoFA', '', 'Décollement - A', 'Décollement - A', '', '', 'text', 'absence d\'image de décollement', 'user', 27, 1, '2017-04-29 21:28:25', 3600, 1),
(221, 'medical', 'e12decoFB', '', 'Décollement - B', 'Décollement - B', '', '', 'text', 'absence d\'image de décollement', 'user', 27, 1, '2017-04-29 21:28:38', 3600, 1),
(222, 'medical', 'e12decoFC', '', 'Décollement - C', 'Décollement - C', '', '', 'text', 'absence d\'image de décollement', 'user', 27, 1, '2017-04-29 21:28:49', 3600, 1),
(223, 'medical', 'examenColpoDuJour', 'examen colposcopique du jour', 'Examen colposcopique du jour', 'examen colposcopique du jour', '', '', 'textarea', '', 'user', 48, 1, '2017-04-01 18:18:46', 3600, 1),
(224, 'medical', 'igLieu', 'lieu de l\'accouchement / fin de grossesse', 'Lieu', 'lieu de l\'accouchement / fin de grossesse', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:38:34', 3600, 1),
(225, 'medical', 'igDate', '', 'Date accouchement', 'date d\'accouchement', '', '', 'date', '', 'user', 49, 1, '2017-04-03 10:39:29', 3600, 1),
(226, 'medical', 'igTermeFA', 'SA', 'Terme - A', 'terme de la grossesse en SA', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:41:07', 3600, 1),
(227, 'medical', 'SigSexeFA', '', 'Sexe - A', 'sexe du foetus A', '', '', 'select', '\'F\' : \'féminin\'\n\'M\' : \'masculin\'\n\'A\' : \'ambigu\'\n\'I\' : \'inconnu\'', 'user', 49, 1, '2017-04-03 10:43:08', 3600, 1),
(228, 'medical', 'igPoidsFA', 'g', 'Poids - A', 'poids du foetus A', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:43:54', 3600, 1),
(229, 'medical', 'igModaliteFA', '', 'Modalité - A', 'modalité de fin de grossesse', '', '', 'select', '\'A\' : \'Accouchement voie basse\'\n\'B\' : \'Accouchement voie basse (instruments)\'\n\'C\' : \'Césarienne\'\n\'D\' : \'Siège voie basse\'\n\'FCS\' : \'FCS\'\n\'FCT\' : \'FCT\'\n\'ISG\' : \'ISG\'\n\'IVG\' : \'IVG\'\n\'GEU\' : \'GEU\'\n\'MFIU\' : \'MFIU\'\n\'IMG\' : \'IMG\'\n\'Mole\' : \'Mole\'', 'user', 49, 1, '2017-04-03 10:49:19', 3600, 1),
(230, 'medical', 'igPrenomFA', 'prénom', 'Prénom - A', 'prénom foetus A', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:52:31', 3600, 1),
(231, 'medical', 'igEtatSanteFA', 'état de santé', 'Etat de santé - A', 'état de santé du foetus A', '', '', 'text', 'bien portant', 'user', 49, 1, '2017-04-03 10:52:16', 3600, 1),
(232, 'medical', 'igTermeFB', 'SA', 'Terme - B', 'terme de la grossesse en SA', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:54:02', 3600, 1),
(233, 'medical', 'SigSexeFB', '', 'Sexe - B', 'sexe du foetus B', '', '', 'select', '\'F\' : \'féminin\'\n\'M\' : \'masculin\'\n\'A\' : \'ambigu\'\n\'I\' : \'inconnu\'', 'user', 49, 1, '2017-04-03 10:54:16', 3600, 1),
(234, 'medical', 'igModaliteFB', '', 'Modalité - B', 'modalité de fin de grossesse', '', '', 'select', '\'A\' : \'Accouchement voie basse\'\n\'B\' : \'Accouchement voie basse (instruments)\'\n\'C\' : \'Césarienne\'\n\'D\' : \'Siège voie basse\'\n\'FCS\' : \'FCS\'\n\'FCT\' : \'FCT\'\n\'ISG\' : \'ISG\'\n\'IVG\' : \'IVG\'\n\'GEU\' : \'GEU\'\n\'MFIU\' : \'MFIU\'\n\'IMG\' : \'IMG\'\n\'Mole\' : \'Mole\'', 'user', 49, 1, '2017-04-03 10:54:37', 3600, 1),
(235, 'medical', 'igPrenomFB', 'prénom', 'Prénom - B', 'prénom foetus B', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:54:54', 3600, 1),
(236, 'medical', 'igEtatSanteFB', 'état de santé', 'Etat de santé - B', 'état de santé du foetus B', '', '', 'text', 'bien portant', 'user', 49, 1, '2017-04-03 10:55:10', 3600, 1),
(237, 'medical', 'igPoidsFB', 'g', 'Poids - B', 'poids du foetus B', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:55:51', 3600, 1),
(238, 'medical', 'igTermeFC', 'SA', 'Terme - C', 'terme de la grossesse en SA', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:56:15', 3600, 1),
(239, 'medical', 'SigSexeFC', '', 'Sexe - C', 'sexe du foetus C', '', '', 'select', '\'F\' : \'féminin\'\n\'M\' : \'masculin\'\n\'A\' : \'ambigu\'\n\'I\' : \'inconnu\'', 'user', 49, 1, '2017-04-03 10:56:32', 3600, 1),
(240, 'medical', 'igModaliteFC', '', 'Modalité - C', 'modalité de fin de grossesse', '', '', 'select', '\'A\' : \'Accouchement voie basse\'\n\'B\' : \'Accouchement voie basse (instruments)\'\n\'C\' : \'Césarienne\'\n\'D\' : \'Siège voie basse\'\n\'FCS\' : \'FCS\'\n\'FCT\' : \'FCT\'\n\'ISG\' : \'ISG\'\n\'IVG\' : \'IVG\'\n\'GEU\' : \'GEU\'\n\'MFIU\' : \'MFIU\'\n\'IMG\' : \'IMG\'\n\'Mole\' : \'Mole\'', 'user', 49, 1, '2017-04-03 10:56:52', 3600, 1),
(241, 'medical', 'igPrenomFC', 'prénom', 'Prénom - C', 'prénom foetus C', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:57:11', 3600, 1),
(242, 'medical', 'igEtatSanteFC', 'état de santé', 'Etat de santé - C', 'état de santé du foetus C', '', '', 'text', 'bien portant', 'user', 49, 1, '2017-04-03 10:57:26', 3600, 1),
(243, 'medical', 'igPoidsFC', 'g', 'Poids - C', 'poids du foetus C', '', '', 'text', '', 'user', 49, 1, '2017-04-03 10:57:47', 3600, 1),
(244, 'medical', 'igNbFoetus', '', 'Nombre de foetus', 'nombre de foetus', '', '', 'number', '1', 'user', 49, 1, '2017-04-03 11:10:49', 3600, 1),
(245, 'medical', 'groFermetureSuivi', '', 'Fermeture de la grossesse', 'date de fermeture de la grossesse (porteur)', '', '', 'text', '', 'user', 32, 1, '2017-04-03 12:53:52', 3600, 1),
(246, 'medical', 'rubStatut', '', 'Rubéole', 'statut rubéole', '', '', 'select', '\'rubIco\' : \'?\'\n\'rub+\' : \'Rub +\'\n\'rub-\' : \'Rub neg\'', 'user', 31, 1, '2017-04-04 17:58:06', 3600, 1),
(247, 'admin', 'mobilePhonePro', '06 xx xx xx xx', 'Téléphone mobile pro.', 'Numéro de téléphone commençant par 06 ou 07', 'mobilphone', 'Le numéro de téléphone mobile pro est incorrect', 'tel', '', 'user', 24, 1, '2017-04-04 09:09:52', 3600, 1),
(248, 'admin', 'telPro2', 'téléphone professionnel 2', 'Téléphone professionnel 2', 'Téléphone pro. 2', 'phone', '', 'tel', '', 'user', 24, 1, '2017-04-04 09:16:41', 3600, 1),
(249, 'admin', 'serviceAdressePro', 'service', 'Service', 'Adresse pro : service', '', '', 'text', '', 'user', 47, 1, '2017-04-04 09:35:37', 3600, 1),
(250, 'admin', 'etablissementAdressePro', 'établissement', 'Établissement', 'Adresse pro : établissement', '', '', 'text', '', 'user', 47, 1, '2017-04-04 09:36:21', 3600, 1),
(251, 'typecs', 'csImport', '', 'Import', 'support parent pour import', '', '', '', '22', 'user', 50, 1, '2017-05-04 20:39:37', 84600, 1),
(252, 'medical', 'dataImport', '', 'Import', 'support pour consultations importées', '', '', 'textarea', '', 'user', 29, 1, '2017-04-04 10:15:55', 84600, 1),
(253, 'medical', 'indicEcho22', '', 'Indication', 'indication de l\'écho de 22', '', '', 'select', '\'A\' : \'dépistage du 2e trimestre\'\n\'B\' : \'complément à un premier examen difficile\'\n\'C\' : \'douleurs pelviennes\'\n\'D\' : \'métrorragies\'\n\'E\' : \'diminution des mouvements actifs fœtaux\'\n\'F\' : \'échographie de seconde intention\'\n\'G\' : \'suivi de grossesse gémellaire\'\n\'H\' : \'surveillance\'\n\'I\' : \'échographie pré-morphologique\'', 'user', 51, 1, '2017-04-30 21:07:41', 3600, 1),
(254, 'medical', 'nbFoetusEcho22', '', 'Nombre de foetus', 'nombre de foetus à l\'écho 22', '', '', 'number', '1', 'user', 51, 1, '2017-04-06 15:23:20', 3600, 1),
(255, 'medical', 'e22typeGro', '', 'Type de grossesse', 'type de grossesse', '', '', 'select', '\'A\' : \'unique\'\n\'B\' : \'bichoriale biamniotique\'\n\'C\' : \'monochoriale biamniotique\'\n\'D\' : \'monochoriale monoamniotique\'\n\'E\' : \'bichoriale biamniotique + 1\'\n\'F\' : \'monochoriale biamniotique + 1\'\n\'G\' : \'monochoriale monoamniotique +1\'\n\'H\' : \'trichoriale triamniotique\'', 'user', 51, 1, '2017-04-30 21:10:50', 3600, 1),
(256, 'medical', 'e22membrane', '', 'Membrane', 'aspect de le mebrane', '', '', 'select', '\'D\' : \'\'\n\'A\' : \'signe du lambda\'\n\'B\' : \'fine insérée en T\'\n\'C\' : \'autre\'', 'user', 51, 1, '2017-05-01 21:23:10', 3600, 1),
(257, 'medical', 'conditionsEcho22', 'bonnes, difficiles ...', 'Conditions de réalisation', 'Conditions de l\'examen : bonnes, difficiles ...', '', '', 'select', '\'A\' : \'bonnes\'\n\'B\' : \'limitées par l\\\'échogénicité pariétale\'\n\'C\' : \'limitées par la position foetale\'\n\'D\' : \'limitées par l\\\'échogénicité pariétale et  la position foetale\'\n\'E\' : \'difficiles\'\n\'F\' : \'limitées par la position utérine\'\n\'G\' : \'limitées par la quantité de liquide amniotique\'\n\'H\' : \'limitée par les mouvements fœtaux\'', 'user', 51, 1, '2017-04-30 21:09:28', 3600, 1),
(258, 'medical', 'voieExamEcho22', '', 'Voie d\'examen', 'voie d\'examen pour l\'écho 22', '', '', 'select', '\'A\' : \'abdominale\'\n\'B\' : \'vaginale\'\n\'C\' : \'abdominale et vaginale\'', 'user', 51, 1, '2017-04-06 15:25:46', 3600, 1),
(259, 'medical', 'e22presentationFA', 'présentation foetus A', 'Présentation - A', 'présentation foetus A', '', '', 'select', '\'A\' : \'céphalique\'\n\'B\' : \'céphalique, dos à gauche\'\n\'C\' : \'céphalique, dos à droite\'\n\'D\' : \'céphalique, dos en avant\'\n\'E\' : \'céphalique, dos en arrière\'\n\'F\' : \'siège\'\n\'G\' : \'siège décomplété, dos à gauche\'\n\'H\' : \'siège décomplété, dos à droite\'\n\'I\' : \'siège décomplété, dos en arrière\'\n\'J\' : \'siège décomplété, dos en avant\'\n\'K\' : \'siège complet, dos à gauche\'\n\'L\' : \'siège complet, dos à droite\'\n\'K\' : \'siège complet, dos en arrière\'\n\'L\' : \'siège complet, dos en avant\'\n\'M\' : \'transverse, tête à gauche\'\n\'N\' : \'transverse, tête à droite\'\n\'O\' : \'variable\'', 'user', 51, 1, '2017-04-30 21:14:48', 3600, 1),
(260, 'medical', 'e22actiCardioFA', '', 'Activité cardiaque - A', 'Activité cardique du foetus A', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'irrégulière\'\n\'C\' : \'absente\'', 'user', 51, 1, '2017-04-30 21:17:15', 3600, 1),
(261, 'medical', 'e22rcfFA', '', 'RCF - A', 'rcf foetus A', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:48', 3600, 1),
(262, 'medical', 'e22mafFA', '', 'MAF - A', 'MAF du foetus A', '', '', 'text', 'présents et normaux', 'user', 51, 1, '2017-04-06 15:32:52', 3600, 1),
(263, 'medical', 'e22bipFA', '', 'BIP - A', 'BIP du foetus A', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:01:41', 3600, 1),
(264, 'medical', 'e22pcFA', '', 'PC - A', 'PC du foetus A', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:02', 3600, 1),
(265, 'medical', 'e22paFA', '', 'PA - A', 'PA du foetus A', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:02:39', 3600, 1),
(266, 'medical', 'e22femurA', '', 'Fémur - A', 'longueur fémur', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:02:11', 3600, 1);
INSERT INTO `data_types` (`id`, `groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
(267, 'medical', 'e22poidsFA', '', 'Poids estimé - A', 'Poids estimé du foetus A', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:25', 3600, 1),
(268, 'medical', 'e22morphologieGeneralesFA', '', 'Morphologie générale - A', 'morphologie générale foetus A', '', '', 'textarea', 'Crâne : la boîte crânienne a des contours d’aspect habituel. \nStructures cérébrales : la ligne médiane est en place. Le septum pelllucidum est présent et de forme habituelle. Les ventricules cérébraux sont d\'aspect normal. Le cervelet et la grande citerne sont d\'aspect habituel. \nFace : la lèvre supérieure est bien continue. Le profil a un aspect habituel. \nThorax : les aires pulmonaires sont homogènes. \nCœur : le cœur est en position normale. Les 4 cavités sont équilibrées. Les gros vaisseaux sont normalement posés et d\'aspect habituel. Il n\'y a pas d\'anomalie du rythme cardiaque. \nAbdomen : la paroi antérieure est fermée. L’estomac est en place et d’aspect habituel. Les anses intestinales sont d\'aspect habituel. La vessie est en position habituelle et d\'aspect normal. Les deux reins sont en place, d\'aspect habituel : les cavités pyélocalicielles ne sont pas dilatées. \nRachis : suivi sur toute sa longueur, sans défaut de fermeture décelable. \nMembres : les quatre membres sont vus, avec trois segments.', 'user', 51, 1, '2017-04-30 21:22:58', 3600, 1),
(269, 'medical', 'e22morphoOGEFA', '', 'OGE - A', 'oge du foetus A', '', '', 'select', '\'XX\' : \'XX\'\n\'XY\' : \'XY\'\n\'XXnr\' : \'XX - non révélé\'\n\'XYnr\' : \'XY - non révélé\'\n\'NV\' : \'non visualisable\'\n\'ND\' : \'non définissable\'\n\'blanc\' : \'\'', 'user', 51, 1, '2017-04-30 23:11:33', 3600, 1),
(270, 'medical', 'e22liquideEtcordonFA', '', 'Liquide et cordon - A', 'liquide et cordon foetus A', '', '', 'text', 'Le liquide amniotique est de volume normal pour le terme. Le cordon est constitué de trois vaisseaux.', 'user', 51, 1, '2017-04-13 09:46:17', 3600, 1),
(271, 'medical', 'e22placentaFA', '', 'Placenta - A', 'placenta foetus A', '', '', 'select', '\'f\' : \'fundique\'\n\'anbi\' : \'antérieur non bas inséré\'\n\'abi\' : \'antérieur bas inséré\'\n\'ar\' : \'antérieur recouvrant\'\n\'pnbi\' : \'postérieur non bas inséré\'\n\'pbi\' : \'postérieur bas inséré\'\n\'pr\' : \'postérieur recouvrant\'\n\'ldnbi\' : \'latéral droit non bas inséré\'\n\'ldbi\' : \'latéral droit bas inséré\'\n\'ldr\' : \'latéral droit recouvrant\'\n\'lgnbi\' : \'latéral gauche non bas inséré\'\n\'lgbi\' : \'latéral gauche bas inséré\'\n\'lgr\' : \'latéral gauche recouvrant\'', 'user', 51, 1, '2017-04-30 21:48:14', 3600, 1),
(272, 'medical', 'e22dopOmbiIRFA', '', 'Dop Ombilical IR - A', '', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:47:51', 3600, 1),
(273, 'medical', 'e22dopOmbiFEDiaFA', '', 'Dop Ombilical Flux en Dia. - A', '', '', '', 'select', '\'P\' : \'positif\'\n\'N\' : \'nul\'\n\'RF\' : \'reverse flow\'', 'user', 51, 1, '2017-04-30 21:50:12', 3600, 1),
(274, 'medical', 'e22dopACMIRFA', '', 'Dop ACM IR - A', '', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:49:42', 3600, 1),
(275, 'medical', 'e22dopACMVFA', '', 'Dop ACM Vitesse (cm/s) - A', '', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:50:25', 3600, 1),
(276, 'medical', 'e22dopACMMoMFA', '', 'Dop ACM MoM - A', '', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:50:58', 3600, 1),
(277, 'medical', 'e22dopArantiusIRFA', '', 'Dop Arantius IR - A', '', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:51:51', 3600, 1),
(278, 'medical', 'e22dopArantiusOAFA', '', 'Dop Arantius Onde A - A', '', '', '', 'select', '\'Pos\' : \'positive\'\n\'Neg\' : \'négative\'\n\'Nulle\' : \'nulle\'', 'user', 51, 1, '2017-04-30 21:51:40', 3600, 1),
(279, 'medical', 'e22dopUterDtIR', '', 'Dop Utérin Dt IR', '', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:56:23', 3600, 1),
(280, 'medical', 'e22dopUterGIR', '', 'Dop Utérin G IR', '', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:56:34', 3600, 1),
(281, 'medical', 'e22dopUterDtNotch', '', 'Dop Utérin Dt Notch', '', '', '', 'select', '\'N\' : \'non\'\n\'O\' : \'oui\'\n\'E\' : \'ébauche\'', 'user', 51, 1, '2017-04-30 21:53:04', 3600, 1),
(282, 'medical', 'e22dopUterGNotch', '', 'Dop Utérin G Notch', '', '', '', 'select', '\'N\' : \'non\'\n\'O\' : \'oui\'\n\'E\' : \'ébauche\'', 'user', 51, 1, '2017-04-30 21:53:32', 3600, 1),
(283, 'medical', 'e22colLg', '', 'Col : longueur', 'longueur col', '', '', 'text', '', 'user', 51, 1, '2017-04-06 15:57:57', 3600, 1),
(284, 'medical', 'e22colEntonnoir', '', 'Col : entonnoir', 'col : entonnoir', '', '', 'select', '\'N\' : \'non\'\n\'O\' : \'oui\'', 'user', 51, 1, '2017-04-30 21:54:08', 3600, 1),
(285, 'medical', 'conclusionE22', 'conclusion', 'Conclusion', 'conclusion écho 22', '', '', 'textarea', 'Bonne vitalité fœtale. \nCroissance fœtale satisfaisante pour le terme.\nPas d\'anomalie morphologique décelable ce jour. \nPlacenta normalement inséré, liquide amniotique en quantité normale.', 'user', 51, 1, '2017-04-30 21:55:51', 3600, 1),
(286, 'medical', 'e22actiCardioFB', '', 'Activité cardiaque - B', 'Activité cardique du foetus B', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'irrégulière\'\n\'C\' : \'absente\'', 'user', 51, 1, '2017-04-30 21:17:22', 3600, 1),
(287, 'medical', 'e22bipFB', '', 'BIP - B', 'BIP du foetus B', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:01:49', 3600, 1),
(288, 'medical', 'e22actiCardioFC', '', 'Activité cardiaque - C', 'Activité cardique du foetus C', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'irrégulière\'\n\'C\' : \'absente\'', 'user', 51, 1, '2017-04-30 21:17:28', 3600, 1),
(289, 'medical', 'e22bipFC', '', 'BIP - C', 'BIP du foetus C', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:01:56', 3600, 1),
(290, 'medical', 'e22dopACMIRFB', '', 'Dop ACM IR - B', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:40:49', 3600, 1),
(291, 'medical', 'e22dopACMIRFC', '', 'Dop ACM IR - C', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:41:00', 3600, 1),
(292, 'medical', 'e22dopACMMoMFB', '', 'Dop ACM MoM - B', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:41:13', 3600, 1),
(293, 'medical', 'e22dopACMMoMFC', '', 'Dop ACM MoM - C', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:41:26', 3600, 1),
(294, 'medical', 'e22dopACMVFB', '', 'Dop ACM Vitesse (cm/s) - B', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:41:40', 3600, 1),
(295, 'medical', 'e22dopACMVFC', '', 'Dop ACM Vitesse (cm/s) - C', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:41:52', 3600, 1),
(296, 'medical', 'e22dopArantiusIRFB', '', 'Dop Arantius IR - B', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:42:05', 3600, 1),
(297, 'medical', 'e22dopArantiusIRFC', '', 'Dop Arantius IR - C', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:42:21', 3600, 1),
(298, 'medical', 'e22dopArantiusOAFB', '', 'Dop Arantius Onde A - B', '', '', '', 'select', '\'Pos\' : \'positive\'\n\'Neg\' : \'négative\'\n\'Nulle\' : \'nulle\'', 'user', 51, 1, '2017-04-30 21:51:48', 3600, 1),
(299, 'medical', 'e22dopArantiusOAFC', '', 'Dop Arantius Onde A - C', '', '', '', 'select', '\'Pos\' : \'positive\'\n\'Neg\' : \'négative\'\n\'Nulle\' : \'nulle\'', 'user', 51, 1, '2017-04-30 21:51:56', 3600, 1),
(300, 'medical', 'e22dopOmbiFEDiaFB', '', 'Dop Ombilical Flux en Dia. - B', '', '', '', 'select', '\'P\' : \'positif\'\n\'N\' : \'nul\'\n\'RF\' : \'reverse flow\'', 'user', 51, 1, '2017-04-30 21:50:22', 3600, 1),
(301, 'medical', 'e22dopOmbiFEDiaFC', '', 'Dop Ombilical Flux en Dia. - C', '', '', '', 'select', '\'P\' : \'positif\'\n\'N\' : \'nul\'\n\'RF\' : \'reverse flow\'', 'user', 51, 1, '2017-04-30 21:50:31', 3600, 1),
(302, 'medical', 'e22dopOmbiIRFB', '', 'Dop Ombilical IR - B', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:43:22', 3600, 1),
(303, 'medical', 'e22dopOmbiIRFC', '', 'Dop Ombilical IR - C', '', '', '', 'text', '', 'user', 51, 1, '2017-04-07 11:43:34', 3600, 1),
(304, 'medical', 'e22femurB', '', 'Fémur - B', 'longueur fémur B', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:02:19', 3600, 1),
(305, 'medical', 'e22femurC', '', 'Fémur - C', 'longueur fémur C', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:02:26', 3600, 1),
(306, 'medical', 'e22liquideEtcordonFB', '', 'Liquide et cordon - B', 'liquide et cordon foetus B', '', '', 'text', 'Le liquide amniotique est de volume normal pour le terme. Le cordon est constitué de trois vaisseaux.', 'user', 51, 1, '2017-04-13 09:46:10', 3600, 1),
(307, 'medical', 'e22liquideEtcordonFC', '', 'Liquide et cordon - C', 'liquide et cordon foetus C', '', '', 'text', 'Le liquide amniotique est de volume normal pour le terme. Le cordon est constitué de trois vaisseaux.', 'user', 51, 1, '2017-04-13 09:46:02', 3600, 1),
(308, 'medical', 'e22mafFB', '', 'MAF - B', 'MAF du foetus B', '', '', 'text', 'présents et normaux', 'user', 51, 1, '2017-04-07 11:45:04', 3600, 1),
(309, 'medical', 'e22mafFC', '', 'MAF - C', 'MAF du foetus C', '', '', 'text', 'présents et normaux', 'user', 51, 1, '2017-04-07 11:45:16', 3600, 1),
(310, 'medical', 'e22morphologieGeneralesFB', '', 'Morphologie générale - B', 'morphologie générale foetus B', '', '', 'textarea', 'Crâne : la boîte crânienne a des contours d’aspect habituel. \nStructures cérébrales : la ligne médiane est en place. Le septum pelllucidum est présent et de forme habituelle. Les ventricules cérébraux sont d\'aspect normal. Le cervelet et la grande citerne sont d\'aspect habituel. \nFace : la lèvre supérieure est bien continue. Le profil a un aspect habituel. \nThorax : les aires pulmonaires sont homogènes. \nCœur : le cœur est en position normale. Les 4 cavités sont équilibrées. Les gros vaisseaux sont normalement posés et d\'aspect habituel. Il n\'y a pas d\'anomalie du rythme cardiaque. \nAbdomen : la paroi antérieure est fermée. L’estomac est en place et d’aspect habituel. Les anses intestinales sont d\'aspect habituel. La vessie est en position habituelle et d\'aspect normal. Les deux reins sont en place, d\'aspect habituel : les cavités pyélocalicielles ne sont pas dilatées. \nRachis : suivi sur toute sa longueur, sans défaut de fermeture décelable. \nMembres : les quatre membres sont vus, avec trois segments.', 'user', 51, 1, '2017-04-30 21:22:41', 3600, 1),
(311, 'medical', 'e22morphologieGeneralesFC', '', 'Morphologie générale - C', 'morphologie générale foetus C', '', '', 'textarea', 'Crâne : la boîte crânienne a des contours d’aspect habituel. \nStructures cérébrales : la ligne médiane est en place. Le septum pelllucidum est présent et de forme habituelle. Les ventricules cérébraux sont d\'aspect normal. Le cervelet et la grande citerne sont d\'aspect habituel. \nFace : la lèvre supérieure est bien continue. Le profil a un aspect habituel. \nThorax : les aires pulmonaires sont homogènes. \nCœur : le cœur est en position normale. Les 4 cavités sont équilibrées. Les gros vaisseaux sont normalement posés et d\'aspect habituel. Il n\'y a pas d\'anomalie du rythme cardiaque. \nAbdomen : la paroi antérieure est fermée. L’estomac est en place et d’aspect habituel. Les anses intestinales sont d\'aspect habituel. La vessie est en position habituelle et d\'aspect normal. Les deux reins sont en place, d\'aspect habituel : les cavités pyélocalicielles ne sont pas dilatées. \nRachis : suivi sur toute sa longueur, sans défaut de fermeture décelable. \nMembres : les quatre membres sont vus, avec trois segments.', 'user', 51, 1, '2017-04-30 21:23:16', 3600, 1),
(312, 'medical', 'e22morphoOGEFB', '', 'OGE - B', 'oge du foetus B', '', '', 'select', '\'XX\' : \'XX\'\n\'XY\' : \'XY\'\n\'XXnr\' : \'XX - non révélé\'\n\'XYnr\' : \'XY - non révélé\'\n\'NV\' : \'non visualisable\'\n\'ND\' : \'non définissable\'\n\'blanc\' : \'\'', 'user', 51, 1, '2017-04-30 23:11:43', 3600, 1),
(313, 'medical', 'e22morphoOGEFC', '', 'OGE - C', 'oge du foetus C', '', '', 'select', '\'XX\' : \'XX\'\n\'XY\' : \'XY\'\n\'XXnr\' : \'XX - non révélé\'\n\'XYnr\' : \'XY - non révélé\'\n\'NV\' : \'non visualisable\'\n\'ND\' : \'non définissable\'\n\'blanc\' : \'\'', 'user', 51, 1, '2017-04-30 23:11:53', 3600, 1),
(314, 'medical', 'e22paFB', '', 'PA - B', 'PA du foetus B', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:02:47', 3600, 1),
(315, 'medical', 'e22paFC', '', 'PA - C', 'PA du foetus C', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:02:54', 3600, 1),
(316, 'medical', 'e22pcFB', '', 'PC - B', 'PC du foetus B', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:09', 3600, 1),
(317, 'medical', 'e22pcFC', '', 'PC - C', 'PC du foetus C', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:17', 3600, 1),
(318, 'medical', 'e22placentaFB', '', 'Placenta - B', 'placenta foetus B', '', '', 'select', '\'f\' : \'fundique\'\n\'anbi\' : \'antérieur non bas inséré\'\n\'abi\' : \'antérieur bas inséré\'\n\'ar\' : \'antérieur recouvrant\'\n\'pnbi\' : \'postérieur non bas inséré\'\n\'pbi\' : \'postérieur bas inséré\'\n\'pr\' : \'postérieur recouvrant\'\n\'ldnbi\' : \'latéral droit non bas inséré\'\n\'ldbi\' : \'latéral droit bas inséré\'\n\'ldr\' : \'latéral droit recouvrant\'\n\'lgnbi\' : \'latéral gauche non bas inséré\'\n\'lgbi\' : \'latéral gauche bas inséré\'\n\'lgr\' : \'latéral gauche recouvrant\'', 'user', 51, 1, '2017-04-30 21:48:25', 3600, 1),
(319, 'medical', 'e22placentaFC', '', 'Placenta - C', 'placenta foetus C', '', '', 'select', '\'f\' : \'fundique\'\n\'anbi\' : \'antérieur non bas inséré\'\n\'abi\' : \'antérieur bas inséré\'\n\'ar\' : \'antérieur recouvrant\'\n\'pnbi\' : \'postérieur non bas inséré\'\n\'pbi\' : \'postérieur bas inséré\'\n\'pr\' : \'postérieur recouvrant\'\n\'ldnbi\' : \'latéral droit non bas inséré\'\n\'ldbi\' : \'latéral droit bas inséré\'\n\'ldr\' : \'latéral droit recouvrant\'\n\'lgnbi\' : \'latéral gauche non bas inséré\'\n\'lgbi\' : \'latéral gauche bas inséré\'\n\'lgr\' : \'latéral gauche recouvrant\'', 'user', 51, 1, '2017-04-30 21:48:32', 3600, 1),
(320, 'medical', 'e22poidsFB', '', 'Poids estimé - B', 'Poids estimé du foetus B', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:32', 3600, 1),
(321, 'medical', 'e22poidsFC', '', 'Poids estimé - C', 'Poids estimé du foetus C', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:38', 3600, 1),
(322, 'medical', 'e22presentationFB', 'présentation foetus B', 'Présentation - B', 'présentation foetus B', '', '', 'select', '\'A\' : \'céphalique\'\n\'B\' : \'céphalique, dos à gauche\'\n\'C\' : \'céphalique, dos à droite\'\n\'D\' : \'céphalique, dos en avant\'\n\'E\' : \'céphalique, dos en arrière\'\n\'F\' : \'siège\'\n\'G\' : \'siège décomplété, dos à gauche\'\n\'H\' : \'siège décomplété, dos à droite\'\n\'I\' : \'siège décomplété, dos en arrière\'\n\'J\' : \'siège décomplété, dos en avant\'\n\'K\' : \'siège complet, dos à gauche\'\n\'L\' : \'siège complet, dos à droite\'\n\'K\' : \'siège complet, dos en arrière\'\n\'L\' : \'siège complet, dos en avant\'\n\'M\' : \'transverse, tête à gauche\'\n\'N\' : \'transverse, tête à droite\'\n\'O\' : \'variable\'', 'user', 51, 1, '2017-04-30 21:15:00', 3600, 1),
(323, 'medical', 'e22presentationFC', 'présentation foetus C', 'Présentation - C', 'présentation foetus C', '', '', 'select', '\'A\' : \'céphalique\'\n\'B\' : \'céphalique, dos à gauche\'\n\'C\' : \'céphalique, dos à droite\'\n\'D\' : \'céphalique, dos en avant\'\n\'E\' : \'céphalique, dos en arrière\'\n\'F\' : \'siège\'\n\'G\' : \'siège décomplété, dos à gauche\'\n\'H\' : \'siège décomplété, dos à droite\'\n\'I\' : \'siège décomplété, dos en arrière\'\n\'J\' : \'siège décomplété, dos en avant\'\n\'K\' : \'siège complet, dos à gauche\'\n\'L\' : \'siège complet, dos à droite\'\n\'K\' : \'siège complet, dos en arrière\'\n\'L\' : \'siège complet, dos en avant\'\n\'M\' : \'transverse, tête à gauche\'\n\'N\' : \'transverse, tête à droite\'\n\'O\' : \'variable\'', 'user', 51, 1, '2017-04-30 21:15:08', 3600, 1),
(324, 'medical', 'e22rcfFB', '', 'RCF - B', 'rcf foetus B', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:03:56', 3600, 1),
(325, 'medical', 'e22rcfFC', '', 'RCF - C', 'rcf foetus C', '', '', 'text', '', 'user', 51, 1, '2017-04-27 15:04:02', 3600, 1),
(326, 'medical', 'indicEcho32', '', 'Indication', 'indication de l\'écho de 22', '', '', 'select', '\'A\' : \'dépistage du 3e trimestre\'\n\'B\' : \'complément à un premier examen difficile\'\n\'C\' : \'douleurs pelviennes\'\n\'D\' : \'métrorragies\'\n\'E\' : \'diminution des mouvements actifs fœtaux\'\n\'F\' : \'échographie de seconde intention\'\n\'G\' : \'suivi de grossesse gémellaire\'\n\'H\' : \'surveillance\'', 'user', 52, 1, '2017-05-01 22:12:20', 3600, 1),
(327, 'medical', 'nbFoetusEcho32', '', 'Nombre de foetus', 'nombre de foetus à l\'écho 22', '', '', 'number', '1', 'user', 52, 1, '2017-04-06 15:23:20', 3600, 1),
(328, 'medical', 'e32typeGro', '', 'Type de grossesse', 'type de grossesse', '', '', 'select', '\'A\' : \'unique\'\n\'B\' : \'bichoriale biamniotique\'\n\'C\' : \'monochoriale biamniotique\'\n\'D\' : \'monochoriale monoamniotique\'\n\'E\' : \'bichoriale biamniotique + 1\'\n\'F\' : \'monochoriale biamniotique + 1\'\n\'G\' : \'monochoriale monoamniotique +1\'\n\'H\' : \'trichoriale triamniotique\'', 'user', 52, 1, '2017-05-01 21:26:14', 3600, 1),
(329, 'medical', 'e32membrane', '', 'Membrane', 'aspect de la mebrane', '', '', 'text', '\'D\' : \'\'\n\'A\' : \'signe du lambda\'\n\'B\' : \'fine insérée en T\'\n\'C\' : \'autre\'', 'user', 52, 1, '2017-05-01 21:23:24', 3600, 1),
(330, 'medical', 'conditionsEcho32', 'bonnes, difficiles ...', 'Conditions de réalisation', 'Conditions de l\'examen : bonnes, difficiles ...', '', '', 'select', '\'A\' : \'bonnes\'\n\'B\' : \'limitées par l\\\'échogénicité pariétale\'\n\'C\' : \'limitées par la position foetale\'\n\'D\' : \'limitées par l\\\'échogénicité pariétale et  la position foetale\'\n\'E\' : \'difficiles\'\n\'F\' : \'limitées par la position utérine\'\n\'G\' : \'limitées par la quantité de liquide amniotique\'\n\'H\' : \'limitée par les mouvements fœtaux\'', 'user', 52, 1, '2017-05-01 21:17:54', 3600, 1),
(331, 'medical', 'voieExamEcho32', '', 'Voie d\'examen', 'voie d\'examen pour l\'écho 22', '', '', 'select', '\'A\' : \'abdominale\'\n\'B\' : \'vaginale\'\n\'C\' : \'abdominale et vaginale\'', 'user', 52, 1, '2017-05-01 21:26:28', 3600, 1),
(332, 'medical', 'e32presentationFA', 'présentation foetus A', 'Présentation - A', 'présentation foetus A', '', '', 'select', '\'A\' : \'céphalique\'\n\'B\' : \'céphalique, dos à gauche\'\n\'C\' : \'céphalique, dos à droite\'\n\'D\' : \'céphalique, dos en avant\'\n\'E\' : \'céphalique, dos en arrière\'\n\'F\' : \'siège\'\n\'G\' : \'siège décomplété, dos à gauche\'\n\'H\' : \'siège décomplété, dos à droite\'\n\'I\' : \'siège décomplété, dos en arrière\'\n\'J\' : \'siège décomplété, dos en avant\'\n\'K\' : \'siège complet, dos à gauche\'\n\'L\' : \'siège complet, dos à droite\'\n\'K\' : \'siège complet, dos en arrière\'\n\'L\' : \'siège complet, dos en avant\'\n\'M\' : \'transverse, tête à gauche\'\n\'N\' : \'transverse, tête à droite\'\n\'O\' : \'variable\'', 'user', 52, 1, '2017-05-01 21:25:35', 3600, 1),
(333, 'medical', 'e32actiCardioFA', '', 'Activité cardiaque - A', 'Activité cardique du foetus A', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'irrégulière\'\n\'C\' : \'absente\'', 'user', 52, 1, '2017-05-01 21:16:45', 3600, 1),
(334, 'medical', 'e32rcfFA', '', 'RCF - A', 'rcf foetus A', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:33:07', 3600, 1),
(335, 'medical', 'e32mafFA', '', 'MAF - A', 'MAF du foetus A', '', '', 'text', 'présents et normaux', 'user', 52, 1, '2017-04-06 15:32:52', 3600, 1),
(336, 'medical', 'e32bipFA', '', 'BIP - A', 'BIP du foetus A', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:53:39', 3600, 1),
(337, 'medical', 'e32pcFA', '', 'PC - A', 'PC du foetus A', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:54:57', 3600, 1),
(338, 'medical', 'e32paFA', '', 'PA - A', 'PA du foetus A', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:54:35', 3600, 1),
(339, 'medical', 'e32femurA', '', 'Fémur - A', 'longueur fémur', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:54:09', 3600, 1),
(340, 'medical', 'e32poidsFA', '', 'Poids estimé - A', 'Poids estimé du foetus A', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:55:28', 3600, 1),
(341, 'medical', 'e32morphologieGeneralesFA', '', 'Morphologie générale - A', 'morphologie générale foetus A', '', '', 'textarea', 'Crâne : la boîte crânienne a des contours d’aspect habituel. \nStructures cérébrales : la ligne médiane est en place. Le septum pelllucidum est présent et de forme habituelle. Les ventricules cérébraux sont d\'aspect normal. Le cervelet et la grande citerne sont d\'aspect habituel. \nFace : la lèvre supérieure est bien continue. Le profil a un aspect habituel. \nThorax : les aires pulmonaires sont homogènes. \nCœur : le cœur est en position normale. Les 4 cavités sont équilibrées. Les gros vaisseaux sont normalement posés et d\'aspect habituel. Il n\'y a pas d\'anomalie du rythme cardiaque. \nAbdomen : la paroi antérieure est fermée. L’estomac est en place et d’aspect habituel. Les anses intestinales sont d\'aspect habituel. La vessie est en position habituelle et d\'aspect normal. Les deux reins sont en place, d\'aspect habituel : les cavités pyélocalicielles ne sont pas dilatées. \nRachis : suivi sur toute sa longueur, sans défaut de fermeture décelable. \nMembres : les quatre membres sont vus, avec trois segments.', 'user', 52, 1, '2017-05-01 22:18:31', 3600, 1),
(342, 'medical', 'e32morphoOGEFA', '', 'OGE - A', 'oge du foetus A', '', '', 'select', '\'XX\' : \'XX\'\n\'XY\' : \'XY\'\n\'XXnr\' : \'XX - non révélé\'\n\'XYnr\' : \'XY - non révélé\'\n\'NV\' : \'non visualisable\'\n\'ND\' : \'non définissable\'\n\'blanc\' : \'\'', 'user', 52, 1, '2017-05-01 21:24:08', 3600, 1),
(343, 'medical', 'e32liquideEtcordonFA', '', 'Liquide et cordon - A', 'liquide et cordon foetus A', '', '', 'text', 'Le liquide amniotique est de volume normal pour le terme. Le cordon est constitué de trois vaisseaux.', 'user', 52, 1, '2017-05-01 21:22:09', 3600, 1),
(344, 'medical', 'e32placentaFA', '', 'Placenta - A', 'placenta foetus A', '', '', 'select', '\'f\' : \'fundique\'\n\'anbi\' : \'antérieur non bas inséré\'\n\'abi\' : \'antérieur bas inséré\'\n\'ar\' : \'antérieur recouvrant\'\n\'pnbi\' : \'postérieur non bas inséré\'\n\'pbi\' : \'postérieur bas inséré\'\n\'pr\' : \'postérieur recouvrant\'\n\'ldnbi\' : \'latéral droit non bas inséré\'\n\'ldbi\' : \'latéral droit bas inséré\'\n\'ldr\' : \'latéral droit recouvrant\'\n\'lgnbi\' : \'latéral gauche non bas inséré\'\n\'lgbi\' : \'latéral gauche bas inséré\'\n\'lgr\' : \'latéral gauche recouvrant\'', 'user', 52, 1, '2017-05-01 21:24:55', 3600, 1),
(345, 'medical', 'e32dopOmbiIRFA', '', 'Dop Ombilical IR - A', '', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:47:51', 3600, 1),
(346, 'medical', 'e32dopOmbiFEDiaFA', '', 'Dop Ombilical Flux en Dia. - A', '', '', '', 'select', '\'P\' : \'positif\'\n\'N\' : \'nul\'\n\'RF\' : \'reverse flow\'', 'user', 52, 1, '2017-05-01 21:19:54', 3600, 1),
(347, 'medical', 'e32dopACMIRFA', '', 'Dop ACM IR - A', '', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:49:42', 3600, 1),
(348, 'medical', 'e32dopACMVFA', '', 'Dop ACM Vitesse (cm/s) - A', '', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:50:25', 3600, 1),
(349, 'medical', 'e32dopACMMoMFA', '', 'Dop ACM MoM - A', '', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:50:58', 3600, 1),
(350, 'medical', 'e32dopArantiusIRFA', '', 'Dop Arantius IR - A', '', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:51:51', 3600, 1),
(351, 'medical', 'e32dopArantiusOAFA', '', 'Dop Arantius Onde A - A', '', '', '', 'select', '\'Pos\' : \'positive\'\n\'Neg\' : \'négative\'\n\'Nulle\' : \'nulle\'', 'user', 52, 1, '2017-05-01 21:18:55', 3600, 1),
(352, 'medical', 'e32dopUterDtIR', '', 'Dop Utérin Dt IR', '', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:56:23', 3600, 1),
(353, 'medical', 'e32dopUterGIR', '', 'Dop Utérin G IR', '', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:56:34', 3600, 1),
(354, 'medical', 'e32dopUterDtNotch', '', 'Dop Utérin Dt Notch', '', '', '', 'select', '\'N\' : \'non\'\n\'O\' : \'oui\'\n\'E\' : \'ébauche\'', 'user', 52, 1, '2017-05-01 21:20:42', 3600, 1),
(355, 'medical', 'e32dopUterGNotch', '', 'Dop Utérin G Notch', '', '', '', 'select', '\'N\' : \'non\'\n\'O\' : \'oui\'\n\'E\' : \'ébauche\'', 'user', 52, 1, '2017-05-01 21:20:51', 3600, 1),
(356, 'medical', 'e32colLg', '', 'Col : longueur', 'longueur col', '', '', 'text', '', 'user', 52, 1, '2017-04-06 15:57:57', 3600, 1),
(357, 'medical', 'e32colEntonnoir', '', 'Col : entonnoir', 'col : entonnoir', '', '', 'select', '\'N\' : \'non\'\n\'O\' : \'oui\'', 'user', 52, 1, '2017-05-01 21:17:26', 3600, 1),
(358, 'medical', 'conclusione32', 'conclusion', 'Conclusion', 'conclusion écho 32', '', '', 'textarea', 'Bonne vitalité fœtale. \nPas d’anomalie morphologique décelable ce jour. \nPlacenta normalement inséré, liquide amniotique en quantité normale. \nCroissance fœtale satisfaisante pour le terme.', 'user', 52, 1, '2017-05-01 22:22:52', 3600, 1),
(359, 'medical', 'e32actiCardioFB', '', 'Activité cardiaque - B', 'Activité cardique du foetus B', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'irrégulière\'\n\'C\' : \'absente\'', 'user', 52, 1, '2017-05-01 21:16:52', 3600, 1),
(360, 'medical', 'e32bipFB', '', 'BIP - B', 'BIP du foetus B', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:53:45', 3600, 1),
(361, 'medical', 'e32actiCardioFC', '', 'Activité cardiaque - C', 'Activité cardique du foetus C', '', '', 'select', '\'A\' : \'présente et régulière\'\n\'B\' : \'irrégulière\'\n\'C\' : \'absente\'', 'user', 52, 1, '2017-05-01 21:16:58', 3600, 1),
(362, 'medical', 'e32bipFC', '', 'BIP - C', 'BIP du foetus C', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:53:54', 3600, 1),
(363, 'medical', 'e32dopACMIRFB', '', 'Dop ACM IR - B', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:40:49', 3600, 1),
(364, 'medical', 'e32dopACMIRFC', '', 'Dop ACM IR - C', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:41:00', 3600, 1),
(365, 'medical', 'e32dopACMMoMFB', '', 'Dop ACM MoM - B', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:41:13', 3600, 1),
(366, 'medical', 'e32dopACMMoMFC', '', 'Dop ACM MoM - C', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:41:26', 3600, 1),
(367, 'medical', 'e32dopACMVFB', '', 'Dop ACM Vitesse (cm/s) - B', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:41:40', 3600, 1),
(368, 'medical', 'e32dopACMVFC', '', 'Dop ACM Vitesse (cm/s) - C', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:41:52', 3600, 1),
(369, 'medical', 'e32dopArantiusIRFB', '', 'Dop Arantius IR - B', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:42:05', 3600, 1),
(370, 'medical', 'e32dopArantiusIRFC', '', 'Dop Arantius IR - C', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:42:21', 3600, 1),
(371, 'medical', 'e32dopArantiusOAFB', '', 'Dop Arantius Onde A - B', '', '', '', 'select', '\'Pos\' : \'positive\'\n\'Neg\' : \'négative\'\n\'Nulle\' : \'nulle\'', 'user', 52, 1, '2017-05-01 21:19:04', 3600, 1),
(372, 'medical', 'e32dopArantiusOAFC', '', 'Dop Arantius Onde A - C', '', '', '', 'select', '\'Pos\' : \'positive\'\n\'Neg\' : \'négative\'\n\'Nulle\' : \'nulle\'', 'user', 52, 1, '2017-05-01 21:19:15', 3600, 1),
(373, 'medical', 'e32dopOmbiFEDiaFB', '', 'Dop Ombilical Flux en Dia. - B', '', '', '', 'select', '\'P\' : \'positif\'\n\'N\' : \'nul\'\n\'RF\' : \'reverse flow\'', 'user', 52, 1, '2017-05-01 21:20:03', 3600, 1),
(374, 'medical', 'e32dopOmbiFEDiaFC', '', 'Dop Ombilical Flux en Dia. - C', '', '', '', 'select', '\'P\' : \'positif\'\n\'N\' : \'nul\'\n\'RF\' : \'reverse flow\'', 'user', 52, 1, '2017-05-01 21:20:11', 3600, 1),
(375, 'medical', 'e32dopOmbiIRFB', '', 'Dop Ombilical IR - B', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:43:22', 3600, 1),
(376, 'medical', 'e32dopOmbiIRFC', '', 'Dop Ombilical IR - C', '', '', '', 'text', '', 'user', 52, 1, '2017-04-07 11:43:34', 3600, 1),
(377, 'medical', 'e32femurB', '', 'Fémur - B', 'longueur fémur B', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:54:16', 3600, 1),
(378, 'medical', 'e32femurC', '', 'Fémur - C', 'longueur fémur C', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:54:22', 3600, 1),
(379, 'medical', 'e32liquideEtcordonFB', '', 'Liquide et cordon - B', 'liquide et cordon foetus B', '', '', 'text', 'Le liquide amniotique est de volume normal pour le terme. Le cordon est constitué de trois vaisseaux.', 'user', 52, 1, '2017-05-01 21:22:15', 3600, 1),
(380, 'medical', 'e32liquideEtcordonFC', '', 'Liquide et cordon - C', 'liquide et cordon foetus C', '', '', 'text', 'Le liquide amniotique est de volume normal pour le terme. Le cordon est constitué de trois vaisseaux.', 'user', 52, 1, '2017-05-01 21:22:22', 3600, 1),
(381, 'medical', 'e32mafFB', '', 'MAF - B', 'MAF du foetus B', '', '', 'text', 'présents et normaux', 'user', 52, 1, '2017-04-07 11:45:04', 3600, 1),
(382, 'medical', 'e32mafFC', '', 'MAF - C', 'MAF du foetus C', '', '', 'text', 'présents et normaux', 'user', 52, 1, '2017-04-07 11:45:16', 3600, 1),
(383, 'medical', 'e32morphologieGeneralesFB', '', 'Morphologie générale - B', 'morphologie générale foetus B', '', '', 'textarea', 'Crâne : la boîte crânienne a des contours d’aspect habituel. \nStructures cérébrales : la ligne médiane est en place. Le septum pelllucidum est présent et de forme habituelle. Les ventricules cérébraux sont d\'aspect normal. Le cervelet et la grande citerne sont d\'aspect habituel. \nFace : la lèvre supérieure est bien continue. Le profil a un aspect habituel. \nThorax : les aires pulmonaires sont homogènes. \nCœur : le cœur est en position normale. Les 4 cavités sont équilibrées. Les gros vaisseaux sont normalement posés et d\'aspect habituel. Il n\'y a pas d\'anomalie du rythme cardiaque. \nAbdomen : la paroi antérieure est fermée. L’estomac est en place et d’aspect habituel. Les anses intestinales sont d\'aspect habituel. La vessie est en position habituelle et d\'aspect normal. Les deux reins sont en place, d\'aspect habituel : les cavités pyélocalicielles ne sont pas dilatées. \nRachis : suivi sur toute sa longueur, sans défaut de fermeture décelable. \nMembres : les quatre membres sont vus, avec trois segments.', 'user', 52, 1, '2017-05-01 22:18:39', 3600, 1),
(384, 'medical', 'e32morphologieGeneralesFC', '', 'Morphologie générale - C', 'morphologie générale foetus C', '', '', 'textarea', 'Crâne : la boîte crânienne a des contours d’aspect habituel. \nStructures cérébrales : la ligne médiane est en place. Le septum pelllucidum est présent et de forme habituelle. Les ventricules cérébraux sont d\'aspect normal. Le cervelet et la grande citerne sont d\'aspect habituel. \nFace : la lèvre supérieure est bien continue. Le profil a un aspect habituel. \nThorax : les aires pulmonaires sont homogènes. \nCœur : le cœur est en position normale. Les 4 cavités sont équilibrées. Les gros vaisseaux sont normalement posés et d\'aspect habituel. Il n\'y a pas d\'anomalie du rythme cardiaque. \nAbdomen : la paroi antérieure est fermée. L’estomac est en place et d’aspect habituel. Les anses intestinales sont d\'aspect habituel. La vessie est en position habituelle et d\'aspect normal. Les deux reins sont en place, d\'aspect habituel : les cavités pyélocalicielles ne sont pas dilatées. \nRachis : suivi sur toute sa longueur, sans défaut de fermeture décelable. \nMembres : les quatre membres sont vus, avec trois segments.', 'user', 52, 1, '2017-05-01 22:18:46', 3600, 1),
(385, 'medical', 'e32morphoOGEFB', '', 'OGE - B', 'oge du foetus B', '', '', 'select', '\'XX\' : \'XX\'\n\'XY\' : \'XY\'\n\'XXnr\' : \'XX - non révélé\'\n\'XYnr\' : \'XY - non révélé\'\n\'NV\' : \'non visualisable\'\n\'ND\' : \'non définissable\'\n\'blanc\' : \'\'', 'user', 52, 1, '2017-05-01 21:24:16', 3600, 1),
(386, 'medical', 'e32morphoOGEFC', '', 'OGE - C', 'oge du foetus C', '', '', 'select', '\'XX\' : \'XX\'\n\'XY\' : \'XY\'\n\'XXnr\' : \'XX - non révélé\'\n\'XYnr\' : \'XY - non révélé\'\n\'NV\' : \'non visualisable\'\n\'ND\' : \'non définissable\'\n\'blanc\' : \'\'', 'user', 52, 1, '2017-05-01 21:24:24', 3600, 1),
(387, 'medical', 'e32paFB', '', 'PA - B', 'PA du foetus B', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:54:42', 3600, 1),
(388, 'medical', 'e32paFC', '', 'PA - C', 'PA du foetus C', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:54:49', 3600, 1),
(389, 'medical', 'e32pcFB', '', 'PC - B', 'PC du foetus B', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:55:03', 3600, 1),
(390, 'medical', 'e32pcFC', '', 'PC - C', 'PC du foetus C', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:55:20', 3600, 1),
(391, 'medical', 'e32placentaFB', '', 'Placenta - B', 'placenta foetus B', '', '', 'select', '\'f\' : \'fundique\'\n\'anbi\' : \'antérieur non bas inséré\'\n\'abi\' : \'antérieur bas inséré\'\n\'ar\' : \'antérieur recouvrant\'\n\'pnbi\' : \'postérieur non bas inséré\'\n\'pbi\' : \'postérieur bas inséré\'\n\'pr\' : \'postérieur recouvrant\'\n\'ldnbi\' : \'latéral droit non bas inséré\'\n\'ldbi\' : \'latéral droit bas inséré\'\n\'ldr\' : \'latéral droit recouvrant\'\n\'lgnbi\' : \'latéral gauche non bas inséré\'\n\'lgbi\' : \'latéral gauche bas inséré\'\n\'lgr\' : \'latéral gauche recouvrant\'', 'user', 52, 1, '2017-05-01 21:25:02', 3600, 1),
(392, 'medical', 'e32placentaFC', '', 'Placenta - C', 'placenta foetus C', '', '', 'select', '\'f\' : \'fundique\'\n\'anbi\' : \'antérieur non bas inséré\'\n\'abi\' : \'antérieur bas inséré\'\n\'ar\' : \'antérieur recouvrant\'\n\'pnbi\' : \'postérieur non bas inséré\'\n\'pbi\' : \'postérieur bas inséré\'\n\'pr\' : \'postérieur recouvrant\'\n\'ldnbi\' : \'latéral droit non bas inséré\'\n\'ldbi\' : \'latéral droit bas inséré\'\n\'ldr\' : \'latéral droit recouvrant\'\n\'lgnbi\' : \'latéral gauche non bas inséré\'\n\'lgbi\' : \'latéral gauche bas inséré\'\n\'lgr\' : \'latéral gauche recouvrant\'', 'user', 52, 1, '2017-05-01 21:25:08', 3600, 1),
(393, 'medical', 'e32poidsFB', '', 'Poids estimé - B', 'Poids estimé du foetus B', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:55:36', 3600, 1),
(394, 'medical', 'e32poidsFC', '', 'Poids estimé - C', 'Poids estimé du foetus C', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:55:43', 3600, 1),
(395, 'medical', 'e32presentationFB', 'présentation foetus B', 'Présentation - B', 'présentation foetus B', '', '', 'select', '\'A\' : \'céphalique\'\n\'B\' : \'céphalique, dos à gauche\'\n\'C\' : \'céphalique, dos à droite\'\n\'D\' : \'céphalique, dos en avant\'\n\'E\' : \'céphalique, dos en arrière\'\n\'F\' : \'siège\'\n\'G\' : \'siège décomplété, dos à gauche\'\n\'H\' : \'siège décomplété, dos à droite\'\n\'I\' : \'siège décomplété, dos en arrière\'\n\'J\' : \'siège décomplété, dos en avant\'\n\'K\' : \'siège complet, dos à gauche\'\n\'L\' : \'siège complet, dos à droite\'\n\'K\' : \'siège complet, dos en arrière\'\n\'L\' : \'siège complet, dos en avant\'\n\'M\' : \'transverse, tête à gauche\'\n\'N\' : \'transverse, tête à droite\'\n\'O\' : \'variable\'', 'user', 52, 1, '2017-05-01 21:25:44', 3600, 1),
(396, 'medical', 'e32presentationFC', 'présentation foetus C', 'Présentation - C', 'présentation foetus C', '', '', 'select', '\'A\' : \'céphalique\'\n\'B\' : \'céphalique, dos à gauche\'\n\'C\' : \'céphalique, dos à droite\'\n\'D\' : \'céphalique, dos en avant\'\n\'E\' : \'céphalique, dos en arrière\'\n\'F\' : \'siège\'\n\'G\' : \'siège décomplété, dos à gauche\'\n\'H\' : \'siège décomplété, dos à droite\'\n\'I\' : \'siège décomplété, dos en arrière\'\n\'J\' : \'siège décomplété, dos en avant\'\n\'K\' : \'siège complet, dos à gauche\'\n\'L\' : \'siège complet, dos à droite\'\n\'K\' : \'siège complet, dos en arrière\'\n\'L\' : \'siège complet, dos en avant\'\n\'M\' : \'transverse, tête à gauche\'\n\'N\' : \'transverse, tête à droite\'\n\'O\' : \'variable\'', 'user', 52, 1, '2017-05-01 21:25:51', 3600, 1),
(397, 'medical', 'e32rcfFB', '', 'RCF - B', 'rcf foetus B', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:33:15', 3600, 1),
(398, 'medical', 'e32rcfFC', '', 'RCF - C', 'rcf foetus C', '', '', 'text', '', 'user', 52, 1, '2017-04-27 14:33:24', 3600, 1),
(399, 'medical', 'examenObsDuJour', 'examen obstétrical du jour', 'Examen obstétrical du jour', 'examen obstétrical du jour', '', '', 'textarea', '', 'user', 53, 1, '2017-04-07 16:01:44', 3600, 1),
(400, 'medical', 'eGynContexteGyn', '', 'Contexte gynécologique', 'traitements', '', '', 'select', '\'\' : \'\'\n\'mths\' : \'ménopause sous THS\'\n\'mpths\' : \'ménopause sans THS\'\n\'cs\' : \'cycles spontanés\'\n\'op\' : \'oestroprogestatif\'\n\'micro\' : \'microprogestatif\'\n\'prog\' : \'progestatif\'\n\'diu\' : \'DIU cuivre\'\n\'diuprog\' : \'DIU progestatif\'\n\'pma\' : \'PMA\'', 'user', 54, 1, '2017-05-12 21:08:19', 3600, 1),
(401, 'medical', 'eGynPrescripteur', '', 'Prescripteur', 'prescripteur', '', '', 'text', '', 'user', 54, 1, '2017-04-10 16:48:01', 3600, 1),
(402, 'medical', 'eGynConditions', 'bonnes, difficiles ...', 'Conditions de réalisation', 'Conditions de l\'examen : bonnes, difficiles ...', '', '', 'select', '\'A\' : \'bonnes\'\n\'B\' : \'mauvaise échogénicité\'\n\'C\' : \'limitées par la position utérine\'\n\'D\' : \'mauvaises\'\n\'Z\' : \'\'', 'user', 54, 1, '2017-05-12 21:14:37', 3600, 1),
(403, 'medical', 'eGynVoieExam', '', 'Voie d\'examen', 'voie d\'examen pour l\'écho gyn', '', '', 'select', '\'A\' : \'vaginale\'\n\'B\' : \'abdominale\'\n\'C\' : \'abdominale et vaginale\'', 'user', 54, 1, '2017-05-12 21:15:11', 3600, 1),
(404, 'medical', 'eGyn', '', 'Indication - texte libre', 'indication - texte libre', '', '', 'textarea', '', 'user', 54, 1, '2017-05-12 23:16:27', 3600, 1),
(407, 'medical', 'eGynIndicAnnexes', '', 'Indication - Annexes', '', '', '', 'select', '\'Z\' : \' \'\n\'controlekysov\' : \'contrôle d\\\'un kyste de l\\\'ovaire\'\n\'controlemaselatut\' : \'contrôle d\\\'une masse latéro-utérine\'\n\'controlehydrosal\' : \'contrôle d\\\'un hydrosalpinx\'\n\'suspisopk\' : \'suspicion de SOPK\'', 'user', 54, 1, '2017-05-12 21:29:07', 3600, 1),
(408, 'medical', 'eGynIndicUterus', '', 'Indication - Utérus', '', '', '', 'select', '\'Z\' : \'\'\n\'ameno\' : \'aménorrhée\'\n\'cycleir\' : \'règles irrégulières\'\n\'meno\' : \'ménorragies\'\n\'metro\' : \'métrorragies\' \n\'mentropostmeno\' : \'métrorragies post-ménopausiques\'\n\'dysmeno\' : \'dysménorrhées\'  \n\'uterusmyo\' : \'surveillance d\\\'un utérus myomateux\'\n\'mesureendo\' : \'mesure de l\\\'endomètre\'\n\'vacuitefcs\' : \'contrôle de vacuité utérine après FCS\'\n\'vacuiteivg\' : \'contrôle de vacuité utérine après IVG\'\n\'controlediu\' : \'contrôle d\'un DIU\'', 'user', 54, 1, '2017-05-12 21:29:28', 3600, 1),
(411, 'medical', 'eGynIndicAutres', '', 'Indication - Autres', '', '', '', 'select', '\'Z\' : \'\'\n\'doulpelv\' : \'douleurs pelviennes\'\n\'doulfid\' : \'douleurs FID\'\n\'doulfig\' : \'douleurs FIG\'\n\'dyspareunies\' : \'dyspareunies\' \n\'suspiendomet\' : \'suspicion d\\\'endométriose\'\n\'bilaninfer\' : \'bilan d\\\'infertilité\'\n\'suivipma\' : \'suivi PMA\'', 'user', 54, 1, '2017-05-12 21:33:57', 3600, 1),
(412, 'medical', 'eGynPosiUterus', '', 'Utérus : position', '', '', '', 'select', '\'ante\' : \'antéversée\'\n\'retro\' : \'rétroversée\'\n\'intermed\' : \'intermédiaire\'\n\'absent\' : \'absent\'', 'user', 54, 1, '2017-05-12 21:42:27', 3600, 1),
(413, 'medical', 'eGynUterusLarg', '', 'Utérus : largeur', 'largeur de l\'utérus', '', '', 'text', '', 'user', 54, 1, '2017-04-27 13:43:09', 3600, 1),
(414, 'medical', 'eGynUterusLong', '', 'Utérus : longueur', 'longueur de l\'utérus', '', '', 'text', '', 'user', 54, 1, '2017-04-27 13:43:25', 3600, 1),
(415, 'medical', 'eGynUterusHauteur', '', 'Utérus : hauteur', 'hauteur de l\'utérus', '', '', 'text', '', 'user', 54, 1, '2017-04-27 13:42:58', 3600, 1),
(416, 'medical', 'eGynUterusContours', '', 'Utérus : contours', '', '', '', 'select', '\'reg\' : \'réguliers\'\n\'irreg\' : \'irréguliers\'', 'user', 54, 1, '2017-04-13 12:30:18', 3600, 1),
(417, 'medical', 'eGynUterusStuctureMyo', '', 'Structure myomètre', 'Utérus : structure myomètre', '', '', 'select', '\'homogene\' : \'homogène\'\n\'heterogene\' : \'hétérogène\'\n\'fibro\' : \'fibromateux\'\n\'adenomyose\' : \'adénomyose\'', 'user', 54, 1, '2017-05-12 21:43:43', 3600, 1),
(418, 'medical', 'eGynDopAUDIR', '', 'AUD IR', 'Artère utérine droite IR', '', '', 'text', '', 'user', 54, 1, '2017-04-13 12:38:44', 3600, 1),
(419, 'medical', 'eGynDopAUDIP', '', 'AUD IP', 'Artère utérine droite IP', '', '', 'text', '', 'user', 54, 1, '2017-04-13 12:39:09', 3600, 1),
(420, 'medical', 'eGynDopAUGIP', '', 'AUG IP', 'Artère utérine gauche IP', '', '', 'text', '', 'user', 54, 1, '2017-04-13 12:39:51', 3600, 1),
(421, 'medical', 'eGynDopAUGIR', '', 'AUG IR', 'Artère utérine gauche IR', '', '', 'text', '', 'user', 54, 1, '2017-04-13 12:40:10', 3600, 1),
(422, 'medical', 'eGynEndom', '', 'Endomètre', 'endomètre', '', '', 'textarea', 'vu sur toute sa longueur, fin et régulier.', 'user', 54, 1, '2017-04-13 12:43:13', 3600, 1),
(423, 'medical', 'eGynEndomEpai', '', 'Endomètre : épaisseur', 'épaisseur de l\'endomètre', '', '', 'text', '', 'user', 54, 1, '2017-04-27 14:03:38', 3600, 1),
(424, 'medical', 'eGynCavité', '', 'Cavité', 'cavité', '', '', 'textarea', 'aspect normal', 'user', 54, 1, '2017-05-16 16:43:56', 3600, 1),
(425, 'medical', 'eGynCaviteDIU', '', 'Cavité : DIU', '', '', '', 'select', '\'Z\' : \'\'\n\'diucuivre\' : \'DIU cuivre\'\n\'diupro\' : \'DIU progestatif\'\n\'vacuite\' : \'vacuité utérine\'', 'user', 54, 1, '2017-05-12 21:49:34', 3600, 1),
(426, 'medical', 'eGynDescriptionTrompes', '', 'Description trompes', '', '', '', 'textarea', '', 'user', 54, 1, '2017-05-12 21:59:06', 3600, 1),
(427, 'medical', 'eGynOvaireDroit', '', 'Ovaire droit', '', '', '', 'textarea', 'aspect normal', 'user', 54, 1, '2017-04-13 12:53:14', 3600, 1),
(428, 'medical', 'eGynOvaireGauche', '', 'Ovaire gauche', '', '', '', 'textarea', 'aspect normal', 'user', 54, 1, '2017-04-13 12:53:36', 3600, 1),
(429, 'medical', 'eGynCulsDeSacLat', '', 'Culs de sac latéraux', '', '', '', 'textarea', 'libres', 'user', 54, 1, '2017-04-13 12:54:52', 3600, 1),
(430, 'medical', 'eGynDouglas', '', 'Douglas', '', '', '', 'textarea', 'libre', 'user', 54, 1, '2017-05-12 21:57:21', 3600, 1),
(431, 'medical', 'eGynConclusion', '', 'Conclusion', 'conclusion', '', '', 'textarea', 'Échographie gynécologique dans les limites de la normale', 'user', 54, 1, '2017-05-12 22:00:30', 3600, 1),
(432, 'medical', 'eGynDDR', '', 'DDR', 'date des dernières règles', '', '', 'date', '', 'user', 54, 1, '2017-04-13 13:08:07', 3600, 1),
(433, 'dicom', 'dicomStudyID', '', 'StudyID', '', '', '', 'text', '', 'user', 55, 1, '2017-04-13 14:25:00', 3600, 1),
(434, 'dicom', 'dicomSerieID', '', 'SerieID', '', '', '', 'text', '', 'user', 55, 1, '2017-04-13 16:25:25', 3600, 1),
(435, 'dicom', 'dicomInstanceID', '', 'InstanceID', '', '', '', 'text', '', 'user', 55, 1, '2017-04-13 16:25:49', 3600, 1),
(436, 'user', 'dicomAutoSendPatient2Echo', '', 'dicomAutoSendPatient2Echo', 'Pousser le dossier patient à l\'ouverture dans le serveur DICOM', '', '', 'text', 'false', 'user', 56, 1, '2017-04-25 22:06:41', 3600, 1),
(437, 'medical', 'e22pgcfa', '', 'PGC - A', 'pgc foetus A', '', '', 'text', '', 'user', 51, 1, '2017-04-30 22:01:20', 3600, 1),
(438, 'medical', 'e22pgcfb', '', 'PGC - B', 'pgc foetus B', '', '', 'text', '', 'user', 51, 1, '2017-04-30 22:01:50', 3600, 1),
(439, 'medical', 'e22pgcfc', '', 'PGC - C', 'pgc foetus C', '', '', 'text', '', 'user', 51, 1, '2017-04-30 22:02:05', 3600, 1),
(440, 'medical', 'e32pgcfa', '', 'PGC - A', 'pgc foetus A', '', '', 'text', '', 'user', 52, 1, '2017-05-01 21:10:42', 3600, 1),
(441, 'medical', 'e32pgcfb', '', 'PGC - B', 'pgc foetus B', '', '', 'text', '', 'user', 52, 1, '2017-05-01 21:10:59', 3600, 1),
(442, 'medical', 'e32pgcfc', '', 'PGC - C', 'pgc foetus C', '', '', 'text', '', 'user', 52, 1, '2017-05-01 21:11:15', 3600, 1),
(443, 'admin', 'notesPro', 'notes pros', 'Notes pros', 'Zone de notes pros', '', '', 'textarea', '', 'user', 26, 1, '2017-05-04 10:53:11', 3600, 1),
(444, 'courrier', 'consentementEcho', '', 'Consentement échographie foetale', 'Consentement échographie foetale', '', '', '', 'consentementEcho', 'user', 37, 1, '2017-05-09 17:47:38', 3600, 1),
(445, 'medical', 'e32concluAutomat', '', 'Conclusion complémentaire', 'conclusion complémentaire automatique avec EPF et présentation', '', '', 'textarea', '', 'user', 52, 1, '2017-05-12 22:11:12', 3600, 1),
(446, 'mail', 'modelesMails', '', 'Modèle', 'liste des modèles', '', '', 'select', '', 'user', 39, 1, '2017-05-15 08:14:44', 1576800000, 1),
(447, 'courrier', 'mmFelicitation', '', 'Félicitations', 'modèle mail félicitation naissance', '', '', '', 'Toutes mes félicitations, \n\nJe suis heureuse d\'apprendre la naissance de .................. \nJe vous souhaite beaucoup de bonheur. \n\nJe vous remercie pour la confiance que vous m\'avez accordée au cours de votre grossesse. \n\nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:07:43', 3600, 1),
(448, 'courrier', 'certifProlongationActi', '', 'Certificat prolongation activité pro.', 'certificat prolongation activité pro.', '', '', '', 'certif-prolongationActivite', 'user', 37, 1, '2017-05-15 09:17:14', 3600, 1),
(449, 'courrier', 'certifDemandeIVG', '', 'Certificat demande IVG', 'certificat demande IVG', '', '', '', 'certif-demandeIVG', 'user', 37, 1, '2017-05-15 09:25:34', 3600, 1),
(450, 'courrier', 'certifGrossesse', '', 'Certificat grossesse', 'certificat grossesse', '', '', '', 'certif-grossesse', 'user', 37, 1, '2017-05-15 09:30:28', 3600, 1),
(451, 'courrier', 'modeleCourrierBUD', '', 'BUD', 'modèle de courrier bud', '', '', '', 'courrier-bud', 'user', 38, 1, '2017-05-19 09:19:10', 3600, 1),
(452, 'medical', 'eGynOvaireDtGdAxe', '', 'Ovaire droit : grand axe', '', '', '', 'text', '', 'user', 54, 1, '2017-05-15 15:40:25', 3600, 1),
(453, 'medical', 'eGynOvaireGGdAxe', '', 'Ovaire gauche : grand axe', '', '', '', 'text', '', 'user', 54, 1, '2017-05-15 15:42:36', 3600, 1),
(454, 'courrier', 'mmMammoN', '', 'Mammographie normale', 'modèle mail mammo normale', '', '', '', 'Madame,\n\nJ\'ai bien reçu le compte-rendu de votre mammographie qui est normale.\n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:19:13', 3600, 1),
(461, 'courrier', 'mmConfirmMenop', '', 'Confirmation ménopause', 'modèle mail confirmation ménopause', '', '', '', 'Madame,\n\nJ\'ai bien reçu le résultat de votre bilan biologique qui confirme que vous êtes bien ménopausée.\n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:20:29', 3600, 1),
(455, 'courrier', 'mmFCVA', '', 'FCV A', 'modèle mail FCV A', '', '', '', 'Madame,\n\nVeuillez trouver ci-joint le résultat de votre frottis cervico-vaginal : il est normal mais le laboratoire ne peut en faire qu\'une interprétation limitée. \nIl convient de le refaire, sans aucune urgence, après un traitement par Colposeptine, pour lequel je vous fais parvenir une ordonnance par courrier. \nJe vous laisse reprendre RDV auprès de ma secrétaire.\n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:12:51', 3600, 1),
(456, 'courrier', 'mmRT21', '', 'Résultat dépistage T21', 'modèle mail résultat dépistage T21', '', '', '', 'Madame,\n\nVeuillez trouver ci-joints vos résultats du test de dépistage de trisomie 21 fœtale.\nComme vous le verrez, ces résultats ne vous classent pas dans une population à risque accru.\nCeci est donc très rassurant.\n\nIl est important que vous communiquiez ces résultats au médecin ou à la sage-femme qui suit votre grossesse.\n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:12:06', 3600, 1),
(457, 'courrier', 'mmFCVI', '', 'FCV I', 'modèle mail FCV I', '', '', '', 'Madame,\n\nVeuillez trouver ci-joint le résultat de votre frottis cervico-vaginal, qui est NORMAL. \nIl met simplement en évidence, de façon fortuite, une infection tout à fait banale. \nJe vous envoie, par courrier, une ordonnance pour le traitement.\nIl n\'est pas nécessaire de faire de contrôle de frottis plus tôt que d\'habitude. \n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:14:04', 3600, 1);
INSERT INTO `data_types` (`id`, `groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
(458, 'courrier', 'mmPVV', '', 'Prélèvement vaginal (PVV)', 'modèle mail résultat PVV', '', '', '', 'Madame,\n\nJ\'ai bien reçu le résultat du prélèvement vaginal réalisé en consultation : il retrouve une vaginose, infection banale et bénigne mais qui explique parfaitement l\'odeur des pertes que vous avez constatée.\nJe vous envoie donc une ordonnance par courrier.\nIl est inutile de protéger vos rapports car il ne s\'agit absolument pas d\'une MST.\nIl est inutile de faire un prélèvement de contrôle après traitement.\n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:15:24', 3600, 1),
(459, 'courrier', 'mmPVN', '', 'Prélèvement vaginal (PVN)', 'modèle mail résultat PVN', '', '', '', 'Madame,\n\nJ\'ai bien reçu le résultat du prélèvement vaginal réalisé en consultation : il est NORMAL. \n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:16:01', 3600, 1),
(460, 'courrier', 'mmPostOp', '', 'Post op', 'modèle mail post op', '', '', '', 'Madame,\n\nJ\'ai bien reçu le compte-rendu opératoire du Dr XXXXXX.\nJe suis ravie de voir que tout s\'est bien passé, j\'espère que vous allez être bien soulagée.\nJe vous souhaite maintenant un bon rétablissement.\n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:17:21', 3600, 1),
(462, 'courrier', 'mmCReT3', '', 'Compte-rendu Echo T3', 'modèle mail compte-rendu echo T3', '', '', '', 'Cher Confrère, Chère Consœur,\n\nMerci de m\'avoir adressé votre patiente pour son échographie du troisième trimestre.\n\nL\'examen échographique, dont vous trouverez ci-joint le compte rendu, est sans particularité. \n\nNous vous remercions pour votre confiance et nous restons à votre disposition pour toutes informations complémentaires.\n\nBien cordialement,\nDocteur', 'user', 59, 1, '2017-05-15 21:22:16', 3600, 1),
(463, 'courrier', 'mmCReT2', '', 'Compte-rendu Echo T2', 'modèle mail compte-rendu echo T2', '', '', '', 'Cher Confrère, Chère Consœur,\n\nMerci de m\'avoir adressé votre patiente pour son échographie du deuxième trimestre.\n\nL\'examen échographique, dont vous trouverez ci-joint le compte rendu, est sans particularité. \n\nNous vous remercions pour votre confiance et nous restons à votre disposition pour toutes informations complémentaires.\n\nBien cordialement,\nDocteur', 'user', 59, 1, '2017-05-15 21:22:48', 3600, 1),
(464, 'courrier', 'mmCReT1', '', 'Compte-rendu Echo T1', 'modèle mail compte-rendu echo T1', '', '', '', 'Cher Confrère, Chère Consœur,\n\nMerci de m\'avoir adressé votre patiente pour son échographie du premier trimestre.\n\nL\'examen échographique, dont vous trouverez ci-joint le compte rendu, est sans particularité. \n\nNous vous remercions pour votre confiance et nous restons à votre disposition pour toutes informations complémentaires.\n\nBien cordialement,\nDocteur', 'user', 59, 1, '2017-05-15 21:23:22', 3600, 1),
(465, 'courrier', 'mmBonReta', '', 'Bon rétablissement', 'modèle mail bon rétablissement', '', '', '', 'Madame,\n\nJ\'ai bien reçu le compte-rendu opératoire du Dr .................... Je suis ravie d\'apprendre que l\'intervention s\'est bien déroulée et vous souhaite maintenant un bon rétablissement.\nMeilleures pensées,\n\nBien cordialement,\n\nDr', 'user', 58, 1, '2017-05-15 21:24:56', 3600, 1),
(466, 'courrier', 'mmBioNormale', '', 'Bilan biologique normal', 'modèle mail bilan bio normal', '', '', '', 'Madame,\n\nJ\'ai bien reçu le résultat de votre bilan biologique qui est NORMAL. \n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 21:26:05', 3600, 1),
(467, 'courrier', 'mmFCVN', '', 'FCV normal', 'modèle mail FCV normal', '', '', '', 'Madame,\n\nVeuillez trouver ci-joint le résultat de votre frottis cervico-vaginal, qui est NORMAL.\nIl est important que vous conserviez ces résultats.\n\nEn vous remerciant pour votre confiance, \nBien cordialement,\nDocteur', 'user', 58, 1, '2017-05-15 22:07:18', 3600, 1),
(468, 'medical', 'fmT21NbFoetus', '', 'Nombre de foetus', 'nombre de foetus', '', '', 'number', '1', 'user', 60, 1, '2017-05-16 09:54:32', 3600, 1),
(469, 'medical', 'fmT21AtcdT21', '', 'Antécédent de trisomie 21', 'atcd de T21 lors d\'une grossesse précédente', '', '', 'select', '\' \' : \' \' \n\'o\' : \'oui\'\n\'n\' : \'non\'', 'user', 60, 1, '2017-05-16 09:53:15', 3600, 1),
(470, 'medical', 'fmT21AtcdTubeNeural', '', 'Antécédent de non fermeture du tube neural', 'atcd de non fermeture du tube neural lors d\'une grossesse précédente', '', '', 'select', '\' \' : \' \' \n\'o\' : \'oui\'\n\'n\' : \'non\'', 'user', 60, 1, '2017-05-16 09:54:39', 3600, 1),
(471, 'medical', 'fmT21Fumeuse', '', 'Fumeuse', 'fumeuse', '', '', 'select', '\' \' : \' \' \n\'o\' : \'oui\'\n\'n\' : \'non\'', 'user', 60, 1, '2017-05-16 09:54:49', 3600, 1),
(472, 'medical', 'fmT21nbCig', '', 'Nombre de cigarettes par jour', 'nombre de cigarettes par jour', '', '', 'number', '0', 'user', 60, 1, '2017-05-16 22:32:23', 3600, 1),
(473, 'medical', 'fmT21OrigineGeo', '', 'Origine géographique', 'origine géographique de la patiente', '', '', 'select', '\' \' : \' \' \n\'EA\' : \'Europe / Afrique du nord\'\n\'ASS\' : \'Afrique sub-saharienne\'\n\'As\' : \'Asie\'\n\'M\' : \'Mixte\'', 'user', 60, 1, '2017-05-16 09:57:38', 3600, 1),
(474, 'medical', 'fmT21StrategieDepis', '', 'Stratégie de dépistage', 'stratégie de dépistage choisie', '', '', 'select', '\' \' : \' \' \n\'DC1\' : \'Dépistage combiné au 1er trimestre\'\n\'DS2\' : \'Dépistage séquentiel intégré au 2nd trimestre\'\n\'MS2\' : \'Marqueurs sériques maternels au 2nd trimestre\'', 'user', 60, 1, '2017-05-16 14:53:32', 3600, 1),
(475, 'typecs', 'csMarqueursSerT21', '', 'Marqueurs sériques', 'support parent pour marqueurs sériques', '', '', '', '28', 'user', 50, 1, '2017-05-16 11:23:45', 84600, 1),
(476, 'medical', 'fmT21Did', '', 'Diabète insulino-dépendant', 'DID', '', '', 'select', '\' \' : \' \' \n\'o\' : \'oui\'\n\'n\' : \'non\'', 'user', 60, 1, '2017-05-16 15:15:20', 3600, 1),
(477, 'admin', 'nReseau', '', 'Numéro de réseau', 'numéro de réseau (dépistage)', '', '', 'text', '', 'user', 36, 1, '2017-05-16 22:21:00', 3600, 1),
(478, 'courrier', 'modeleCourrierResumeDossier', '', 'Résumé dossier', 'modèle de courrier pour un résumé du dossier', '', '', '', 'courrier-resumeDossier', 'user', 38, 1, '2017-05-19 09:20:43', 3600, 1);

-- --------------------------------------------------------

--
-- Structure de la table `dicomTags`
--

CREATE TABLE `dicomTags` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `dicomTag` varchar(25) NOT NULL,
  `typeID` mediumint(5) UNSIGNED NOT NULL DEFAULT '0',
  `dicomCodeMeaning` varchar(255) DEFAULT NULL,
  `dicomUnits` varchar(255) DEFAULT NULL,
  `returnValue` enum('min','max','avg') NOT NULL DEFAULT 'avg',
  `roundDecimal` tinyint(1) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `dicomTags`
--

INSERT INTO `dicomTags` (`id`, `dicomTag`, `typeID`, `dicomCodeMeaning`, `dicomUnits`, `returnValue`, `roundDecimal`) VALUES
(1, '11878-6', 0, 'Number of Fetuses', '1', 'avg', 0),
(2, '12145-9', 423, 'Endometrium Thickness', 'mm', 'avg', 1),
(3, '11842-2', 414, 'Uterus Length', 'mm', 'avg', 1),
(4, '11859-6', 415, 'Uterus Height', 'mm', 'avg', 1),
(5, '33192-6', 0, 'Uterus Volume', 'ml', 'avg', 1),
(6, '11865-3', 413, 'Uterus Width', 'mm', 'avg', 1),
(7, '11888-5', 0, 'Composite Ultrasound Age', 'd', 'avg', 0),
(8, '11885-1', 0, 'Gestational Age by LMP', 'd', 'avg', 0),
(9, '11727-5', 0, '', '', 'avg', 1),
(10, '11767-1', 0, '', '', 'avg', 1),
(11, '11947-9', 0, 'HC/AC', '1', 'avg', 1),
(12, '11871-1', 0, 'FL/AC', '%', 'avg', 1),
(13, '11872-9', 0, 'FL/BPD', '%', 'avg', 1),
(14, '11873-7', 0, 'FL/HC', '%', 'avg', 1),
(15, '11979-2', 338, 'Abdominal Circumference', 'mm', 'avg', 1),
(16, '18185-9', 0, 'Gestational Age', 'd', 'avg', 0),
(17, '125012', 0, 'Growth Percentile Rank', 'percentile', 'avg', 1),
(18, '11820-8', 336, 'Biparietal Diameter', 'mm', 'avg', 1),
(19, '11963-6', 339, 'Femur Length', 'mm', 'avg', 1),
(20, '11984-2', 337, 'Head Circumference', 'mm', 'avg', 1),
(21, '12171-5', 0, 'Lateral Ventrical width', 'mm', 'avg', 1),
(22, '11863-8', 0, 'Trans Cerebellar Diameter', 'mm', 'avg', 1),
(23, '11948-7', 334, 'Fetal Heart Rate', '{H.B.}/min', 'avg', 0),
(24, '11862-0', 0, 'Tranverse Abdominal Diameter', 'mm', 'avg', 1),
(25, '33069-6', 76, 'Nuchal Translucency', 'mm', 'max', 2),
(26, '11957-8', 125, 'Crown Rump Length', 'mm', 'avg', 1),
(27, '11820-8', 126, 'Biparietal Diameter', 'mm', 'avg', 1),
(28, '11948-7', 142, 'Fetal Heart Rate', '{H.B.}/min', 'avg', 0),
(29, '11948-7', 72, 'Fetal Heart Rate', '{H.B.}/min', 'avg', 0),
(30, '11957-8', 31, 'Crown Rump Length', 'mm', 'avg', 1),
(31, '11820-8', 74, 'Biparietal Diameter', 'mm', 'avg', 1),
(32, '11979-2', 75, 'Abdominal Circumference', 'mm', 'avg', 1),
(33, '11963-6', 206, 'Femur Length', 'mm', 'avg', 1),
(34, '11948-7', 261, 'Fetal Heart Rate', '{H.B.}/min', 'avg', 0),
(35, '11820-8', 263, 'Biparietal Diameter', 'mm', 'avg', 1),
(36, '11984-2', 264, 'Head Circumference', 'mm', 'avg', 1),
(37, '11979-2', 265, 'Abdominal Circumference', 'mm', 'avg', 1),
(38, '11963-6', 266, 'Femur Length', 'mm', 'avg', 1),
(39, '', 0, '', '', 'avg', 0);

-- --------------------------------------------------------

--
-- Structure de la table `forms`
--

CREATE TABLE `forms` (
  `id` smallint(4) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `description` varchar(250) NOT NULL,
  `dataset` varchar(60) NOT NULL DEFAULT 'data_types',
  `groupe` enum('admin','medical','mail','doc','courrier','ordo','reglement') NOT NULL DEFAULT 'medical',
  `formMethod` enum('post','get') NOT NULL DEFAULT 'post',
  `formAction` varchar(255) DEFAULT '/patient/actions/saveCsForm/',
  `cat` smallint(4) DEFAULT NULL,
  `type` enum('public','private') NOT NULL DEFAULT 'public',
  `yamlStructure` text,
  `yamlStructureDefaut` text,
  `printModel` varchar(25) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `forms`
--

INSERT INTO `forms` (`id`, `name`, `description`, `dataset`, `groupe`, `formMethod`, `formAction`, `cat`, `type`, `yamlStructure`, `yamlStructureDefaut`, `printModel`) VALUES
(1, 'Formulaire nouveau patient', 'formulaire d\'enregistrement d\'un nouveau patient', 'data_types', 'admin', 'post', '/patient/register/', 1, 'public', 'structure:\r\n  row1:                              \r\n    col1:                              \r\n      head: \'Etat civil\'             \r\n      size: 3\r\n      bloc:                          \r\n        - 14                                                 # Sexe\r\n        - 2,required,autocomplete,data-acTypeID=2:1          # Nom d\'usage (requis)\r\n        - 1,autocomplete,data-acTypeID=2:1                   # Nom de jeune fille \r\n        - 3,required,autocomplete,data-acTypeID=3:22:230:235:241    # Prénom (requis)\r\n        - 8	                     # Date de naissance\r\n    col2:\r\n      head: \'Contact\'\r\n      size: 3\r\n      bloc:\r\n        - 4\r\n        - 7\r\n        - 10\r\n    col3:\r\n      head: \'Adresse personnelle\'\r\n      size: 3\r\n      bloc: \r\n        - 9\r\n        - 11,autocomplete,data-acTypeID=11:55\r\n        - 13\r\n        - 12,autocomplete,data-acTypeID=12:56\r\n  row2:\r\n    col1:\r\n      size: 9\r\n      bloc:\r\n        - 21,rows=5', 'structure:\r\n  row1:                              \r\n    col1:                              \r\n      head: \'Etat civil\'             \r\n      size: 3\r\n      bloc:                          \r\n        - 14                                                 # Sexe\r\n        - 2,required,autocomplete,data-acTypeID=2:1          # Nom d\'usage (requis)\r\n        - 1,autocomplete,data-acTypeID=2:1                   # Nom de jeune fille \r\n        - 3,required,autocomplete,data-acTypeID=3:22:230:235:241    # Prénom (requis)\r\n        - 8	                     # Date de naissance\r\n    col2:\r\n      head: \'Contact\'\r\n      size: 3\r\n      bloc:\r\n        - 4\r\n        - 7\r\n        - 10\r\n    col3:\r\n      head: \'Adresse personnelle\'\r\n      size: 3\r\n      bloc: \r\n        - 9\r\n        - 11,autocomplete,data-acTypeID=11:55\r\n        - 13\r\n        - 12,autocomplete,data-acTypeID=12:56\r\n  row2:\r\n    col1:\r\n      size: 9\r\n      bloc:\r\n        - 21,rows=5', ''),
(2, 'Listing des patients', 'description des colonnes affichées en résultat d\'une recherche patient', 'data_types', 'admin', 'post', '', 2, 'public', 'col1:\r\n    head: "Identité"\r\n    blocseparator: " "\r\n    bloc:\r\n        - 2,text-uppercase,gras\r\n        - 3,text-capitalize,gras\r\ncol2:\r\n    head: "Nom de jeune fille"\r\n    blocseparator: " "\r\n    bloc:\r\n        - 1,text-uppercase,gras \r\ncol3:\r\n    head: "Date de naissance" \r\n    bloc: \r\n        - 8\r\ncol4:\r\n    head: "Tel" \r\n    blocseparator: " - "\r\n    bloc: \r\n        - 7\r\n        - 10\r\ncol5:\r\n    head: "Email"\r\n    bloc:\r\n        - 4\r\ncol6:\r\n    head: "Ville"\r\n    bloc:\r\n        - 12,text-uppercase', 'col1:\r\n    head: "Identité"\r\n    blocseparator: " "\r\n    bloc:\r\n        - 2,text-uppercase,gras\r\n        - 3,text-capitalize,gras\r\ncol2:\r\n    head: "Nom de jeune fille"\r\n    blocseparator: " "\r\n    bloc:\r\n        - 1,text-uppercase,gras \r\ncol3:\r\n    head: "Date de naissance" \r\n    bloc: \r\n        - 8\r\ncol4:\r\n    head: "Tel" \r\n    blocseparator: " - "\r\n    bloc: \r\n        - 7\r\n        - 10\r\ncol5:\r\n    head: "Email"\r\n    bloc:\r\n        - 4\r\ncol6:\r\n    head: "Ville"\r\n    bloc:\r\n        - 12,text-uppercase', ''),
(3, 'Login', 'formulaire login utilisateur', 'form_basic_types', 'admin', 'post', '/login/logInDo/', 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    head: "Identification utilisateur"\r\n    size: 3\r\n    bloc: \r\n      - 1,required\r\n      - 2,required\r\n      - 3', 'structure:\r\n row1:\r\n  col1: \r\n    head: "Identification utilisateur"\r\n    size: 3\r\n    bloc: \r\n      - 1,required\r\n      - 2,required\r\n      - 3', ''),
(4, 'Formulaire latéral écran patient principal (atcd)', 'formulaire en colonne latéral du dossier patient (atcd)', 'data_types', 'medical', 'post', '', 4, 'public', 'structure:\r\n  row1:                              # 1re rangée\r\n    col1:                            # 1re colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 34                         # Poids\r\n    col2:                            # 2e colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 35                         # Taille\r\n    col3:                            # 3e colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 43,readonly                # IMC\r\n  row2:                              # 2e rangée\r\n    col1:                            # 1re colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 37                         # Poids\r\n    col2:                            # 2e colonne  \r\n      size: 4\r\n      bloc:                          \r\n        - 36     \r\n    col3:                            # 3e colonne  \r\n      size: 4\r\n      bloc:                          \r\n        - 246                     \r\n  row3:                              # 2e rangée\r\n    col1:                            # 1re colonne  \r\n      size: 12\r\n      bloc:                          # Types utilisés\r\n        - 19                         # activités pro\r\n        - 66,rows=2                  # Allergies\r\n        - 42                         # Tox\r\n  row4:                              # 3e rangée\r\n    col1:                            # 1re colonne  \r\n      size: 12\r\n      bloc:                          # Types utilisés\r\n        - 40,rows=6                 # ATCD obs\r\n        - 39,rows=6                 # ATCD gyn\r\n        - 41,rows=6                 # ATCD gyn\r\n        - 38,rows=6                 # ATCD fam', 'structure:\r\n  row1:                              # 1re rangée\r\n    col1:                            # 1re colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 34                         # Poids\r\n    col2:                            # 2e colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 35                         # Taille\r\n    col3:                            # 3e colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 43,readonly                # IMC\r\n  row2:                              # 2e rangée\r\n    col1:                            # 1re colonne  \r\n      size: 4\r\n      bloc:                          # Types utilisés\r\n        - 37                         # Poids\r\n    col2:                            # 2e colonne  \r\n      size: 4\r\n      bloc:                          \r\n        - 36     \r\n    col3:                            # 3e colonne  \r\n      size: 4\r\n      bloc:                          \r\n        - 246                     \r\n  row3:                              # 2e rangée\r\n    col1:                            # 1re colonne  \r\n      size: 12\r\n      bloc:                          # Types utilisés\r\n        - 19                         # activités pro\r\n        - 66,rows=2                  # Allergies\r\n        - 42                         # Tox\r\n  row4:                              # 3e rangée\r\n    col1:                            # 1re colonne  \r\n      size: 12\r\n      bloc:                          # Types utilisés\r\n        - 40,rows=6                 # ATCD obs\r\n        - 39,rows=6                 # ATCD gyn\r\n        - 41,rows=6                 # ATCD gyn\r\n        - 38,rows=6                 # ATCD fam', ''),
(5, 'Synthèse patiente', 'formulaire fixe de synthèse gynécologique', 'data_types', 'medical', 'post', '', 4, 'public', 'structure:\r\n  row1:                              \r\n    col1:                             \r\n      size: 12\r\n      bloc:                          \r\n        - 44,rows=8                # Synthèse patiente', 'structure:\r\n  row1:                              \r\n    col1:                             \r\n      size: 12\r\n      bloc:                          \r\n        - 44,rows=8                # Synthèse patiente', ''),
(6, 'Synthèse grossesse en cours', 'formulaire fixe sur les données de la grossesse en cours', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'structure:\r\n  row1:                              \r\n    col1:                             \r\n      size: 3\r\n      bloc:                          \r\n        - 45                         # DDR\r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 48,readonly                # DDG théorique\r\n    col3:\r\n      size: 3\r\n      bloc: \r\n        - 49                         # DDG retenue\r\n    col4:\r\n      size: 3\r\n      bloc: \r\n        - 50,readonly                # terme du jour\r\n  row2:\r\n    col1:\r\n      size: 12\r\n      bloc:\r\n        - 47,rows=5                  # synthèse grossesse en cours', 'structure:\r\n  row1:                              \r\n    col1:                             \r\n      size: 3\r\n      bloc:                          \r\n        - 45                         # DDR\r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 48,readonly                # DDG théorique\r\n    col3:\r\n      size: 3\r\n      bloc: \r\n        - 49                         # DDG retenue\r\n    col4:\r\n      size: 3\r\n      bloc: \r\n        - 50,readonly                # terme du jour\r\n  row2:\r\n    col1:\r\n      size: 12\r\n      bloc:\r\n        - 47,rows=5                  # synthèse grossesse en cours', 'csNouvelleGrossesse'),
(7, 'Formulaire nouveau pro', 'formulaire d\'enregistrement d\'un nouveau pro', 'data_types', 'admin', 'post', '/pro/register/', 1, 'public', 'structure:\r\n  row1:                              \r\n    col1:                            \r\n      head: \'Etat civil\'            \r\n      size: 3\r\n      bloc:                          \r\n        - 14                         # Sexe\r\n        - 19,autocomplete            # Profession\r\n        - 51,autocomplete            # titre\r\n        - 2,required,autocomplete,data-acTypeID=2:1    # Nom d\'usage (requis)\r\n        - 3,autocomplete,data-acTypeID=3:22:230:235:241    # Prénom (requis)\r\n    col2:\r\n      head: \'Contact\'\r\n      size: 3\r\n      bloc:\r\n        - 59              # email apicrypt\r\n        - 5              # email pro\r\n        - 4              # email perso\r\n        - 57             # tel pro \r\n        - 248            # tel pro 2\r\n        - 247            # mobile pro \r\n        - 58             # fax pro \r\n    col3:\r\n      head: \'Adresse professionnelle\'\r\n      size: 3\r\n      bloc: \r\n        - 54\r\n        - 55,autocomplete,data-acTypeID=11:55\r\n        - 53\r\n        - 56,autocomplete,data-acTypeID=12:56\r\n        - 249,autocomplete\r\n        - 250,autocomplete\r\n  row2:\r\n    col1:\r\n      size: 9\r\n      bloc:\r\n        - 443,rows=5\r\n\r\n  row3:\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 103         # RPPS\r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 104         # ADELI       \r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 477         # N° réseau', 'structure:\r\n  row1:                              \r\n    col1:                            \r\n      head: \'Etat civil\'            \r\n      size: 3\r\n      bloc:                          \r\n        - 14                         # Sexe\r\n        - 19,autocomplete            # Profession\r\n        - 51,autocomplete            # titre\r\n        - 2,required,autocomplete,data-acTypeID=2:1    # Nom d\'usage (requis)\r\n        - 3,autocomplete,data-acTypeID=3:22:230:235:241    # Prénom (requis)\r\n    col2:\r\n      head: \'Contact\'\r\n      size: 3\r\n      bloc:\r\n        - 59              # email apicrypt\r\n        - 5              # email pro\r\n        - 4              # email perso\r\n        - 57             # tel pro \r\n        - 248            # tel pro 2\r\n        - 247            # mobile pro \r\n        - 58             # fax pro \r\n    col3:\r\n      head: \'Adresse professionnelle\'\r\n      size: 3\r\n      bloc: \r\n        - 54\r\n        - 55,autocomplete,data-acTypeID=11:55\r\n        - 53\r\n        - 56,autocomplete,data-acTypeID=12:56\r\n        - 249,autocomplete\r\n        - 250,autocomplete\r\n  row2:\r\n    col1:\r\n      size: 9\r\n      bloc:\r\n        - 443,rows=5\r\n\r\n  row3:\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 103         # RPPS\r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 104         # ADELI       \r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 477         # N° réseau', ''),
(8, 'Listing des praticiens', 'description des colonnes affichées en résultat d\'une recherche praticien', 'data_types', 'admin', 'post', '', 2, 'public', 'col1:\r\n    head: "Identité"\r\n    blocseparator: " "\r\n    bloc:\r\n        - 51,gras\r\n        - 2,text-uppercase,gras\r\n        - 3,text-capitalize,gras\r\ncol2:\r\n    head: "Activité pro" \r\n    bloc: \r\n        - 19\r\ncol3:\r\n    head: "Tel" \r\n    bloc: \r\n        - 57\r\ncol4:\r\n    head: "Fax" \r\n    bloc: \r\n        - 58\r\ncol5:\r\n    head: "Email"\r\n    bloc-separator: " - "\r\n    bloc:\r\n        - 59\r\n        - 4\r\ncol6:\r\n    head: "Ville"\r\n    bloc:\r\n        - 56,text-uppercase', 'col1:\r\n    head: "Identité"\r\n    blocseparator: " "\r\n    bloc:\r\n        - 51,gras\r\n        - 2,text-uppercase,gras\r\n        - 3,text-capitalize,gras\r\ncol2:\r\n    head: "Activité pro" \r\n    bloc: \r\n        - 19\r\ncol3:\r\n    head: "Tel" \r\n    bloc: \r\n        - 57\r\ncol4:\r\n    head: "Fax" \r\n    bloc: \r\n        - 58\r\ncol5:\r\n    head: "Email"\r\n    bloc-separator: " - "\r\n    bloc:\r\n        - 59\r\n        - 4\r\ncol6:\r\n    head: "Ville"\r\n    bloc:\r\n        - 56,text-uppercase', ''),
(9, 'Formulaire Echo 12', 'formulaire écho 12', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie 1er trimestre\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 67                         # indication\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 68                         # voie\r\n    col3:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 69                         # conditions\r\n row2:                             \r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 70,min=1,max=3,step=1      # nb de foetus\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 209                        # type de grossesse\r\n    col3:                            \r\n      size: 4\r\n      bloc:                          \r\n        - 210                        # membrane  \r\n\r\n####### FOETUS A ######\r\n row3:                               # Foetus A\r\n    class: \'foetusA\'\r\n    head: \'Foetus A\'    \r\n    col1:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 71                         # activité cardiaque\r\n        - 74,plus={mm}               # bip\r\n        - 206,plus={mm}              # fémur\r\n    col2:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 72,plus={bpm}              # rcf\r\n        - 75,plus={mm}               # périmètre abdo\r\n    col3:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 73                         # maf\r\n        - 76,plus={mm}               # clarté nuque\r\n    col4:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 31,plus={mm}               # lcc \r\n        - 113,readonly               # terme & ddg calculés\r\n row4: \r\n   class: \'foetusA\'                              \r\n   col1:                                \r\n      size: 4\r\n      bloc: \r\n        - 77,rows=4                  # morpho céphalique\r\n   col2:                               \r\n      size: 4\r\n      bloc:                          \r\n        - 78,rows=4                  # morpho abdo\r\n   col3:                                \r\n      size: 4\r\n      bloc:                          \r\n        - 79,rows=4                  # morpho membres\r\n row5:\r\n    class: \'foetusA\'\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 211                        # liquide\r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 215                        # tropho : localisation\r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 214                        # tropho aspect \r\n    col4:\r\n      size: 3\r\n      bloc:\r\n        - 220                        # décollement\r\n\r\n  \r\n####### FOETUS B ######\r\n row6:                               # Foetus B\r\n    class: \'foetusB\'\r\n    head: \'Foetus B\'  \r\n    col1:                                 \r\n      size: 3\r\n      bloc:                          \r\n        - 80,disabled                 # activité cardiaque\r\n        - 83,disabled,plus={mm}       # bip\r\n        - 207,disabled,plus={mm}      # fémur\r\n    col2:                                \r\n      size: 3\r\n      bloc:                           \r\n        - 81,disabled,plus={bpm}       # rcf\r\n        - 84,disabled,plus={mm}        # pa\r\n   col3:                                  \r\n      size: 3\r\n      bloc:                          \r\n        - 82,disabled                 # maf\r\n        - 85,disabled,plus={mm}       # clarté nucque\r\n   col4:                                  \r\n      size: 3\r\n      bloc:                          \r\n        - 89,disabled,plus={mm}       # lcc\r\n        - 114,disabled,readonly       # terme et DDG calculés \r\n row7:   \r\n   class: \'foetusB\'                            \r\n   col1:                                \r\n      size: 4\r\n      bloc: \r\n        - 86,rows=4,disabled          # morpha cepha              \r\n   col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 87,rows=4,disabled          # morpha abdo\r\n   col3:                                \r\n      size: 4\r\n      bloc:                          \r\n        - 88,rows=4,disabled          # morpha membres\r\n row8:\r\n    class: \'foetusB\'\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 212,disabled                # liquide \r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 216,disabled                # tropho localisation\r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 218,disabled                # tropho aspect  \r\n    col4:\r\n      size: 3\r\n      bloc:\r\n        - 221,disabled                # décollement   \r\n\r\n\r\n####### FOETUS C ######\r\n row9:                                # Foetus C\r\n   class: \'foetusC\'\r\n   head: \'Foetus C\'   \r\n   col1:                                \r\n      size: 3\r\n      bloc:                          \r\n        - 90,disabled                 # activité cardiaque\r\n        - 93,disabled,plus={mm}       # bip\r\n        - 208,disabled,plus={mm}      # fémur\r\n   col2:                                \r\n      size: 3\r\n      bloc:                          \r\n        - 91,disabled,plus={bpm}      # rcf\r\n        - 94,disabled,plus={mm}       # pa\r\n   col3:                               \r\n      size: 3\r\n      bloc:                          \r\n        - 92,disabled                 # maf\r\n        - 95,disabled,plus={mm}       # nucque\r\n   col4:                                \r\n      size: 3\r\n      bloc:                          \r\n        - 99,disabled,plus={mm}       # lcc\r\n        - 115,disabled,readonly       # terme et DDG calculés\r\n row10:                                \r\n   class: \'foetusC\'\r\n   col1:                                \r\n      size: 4\r\n      bloc: \r\n        - 96,rows=4,disabled                   \r\n   col2:                               \r\n      size: 4\r\n      bloc:                          \r\n        - 97,rows=4,disabled\r\n   col3:                                \r\n      size: 4\r\n      bloc:                          \r\n        - 98,rows=4,disabled\r\n row11:\r\n    class: \'foetusC\'\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 213,disabled \r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 217,disabled\r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 219,disabled \r\n    col4:\r\n      size: 3\r\n      bloc:\r\n        - 222,disabled   \r\n### CONCLUSION ####\r\n row12:                                \r\n   head: \'Conclusion\'\r\n   col1:                               \r\n      size: 12\r\n      bloc: \r\n        - 100,rows=4', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie 1er trimestre\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 67                         # indication\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 68                         # voie\r\n    col3:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 69                         # conditions\r\n row2:                             \r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 70,min=1,max=3,step=1      # nb de foetus\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 209                        # type de grossesse\r\n    col3:                            \r\n      size: 4\r\n      bloc:                          \r\n        - 210                        # membrane  \r\n\r\n####### FOETUS A ######\r\n row3:                               # Foetus A\r\n    class: \'foetusA\'\r\n    head: \'Foetus A\'    \r\n    col1:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 71                         # activité cardiaque\r\n        - 74,plus={mm}               # bip\r\n        - 206,plus={mm}              # fémur\r\n    col2:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 72,plus={bpm}              # rcf\r\n        - 75,plus={mm}               # périmètre abdo\r\n    col3:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 73                         # maf\r\n        - 76,plus={mm}               # clarté nuque\r\n    col4:                              \r\n      size: 3\r\n      bloc:                          \r\n        - 31,plus={mm}               # lcc \r\n        - 113,readonly               # terme & ddg calculés\r\n row4: \r\n   class: \'foetusA\'                              \r\n   col1:                                \r\n      size: 4\r\n      bloc: \r\n        - 77,rows=4                  # morpho céphalique\r\n   col2:                               \r\n      size: 4\r\n      bloc:                          \r\n        - 78,rows=4                  # morpho abdo\r\n   col3:                                \r\n      size: 4\r\n      bloc:                          \r\n        - 79,rows=4                  # morpho membres\r\n row5:\r\n    class: \'foetusA\'\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 211                        # liquide\r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 215                        # tropho : localisation\r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 214                        # tropho aspect \r\n    col4:\r\n      size: 3\r\n      bloc:\r\n        - 220                        # décollement\r\n\r\n  \r\n####### FOETUS B ######\r\n row6:                               # Foetus B\r\n    class: \'foetusB\'\r\n    head: \'Foetus B\'  \r\n    col1:                                 \r\n      size: 3\r\n      bloc:                          \r\n        - 80,disabled                 # activité cardiaque\r\n        - 83,disabled,plus={mm}       # bip\r\n        - 207,disabled,plus={mm}      # fémur\r\n    col2:                                \r\n      size: 3\r\n      bloc:                           \r\n        - 81,disabled,plus={bpm}       # rcf\r\n        - 84,disabled,plus={mm}        # pa\r\n   col3:                                  \r\n      size: 3\r\n      bloc:                          \r\n        - 82,disabled                 # maf\r\n        - 85,disabled,plus={mm}       # clarté nucque\r\n   col4:                                  \r\n      size: 3\r\n      bloc:                          \r\n        - 89,disabled,plus={mm}       # lcc\r\n        - 114,disabled,readonly       # terme et DDG calculés \r\n row7:   \r\n   class: \'foetusB\'                            \r\n   col1:                                \r\n      size: 4\r\n      bloc: \r\n        - 86,rows=4,disabled          # morpha cepha              \r\n   col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 87,rows=4,disabled          # morpha abdo\r\n   col3:                                \r\n      size: 4\r\n      bloc:                          \r\n        - 88,rows=4,disabled          # morpha membres\r\n row8:\r\n    class: \'foetusB\'\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 212,disabled                # liquide \r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 216,disabled                # tropho localisation\r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 218,disabled                # tropho aspect  \r\n    col4:\r\n      size: 3\r\n      bloc:\r\n        - 221,disabled                # décollement   \r\n\r\n\r\n####### FOETUS C ######\r\n row9:                                # Foetus C\r\n   class: \'foetusC\'\r\n   head: \'Foetus C\'   \r\n   col1:                                \r\n      size: 3\r\n      bloc:                          \r\n        - 90,disabled                 # activité cardiaque\r\n        - 93,disabled,plus={mm}       # bip\r\n        - 208,disabled,plus={mm}      # fémur\r\n   col2:                                \r\n      size: 3\r\n      bloc:                          \r\n        - 91,disabled,plus={bpm}      # rcf\r\n        - 94,disabled,plus={mm}       # pa\r\n   col3:                               \r\n      size: 3\r\n      bloc:                          \r\n        - 92,disabled                 # maf\r\n        - 95,disabled,plus={mm}       # nucque\r\n   col4:                                \r\n      size: 3\r\n      bloc:                          \r\n        - 99,disabled,plus={mm}       # lcc\r\n        - 115,disabled,readonly       # terme et DDG calculés\r\n row10:                                \r\n   class: \'foetusC\'\r\n   col1:                                \r\n      size: 4\r\n      bloc: \r\n        - 96,rows=4,disabled                   \r\n   col2:                               \r\n      size: 4\r\n      bloc:                          \r\n        - 97,rows=4,disabled\r\n   col3:                                \r\n      size: 4\r\n      bloc:                          \r\n        - 98,rows=4,disabled\r\n row11:\r\n    class: \'foetusC\'\r\n    col1:\r\n      size: 3\r\n      bloc:\r\n        - 213,disabled \r\n    col2:\r\n      size: 3\r\n      bloc:\r\n        - 217,disabled\r\n    col3:\r\n      size: 3\r\n      bloc:\r\n        - 219,disabled \r\n    col4:\r\n      size: 3\r\n      bloc:\r\n        - 222,disabled   \r\n### CONCLUSION ####\r\n row12:                                \r\n   head: \'Conclusion\'\r\n   col1:                               \r\n      size: 12\r\n      bloc: \r\n        - 100,rows=4', 'csEcho12'),
(10, 'Formulaire Cs gynéco', 'formulaire basique de consultation gynéco', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Consultation gynécologique\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 101,rows=10                 # observation texte libre', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Consultation gynécologique\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 101,rows=10                 # observation texte libre', 'csGyneco'),
(11, 'Formulaire mail', 'formulaire pour mail', 'data_types', 'mail', 'post', '/patient/actions/sendMail/', 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 109,required\r\n  col2: \r\n    size: 6\r\n    bloc: \r\n      - 110,required\r\n row2:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 112,required\r\n row3:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 446\r\n row4:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 111,rows=10', 'structure:\r\n row1:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 109,required\r\n  col2: \r\n    size: 6\r\n    bloc: \r\n      - 110,required\r\n row2:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 112,required\r\n row3:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 446\r\n row4:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 111,rows=10', ''),
(12, 'Formulaire Echo inf. à 11', 'formulaire écho 11SA et inférieure', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie < 11 SA\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 130                         # indication\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 133                         # voie examen                         \r\n    col3:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 132                         # conditions de réalisation                        \r\n row2:                              \r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 131,min=1,max=3,step=1     # nb embryon\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 171,disabled               # type grossesse\r\n    col3:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 172,disabled               # membrane \r\n\r\n####### FOETUS A ######\r\n row3:                               # Foetus A\r\n    class: \'foetusA\'\r\n    head: \'Embryon A\'    \r\n    col1:                              \r\n      head: \'Embryon\'\r\n      size: 6\r\n      bloc:                          \r\n       - 173                        # visibilité\r\n       - 125,plus={mm}              # lcc\r\n       - 202,readonly               # terme et DDG calculés\r\n       - 126,plus={mm}              # bip\r\n       - 127                        # activité cardiaque\r\n       - 142,plus={bpm}             # rcf\r\n       - 128,rows=2                 # morpho céphalique\r\n       - 129,rows=2                 # morpho membre\r\n    col2:                              \r\n      head: \'Sac gestationnel\'\r\n      size: 6\r\n      bloc:                          \r\n       - 117                        # sac gest : localisation\r\n       - 118                        # sac gest : tonicité\r\n       - 119                        # sac gest : tropho\r\n       - 123,plus={mm}              # sac gest : diamètre\r\n       - 124                        # sac gest : décollement \r\n\r\n\r\n####### FOETUS B ######\r\n row4:                               # Foetus B\r\n    class: \'foetusB\'\r\n    head: \'Embryon B\'    \r\n    col1:                              \r\n      head: \'Embryon\'\r\n      size: 6\r\n      bloc:                          \r\n       - 174,disabled\r\n       - 151,disabled,plus={mm}\r\n       - 203,disabled,readonly\r\n       - 152,disabled,plus={mm}\r\n       - 153,disabled\r\n       - 156,disabled,plus={bpm}\r\n       - 154,rows=2,disabled\r\n       - 155,rows=2,disabled \r\n   col2:                              \r\n      head: \'Sac gestationnel\'\r\n      size: 6\r\n      bloc:                          \r\n       - 143,disabled\r\n       - 144,disabled\r\n       - 145,disabled\r\n       - 149,disabled,plus={mm}\r\n       - 150,disabled\r\n\r\n####### FOETUS C ######\r\n row5:                               # Foetus C\r\n    class: \'foetusC\'\r\n    head: \'Embryon C\'    \r\n    col1:                              \r\n      head: \'Embryon\'\r\n      size: 6\r\n      bloc:                          \r\n       - 175,disabled\r\n       - 165,disabled,plus={mm}\r\n       - 204,disabled,readonly\r\n       - 166,disabled,plus={mm}\r\n       - 167,disabled\r\n       - 170,disabled,plus={bpm}\r\n       - 168,rows=2,disabled\r\n       - 169,rows=2,disabled\r\n    col2:                              \r\n      head: \'Sac gestationnel\'\r\n      size: 6\r\n      bloc:                          \r\n       - 157,disabled\r\n       - 158,disabled\r\n       - 159,disabled\r\n       - 163,disabled,plus={mm}\r\n       - 164,disabled\r\n\r\n####### OVAIRES ######\r\n row6:     \r\n    head: \'Ovaires\'                                \r\n    col1:                              \r\n      head: \'Ovaire droit\'  \r\n      size: 6\r\n      bloc:                          \r\n       - 138,plus={mm}\r\n       - 139\r\n    col2:                              \r\n      head: \'Ovaire gauche\'  \r\n      size: 6\r\n      bloc:                          \r\n       - 140,plus={mm}\r\n       - 141\r\n\r\n####### Conclusion ######\r\n row7:     \r\n    head: \'Conclusion\'                                \r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n       - 176,rows=8', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie < 11 SA\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 130                         # indication\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 133                         # voie examen                         \r\n    col3:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 132                         # conditions de réalisation                        \r\n row2:                              \r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 131,min=1,max=3,step=1     # nb embryon\r\n    col2:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 171,disabled               # type grossesse\r\n    col3:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 172,disabled               # membrane \r\n\r\n####### FOETUS A ######\r\n row3:                               # Foetus A\r\n    class: \'foetusA\'\r\n    head: \'Embryon A\'    \r\n    col1:                              \r\n      head: \'Embryon\'\r\n      size: 6\r\n      bloc:                          \r\n       - 173                        # visibilité\r\n       - 125,plus={mm}              # lcc\r\n       - 202,readonly               # terme et DDG calculés\r\n       - 126,plus={mm}              # bip\r\n       - 127                        # activité cardiaque\r\n       - 142,plus={bpm}             # rcf\r\n       - 128,rows=2                 # morpho céphalique\r\n       - 129,rows=2                 # morpho membre\r\n    col2:                              \r\n      head: \'Sac gestationnel\'\r\n      size: 6\r\n      bloc:                          \r\n       - 117                        # sac gest : localisation\r\n       - 118                        # sac gest : tonicité\r\n       - 119                        # sac gest : tropho\r\n       - 123,plus={mm}              # sac gest : diamètre\r\n       - 124                        # sac gest : décollement \r\n\r\n\r\n####### FOETUS B ######\r\n row4:                               # Foetus B\r\n    class: \'foetusB\'\r\n    head: \'Embryon B\'    \r\n    col1:                              \r\n      head: \'Embryon\'\r\n      size: 6\r\n      bloc:                          \r\n       - 174,disabled\r\n       - 151,disabled,plus={mm}\r\n       - 203,disabled,readonly\r\n       - 152,disabled,plus={mm}\r\n       - 153,disabled\r\n       - 156,disabled,plus={bpm}\r\n       - 154,rows=2,disabled\r\n       - 155,rows=2,disabled \r\n   col2:                              \r\n      head: \'Sac gestationnel\'\r\n      size: 6\r\n      bloc:                          \r\n       - 143,disabled\r\n       - 144,disabled\r\n       - 145,disabled\r\n       - 149,disabled,plus={mm}\r\n       - 150,disabled\r\n\r\n####### FOETUS C ######\r\n row5:                               # Foetus C\r\n    class: \'foetusC\'\r\n    head: \'Embryon C\'    \r\n    col1:                              \r\n      head: \'Embryon\'\r\n      size: 6\r\n      bloc:                          \r\n       - 175,disabled\r\n       - 165,disabled,plus={mm}\r\n       - 204,disabled,readonly\r\n       - 166,disabled,plus={mm}\r\n       - 167,disabled\r\n       - 170,disabled,plus={bpm}\r\n       - 168,rows=2,disabled\r\n       - 169,rows=2,disabled\r\n    col2:                              \r\n      head: \'Sac gestationnel\'\r\n      size: 6\r\n      bloc:                          \r\n       - 157,disabled\r\n       - 158,disabled\r\n       - 159,disabled\r\n       - 163,disabled,plus={mm}\r\n       - 164,disabled\r\n\r\n####### OVAIRES ######\r\n row6:     \r\n    head: \'Ovaires\'                                \r\n    col1:                              \r\n      head: \'Ovaire droit\'  \r\n      size: 6\r\n      bloc:                          \r\n       - 138,plus={mm}\r\n       - 139\r\n    col2:                              \r\n      head: \'Ovaire gauche\'  \r\n      size: 6\r\n      bloc:                          \r\n       - 140,plus={mm}\r\n       - 141\r\n\r\n####### Conclusion ######\r\n row7:     \r\n    head: \'Conclusion\'                                \r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n       - 176,rows=8', 'csEcho11'),
(20, 'Formulaire cs colposcopie', 'formulaire colposcopie', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Colposcopie\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 223,rows=10                 # observation sur colposcopie', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Colposcopie\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 223,rows=10                 # observation sur colposcopie', 'csColpo'),
(21, 'Issue de grossesse', 'formulaire issue de grossesse', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Issue de grossesse\'\r\n    col1:                            \r\n      size: 3\r\n      bloc:                          \r\n        - 225\r\n    col2:                            \r\n      size: 6\r\n      bloc:                          \r\n        - 224,autocomplete\r\n    col3:                            \r\n      size: 3\r\n      bloc:                          \r\n        - 244,min=1,max=3,step=1\r\n\r\n####### FOETUS A ######\r\n row2:                               # Foetus A\r\n    class: \'foetusA\'\r\n    head: \'Foetus A\'    \r\n    col1:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 230,autocomplete,data-acTypeID=3:22:230:235:241\r\n        - 229\r\n    col2:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 227\r\n        - 231\r\n    col3:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 228\r\n        - 226\r\n\r\n####### FOETUS B ######\r\n row3:                               # Foetus B\r\n    class: \'foetusB\'\r\n    head: \'Foetus B\'    \r\n    col1:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 235,disabled,autocomplete,data-acTypeID=3:22:230:235:241\r\n        - 234,disabled\r\n    col2:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 233,disabled\r\n        - 236,disabled\r\n    col3:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 237,disabled\r\n        - 232,disabled\r\n\r\n####### FOETUS C ######\r\n row4:                               # Foetus C\r\n    class: \'foetusC\'\r\n    head: \'Foetus C\'    \r\n    col1:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 241,disabled,autocomplete,data-acTypeID=3:22:230:235:241\r\n        - 240,disabled\r\n    col2:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 239,disabled\r\n        - 242,disabled\r\n    col3:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 243,disabled\r\n        - 238,disabled', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Issue de grossesse\'\r\n    col1:                            \r\n      size: 3\r\n      bloc:                          \r\n        - 225\r\n    col2:                            \r\n      size: 6\r\n      bloc:                          \r\n        - 224,autocomplete\r\n    col3:                            \r\n      size: 3\r\n      bloc:                          \r\n        - 244,min=1,max=3,step=1\r\n\r\n####### FOETUS A ######\r\n row2:                               # Foetus A\r\n    class: \'foetusA\'\r\n    head: \'Foetus A\'    \r\n    col1:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 230,autocomplete,data-acTypeID=3:22:230:235:241\r\n        - 229\r\n    col2:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 227\r\n        - 231\r\n    col3:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 228\r\n        - 226\r\n\r\n####### FOETUS B ######\r\n row3:                               # Foetus B\r\n    class: \'foetusB\'\r\n    head: \'Foetus B\'    \r\n    col1:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 235,disabled,autocomplete,data-acTypeID=3:22:230:235:241\r\n        - 234,disabled\r\n    col2:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 233,disabled\r\n        - 236,disabled\r\n    col3:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 237,disabled\r\n        - 232,disabled\r\n\r\n####### FOETUS C ######\r\n row4:                               # Foetus C\r\n    class: \'foetusC\'\r\n    head: \'Foetus C\'    \r\n    col1:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 241,disabled,autocomplete,data-acTypeID=3:22:230:235:241\r\n        - 240,disabled\r\n    col2:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 239,disabled\r\n        - 242,disabled\r\n    col3:                              \r\n      size: 4      \r\n      bloc:                          \r\n        - 243,disabled\r\n        - 238,disabled', 'csIssueGro'),
(14, 'Formulaire mail Apicrypt', 'formulaire pour expédier un mail vers un correspondant apicrypt', 'data_types', 'mail', 'post', '/patient/actions/sendMail/', 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 109,required\r\n  col2: \r\n    size: 6\r\n    bloc: \r\n      - 179,required\r\n row2:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 112,required\r\n row3:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 446\r\n row4:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 111,rows=10', 'structure:\r\n row1:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 109,required\r\n  col2: \r\n    size: 6\r\n    bloc: \r\n      - 179,required\r\n row2:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 112,required\r\n row3:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 446\r\n row4:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 111,rows=10', ''),
(15, 'Fomulaire d\'import de document externe', 'fomulaire d\'import de document externe', 'data_types', 'doc', 'post', NULL, 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 181', 'structure:\r\n row1:\r\n  col1: \r\n    size: 12\r\n    bloc: \r\n      - 181', ''),
(16, 'Formulaire ordonnance', 'formualire ordonnance', 'data_types', 'ordo', 'post', NULL, 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 187\r\n  col2: \r\n    size: 6\r\n    bloc: \r\n      - 188', 'structure:\r\n row1:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 187\r\n  col2: \r\n    size: 6\r\n    bloc: \r\n      - 188', ''),
(17, 'Formulaire règlement', 'formulaire pour le règlement', 'data_types', 'reglement', 'post', '/patient/actions/saveReglementForm/', 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 197\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 198,plus={€}\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 199,plus={€}\r\n  col4: \r\n    size: 3\r\n    bloc: \r\n      - 196,readonly,plus={€}\r\n row2:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 194,plus={€}\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 193,plus={€}\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 195,plus={€}\r\n  col4: \r\n    size: 3\r\n    bloc: \r\n      - 200,plus={€}\r\n row3:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 205', 'structure:\r\n row1:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 197\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 198,plus={€}\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 199,plus={€}\r\n  col4: \r\n    size: 3\r\n    bloc: \r\n      - 196,readonly,plus={€}\r\n row2:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 194,plus={€}\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 193,plus={€}\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 195,plus={€}\r\n  col4: \r\n    size: 3\r\n    bloc: \r\n      - 200,plus={€}\r\n row3:\r\n  col1: \r\n    size: 6\r\n    bloc: \r\n      - 205', ''),
(18, 'Formulaire simplifié règlement (page compta)', 'formulaire simplifié pour le règlement', 'data_types', 'reglement', 'post', '/compta/actions/saveReglementForm/', 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 193,plus={€}\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 194,plus={€}\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 195,plus={€}\r\n row2:\r\n  col1: \r\n    size: 9\r\n    bloc: \r\n      - 205', 'structure:\r\n row1:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 193,plus={€}\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 194,plus={€}\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 195,plus={€}\r\n row2:\r\n  col1: \r\n    size: 9\r\n    bloc: \r\n      - 205', ''),
(19, 'Recherche règlements', 'formulaire recherche règlement', 'form_basic_types', 'admin', 'post', '', 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 4\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 4\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 3', 'structure:\r\n row1:\r\n  col1: \r\n    size: 3\r\n    bloc: \r\n      - 4\r\n  col2: \r\n    size: 3\r\n    bloc: \r\n      - 4\r\n  col3: \r\n    size: 3\r\n    bloc: \r\n      - 3', '');
INSERT INTO `forms` (`id`, `name`, `description`, `dataset`, `groupe`, `formMethod`, `formAction`, `cat`, `type`, `yamlStructure`, `yamlStructureDefaut`, `printModel`) VALUES
(22, 'Import', 'formulaire pour consultation importée d\'une source externe', 'data_types', 'medical', 'post', '', 5, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Consultation importée\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 252,rows=10', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Consultation importée\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 252,rows=10', 'csImportee'),
(23, 'Formulaire Echo 22', 'formulaire écho 22', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie 2e trimestre\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                         \r\n        - 253                           # indication                      \r\n    col2:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 258                           # voie d\'examen\r\n    col3:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 257                           # conditions réalisation\r\n row2:                              \r\n    col1:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 254,min=1,max=3,step=1        # nombre de foetus\r\n    col2:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 255                           # type de grossesse\r\n    col3:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 256                           # membrane\r\n\r\n\r\n####### FOETUS A ######\r\n row3:                               \r\n    class: \'foetusA\'\r\n    head: \'Foetus A\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 259                        # présentation                  \r\n        - 260                        # acti cardio\r\n        - 261,plus={bpm}             # rcf\r\n        - 262                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 263,plus={ },plusg={mm}                        # bip\r\n        - 264,plus={ },plusg={mm}                        # pc\r\n        - 265,plus={ },plusg={mm}                        # pa\r\n        - 266,plus={ },plusg={mm}                        # fémur\r\n        - 267,plus={ },plusg={g}                        # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 268,rows=11                # morpho générale\r\n        - 269                        # oge\r\n\r\n row4:                               \r\n    class: \'foetusA\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 270                        # liquide et cordon\r\n        - 437,plus={mm}              # pgc\r\n        - 271                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 272                        # dopp ombi IR  \r\n        - 273                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 274                        # dopp acm IR  \r\n        - 275                        # dopp acm vitesse \r\n        - 276,readonly               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 277                        # dopp arantius IR  \r\n        - 278                        # dopp arantius onde A  \r\n\r\n####### FOETUS B ######\r\n row5:                               \r\n    class: \'foetusB\'\r\n    head: \'Foetus B\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 322,disabled                        # présentation                  \r\n        - 286,disabled                        # acti cardio\r\n        - 324,disabled,plus={bpm}             # rcf\r\n        - 308,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 287,disabled,plus={ },plusg={mm}                        # bip\r\n        - 316,disabled,plus={ },plusg={mm}                        # pc\r\n        - 314,disabled,plus={ },plusg={mm}                        # pa\r\n        - 304,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 320,disabled,plus={ },plusg={g}                         # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 310,disabled,rows=11                # morpho générale\r\n        - 312,disabled                        # oge\r\n\r\n row6:                               \r\n    class: \'foetusB\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 306,disabled                        # liquide et cordon\r\n        - 438,disabled,plus={mm}              # pgc\r\n        - 318,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 302,disabled                        # dopp ombi IR  \r\n        - 300,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 290,disabled                        # dopp acm IR  \r\n        - 294,disabled                        # dopp acm vitesse \r\n        - 292,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 296,disabled                        # dopp arantius IR  \r\n        - 298,disabled                        # dopp arantius onde A \r\n\r\n\r\n####### FOETUS C ######\r\n row7:                               \r\n    class: \'foetusC\'\r\n    head: \'Foetus C\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 323,disabled                        # présentation                  \r\n        - 288,disabled                        # acti cardio\r\n        - 325,disabled,plus={bpm}            # rcf\r\n        - 309,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 289,disabled,plus={ },plusg={mm}                        # bip\r\n        - 317,disabled,plus={ },plusg={mm}                        # pc\r\n        - 315,disabled,plus={ },plusg={mm}                        # pa\r\n        - 305,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 321,disabled,plus={ },plusg={g}                         # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 311,disabled,rows=11                # morpho générale\r\n        - 313,disabled                        # oge\r\n\r\n row8:                               \r\n    class: \'foetusC\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 307,disabled                        # liquide et cordon\r\n        - 439,disabled,plus={mm}              # pgc\r\n        - 319,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 303,disabled                        # dopp ombi IR  \r\n        - 301,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 291,disabled                        # dopp acm IR  \r\n        - 295,disabled                        # dopp acm vitesse \r\n        - 293,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 297,disabled                        # dopp arantius IR  \r\n        - 299,disabled                        # dopp arantius onde A \r\n\r\n####### UTERUS ######\r\n\r\n row9:   \r\n    head: \'Utérus\'                            \r\n    col1:                              \r\n      head: \'Dopplers utérins\' \r\n      size: 3\r\n      bloc:        \r\n        - 279                        # dopp ut dt IR   \r\n        - 281                        # dopp ut dt Notch  \r\n    col2:                              \r\n      head: \' \' \r\n      size: 3\r\n      bloc:        \r\n        - 280                        # dopp ut g IR   \r\n        - 282                        # dopp ut g Notch\r\n    col3:                              \r\n      head: \'Col\' \r\n      size: 3\r\n      bloc:        \r\n        - 283                        # col : longueur   \r\n        - 284                        # col : entonnoir\r\n\r\n####### CONCLUSION ######\r\n row10: \r\n    head: \'Conclusion\'                               \r\n    col1:                              \r\n      size: 12\r\n      bloc: \r\n        - 285,rows=5                        # conclusion générale', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie 2e trimestre\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                         \r\n        - 253                           # indication                      \r\n    col2:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 258                           # voie d\'examen\r\n    col3:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 257                           # conditions réalisation\r\n row2:                              \r\n    col1:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 254,min=1,max=3,step=1        # nombre de foetus\r\n    col2:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 255                           # type de grossesse\r\n    col3:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 256                           # membrane\r\n\r\n\r\n####### FOETUS A ######\r\n row3:                               \r\n    class: \'foetusA\'\r\n    head: \'Foetus A\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 259                        # présentation                  \r\n        - 260                        # acti cardio\r\n        - 261,plus={bpm}             # rcf\r\n        - 262                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 263,plus={ },plusg={mm}                        # bip\r\n        - 264,plus={ },plusg={mm}                        # pc\r\n        - 265,plus={ },plusg={mm}                        # pa\r\n        - 266,plus={ },plusg={mm}                        # fémur\r\n        - 267,plus={ },plusg={g}                        # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 268,rows=11                # morpho générale\r\n        - 269                        # oge\r\n\r\n row4:                               \r\n    class: \'foetusA\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 270                        # liquide et cordon\r\n        - 437,plus={mm}              # pgc\r\n        - 271                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 272                        # dopp ombi IR  \r\n        - 273                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 274                        # dopp acm IR  \r\n        - 275                        # dopp acm vitesse \r\n        - 276,readonly               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 277                        # dopp arantius IR  \r\n        - 278                        # dopp arantius onde A  \r\n\r\n####### FOETUS B ######\r\n row5:                               \r\n    class: \'foetusB\'\r\n    head: \'Foetus B\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 322,disabled                        # présentation                  \r\n        - 286,disabled                        # acti cardio\r\n        - 324,disabled,plus={bpm}             # rcf\r\n        - 308,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 287,disabled,plus={ },plusg={mm}                        # bip\r\n        - 316,disabled,plus={ },plusg={mm}                        # pc\r\n        - 314,disabled,plus={ },plusg={mm}                        # pa\r\n        - 304,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 320,disabled,plus={ },plusg={g}                         # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 310,disabled,rows=11                # morpho générale\r\n        - 312,disabled                        # oge\r\n\r\n row6:                               \r\n    class: \'foetusB\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 306,disabled                        # liquide et cordon\r\n        - 438,disabled,plus={mm}              # pgc\r\n        - 318,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 302,disabled                        # dopp ombi IR  \r\n        - 300,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 290,disabled                        # dopp acm IR  \r\n        - 294,disabled                        # dopp acm vitesse \r\n        - 292,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 296,disabled                        # dopp arantius IR  \r\n        - 298,disabled                        # dopp arantius onde A \r\n\r\n\r\n####### FOETUS C ######\r\n row7:                               \r\n    class: \'foetusC\'\r\n    head: \'Foetus C\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 323,disabled                        # présentation                  \r\n        - 288,disabled                        # acti cardio\r\n        - 325,disabled,plus={bpm}            # rcf\r\n        - 309,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 289,disabled,plus={ },plusg={mm}                        # bip\r\n        - 317,disabled,plus={ },plusg={mm}                        # pc\r\n        - 315,disabled,plus={ },plusg={mm}                        # pa\r\n        - 305,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 321,disabled,plus={ },plusg={g}                         # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 311,disabled,rows=11                # morpho générale\r\n        - 313,disabled                        # oge\r\n\r\n row8:                               \r\n    class: \'foetusC\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 307,disabled                        # liquide et cordon\r\n        - 439,disabled,plus={mm}              # pgc\r\n        - 319,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 303,disabled                        # dopp ombi IR  \r\n        - 301,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 291,disabled                        # dopp acm IR  \r\n        - 295,disabled                        # dopp acm vitesse \r\n        - 293,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 297,disabled                        # dopp arantius IR  \r\n        - 299,disabled                        # dopp arantius onde A \r\n\r\n####### UTERUS ######\r\n\r\n row9:   \r\n    head: \'Utérus\'                            \r\n    col1:                              \r\n      head: \'Dopplers utérins\' \r\n      size: 3\r\n      bloc:        \r\n        - 279                        # dopp ut dt IR   \r\n        - 281                        # dopp ut dt Notch  \r\n    col2:                              \r\n      head: \' \' \r\n      size: 3\r\n      bloc:        \r\n        - 280                        # dopp ut g IR   \r\n        - 282                        # dopp ut g Notch\r\n    col3:                              \r\n      head: \'Col\' \r\n      size: 3\r\n      bloc:        \r\n        - 283                        # col : longueur   \r\n        - 284                        # col : entonnoir\r\n\r\n####### CONCLUSION ######\r\n row10: \r\n    head: \'Conclusion\'                               \r\n    col1:                              \r\n      size: 12\r\n      bloc: \r\n        - 285,rows=5                        # conclusion générale', 'csEcho22'),
(24, 'Formulaire Echo 32', 'formulaire écho 32', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie 3e trimestre\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                         \r\n        - 326                        # indication\r\n    col2:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 331                        # voie d\'examen\r\n    col3:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 330                        # conditions de réalisation\r\n row2:                              \r\n    col1:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 327,min=1,max=3,step=1     # nombre de foetus\r\n    col2:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 328                        # type de grossesse \r\n\r\n\r\n\r\n####### FOETUS A ######\r\n row3:                               \r\n    class: \'foetusA\'\r\n    head: \'Foetus A\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 332                        # présentation                  \r\n        - 333                        # acti cardio\r\n        - 334,plus={bpm}             # rcf\r\n        - 335                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 336,plus={ },plusg={mm}                        # bip\r\n        - 337,plus={ },plusg={mm}                        # pc\r\n        - 338,plus={ },plusg={mm}                        # pa\r\n        - 339,plus={ },plusg={mm}                        # fémur\r\n        - 340,plus={ },plusg={g}                        # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 341,rows=11                # morpho générale\r\n        - 342                        # oge\r\n\r\n row4:                               \r\n    class: \'foetusA\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 343                        # liquide et cordon\r\n        - 440,plus={mm}              # pgc\r\n        - 344                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 345                        # dopp ombi IR  \r\n        - 346                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 347                        # dopp acm IR  \r\n        - 348                        # dopp acm vitesse \r\n        - 349,readonly               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 350                        # dopp arantius IR  \r\n        - 351                        # dopp arantius onde A  \r\n\r\n####### FOETUS B ######\r\n row5:                               \r\n    class: \'foetusB\'\r\n    head: \'Foetus B\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 395,disabled                        # présentation                  \r\n        - 359,disabled                        # acti cardio\r\n        - 397,disabled,plus={bpm}             # rcf\r\n        - 381,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 360,disabled,plus={ },plusg={mm}                        # bip\r\n        - 389,disabled,plus={ },plusg={mm}                        # pc\r\n        - 387,disabled,plus={ },plusg={mm}                        # pa\r\n        - 377,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 393,disabled,plus={ },plusg={g}                         # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 383,disabled,rows=11                # morpho générale\r\n        - 385,disabled                        # oge\r\n\r\n row6:                               \r\n    class: \'foetusB\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 379,disabled                        # liquide et cordon\r\n        - 441,disabled,plus={mm}              # pgc\r\n        - 391,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 375,disabled                        # dopp ombi IR  \r\n        - 373,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 363,disabled                        # dopp acm IR  \r\n        - 367,disabled                        # dopp acm vitesse \r\n        - 365,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 369,disabled                        # dopp arantius IR  \r\n        - 371,disabled                        # dopp arantius onde A \r\n\r\n\r\n####### FOETUS C ######\r\n row7:                               \r\n    class: \'foetusC\'\r\n    head: \'Foetus C\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 396,disabled                        # présentation                  \r\n        - 361,disabled                        # acti cardio\r\n        - 398,disabled,plus={bpm}             # rcf\r\n        - 309,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 362,disabled,plus={ },plusg={mm}                        # bip\r\n        - 390,disabled,plus={ },plusg={mm}                        # pc\r\n        - 388,disabled,plus={ },plusg={mm}                        # pa\r\n        - 378,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 394,disabled,plus={ },plusg={g}                        # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 384,disabled,rows=11                # morpho générale\r\n        - 386,disabled                        # oge\r\n\r\n row8:                               \r\n    class: \'foetusC\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 380,disabled                        # liquide et cordon\r\n        - 442,disabled,plus={mm}              # pgc\r\n        - 392,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 376,disabled                        # dopp ombi IR  \r\n        - 374,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 364,disabled                        # dopp acm IR  \r\n        - 368,disabled                        # dopp acm vitesse \r\n        - 366,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 370,disabled                        # dopp arantius IR  \r\n        - 372,disabled                        # dopp arantius onde A \r\n\r\n####### UTERUS ######\r\n\r\n row9:   \r\n    head: \'Utérus\'                            \r\n    col1:                              \r\n      head: \'Doppler utérins\' \r\n      size: 3\r\n      bloc:        \r\n        - 352                        # dopp ut dt IR   \r\n        - 354                        # dopp ut dt Notch  \r\n    col2:                              \r\n      head: \' \' \r\n      size: 3\r\n      bloc:        \r\n        - 353                        # dopp ut g IR   \r\n        - 355                        # dopp ut g Notch\r\n    col3:                              \r\n      head: \'Col\' \r\n      size: 3\r\n      bloc:        \r\n        - 356                        # col : longueur   \r\n        - 357                        # col : entonnoir\r\n\r\n####### CONCLUSION ######\r\n row10: \r\n    head: \'Conclusion\'                               \r\n    col1:                              \r\n      size: 12\r\n      bloc: \r\n        - 358,rows=5                        # conclusion générale\r\n        - 445,readonly,rows=3               # conclusion complémentaire', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Echographie 3e trimestre\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                         \r\n        - 326                        # indication\r\n    col2:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 331                        # voie d\'examen\r\n    col3:                           \r\n      size: 4\r\n      bloc:                         \r\n        - 330                        # conditions de réalisation\r\n row2:                              \r\n    col1:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 327,min=1,max=3,step=1     # nombre de foetus\r\n    col2:                            \r\n      size: 4\r\n      bloc:                         \r\n        - 328                        # type de grossesse \r\n\r\n\r\n\r\n####### FOETUS A ######\r\n row3:                               \r\n    class: \'foetusA\'\r\n    head: \'Foetus A\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 332                        # présentation                  \r\n        - 333                        # acti cardio\r\n        - 334,plus={bpm}             # rcf\r\n        - 335                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 336,plus={ },plusg={mm}                        # bip\r\n        - 337,plus={ },plusg={mm}                        # pc\r\n        - 338,plus={ },plusg={mm}                        # pa\r\n        - 339,plus={ },plusg={mm}                        # fémur\r\n        - 340,plus={ },plusg={g}                        # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 341,rows=11                # morpho générale\r\n        - 342                        # oge\r\n\r\n row4:                               \r\n    class: \'foetusA\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 343                        # liquide et cordon\r\n        - 440,plus={mm}              # pgc\r\n        - 344                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 345                        # dopp ombi IR  \r\n        - 346                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 347                        # dopp acm IR  \r\n        - 348                        # dopp acm vitesse \r\n        - 349,readonly               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 350                        # dopp arantius IR  \r\n        - 351                        # dopp arantius onde A  \r\n\r\n####### FOETUS B ######\r\n row5:                               \r\n    class: \'foetusB\'\r\n    head: \'Foetus B\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 395,disabled                        # présentation                  \r\n        - 359,disabled                        # acti cardio\r\n        - 397,disabled,plus={bpm}             # rcf\r\n        - 381,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 360,disabled,plus={ },plusg={mm}                        # bip\r\n        - 389,disabled,plus={ },plusg={mm}                        # pc\r\n        - 387,disabled,plus={ },plusg={mm}                        # pa\r\n        - 377,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 393,disabled,plus={ },plusg={g}                         # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 383,disabled,rows=11                # morpho générale\r\n        - 385,disabled                        # oge\r\n\r\n row6:                               \r\n    class: \'foetusB\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 379,disabled                        # liquide et cordon\r\n        - 441,disabled,plus={mm}              # pgc\r\n        - 391,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 375,disabled                        # dopp ombi IR  \r\n        - 373,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 363,disabled                        # dopp acm IR  \r\n        - 367,disabled                        # dopp acm vitesse \r\n        - 365,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 369,disabled                        # dopp arantius IR  \r\n        - 371,disabled                        # dopp arantius onde A \r\n\r\n\r\n####### FOETUS C ######\r\n row7:                               \r\n    class: \'foetusC\'\r\n    head: \'Foetus C\' \r\n    col1:                              \r\n      head: \'Présentation et Vitalité\' \r\n      size: 3\r\n      bloc:        \r\n        - 396,disabled                        # présentation                  \r\n        - 361,disabled                        # acti cardio\r\n        - 398,disabled,plus={bpm}             # rcf\r\n        - 309,disabled                        # maf \r\n    col2:                              \r\n      head: \'Biométrie\' \r\n      size: 3\r\n      bloc:                          \r\n        - 362,disabled,plus={ },plusg={mm}                        # bip\r\n        - 390,disabled,plus={ },plusg={mm}                        # pc\r\n        - 388,disabled,plus={ },plusg={mm}                        # pa\r\n        - 378,disabled,plus={ },plusg={mm}                        # fémur\r\n        - 394,disabled,plus={ },plusg={g}                        # poids estimé\r\n    col3:                              \r\n      head: \'Morphologie\' \r\n      size: 6\r\n      bloc:                          \r\n        - 384,disabled,rows=11                # morpho générale\r\n        - 386,disabled                        # oge\r\n\r\n row8:                               \r\n    class: \'foetusC\'\r\n    col1:                              \r\n      head: \'Annexes\' \r\n      size: 3\r\n      bloc:        \r\n        - 380,disabled                        # liquide et cordon\r\n        - 442,disabled,plus={mm}              # pgc\r\n        - 392,disabled                        # placenta\r\n\r\n    col2:                              \r\n      head: \'Doppler ombilical\' \r\n      size: 3\r\n      bloc:        \r\n        - 376,disabled                        # dopp ombi IR  \r\n        - 374,disabled                        # dopp ombi flux en dia  \r\n\r\n    col3:                              \r\n      head: \'Doppler ACM\' \r\n      size: 3\r\n      bloc:        \r\n        - 364,disabled                        # dopp acm IR  \r\n        - 368,disabled                        # dopp acm vitesse \r\n        - 366,readonly,disabled               # dopp acm mom\r\n\r\n    col4:                              \r\n      head: \'Doppler Arantius\' \r\n      size: 3\r\n      bloc:        \r\n        - 370,disabled                        # dopp arantius IR  \r\n        - 372,disabled                        # dopp arantius onde A \r\n\r\n####### UTERUS ######\r\n\r\n row9:   \r\n    head: \'Utérus\'                            \r\n    col1:                              \r\n      head: \'Doppler utérins\' \r\n      size: 3\r\n      bloc:        \r\n        - 352                        # dopp ut dt IR   \r\n        - 354                        # dopp ut dt Notch  \r\n    col2:                              \r\n      head: \' \' \r\n      size: 3\r\n      bloc:        \r\n        - 353                        # dopp ut g IR   \r\n        - 355                        # dopp ut g Notch\r\n    col3:                              \r\n      head: \'Col\' \r\n      size: 3\r\n      bloc:        \r\n        - 356                        # col : longueur   \r\n        - 357                        # col : entonnoir\r\n\r\n####### CONCLUSION ######\r\n row10: \r\n    head: \'Conclusion\'                               \r\n    col1:                              \r\n      size: 12\r\n      bloc: \r\n        - 358,rows=5                        # conclusion générale\r\n        - 445,readonly,rows=3               # conclusion complémentaire', 'csEcho32'),
(25, 'Assigner un mot de passe', 'formulaire assigner un password à un utilisateur', 'form_basic_types', 'admin', 'post', '/configuration/actions/configUpdatePassword/', 5, 'public', 'structure:\r\n row1:\r\n  col1: \r\n    head: "Assigner le mot de passe à l\'identifiant"\r\n    size: 3\r\n    bloc: \r\n      - 1,required\r\n      - 2,required\r\n      - 3', 'structure:\r\n row1:\r\n  col1: \r\n    head: "Assigner le mot de passe à l\'identifiant"\r\n    size: 3\r\n    bloc: \r\n      - 1,required\r\n      - 2,required\r\n      - 3', ''),
(26, 'Formulaire Cs grossesse', 'formulaire basique de consultation pendant grossesse', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Consultation obstétricale\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 399,rows=10             # observation texte libre', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### INTRODUCTION ######\r\n  row1:                              \r\n    head: \'Consultation obstétricale\'\r\n    col1:                              \r\n      size: 12\r\n      bloc:                          \r\n        - 399,rows=10             # observation texte libre', 'csGrossesse'),
(27, 'Formulaire Echo gynéco', 'formulaire écho gynéco', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### Renseignements généraux ######\r\n  row1:                              \r\n    head: \'Echographie gynécologique\'\r\n    col1:                              \r\n      size: 4\r\n      head: \'Renseignements généraux\'\r\n      bloc:                         \r\n        - 432,plusg={ }         # ddr\r\n        - 400                    # traitement\r\n        - 401                    # prescipteur\r\n        - 402                    # conditions\r\n        - 403                    # voie\r\n\r\n    col2:                              \r\n      size: 8\r\n      head: \'Indications\'\r\n      bloc:                         \r\n        - 408                    # indic : uterus\r\n        - 407                    # indic : annexes\r\n        - 411                    # indic : autres\r\n        - 404,rows=4             # indic txt libre\r\n   \r\n####### Utérus ######\r\n  row2:                              \r\n    head: \'Utérus\'\r\n    col1: \r\n      size: 2\r\n      head: \'Dimensions\'\r\n      bloc:                         \r\n        - 414,plus={mm}          # longueur\r\n        - 413,plus={mm}          # largeur\r\n        - 415,plus={mm}          # hauteur\r\n\r\n   col2: \r\n      size: 2\r\n      head: \'Anatomie\'\r\n      bloc:                         \r\n        - 412                    # position\r\n        - 416                    # contours\r\n        - 417                    # structure myomètre\r\n\r\n   col3: \r\n      size: 4\r\n      head: \'Endomètre\'\r\n      bloc:                         \r\n        - 422                    # endomètre texte libre\r\n        - 423,plus={mm}          # endomètre épaisseur\r\n\r\n   col4: \r\n      size: 4\r\n      head: \'Cavité\'\r\n      bloc:                         \r\n        - 424                    # cavité : txt libre\r\n        - 425                    # cavité : contenu\r\n\r\n####### Autres ######\r\n  row3:                              \r\n    head: \'Autres\'\r\n    col1: \r\n      size: 3\r\n      head: \'Ovaires\'\r\n      bloc:                         \r\n        - 427                    # ovaire dt\r\n        - 452,plus={mm}          # ovaire dt gd axe        \r\n        - 428                    # ovaire g\r\n        - 453,plus={mm}          # ovaire g gd axe  \r\n\r\n    col2: \r\n      size: 3\r\n      head: \'Culs de sac\'\r\n      bloc:                         \r\n        - 429                    # latéraux\r\n        - 430                    # douglas\r\n\r\n    col3: \r\n      size: 3\r\n      head: \'Doppler A. utérines\'\r\n      bloc:                         \r\n        - 418                    # dte IR\r\n        - 419                    # dte IP\r\n        - 421                    # g IR\r\n        - 420                    # g IP\r\n\r\n    col4: \r\n      size: 3\r\n      head: \'Trompes\'\r\n      bloc:                         \r\n        - 426                    # dispo intra tubaire\r\n\r\n####### Conclusion ######\r\n  row4:                              \r\n    head: \'Conclusion\'\r\n    col1: \r\n      size: 12\r\n      bloc:                         \r\n        - 431,rows=5                    # conclusion', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n####### Renseignements généraux ######\r\n  row1:                              \r\n    head: \'Echographie gynécologique\'\r\n    col1:                              \r\n      size: 4\r\n      head: \'Renseignements généraux\'\r\n      bloc:                         \r\n        - 432,plusg={ }         # ddr\r\n        - 400                    # traitement\r\n        - 401                    # prescipteur\r\n        - 402                    # conditions\r\n        - 403                    # voie\r\n\r\n    col2:                              \r\n      size: 8\r\n      head: \'Indications\'\r\n      bloc:                         \r\n        - 408                    # indic : uterus\r\n        - 407                    # indic : annexes\r\n        - 411                    # indic : autres\r\n        - 404,rows=4             # indic txt libre\r\n   \r\n####### Utérus ######\r\n  row2:                              \r\n    head: \'Utérus\'\r\n    col1: \r\n      size: 2\r\n      head: \'Dimensions\'\r\n      bloc:                         \r\n        - 414,plus={mm}          # longueur\r\n        - 413,plus={mm}          # largeur\r\n        - 415,plus={mm}          # hauteur\r\n\r\n   col2: \r\n      size: 2\r\n      head: \'Anatomie\'\r\n      bloc:                         \r\n        - 412                    # position\r\n        - 416                    # contours\r\n        - 417                    # structure myomètre\r\n\r\n   col3: \r\n      size: 4\r\n      head: \'Endomètre\'\r\n      bloc:                         \r\n        - 422                    # endomètre texte libre\r\n        - 423,plus={mm}          # endomètre épaisseur\r\n\r\n   col4: \r\n      size: 4\r\n      head: \'Cavité\'\r\n      bloc:                         \r\n        - 424                    # cavité : txt libre\r\n        - 425                    # cavité : contenu\r\n\r\n####### Autres ######\r\n  row3:                              \r\n    head: \'Autres\'\r\n    col1: \r\n      size: 3\r\n      head: \'Ovaires\'\r\n      bloc:                         \r\n        - 427                    # ovaire dt\r\n        - 452,plus={mm}          # ovaire dt gd axe        \r\n        - 428                    # ovaire g\r\n        - 453,plus={mm}          # ovaire g gd axe  \r\n\r\n    col2: \r\n      size: 3\r\n      head: \'Culs de sac\'\r\n      bloc:                         \r\n        - 429                    # latéraux\r\n        - 430                    # douglas\r\n\r\n    col3: \r\n      size: 3\r\n      head: \'Doppler A. utérines\'\r\n      bloc:                         \r\n        - 418                    # dte IR\r\n        - 419                    # dte IP\r\n        - 421                    # g IR\r\n        - 420                    # g IP\r\n\r\n    col4: \r\n      size: 3\r\n      head: \'Trompes\'\r\n      bloc:                         \r\n        - 426                    # dispo intra tubaire\r\n\r\n####### Conclusion ######\r\n  row4:                              \r\n    head: \'Conclusion\'\r\n    col1: \r\n      size: 12\r\n      bloc:                         \r\n        - 431,rows=5                    # conclusion', 'csEchoGyn'),
(28, 'Formulaire marqueurs sériques', 'formulaire marqueurs sériques', 'data_types', 'medical', 'post', '/patient/actions/saveCsForm/', 4, 'public', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n  row1:                              \r\n    head: \'Marqueurs sériques\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 468                         # nb foetus\r\n        - 473                         # origine géo   \r\n    col2:                              \r\n      size: 4\r\n      bloc:   \r\n        - 469                         # atcd t21\r\n        - 470                         # atcd non fermeture tn\r\n        - 476                         # did\r\n    col3:                              \r\n      size: 4\r\n      bloc:   \r\n        - 471                         # fumeuse\r\n        - 472                         # nb cig / j\r\n  row2:                              \r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 474                         # stratégie dépistage', 'global:\r\n  formClass: \'newCS\' \r\nstructure:\r\n  row1:                              \r\n    head: \'Marqueurs sériques\'\r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 468                         # nb foetus\r\n        - 473                         # origine géo   \r\n    col2:                              \r\n      size: 4\r\n      bloc:   \r\n        - 469                         # atcd t21\r\n        - 470                         # atcd non fermeture tn\r\n        - 476                         # did\r\n    col3:                              \r\n      size: 4\r\n      bloc:   \r\n        - 471                         # fumeuse\r\n        - 472                         # nb cig / j\r\n  row2:                              \r\n    col1:                              \r\n      size: 4\r\n      bloc:                          \r\n        - 474                         # stratégie dépistage', 'marqueursT21');

-- --------------------------------------------------------

--
-- Structure de la table `forms_cat`
--

CREATE TABLE `forms_cat` (
  `id` smallint(5) NOT NULL,
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `type` enum('base','user') NOT NULL DEFAULT 'user',
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `forms_cat`
--

INSERT INTO `forms_cat` (`id`, `name`, `label`, `description`, `type`, `fromID`, `creationDate`) VALUES
(1, 'patientforms', 'Formulaires de saisie', 'Formulaire liés à la saisie de données', 'user', 1, '2016-12-16 16:13:38'),
(2, 'displayforms', 'Formulaires d\'affichage', 'Formulaires liés à l\'affichage d\'informations', 'user', 1, '2016-12-16 16:19:35'),
(4, 'formCS', 'Formulaires de consultation', 'Formulaires pour construire les consultations', 'user', 1, '2017-03-13 12:08:35'),
(5, 'systemForm', 'Formulaires système', 'formulaires système', 'user', 1, '2017-03-16 19:53:03');

-- --------------------------------------------------------

--
-- Structure de la table `form_basic_types`
--

CREATE TABLE `form_basic_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `placeholder` varchar(255) NOT NULL,
  `label` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `validationRules` varchar(255) NOT NULL,
  `validationErrorMsg` varchar(255) NOT NULL,
  `formType` varchar(255) NOT NULL,
  `formValues` text NOT NULL,
  `type` enum('base','user') NOT NULL DEFAULT 'user',
  `cat` smallint(5) UNSIGNED NOT NULL,
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL,
  `deleteByID` smallint(5) UNSIGNED NOT NULL,
  `deleteDate` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `form_basic_types`
--

INSERT INTO `form_basic_types` (`id`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `deleteByID`, `deleteDate`) VALUES
(1, 'userid', 'identifiant', 'Identifiant', 'identifiant numérique d\'utilisateur', 'required|numeric', 'L\'identifiant utilisateur n\'est pas correct', 'text', '', 'base', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00'),
(2, 'password', 'mot de passe', 'Mot de passe', 'mot de passe utilisateur', 'required', 'Le mot de passe est manquant', 'password', '', 'base', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00'),
(3, 'submit', '', 'Valider', 'bouton submit de validation', '', '', 'submit', '', 'base', 0, 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00'),
(4, 'date', '', 'Début de période', '', '', '', 'date', '', 'base', 0, 0, '2017-03-27 00:00:00', 0, '2017-03-27 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `hprim`
--

CREATE TABLE `hprim` (
  `id` int(11) NOT NULL,
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `toID` smallint(5) UNSIGNED NOT NULL,
  `date` date DEFAULT '1000-01-01',
  `objetID` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `labelStandard` varchar(255) NOT NULL,
  `typeResultat` varchar(2) NOT NULL,
  `resultat` varchar(255) NOT NULL,
  `unite` varchar(20) NOT NULL,
  `normaleInf` varchar(20) NOT NULL,
  `normaleSup` varchar(20) NOT NULL,
  `indicateurAnormal` varchar(5) NOT NULL,
  `statutRes` varchar(1) NOT NULL,
  `resAutreU` varchar(50) NOT NULL,
  `normaleInfAutreU` varchar(20) NOT NULL,
  `normalSupAutreU` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `inbox`
--

CREATE TABLE `inbox` (
  `id` int(7) UNSIGNED NOT NULL,
  `txtFileName` varchar(30) NOT NULL,
  `txtDatetime` datetime NOT NULL,
  `txtNumOrdre` smallint(4) UNSIGNED NOT NULL,
  `hprimIdentite` varchar(250) NOT NULL,
  `hprimExpediteur` varchar(250) NOT NULL,
  `hprimCodePatient` varchar(250) NOT NULL,
  `hprimDateDossier` varchar(30) NOT NULL,
  `hprimAllSerialize` blob NOT NULL,
  `pjNombre` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `pjSerializeName` blob NOT NULL,
  `archived` enum('y','c','n') NOT NULL DEFAULT 'n',
  `assoToID` mediumint(7) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `objets_data`
--

CREATE TABLE `objets_data` (
  `id` int(11) UNSIGNED NOT NULL,
  `fromID` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `toID` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `typeID` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `parentTypeID` int(11) UNSIGNED DEFAULT '0',
  `instance` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `creationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `value` text,
  `outdated` enum('','y') NOT NULL DEFAULT '',
  `important` enum('n','y') DEFAULT 'n',
  `titre` varchar(255) NOT NULL DEFAULT '',
  `deleted` enum('','y') NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `people`
--

CREATE TABLE `people` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` enum('patient','pro') NOT NULL DEFAULT 'patient',
  `rank` enum('','admin') DEFAULT NULL,
  `pass` varbinary(60) DEFAULT NULL,
  `registerDate` datetime DEFAULT NULL,
  `fromID` smallint(5) DEFAULT NULL,
  `lastLogIP` varchar(50) DEFAULT NULL,
  `lastLogDate` datetime DEFAULT NULL,
  `lastLogFingerprint` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `people`
--

INSERT INTO `people` (`id`, `type`, `rank`, `pass`, `registerDate`, `fromID`, `lastLogIP`, `lastLogDate`, `lastLogFingerprint`) VALUES
(1, 'pro', 'admin', 0x75a548542f3c5d2917b7ecb03112ddcc, NULL, NULL, '127.0.0.1', '2017-05-21 15:01:36', 'bb07ccd899b821bf1451e93dc8907f63831e7415');

-- --------------------------------------------------------

--
-- Structure de la table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` smallint(5) NOT NULL,
  `cat` smallint(3) UNSIGNED NOT NULL DEFAULT '0',
  `label` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `cat`, `label`, `description`, `fromID`, `creationDate`) VALUES
(1, 2, 'Ligne vierge', '', 1, '2017-03-22 15:26:08'),
(2, 4, 'Ligne vierge', '', 1, '2017-03-22 15:27:26');

-- --------------------------------------------------------

--
-- Structure de la table `prescriptions_cat`
--

CREATE TABLE `prescriptions_cat` (
  `id` smallint(5) NOT NULL,
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `type` enum('base','user') NOT NULL DEFAULT 'user',
  `fromID` smallint(5) UNSIGNED NOT NULL,
  `creationDate` datetime NOT NULL,
  `displayOrder` tinyint(2) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `prescriptions_cat`
--

INSERT INTO `prescriptions_cat` (`id`, `name`, `label`, `description`, `type`, `fromID`, `creationDate`, `displayOrder`) VALUES
(2, 'prescripMedic', 'Prescriptions médicamenteuses', 'prescriptions médicamenteuses', 'user', 1, '2017-03-22 12:36:12', 1),
(4, 'prescriNonMedic', 'Prescriptions non médicamenteuses', 'prescriptions non médicamenteuses', 'user', 1, '2017-05-09 14:02:12', 1);

-- --------------------------------------------------------

--
-- Structure de la table `printed`
--

CREATE TABLE `printed` (
  `id` int(11) UNSIGNED NOT NULL,
  `fromID` int(11) UNSIGNED NOT NULL,
  `toID` int(11) UNSIGNED NOT NULL,
  `type` enum('cr','ordo','courrier') NOT NULL DEFAULT 'cr',
  `objetID` int(11) UNSIGNED DEFAULT NULL,
  `creationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `serializedTags` longblob,
  `outdated` enum('','y') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `actes`
--
ALTER TABLE `actes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `actes_cat`
--
ALTER TABLE `actes_cat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `data_cat`
--
ALTER TABLE `data_cat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groupe` (`groupe`),
  ADD KEY `cat` (`cat`),
  ADD KEY `groupe_2` (`groupe`,`id`);

--
-- Index pour la table `dicomTags`
--
ALTER TABLE `dicomTags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dicomTag` (`dicomTag`,`typeID`),
  ADD KEY `dicomTag_2` (`dicomTag`),
  ADD KEY `typeID` (`typeID`);

--
-- Index pour la table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `forms_cat`
--
ALTER TABLE `forms_cat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `form_basic_types`
--
ALTER TABLE `form_basic_types`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hprim`
--
ALTER TABLE `hprim`
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `inbox`
--
ALTER TABLE `inbox`
  ADD PRIMARY KEY (`txtFileName`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `archived` (`archived`);

--
-- Index pour la table `objets_data`
--
ALTER TABLE `objets_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `toID_typeID` (`toID`,`typeID`),
  ADD KEY `typeID` (`typeID`),
  ADD KEY `instance` (`instance`),
  ADD KEY `parentTypeID` (`parentTypeID`),
  ADD KEY `toID` (`toID`),
  ADD KEY `toID_2` (`toID`,`outdated`,`deleted`),
  ADD KEY `typeIDetValue` (`typeID`,`value`(15));

--
-- Index pour la table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Index pour la table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `prescriptions_cat`
--
ALTER TABLE `prescriptions_cat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `printed`
--
ALTER TABLE `printed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `examenID` (`objetID`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `actes`
--
ALTER TABLE `actes`
  MODIFY `id` smallint(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `actes_cat`
--
ALTER TABLE `actes_cat`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `data_cat`
--
ALTER TABLE `data_cat`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
--
-- AUTO_INCREMENT pour la table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=479;
--
-- AUTO_INCREMENT pour la table `dicomTags`
--
ALTER TABLE `dicomTags`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT pour la table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` smallint(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT pour la table `forms_cat`
--
ALTER TABLE `forms_cat`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `form_basic_types`
--
ALTER TABLE `form_basic_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `hprim`
--
ALTER TABLE `hprim`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `inbox`
--
ALTER TABLE `inbox`
  MODIFY `id` int(7) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `objets_data`
--
ALTER TABLE `objets_data`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `people`
--
ALTER TABLE `people`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `prescriptions_cat`
--
ALTER TABLE `prescriptions_cat`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `printed`
--
ALTER TABLE `printed`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
