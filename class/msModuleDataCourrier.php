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

class msModuleDataCourrier
{


/**
 * Extractions complémentaires générales pour getCrData() de msCourrier
 * @param  array $d         tableau de tags
 * @return void
 */
  public static function getCrDataCompleteModule(&$d) {

    //atcd du patient (data du formulaire latéral)
    $atcd = new msCourrier();
    $atcd = $atcd->getExamenData($d['patientID'], 'gynObsATCD', 0);
    if(is_array($atcd)) {
      $d=$d+$atcd;
    }

  }

/**
 * Extractions complémentaires générales pour getCourrierData() de msCourrier
 * @param  array $d         tableau typeID=>value
 * @return void
 */
  public static function getCourrierDataCompleteModule(&$d) {

    //Ajouter les data de grossesse pour la rédaction de courrier / certificat
    if ($findGro=msSQL::sqlUnique("select pd.id as idGro, eg.id as idFin
      from objets_data as pd
      left join objets_data as eg on pd.id=eg.instance and eg.typeID='245' and eg.outdated='' and eg.deleted=''
      where pd.toID='".$d['patientID']."' and pd.typeID=46 and pd.outdated='' and pd.deleted='' order by pd.creationDate desc
      limit 1")) {

        $grossesseData = new msObjet();
        if($grossesseData = $grossesseData->getObjetAndSons($findGro['idGro'])) {
          foreach($grossesseData as $k=>$v) {
            $d[$k]=$v['value'];
          }
        }

      }
  }

/**
 * Ajouter des datas pour le modèle de courrier 478 (résumé du dossier)
 * @param  array $d tableau des tags
 * @return void
 */
  public static function getCourrierDataCompleteModuleModele478(&$d) {

    // extraction des ATCD
    $atcd = new msCourrier();
    $atcd = $atcd->getExamenData($d['patientID'], 'gynObsATCD', 0);
    if(is_array($atcd)) {
      $d=$d+$atcd;
    }
  }


/**
 * Calcule tout le nécessaire à l'établissement du form 28 marqueurs sériques T21
 * @param  array $d array des types
 * @return void
 */
      public static function getCourrierDataCompleteModuleForm28(&$d) {

        // echo 12 id + date
        $e12=msSQL::sqlUnique("select id, creationDate from objets_data where toID='".$d['patientID']."' and instance='".$d['instance']."' and typeID='33' and deleted='' and outdated='' limit 1 ");
        $d['dateEcho12'] = $e12['creationDate'];

        // data echo 12 de la même grossesse
        $dataE12 = new msCourrier();
        $d=$d+$dataE12->getExamenData($d['patientID'], 'gynObsEcho12', $e12['id']);

        //Définition du modèle de page d'impression
        $d['templateCrHeadAndFoot']='empty.html.twig';

        //calcul limite dépistage
        $dates=msModuleCalcMed::ddg2datesMST21($d[49]);
        if(is_array($dates)) {
          $d=$d+$dates;
        }
      }



  /**
   * Calcules complémentaires à l présence du type 36
   * @param  array $d array des types
   * @return void
   */
      public static function type34CompleteData(&$d)
      {
          if (isset($d[35])) {
              $d[43]=msModuleCalcMed::imc($d[34], $d[35]);
          }
      }

  /**
   * Calcules complémentaires à l présence du type 45
   * @param  array $d array des types
   * @return void
   */
      public static function type45CompleteData(&$d)
      {
          $d[48]=msModuleCalcMed::ddr2ddg($d[45]);
          $d[50]=msModuleCalcMed::ddr2terme($d[45], date('d/m/Y', strtotime($d['date'])));
      }

  /**
   * Calcules complémentaires à l présence du type 49
   * @param  array $d array des types
   * @return void
   */
      public static function type49CompleteData(&$d)
      {
          $d['termeReelJourExamen']=msModuleCalcMed::ddg2terme($d[49], date('d/m/Y', strtotime($d['date'])));
          $d['termeReelJourExamenMath']=msModuleCalcMed::ddg2termeMath($d[49], date('d/m/Y', strtotime($d['date'])));
      }

  /**
  * Calculer percentiles pour l'écho 22
  * @param  array $d array avec data examen
  * @return void
  */
    //foetus A
      public static function type263CompleteData(&$d)
      {
          $d['pct263']=msModuleCalcMed::bip100($d[263], $d['termeReelJourExamenMath']);
      }
      public static function type264CompleteData(&$d)
      {
          $d['pct264']=msModuleCalcMed::pc100($d[264], $d['termeReelJourExamenMath']);
      }
      public static function type265CompleteData(&$d)
      {
          $d['pct265']=msModuleCalcMed::pa100($d[265], $d['termeReelJourExamenMath']);
      }
      public static function type266CompleteData(&$d)
      {
          $d['pct266']=msModuleCalcMed::lf100($d[266], $d['termeReelJourExamenMath']);
      }
      public static function type267CompleteData(&$d)
      {
          $d['pct267']=msModuleCalcMed::poids100($d[267], $d['termeReelJourExamenMath']);
      }
      //foetus B
      public static function type287CompleteData(&$d)
      {
          $d['pct287']=msModuleCalcMed::bip100($d[287], $d['termeReelJourExamenMath']);
      }
      public static function type316CompleteData(&$d)
      {
          $d['pct316']=msModuleCalcMed::pc100($d[316], $d['termeReelJourExamenMath']);
      }
      public static function type314CompleteData(&$d)
      {
          $d['pct314']=msModuleCalcMed::pa100($d[314], $d['termeReelJourExamenMath']);
      }
      public static function type304CompleteData(&$d)
      {
          $d['pct304']=msModuleCalcMed::lf100($d[304], $d['termeReelJourExamenMath']);
      }
      public static function type320CompleteData(&$d)
      {
          $d['pct320']=msModuleCalcMed::poids100($d[320], $d['termeReelJourExamenMath']);
      }
      //foetus C
      public static function type289CompleteData(&$d)
      {
          $d['pct289']=msModuleCalcMed::bip100($d[289], $d['termeReelJourExamenMath']);
      }
      public static function type317CompleteData(&$d)
      {
          $d['pct317']=msModuleCalcMed::pc100($d[317], $d['termeReelJourExamenMath']);
      }
      public static function type315CompleteData(&$d)
      {
          $d['pct315']=msModuleCalcMed::pa100($d[315], $d['termeReelJourExamenMath']);
      }
      public static function type305CompleteData(&$d)
      {
          $d['pct305']=msModuleCalcMed::lf100($d[305], $d['termeReelJourExamenMath']);
      }
      public static function type321CompleteData(&$d)
      {
          $d['pct321']=msModuleCalcMed::poids100($d[321], $d['termeReelJourExamenMath']);
      }


    /**
    * Calculer percentiles pour l'écho 32
    * @param  array $d array avec data examen
    * @return void
    */
      public static function type336CompleteData(&$d)
      {
          $d['pct336']=msModuleCalcMed::bip100($d[336], $d['termeReelJourExamenMath']);
      }
      public static function type337CompleteData(&$d)
      {
          $d['pct337']=msModuleCalcMed::pc100($d[337], $d['termeReelJourExamenMath']);
      }
      public static function type338CompleteData(&$d)
      {
          $d['pct338']=msModuleCalcMed::pa100($d[338], $d['termeReelJourExamenMath']);
      }
      public static function type339CompleteData(&$d)
      {
          $d['pct339']=msModuleCalcMed::lf100($d[339], $d['termeReelJourExamenMath']);
      }
      public static function type340CompleteData(&$d)
      {
          $d['pct340']=msModuleCalcMed::poids100($d[340], $d['termeReelJourExamenMath']);
      }

      //foetus B
      public static function type360CompleteData(&$d)
      {
          $d['pct360']=msModuleCalcMed::bip100($d[360], $d['termeReelJourExamenMath']);
      }
      public static function type389CompleteData(&$d)
      {
          $d['pct389']=msModuleCalcMed::pc100($d[389], $d['termeReelJourExamenMath']);
      }
      public static function type387CompleteData(&$d)
      {
          $d['pct387']=msModuleCalcMed::pa100($d[387], $d['termeReelJourExamenMath']);
      }
      public static function type377CompleteData(&$d)
      {
          $d['pct377']=msModuleCalcMed::lf100($d[377], $d['termeReelJourExamenMath']);
      }
      public static function type393CompleteData(&$d)
      {
          $d['pct393']=msModuleCalcMed::poids100($d[393], $d['termeReelJourExamenMath']);
      }

      //foetus C
      public static function type362CompleteData(&$d)
      {
          $d['pct362']=msModuleCalcMed::bip100($d[362], $d['termeReelJourExamenMath']);
      }
      public static function type390CompleteData(&$d)
      {
          $d['pct390']=msModuleCalcMed::pc100($d[390], $d['termeReelJourExamenMath']);
      }
      public static function type388CompleteData(&$d)
      {
          $d['pct388']=msModuleCalcMed::pa100($d[388], $d['termeReelJourExamenMath']);
      }
      public static function type378CompleteData(&$d)
      {
          $d['pct378']=msModuleCalcMed::lf100($d[378], $d['termeReelJourExamenMath']);
      }
      public static function type394CompleteData(&$d)
      {
          $d['pct394']=msModuleCalcMed::poids100($d[394], $d['termeReelJourExamenMath']);
      }

}
