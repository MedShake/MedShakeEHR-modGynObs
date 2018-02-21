-- Modifications de structure de la bdd d'une version à la suivante
-- 1.1.2 to 1.1.3

INSERT INTO `data_types` (`id`, `groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `type`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
(468, 'medical', 'fmT21NbFoetus', '', 'Nombre de foetus', 'nombre de foetus', '', '', 'number', '1', 'user', 60, 1, '2018-01-01 00:00:00', 3600, 1);

