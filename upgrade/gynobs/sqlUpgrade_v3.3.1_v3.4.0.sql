-- Modifications des données de la bdd de v3.3.1 à v3.4.0

-- mise à jour pour un autocomplete correct formulaire fin de grossesse
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, '3:22:230:235:241', 'firstname:othersfirstname:igPrenomFA:igPrenomFB:igPrenomFC');

-- upgrade n° de version
UPDATE `system` SET `value`='v3.4.0' WHERE `name`='gynobs';

-- déplacement du consentement écho à signer
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='catModelesDocASigner');
update data_types set cat = @catID where name = 'consentementEcho' limit 1;
