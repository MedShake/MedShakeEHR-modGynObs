-- Modifications des données de la bdd de v3.4.0 à v3.4.1


-- upgrade n° de version
UPDATE `system` SET `value`='v3.4.1' WHERE `name`='gynobs';

INSERT IGNORE INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES ('calcMedGynobsLcc2Terme', 'default', '0', '', 'Calculs médicaux', 'texte', 'Méthode de calcul du terme en fonction de la LCC (Intergrowth / Robinson)', 'Intergrowth');
INSERT IGNORE INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES ('calcMedGynobsEPF', 'default', '0', '', 'Calculs médicaux', 'texte', 'Méthode de calcul de l\'EPF (Intergrowth / CFEF)', 'Intergrowth');
