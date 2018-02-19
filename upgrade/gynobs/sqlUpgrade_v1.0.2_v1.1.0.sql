-- Modifications de structure de la bdd d'une version à la suivante

INSERT INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('user', 'administratifPeutAvoirAgenda', '', 'administratifPeutAvoirAgenda', 'permet à l\'utilisateur sélectionné d\'avoir son agenda', '', '', 'text', 'false', 'base', 64, 1, '2018-01-01 00:00:00', 3600, 1),
('user', 'agendaNumberForPatientsOfTheDay', '', 'agendaNumberForPatientsOfTheDay', 'permet d\'indiquer le n° d\'agenda à utiliser pour la liste patients du jour pour cet utilisateur', '', '', 'number', '1', 'base', 64, 1, '2018-01-01 00:00:00', 3600, 1);
