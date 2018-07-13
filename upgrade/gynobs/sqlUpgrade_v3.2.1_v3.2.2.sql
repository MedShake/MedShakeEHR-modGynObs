-- Modifications des données de la bdd de v3.2.1 à v3.2.2

UPDATE `system` SET `value`='v3.2.2' WHERE `name`='gynobs';

-- Correction des menus de présentation pour écho 22 et 32 
UPDATE `data_types` set `formValues` = 'A: \'céphalique\'\nB: \'céphalique, dos à gauche\'\nC: \'céphalique, dos à droite\'\nD: \'céphalique, dos en avant\'\nE: \'céphalique, dos en arrière\'\nF: \'siège\'\nG: \'siège décomplété, dos à gauche\'\nH: \'siège décomplété, dos à droite\'\nI: \'siège décomplété, dos en arrière\'\nJ: \'siège décomplété, dos en avant\'\nP: \'siège complet, dos à gauche\'\nQ: \'siège complet, dos à droite\'\nK: \'siège complet, dos en arrière\'\nL: \'siège complet, dos en avant\'\nM: \'transverse, tête à gauche\'\nN: \'transverse, tête à droite\'\nO: \'variable\'' where name in ('e32presentationFA', 'e32presentationFB', 'e32presentationFC', 'e22presentationFA', 'e22presentationFB', 'e22presentationFC');
