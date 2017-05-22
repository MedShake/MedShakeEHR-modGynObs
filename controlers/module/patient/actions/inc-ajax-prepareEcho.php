<?php
/*
 * This file is part of MedShakeEHR.
 *
 * Copyright (c) 2017
 * Bertrand Boutillier <b.boutillier@gmail.com>
 * http://www.medshake.net
 *
 * MedShakeEHR is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * MedShakeEHR is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MedShakeEHR.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * Patient > ajax : générer le fichier DICOM worklist pour Orthanc
 * Module gynéco obstétrique
 *
 * Inclusion avant l'envoi au template pour extraction de data spécifique à la spé
 * dans le fichier worklist : ici data sur grossesse
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

 //chercher une grossesse en cours (cad si pas de type 245 associé)
 if ($findGro=msSQL::sqlUnique("select pd.id as idGro, eg.id as idFin
   from objets_data as pd
   left join objets_data as eg on pd.id=eg.instance and eg.typeID='245' and eg.outdated='' and eg.deleted=''
   where pd.toID='".$_POST['patientID']."' and pd.typeID=46 and pd.outdated='' and pd.deleted='' order by pd.creationDate desc
   limit 1")) {
     if (!$findGro['idFin']) {
         $p['page']['grossesseEnCours']['id']=$findGro['idGro'];

         // générer le formulaire grossesse tête de page.
         $formSyntheseGrossesse = new msForm();
         $formSyntheseGrossesse->setFormID(6);
         $formSyntheseGrossesse->setInstance($p['page']['grossesseEnCours']['id']);
         $p['page']['dataGrossesse']=$formSyntheseGrossesse->getPrevaluesForPatient($_POST['patientID']);

         if (isset($p['page']['dataGrossesse'][49])) {
             $p['page']['patient']['dicomDDR']=msTools::readableDate2Reverse(msModuleCalcMed::ddg2ddr($p['page']['dataGrossesse'][49]));
         } elseif (isset($p['page']['dataGrossesse'][45])) {
             $p['page']['patient']['dicomDDR']=msTools::readableDate2Reverse($p['page']['dataGrossesse'][45]);
         }
     }
 }

 ?>
