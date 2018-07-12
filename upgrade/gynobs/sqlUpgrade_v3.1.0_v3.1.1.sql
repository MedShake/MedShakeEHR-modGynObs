-- Modifications de structure de la bdd d'une version à la suivante

-- 3.1.0 to 3.1.1

UPDATE `system` SET `value`='v3.1.1' WHERE `groupe`='module' and `name`='gynobs';

SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='porteursOrdo');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('ordo', 'gynobsOrdoPorteur', '', 'Ordonnance', 'Ordonnance simple', '', '', '', '', 'gynobs', @catID, 1, '2018-01-01 00:00:00', 3600, 1);

SET @newPorteur = (SELECT data_types.id FROM `data_types` WHERE `name` = 'gynobsOrdoPorteur');
SET @oldPorteur = (SELECT data_types.id FROM `data_types` WHERE `name` = 'ordoPorteur');
UPDATE `objets_data` as od LEFT JOIN people as p ON od.fromID=p.id SET od.typeID=@newPorteur WHERE od.typeID=@oldPorteur and p.module='gynobs';

SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='porteursReglement');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('reglement', 'gynobsReglePorteur', '', 'Règlement', 'Règlement secteurs 1 et 2', '', '', '', 'baseReglement', 'gynobs', @catID, 1, '2018-01-01 00:00:00', 1576800000, 1);

SET @newPorteur = (SELECT data_types.id FROM `data_types` WHERE `name` = 'gynobsReglePorteur');
SET @oldPorteur = (SELECT data_types.id FROM `data_types` WHERE `name` = 'reglePorteur');
UPDATE `objets_data` as od LEFT JOIN people as p ON od.fromID=p.id SET od.typeID=@newPorteur WHERE od.typeID=@oldPorteur and p.module='gynobs';

SET @catID = (SELECT forms_cat.id FROM forms_cat WHERE forms_cat.name='formATCD');
update forms set cat=@catID where internalName = 'gynObsATCD';
