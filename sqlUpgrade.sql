-- Modifications de structure de la bdd d'une version à la suivante

-- 1.0.2 to 1.1.0
INSERT INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('user', 'administratifPeutAvoirAgenda', '', 'administratifPeutAvoirAgenda', 'permet à l\'utilisateur sélectionné d\'avoir son agenda', '', '', 'text', 'false', 'base', 64, 1, '2017-08-09 15:00:18', 3600, 1),
('user', 'agendaNumberForPatientsOfTheDay', '', 'agendaNumberForPatientsOfTheDay', 'permet d\'indiquer le n° d\'agenda à utiliser pour la liste patients du jour pour cet utilisateur', '', '', 'number', '1', 'base', 64, 1, '2017-08-09 17:45:52', 3600, 1);
