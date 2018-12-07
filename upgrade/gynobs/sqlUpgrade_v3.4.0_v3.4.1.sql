-- Modifications des données de la bdd de v3.4.0 à v3.4.1

-- upgrade n° de version
UPDATE `system` SET `value`='v3.4.1' WHERE `name`='gynobs';

INSERT IGNORE INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES ('calcMedGynobsLcc2Terme', 'default', '0', '', 'Calculs médicaux', 'texte', 'Méthode de calcul du terme en fonction de la LCC (Intergrowth-21st / Robinson)', 'Intergrowth-21st');
INSERT IGNORE INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES ('calcMedGynobsBipPcPaFemPercentiles', 'default', '0', '', 'Calculs médicaux', 'texte', 'Méthode de calcul des percentiles BIP, PC, PA, fémur (Intergrowth-21st / CFEF 2006)', 'Intergrowth-21st');
INSERT IGNORE INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES ('calcMedGynobsEPF', 'default', '0', '', 'Calculs médicaux', 'texte', 'Méthode de calcul de l\'EPF (Hadlock 1985 / Intergrowth-21st)', 'Hadlock 1985');
