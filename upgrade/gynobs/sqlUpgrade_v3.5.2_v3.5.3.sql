-- upgrade n° de version
UPDATE `system` SET `value`='v3.5.3' WHERE `name`='gynobs';

-- correction class fontawesome
UPDATE `forms` SET `yamlStructure` = replace(yamlStructure, '"fa ', '"fas ');
