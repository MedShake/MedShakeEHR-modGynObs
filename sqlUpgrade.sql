-- Modifications de structure de la bdd d'une version à la suivante

-- 1.1.0 to 1.1.1

INSERT INTO `forms` (`id`, `name`, `description`, `dataset`, `groupe`, `formMethod`, `formAction`, `cat`, `type`, `yamlStructure`, `yamlStructureDefaut`, `printModel`) VALUES
(30, 'Agenda prise rdv', 'formulaire latéral de prise de rdv', 'data_types', 'admin', 'post', '', 5, 'public', 'global:\r\n  noFormTags: true\r\nstructure:\r\n  row1:                              \r\n    col1:                              \r\n      size: 6\r\n      bloc:                          \r\n        - 2,readonly         \r\n    col2:                              \r\n      size: 6\r\n      bloc:                          \r\n        - 3,readonly\r\n  row2:\r\n    col1:                              \r\n      size: 5\r\n      bloc:                          \r\n        - 8,readonly\r\n    col2:                              \r\n      size: 7\r\n      bloc:                          \r\n        - 4\r\n  row3:                              \r\n    col1:                              \r\n      size: 6\r\n      bloc:                          \r\n        - 7    \r\n    col2:                              \r\n      size: 6\r\n      bloc:                          \r\n        - 10', NULL, '');


-- 1.0.2 to 1.1.0
INSERT INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('user', 'administratifPeutAvoirAgenda', '', 'administratifPeutAvoirAgenda', 'permet à l\'utilisateur sélectionné d\'avoir son agenda', '', '', 'text', 'false', 'base', 64, 1, '2017-08-09 15:00:18', 3600, 1),
('user', 'agendaNumberForPatientsOfTheDay', '', 'agendaNumberForPatientsOfTheDay', 'permet d\'indiquer le n° d\'agenda à utiliser pour la liste patients du jour pour cet utilisateur', '', '', 'number', '1', 'base', 64, 1, '2017-08-09 17:45:52', 3600, 1);
