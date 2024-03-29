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
 * Module > Patient : la page du dossier patient
 * Complément Module Gynéco Obstétrique
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 * @contrib fr33z00 <https://github.com/fr33z00>
 */

// le formulaire latéral ATCD
$formLat = new msForm();
$formLat->setFormIDbyName('gynObsATCD');
$formLat->getPrevaluesForPatient($p['page']['patient']['id']);
$p['page']['formLat'] = $formLat->getForm();
$p['page']['formJavascript']['gynObsATCD'] = $formLat->getFormJavascript();

// si LAP activé : allergie et atcd structurés
if ($p['config']['optionGeActiverLapInterne'] == 'true') {

  // gestion atcd structurés
  if (!empty(trim($p['config']['lapActiverAtcdStrucSur']))) {
    $gethtml = new msGetHtml;
    $gethtml->set_template('inc-patientAtcdStruc');
    foreach (explode(',', $p['config']['lapActiverAtcdStrucSur']) as $v) {
      $p['page']['beforeVar'][$v] = $patient->getAtcdStruc($v);
      if (empty($p['page']['beforeVar'][$v])) $p['page']['beforeVar'][$v] = array('fake');
      $p['page']['formLat']['before'][$v] = $gethtml->genererHtmlVar($p['page']['beforeVar'][$v]);
    }
    unset($p['page']['beforeVar'], $gethtml);
  }

  // gestion allergies structurées
  if (!empty(trim($p['config']['lapActiverAllergiesStrucSur']))) {
    $gethtml = new msGetHtml;
    $gethtml->set_template('inc-patientAllergies');
    foreach (explode(',', $p['config']['lapActiverAllergiesStrucSur']) as $v) {
      $p['page']['beforeVar'][$v] = $patient->getAllergies($v);
      if (empty($p['page']['beforeVar'][$v])) $p['page']['beforeVar'][$v] = array('fake');
      $p['page']['formLat']['before'][$v] = $gethtml->genererHtmlVar($p['page']['beforeVar'][$v]);
    }
    unset($p['page']['beforeVar'], $gethtml);
  }
}

//formulaire synthèse de gynéco
$formSynthese = new msForm();
$formSynthese->setFormIDbyName('gynObsSyntheseGyn');
$formSynthese->getPrevaluesForPatient($p['page']['patient']['id']);
$p['page']['formSynthese'] = $formSynthese->getForm();
$p['page']['formJavascript']['gynObsSyntheseGyn'] = $formSynthese->getFormJavascript();

//données pour formulaire marqueurs sériques
$p['page']['csMarqueursSeriques']['csID'] = msData::getTypeIDFromName('csMarqueursSerT21');
$p['page']['csMarqueursSeriques']['form'] = 'gynObsMarqueursSeriques';

// données pour génotypage rhésus D foetal
$p['page']['csGenotypageRhesusFoetalSangMaternel']['form'] = 'gynobsGenotypageRhesusFoetalSangMaternel';

// liste des typecs qui produisent des docs à signer si grossesse active
$typeCsSignerSiGro = new msData;
$typeCsSignerSiGro->setModules(['gynobs']);
$p['page']['gynobsDocumentsSignerObs'] = $typeCsSignerSiGro->getDataTypesFromCatName('gynobsCatSupportDocumentsSignerObs', array('id', 'label', 'formValues'));

//types de consultation liées à la gynéco classique.
$typeCsCla = new msData;
$p['page']['typeCsCla'] = $typeCsCla->getDataTypesFromCatName('csGyneco', array('id', 'label', 'formValues'));


//chercher une grossesse en cours (cad si pas de type 245 associé)
$marqueurs = $typeCsCla->getTypeIDsFromName(['groFermetureSuivi', 'nouvelleGrossesse']);
$marqueurs['patientID'] =  $p['page']['patient']['id'];

if ($findGro = msSQL::sqlUnique("SELECT pd.id as idGro, eg.id as idFin
  from objets_data as pd
  left join objets_data as eg on pd.id=eg.instance and eg.typeID = :groFermetureSuivi and eg.outdated='' and eg.deleted=''
  where pd.toID = :patientID and pd.typeID = :nouvelleGrossesse and pd.outdated='' and pd.deleted='' order by pd.creationDate desc
  limit 1", $marqueurs)) {
  if (!$findGro['idFin']) {
    $p['page']['grossesseEnCours']['id'] = $findGro['idGro'];

    // générer le formulaire grossesse tête de page.
    $formSyntheseGrossesse = new msForm();
    $formSyntheseGrossesse->setFormIDbyName('gynObsSyntheseObs');
    $formSyntheseGrossesse->setInstance($p['page']['grossesseEnCours']['id']);
    $formSyntheseGrossesse->getPrevaluesForPatient($p['page']['patient']['id']);
    $p['page']['formSyntheseGrossesse'] = $formSyntheseGrossesse->getForm();
    $p['page']['formJavascript']['gynObsSyntheseObs'] = $formSyntheseGrossesse->getFormJavascript();

    //types de consultation liées à la grossesse.
    $typeCsGro = new msData;
    $p['page']['typeCsGro'] = $typeCsGro->getDataTypesFromCatName('csObs', array('id', 'label', 'formValues'));
  }
}

//fixer les paramètres pour les formulaires d'ordonnance
$data = new msData;
$ordos = $data->getDataTypesFromCatName('porteursOrdo', array('id', 'module', 'label', 'description', 'formValues'));
foreach ($ordos as $v) {
  if ($v['module'] == 'gynobs') {
    $p['page']['formOrdo'][] = $v;
  }
}
