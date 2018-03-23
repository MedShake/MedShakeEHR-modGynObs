-- Modifications de structure de la bdd d'une version à la suivante

-- 3.1.0 to 3.1.1

SET @catID = (SELECT forms_cat.id FROM forms_cat WHERE forms_cat.name='formATCD');
update forms set cat=@catID where internalName = 'gynObsATCD';
