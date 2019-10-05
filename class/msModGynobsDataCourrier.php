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
 *
 * Données et calcules complémentaires :
 * - liés à la présence de typeID particuliers dans le tableau de tags
 * passé au modèle de courrier
 * - appelés en fonction du modèle (modeleID) du courrier
 * - appelés par défaut si existe par les methodes de la class msCourrier
 *
 * Module gynéco obstétrique
 *
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

class msModGynobsDataCourrier
{


/**
 * Extractions complémentaires générales pour getCrData() de msCourrier
 * @param  array $d         tableau de tags
 * @return void
 */
  public static function getCrDataCompleteModule(&$d)
  {

    //atcd du patient (data du formulaire latéral)
    $atcd = new msCourrier();
      $atcd = $atcd->getExamenData($d['patientID'], 'gynObsATCD', 0);
      if (is_array($atcd)) {
          $d=$d+$atcd;
      }
  }

/**
 * Extractions complémentaires générales pour getCourrierData() de msCourrier
 * @param  array $d         tableau typeID=>value
 * @return void
 */
  public static function getCourrierDataCompleteModule(&$d)
  {

    $name2typeID = new msData();
    $name2typeID = $name2typeID->getTypeIDsFromName(['groFermetureSuivi', 'nouvelleGrossesse']);

    //Ajouter les data de grossesse pour la rédaction de courrier / certificat
    if ($findGro=msSQL::sqlUnique("select pd.id as idGro, eg.id as idFin
      from objets_data as pd
      left join objets_data as eg on pd.id=eg.instance and eg.typeID='".$name2typeID['groFermetureSuivi']."' and eg.outdated='' and eg.deleted=''
      where pd.toID='".$d['patientID']."' and pd.typeID='".$name2typeID['nouvelleGrossesse']."' and pd.outdated='' and pd.deleted='' order by pd.creationDate desc
      limit 1")) {
        $grossesseData = new msObjet();
        $grossesseData->setObjetID($findGro['idGro']);
        if ($grossesseData = $grossesseData->getObjetAndSons()) {
            foreach ($grossesseData as $k=>$v) {
                $d[$k]=$v['value'];
                $d[$v['name']]=$v['value'];
            }
        }
    }
  }

/**
 * Ajouter des datas pour le modèle de courrier 478 (résumé du dossier)
 * @param  array $d tableau des tags
 * @return void
 */
  public static function getCourrierDataCompleteModuleModele_modeleCourrierResumeDossier(&$d)
  {
    global $p;

    // extraction des ATCD du formulaire lateral
    $atcd = new msCourrier();
    $atcd = $atcd->getExamenData($d['patientID'], 'gynObsATCD', 0);
    if (is_array($atcd)) {
        $d=$d+$atcd;
    }

    // si LAP, extraction des donnéés structurées
    if($p['config']['utiliserLap'] == 'true') {
      $patient = new msPeople;
      $patient->setToID($d['patientID']);
      foreach(explode(',', $p['config']['lapActiverAtcdStrucSur']) as $v) {
        $d['atcdStruc'][$v]=$patient->getAtcdStruc($v);
      }
      foreach(explode(',', $p['config']['lapActiverAllergiesStrucSur']) as $v) {
        $d['allergiesStruc'][$v]=$patient->getAllergies($v);
      }
      $d['ALD']=$patient->getALD();
    }

  }


/**
 * Calcule tout le nécessaire à l'établissement du form gynObsMarqueursSeriques (28) marqueurs sériques T21
 * @param  array $d array des types
 * @return void
 */
      public static function getCrDataCompleteModuleForm_gynObsMarqueursSeriques(&$d)
      {

        $name2typeID = new msData();
        $name2typeID = $name2typeID->getTypeIDsFromName(['echo12']);

        // echo 12 id + date
        if($e12=msSQL::sqlUnique("select id, creationDate from objets_data where toID='".$d['patientID']."' and instance='".$d['instance']."' and typeID='".$name2typeID['echo12']."' and deleted='' and outdated='' order by id desc limit 1 ")) {
          $d['dateEcho12'] = $e12['creationDate'];
          // data echo 12 de la même grossesse
          $dataE12 = new msCourrier();
          $d=$d+$dataE12->getExamenData($d['patientID'], 'gynObsEcho12', $e12['id']);
        }

        //Définition du modèle de page d'impression
        $d['templateCrHeadAndFoot']='empty.html.twig';

        //calcul limite dépistage
        $dates=msModGynobsCalcMed::ddg2datesMST21($d['ddgReel']);
        if (is_array($dates)) {
            $d=$d+$dates;
        }
      }


/**
 * Calcule tout le nécessaire à l'établissement du form gynObsDPNI
 * @param  array $d array des types
 * @return void
 */
      public static function getCrDataCompleteModuleForm_gynObsDPNI(&$d)
      {

        $name2typeID = new msData();
        $name2typeID = $name2typeID->getTypeIDsFromName(['echo12']);

        // echo 12 id + date
        if($e12=msSQL::sqlUnique("select id, creationDate from objets_data where toID='".$d['patientID']."' and instance='".$d['instance']."' and typeID='".$name2typeID['echo12']."' and deleted='' and outdated='' order by id desc limit 1 ")) {
          $d['dateEcho12'] = $e12['creationDate'];
          // data echo 12 de la même grossesse
          $dataE12 = new msCourrier();
          $d=$d+$dataE12->getExamenData($d['patientID'], 'gynObsEcho12', $e12['id']);
        }

      }


/**
 * Calcule tout le nécessaire à l'établissement du form gynobsGenotypageRhesusFoetalSangMaternel
 * @param  array $d array des types
 * @return void
 */
      public static function getCrDataCompleteModuleForm_gynobsGenotypageRhesusFoetalSangMaternel(&$d)
      {
        //Définition du modèle de page d'impression
        $d['templateCrHeadAndFoot']='empty.html.twig';
      }


  /**
   * Calcules complémentaires à l présence du type 36
   * @param  array $d array des types
   * @return void
   */
      public static function type_poids_CompleteData(&$d)
      {
          if (isset($d['taillePatient'])) {
              $d['imc']=msModGynobsCalcMed::imc($d['poids'], $d['taillePatient']);
          }
      }

  /**
   * Calcules complémentaires à l présence du type 45
   * @param  array $d array des types
   * @return void
   */
      public static function type_DDR_CompleteData(&$d)
      {
          if (msTools::validateDate($d['DDR'], 'd/m/Y')) {
              $d['ddg']=msModGynobsCalcMed::ddr2ddg($d['DDR']);
              $d['termeDuJour']=msModGynobsCalcMed::ddr2terme($d['DDR'], date('d/m/Y', strtotime($d['date'])));
          }
      }

  /**
   * Calcules complémentaires à l présence du type 49
   * @param  array $d array des types
   * @return void
   */
      public static function type_ddgReel_CompleteData(&$d)
      {
          if (msTools::validateDate($d['ddgReel'], 'd/m/Y')) {
              $d['termeReelJourExamen']=msModGynobsCalcMed::ddg2terme($d['ddgReel'], date('d/m/Y', strtotime($d['date'])));
              $d['termeReelJourExamenMath']=msModGynobsCalcMed::ddg2termeMath($d['ddgReel'], date('d/m/Y', strtotime($d['date'])));
          }
      }

  /**
  * Calculer percentiles pour l'écho 22
  * @param  array $d array avec data examen
  * @return void
  */
    //foetus A
      public static function type_e22bipFA_CompleteData(&$d)
      {
          $d['pct263']=$d['pct_e22bipFA']=msModGynobsCalcMed::bip100($d['e22bipFA'], $d['termeReelJourExamenMath']);
      }
    public static function type_e22pcFA_CompleteData(&$d)
    {
        $d['pct264']=$d['pct_e22pcFA']=msModGynobsCalcMed::pc100($d['e22pcFA'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22paFA_CompleteData(&$d)
    {
        $d['pct265']=$d['pct_e22paFA']=msModGynobsCalcMed::pa100($d['e22paFA'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22femurA_CompleteData(&$d)
    {
        $d['pct266']=$d['pct_e22femurA']=msModGynobsCalcMed::lf100($d['e22femurA'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22poidsFA_CompleteData(&$d)
    {
        $d['pct267']=$d['pct_e22poidsFA']=msModGynobsCalcMed::poids100($d['e22poidsFA'], $d['termeReelJourExamenMath']);
    }
      //foetus B
      public static function type_e22bipFB_CompleteData(&$d)
      {
          $d['pct287']=$d['pct_e22bipFB']=msModGynobsCalcMed::bip100($d['e22bipFB'], $d['termeReelJourExamenMath']);
      }
    public static function type_e22pcFB_CompleteData(&$d)
    {
        $d['pct316']=$d['pct_e22pcFB']=msModGynobsCalcMed::pc100($d['e22pcFB'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22paFB_CompleteData(&$d)
    {
        $d['pct314']=$d['pct_e22paFB']=msModGynobsCalcMed::pa100($d['e22paFB'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22femurB_CompleteData(&$d)
    {
        $d['pct304']=$d['pct_e22femurB']=msModGynobsCalcMed::lf100($d['e22femurB'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22poidsFB_CompleteData(&$d)
    {
        $d['pct320']=$d['pct_e22poidsFB']=msModGynobsCalcMed::poids100($d['e22poidsFB'], $d['termeReelJourExamenMath']);
    }
      //foetus C
      public static function type_e22bipFC_CompleteData(&$d)
      {
          $d['pct289']=$d['pct_e22bipFC']=msModGynobsCalcMed::bip100($d['e22bipFC'], $d['termeReelJourExamenMath']);
      }
    public static function type_e22pcFC_CompleteData(&$d)
    {
        $d['pct317']=$d['pct_e22pcFC']=msModGynobsCalcMed::pc100($d['e22pcFC'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22paFC_CompleteData(&$d)
    {
        $d['pct315']=$d['pct_e22paFC']=msModGynobsCalcMed::pa100($d['e22paFC'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22femurC_CompleteData(&$d)
    {
        $d['pct305']=$d['pct_e22femurC']=msModGynobsCalcMed::lf100($d['e22femurC'], $d['termeReelJourExamenMath']);
    }
    public static function type_e22poidsFC_CompleteData(&$d)
    {
        $d['pct321']=$d['pct_e22poidsFC']=msModGynobsCalcMed::poids100($d['e22poidsFC'], $d['termeReelJourExamenMath']);
    }


    /**
    * Calculer percentiles pour l'écho 32
    * @param  array $d array avec data examen
    * @return void
    */
      public static function type_e32bipFA_CompleteData(&$d)
      {
          $d['pct336']=$d['pct_e32bipFA']=msModGynobsCalcMed::bip100($d['e32bipFA'], $d['termeReelJourExamenMath']);
      }
    public static function type_e32pcFA_CompleteData(&$d)
    {
        $d['pct337']=$d['pct_e32pcFA']=msModGynobsCalcMed::pc100($d['e32pcFA'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32paFA_CompleteData(&$d)
    {
        $d['pct338']=$d['pct_e32paFA']=msModGynobsCalcMed::pa100($d['e32paFA'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32femurA_CompleteData(&$d)
    {
        $d['pct339']=$d['pct_e32femurA']=msModGynobsCalcMed::lf100($d['e32femurA'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32poidsFA_CompleteData(&$d)
    {
        $d['pct340']=$d['pct_e32poidsFA']=msModGynobsCalcMed::poids100($d['e32poidsFA'], $d['termeReelJourExamenMath']);
    }

      //foetus B
      public static function type_e32bipFB_CompleteData(&$d)
      {
          $d['pct360']=$d['pct_e32bipFB']=msModGynobsCalcMed::bip100($d['e32bipFB'], $d['termeReelJourExamenMath']);
      }
    public static function type_e32pcFB_CompleteData(&$d)
    {
        $d['pct389']=$d['pct_e32pcFB']=msModGynobsCalcMed::pc100($d['e32pcFB'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32paFB_CompleteData(&$d)
    {
        $d['pct387']=$d['pct_e32paFB']=msModGynobsCalcMed::pa100($d['e32paFB'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32femurB_CompleteData(&$d)
    {
        $d['pct377']=$d['pct_e32femurB']=msModGynobsCalcMed::lf100($d['e32femurB'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32poidsFB_CompleteData(&$d)
    {
        $d['pct393']=$d['pct_e32poidsFB']=msModGynobsCalcMed::poids100($d['e32poidsFB'], $d['termeReelJourExamenMath']);
    }

      //foetus C
      public static function type_e32bipFC_CompleteData(&$d)
      {
          $d['pct362']=$d['pct_e32bipFC']=msModGynobsCalcMed::bip100($d['e32bipFC'], $d['termeReelJourExamenMath']);
      }
    public static function type_e32pcFC_CompleteData(&$d)
    {
        $d['pct390']=$d['pct_e32pcFC']=msModGynobsCalcMed::pc100($d['e32pcFC'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32paFC_CompleteData(&$d)
    {
        $d['pct388']=$d['pct_e32paFC']=msModGynobsCalcMed::pa100($d['e32paFC'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32femurC_CompleteData(&$d)
    {
        $d['pct378']=$d['pct_e32femurC']=msModGynobsCalcMed::lf100($d['e32femurC'], $d['termeReelJourExamenMath']);
    }
    public static function type_e32poidsFC_CompleteData(&$d)
    {
        $d['pct394']=$d['pct_e32poidsFC']=msModGynobsCalcMed::poids100($d['e32poidsFC'], $d['termeReelJourExamenMath']);
    }
}
