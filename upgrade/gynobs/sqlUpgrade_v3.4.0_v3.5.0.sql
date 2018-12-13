
-- upgrade n° de version
UPDATE `system` SET `value`='v3.5.0' WHERE `name`='gynobs';

-- configuration : formulaires de règlements du module
INSERT INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES ( 'administratifReglementFormulaires', 'module', '0', 'gynobs', 'Règlements', 'liste', '', 'gynobsReglePorteurS1,gynobsReglePorteurS2');

update `data_types` set label='Règlement', description='Règlement conventionné S1' WHERE `name` = 'gynobsReglePorteurS1';
update `data_types` set label='Règlement', description='Règlement conventionné S2' WHERE `name` = 'gynobsReglePorteurS2';








-- nouveau formulaire génotypage Rhésus foetal D sur sang maternel

-- data_cat
INSERT IGNORE INTO `data_cat` (`groupe`, `name`, `label`, `description`, `type`, `fromID`, `creationDate`) VALUES
('typecs', 'csAutres', 'Autres', 'autres', 'user', '1', '2018-12-13 13:16:52'),
('medical', 'catDataGenotypageRhesusFoetal', 'Données formulaire génotypage rhesus D foetal', 'données pour le formulaire génotypage rhésus D foetal sur sang maternel', 'base', '1', '2018-12-13 13:16:52');

-- data_types
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='catDataGenotypageRhesusFoetal');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'fGenRhFoePatienteOrigineGeo', NULL, 'Origine géographique de la patiente', 'origine géographique de la patiente', NULL, NULL, 'select', '\' \' : \' \' \n\'E\' : \'Europe\'\n\'AN\' : \'Afrique du nord\'\n\'AoC\' : \'Afrique / Caraïbes\'\n\'MO\' : \'Moyen-Orient\'\n\'As\' : \'Asie\'\n\'Autre\' : \'Autre\'', 'gynobs', @catID, '1', '2018-12-13 13:16:52', '3600', '1'),
('medical', 'fGenRhFoeProcreateurOrigineGeo', NULL, 'Origine géographique du procréateur', 'origine géographique du procréateur', NULL, NULL, 'select', '\' \' : \' \' \n\'E\' : \'Europe\'\n\'AN\' : \'Afrique du nord\'\n\'AoC\' : \'Afrique / Caraïbes\'\n\'MO\' : \'Moyen-Orient\'\n\'As\' : \'Asie\'\n\'Autre\' : \'Autre\'', 'gynobs', @catID, '1', '2018-12-13 13:16:52', '3600', '1'),
('medical', 'fGenRhFoePatienteOrigineGeoAutre', 'Précisez ici l\'origine géographique', 'Autre origine géographique de la patiente', 'Autre origine géographique de la patiente', NULL, NULL, 'text', NULL, 'gynobs', @catID, '1', '2018-12-13 13:16:52', '3600', '1'),
('medical', 'fGenRhFoeProcreateurOrigineGeoAutre', 'Précisez ici l\'origine géographique', 'Autre origine géographique du procreateur', 'Autre origine géographique du procreateur', NULL, NULL, 'text', NULL, 'gynobs', @catID, '1', '2018-12-13 13:16:52', '3600', '1'),
('medical', 'fGenRhFoePatienteTypeGro', NULL, 'Type de grossesse', 'type de grossesse', NULL, NULL, 'select', '\'u\' : \'mono-foetal\'\n\'g\' : \'gémellaire\'', 'gynobs', @catID, '1', '2018-12-13 13:16:52', '3600', '1'),
('medical', 'fGenRhFoePatienteSuivieCNRHP', NULL, 'Patiente suivie au CNRHP', 'patiente suivie au CNRHP', NULL, NULL, 'select', '\'n\' : \'non\'\n\'o\' : \'oui\'', 'gynobs', @catID, '1', '2018-12-13 13:16:52', '3600', '1'),
('medical', 'fGenRhFoePatienteAlloImmAntiDConnue', NULL, 'Patiente avec allo-immunisation anti-D connue', 'patiente avec allo-immunisation anti-D connue', NULL, NULL, 'select', '\'n\' : \'non\'\n\'o\' : \'oui\'', 'gynobs', @catID, '1', '2018-12-13 13:16:52', '3600', '1');

SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='csAutres');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('typecs', 'csGenotypageRhesusFoetalSangMaternel', NULL, 'Génotypage Rhésus D fœtal', 'support parent pour génotypage rhésus D fœtal', NULL, NULL, NULL, 'gynobsGenotypageRhesusFoetalSangMaternel', 'gynobs', @catID, '1', '2018-12-13 13:16:52', '84600', '1');

-- forms_cat
INSERT IGNORE INTO `forms_cat` (`name`, `label`, `description`, `type`, `fromID`, `creationDate`) VALUES
('formCS', 'Formulaires de consultation', 'Formulaires pour construire les consultations', 'user', '1', '2018-12-13 13:16:52');

-- forms
SET @catID = (SELECT forms_cat.id FROM forms_cat WHERE forms_cat.name='formCS');
INSERT IGNORE INTO `forms` (`module`, `internalName`, `name`, `description`, `dataset`, `groupe`, `formMethod`, `formAction`, `cat`, `type`, `yamlStructure`, `yamlStructureDefaut`, `printModel`, `cda`, `javascript`) VALUES
('gynobs', 'gynobsGenotypageRhesusFoetalSangMaternel', 'Génotypage rhésus D fœtal à partir du sang maternel', 'formulaire pour ordonnace de génotypage rhésus D fœtal à partir du sang maternel', 'data_types', 'medical', 'post', '/patient/ajax/saveCsForm/', @catID, 'public', 'structure:\r\n row1:\r\n   head: \"Génotypage rhésus D fœtal à partir du sang maternel\"\r\n   col1:\r\n     head: \'Patiente\'    \r\n     size: 5\r\n     bloc:                          \r\n       - fGenRhFoePatienteOrigineGeo               		#1609 Origine géographique de la patiente\n       - fGenRhFoePatienteOrigineGeoAutre,disabled,nolabel,class=d-none 		#1611 Autre origine géographique de la patiente\n       - fGenRhFoePatienteAlloImmAntiDConnue       		#1615 Patiente avec allo-immunisation anti-D connue\n       - fGenRhFoePatienteSuivieCNRHP              		#1614 Patiente suivie au CNRHP\n       - fGenRhFoePatienteTypeGro                  		#1613 Type de grossesse\n   col2:\r\n     head: \'Procréateur\'    \r\n     size: 5\r\n     bloc:                          \r\n       - fGenRhFoeProcreateurOrigineGeo            		#1610 Origine géographique du procréateur\n       - fGenRhFoeProcreateurOrigineGeoAutre,disabled,nolabel,class=d-none 		#1612 Autre origine géographique du procreateur', NULL, 'ordoGenotypageRhesusFoetal', NULL, '$(\'body\').on(\"change\", \'#id_fGenRhFoePatienteOrigineGeo_id\', function() {\r\n  valeur = $(\'#id_fGenRhFoePatienteOrigineGeo_id\').val();\r\n  if (valeur == \'Autre\') {\r\n    $(\'#id_fGenRhFoePatienteOrigineGeoAutre_id\').removeClass(\'d-none\');\r\n    $(\'#id_fGenRhFoePatienteOrigineGeoAutre_id\').removeAttr(\'disabled\');\r\n  } else {\r\n    $(\'#id_fGenRhFoePatienteOrigineGeoAutre_id\').addClass(\'d-none\');\r\n    $(\'#id_fGenRhFoePatienteOrigineGeoAutre_id\').val(\'\');\r\n    $(\'#id_fGenRhFoePatienteOrigineGeoAutre_id\').attr(\'disabled\', \'disabled\');\r\n  }\r\n});\r\n\r\n$(\'body\').on(\"change\", \'#id_fGenRhFoeProcreateurOrigineGeo_id\', function() {\r\n  valeur = $(\'#id_fGenRhFoeProcreateurOrigineGeo_id\').val();\r\n  if (valeur == \'Autre\') {\r\n    $(\'#id_fGenRhFoeProcreateurOrigineGeoAutre_id\').removeClass(\'d-none\');\r\n    $(\'#id_fGenRhFoeProcreateurOrigineGeoAutre_id\').removeAttr(\'disabled\');\r\n  } else {\r\n    $(\'#id_fGenRhFoeProcreateurOrigineGeoAutre_id\').addClass(\'d-none\');\r\n    $(\'#id_fGenRhFoeProcreateurOrigineGeoAutre_id\').val(\'\');\r\n    $(\'#id_fGenRhFoeProcreateurOrigineGeoAutre_id\').attr(\'disabled\', \'disabled\');\r\n  }\r\n});\r\n\r\n\r\n// Restaurer à l\'édition \r\n$(\'#id_fGenRhFoeProcreateurOrigineGeo_id, #id_fGenRhFoePatienteOrigineGeo_id\').trigger( \"change\" );');
