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
 * Traitement d'une donnée avant enregistrement pour formatage
 * Module gynéco obstétrique
 *
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

class msModGynobsDataSave
{

  /**
   * La suite n'est pas documentée mais s'analyse très simplement :
   * l'ID variable dans le nom de la method correspond au typeID
   */

      // dates clefs pour éviter les mauvaises suprises d'un javascript défaillant
      public function correctionDateBeforeSave($value) {
        $value=trim($value);
        if(is_numeric($value) and strlen($value)==8) {
          $value=$value{0}.$value{1}.'/'.$value{2}.$value{3}.'/'.$value{4}.$value{5}.$value{6}.$value{7};
        }
        return $value;
      }
      public function tbs_DDR($value)
      {
          return $this->correctionDateBeforeSave($value);
      }
      public function tbs_ddgReel($value)
      {
          return $this->correctionDateBeforeSave($value);
      }

      // identité : nom en majuscule, prenom 1er lettre maj
      public function tbs_lastname($value)
      {
          return  mb_strtoupper($value);
      }

      public function tbs_birthname($value)
      {
          return  mb_strtoupper($value);
      }

      public function tbs_firstname($value)
      {
          return mb_convert_case($value, MB_CASE_TITLE, "UTF-8");
      }

      public function tbs_othersfirstname($value)
      {
          return mb_convert_case($value, MB_CASE_TITLE, "UTF-8");
      }

      // format téléphone et fax
      public function telephoneNumberTreatBeforeSave($value)
      {
          $tel = str_replace(' ', '', $value);
          if (strlen($tel) == 10) {
              $tel = preg_replace('/(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/', '\1 \2 \3 \4 \5', $tel);
              return $tel;
          } else {
            return $value;
          }

      }

      public function tbs_mobilePhone($value)
      {
          return $this->telephoneNumberTreatBeforeSave($value);
      }

      public function tbs_homePhone($value)
      {
          return $this->telephoneNumberTreatBeforeSave($value);
      }

      public function tbs_telPro($value)
      {
          return $this->telephoneNumberTreatBeforeSave($value);
      }

      public function tbs_faxPro($value)
      {
          return $this->telephoneNumberTreatBeforeSave($value);
      }

      public function tbs_mobilePhonePro($value)
      {
          return $this->telephoneNumberTreatBeforeSave($value);
      }

      public function tbs_telPro2($value)
      {
          return $this->telephoneNumberTreatBeforeSave($value);
      }

      //ville : en majuscule
      public function tbs_city($value)
      {
          return  mb_strtoupper($value);
      }

      public function tbs_villeAdressePro($value)
      {
          return  mb_strtoupper($value);
      }

      //Règle le problème du séparateur décimales
      public function formatDecimalNumber($value)
      {
          return str_replace(',', '.', $value);
      }
      public function tbs_regleCheque($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_regleCB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_regleEspeces($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_regleFacture($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_regleTarifCejour($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_regleDepaCejour($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_regleTiersPayeur($value)
      {
          return $this->formatDecimalNumber($value);
      }

      //Biomètrie écho 22 et 32
      public function tbs_e22bipFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22bipFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22bipFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22femurA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22femurB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22femurC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22paFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22paFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22paFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22pcFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22pcFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22pcFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32bipFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32bipFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32bipFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32femurA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32femurB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32femurC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32paFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32paFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32paFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32pcFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32pcFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32pcFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22pgcfa($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22pgcfb($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e22pgcfc($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32pgcfa($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32pgcfb($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e32pgcfc($value)
      {
          return $this->formatDecimalNumber($value);
      }


      //biométrie écho 12
      public function tbs_bipFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_bipFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_bipFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_cnFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_cnFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_cnFC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e12femurA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e12femurB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_e12femurC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_lccA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_lccB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_lccC($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_paFA($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_paFB($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_paFC($value)
      {
          return $this->formatDecimalNumber($value);
      }

      //biométrie écho gyn
      public function tbs_eGynEndomEpai($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_eGynUterusHauteur($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_eGynUterusLong($value)
      {
          return $this->formatDecimalNumber($value);
      }
      public function tbs_eGynUterusLarg($value)
      {
          return $this->formatDecimalNumber($value);
      }

}
