-- Modifications de structure de la bdd d'une version à la suivante

-- 3.0.0 to 3.1.0

update `system` SET `version`='v3.1.0' WHERE `name`='gynobs';

UPDATE `forms` SET `formAction`='/patient/ajax/saveCsForm/' WHERE `internalName` in ('gynObsSyntheseObs', 'gynObsEcho12', 'gynObsConsultGyn', 'gynObsEchoAvt11', 'gynObsColposcopie', 'gynObsFinGrossesse', 'gynObsEcho22', 'gynObsEcho32', 'gynObsConsultObs', 'gynObsEchoGyneco', 'gynObsMarqueursSeriques');

