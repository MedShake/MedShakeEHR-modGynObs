
-- upgrade n° de version
UPDATE `system` SET `value`='v3.5.0' WHERE `name`='gynobs';

-- configuration : formulaires de règlements du module
INSERT INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES ( 'administratifReglementFormulaires', 'module', '0', 'gynobs', 'Règlements', 'liste', '', 'gynobsReglePorteurS1,gynobsReglePorteurS2');

update `data_types` set label='Règlement', description='Règlement conventionné S1' WHERE `name` = 'gynobsReglePorteurS1';
update `data_types` set label='Règlement', description='Règlement conventionné S2' WHERE `name` = 'gynobsReglePorteurS2';
