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
 * Calculs médicaux
 * Module gynéco obstétrique
 * Le calculs basique sont dans base,
 * accessibles par extension de class
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

class msModGynobsCalcMed extends msModBaseCalcMed
{

/**
 * DDG vers Dates marqueurs T1
 * @param  string $ddg DDG au format d/m/Y
 * @return array      array
 */
    public static function ddg2datesMST21($ddg)
    {
        #dc1 start
        $date = DateTime::createFromFormat('d/m/Y', $ddg);
        $date->add(new DateInterval('P63D'));
        $tab['dc1_s']=$date->format('d/m/Y');
        #dc1 end
        $date = DateTime::createFromFormat('d/m/Y', $ddg);
        $date->add(new DateInterval('P83D'));
        $tab['dc1_e']=$date->format('d/m/Y');

        #ds2 start
        $date = DateTime::createFromFormat('d/m/Y', $ddg);
        $date->add(new DateInterval('P84D'));
        $tab['ds2_s']=$date->format('d/m/Y');
        #ds2 end
        $date = DateTime::createFromFormat('d/m/Y', $ddg);
        $date->add(new DateInterval('P111D'));
        $tab['ds2_e']=$date->format('d/m/Y');

        #ms2 start
        $date = DateTime::createFromFormat('d/m/Y', $ddg);
        $date->add(new DateInterval('P84D'));
        $tab['ms2_s']=$date->format('d/m/Y');
        #ms2 end
        $date = DateTime::createFromFormat('d/m/Y', $ddg);
        $date->add(new DateInterval('P111D'));
        $tab['ms2_e']=$date->format('d/m/Y');

        return $tab;
    }



/**
 * Calculer percentile PC
 * @param  float $PCm PC
 * @param  float $SA  SA
 * @return int      percentile
 */
    public static function pc100($PCm, $SA)
    {
        global $p;
        if(!is_numeric($PCm) or !is_numeric($SA)) return;

        if($p['config']['calcMedGynobsEPF'] == "CFEF") {
          // Hadlock 1985
          $PC = round((44.4924 * 1 - (2.7182 * ($SA)) * 1 + (0.6673 * pow(($SA), 2)) * 1 - (0.0107 * pow(($SA), 3))), 2);
          $PCds = round((2.7945 * 1 + (0.345 * ($SA))), 2);
        } elseif($p['config']['calcMedGynobsEPF'] == "Intergrowth") {
          // Intergrowth
          $PC = -28.2849 + 1.69267 * pow(($SA), 2) - 0.397485 * pow(($SA), 2) * log(($SA));
          $PCds = 1.98735 + 0.0136772 * pow(($SA), 3) - 0.00726264 * pow(($SA), 3) * log(($SA)) + 0.000976253 * pow(($SA), 3) * pow(log(($SA)), 2);
        }

        $PCzs = round(($PCm - $PC) / $PCds, 2);
        $PC100 = round(((1 / (1 + exp(-1.5976 * ($PCzs) - 0.0706 * pow(($PCzs), 3)))) * 100), 2);
        return round($PC100);
    }

/**
 * Calculer percentile BIP
 * @param  float $BIPm BIP
 * @param  float $SA  SA
 * @return int      percentile
 */
    public static function bip100($BIPm, $SA)
    {
        global $p;
        if(!is_numeric($BIPm) or !is_numeric($SA)) return;

        if($p['config']['calcMedGynobsEPF'] == "CFEF") {
          // Hadlock 1985
          $BIP = round((31.2452 * 1 - (2.8466 * ($SA)) * 1 + (0.2577 * pow(($SA), 2)) * 1 - (0.0037 * pow(($SA), 3))), 2);
          $BIPds = round((1.5022 * 1 + (0.0636 * ($SA))), 2);
        } elseif($p['config']['calcMedGynobsEPF'] == "Intergrowth") {
          // Intergrowth
          $BIP = 5.60878 + 0.158369 * pow(($SA), 2) - 0.00256379 * pow(($SA), 3);
          $BIPds = exp(0.101242 + 0.00150557 * pow(($SA), 3) - 0.000771535 * pow(($SA), 3) * log($SA) + 0.0000999638 * pow(($SA), 3) * pow(log($SA), 2));
        }
        $BIPzs = round((($BIPm - $BIP) / $BIPds), 2);
        $BIP100 = round(((1 / (1 + exp(-1.5976 * ($BIPzs) - 0.0706 * pow(($BIPzs), 3)))) * 100), 2);
        return round($BIP100);
    }

/**
 * Calculer percentile PA
 * @param  float $PAm PA
 * @param  float $SA  SA
 * @return int      percentile
 */
    public static function pa100($PAm, $SA)
    {
        global $p;
        if(!is_numeric($PAm) or !is_numeric($SA)) return;
        if($p['config']['calcMedGynobsEPF'] == "CFEF") {
          // Hadlock 1985
          $PA = round((42.7794 * 1 - (2.7882 * ($SA)) * 1 + (0.5715 * pow(($SA), 2)) * 1 - (0.008 * pow(($SA), 3))), 2);
          $PAds = round((-2.3658 * 1 + (0.6459 * ($SA))), 2);
        } elseif($p['config']['calcMedGynobsEPF'] == "Intergrowth") {
          // Intergrowth
          $PA = -81.3243 + 11.6772 * $SA - 0.000561865 * pow(($SA), 3);
          $PAds = -4.36302 + 0.121445 * pow(($SA), 2) - 0.0130256 * pow(($SA), 3) + 0.00282143 * pow(($SA), 3) * log($SA);
        }
        $PAzs = round((($PAm - $PA) / $PAds), 2);
        $PA100 = round(((1 / (1 + exp(-1.5976 * ($PAzs) - 0.0706 * pow(($PAzs), 3)))) * 100), 2);
        return round($PA100);
    }

/**
 * Calculer percentile Fémur
 * @param  float $LFm LF
 * @param  float $SA  SA
 * @return int      percentile
 */
    public static function lf100($LFm, $SA)
    {
      global $p;
        if(!is_numeric($LFm) or !is_numeric($SA)) return;
        if($p['config']['calcMedGynobsEPF'] == "CFEF") {
          // Hadlock 1985
          $LF = round((-27.085 * 1 + (2.9223 * ($SA)) * 1 + (0.0148 * pow(($SA), 2)) * 1 - (0.0006 * pow(($SA), 3))), 2);
          $LFds = round((1.0809 * 1 + (0.0609 * ($SA))), 2);
        } elseif($p['config']['calcMedGynobsEPF'] == "Intergrowth") {
          // Intergrowth
          $LF = -39.9616 + 4.32298 * $SA - 0.0380156 * pow(($SA), 2);
          $LFds = exp(0.605843 - 42.0014 * pow(($SA), -2) + 0.00000917972 * pow(($SA), 3));
        }
        $LFzs = round((($LFm - $LF) / $LFds), 2);
        $LF100 = round(((1 / (1 + exp(-1.5976 * ($LFzs) - 0.0706 * pow(($LFzs), 3)))) * 100), 2);
        return round($LF100);
    }

/**
 * Calculer percentile poids
 * @param  float $EPFcalc PA
 * @param  float $SA  SA
 * @return int      percentile
 */
    public function poids100($EPFcalc, $SA)
    {
        global $p;
        if(!is_numeric($EPFcalc) or !is_numeric($SA)) return;
        if($p['config']['calcMedGynobsEPF'] == "CFEF") {
          // Hadlock 1985
          $EPFatt = round((pow(2.71828182845904, (0.578 + (0.332*($SA)) * 1 - (0.00354 * pow(($SA), 2))))), 2);
          $EPFds = round((0.127 * ($EPFatt)), 2);
          $EPFzs = round((($EPFcalc - $EPFatt)/$EPFds), 2);
          $EPF100 = round(((1/(1 + exp(-1.5976 * ($EPFzs) - 0.0706 * pow(($EPFzs), 3)))) * 100), 2);
        } elseif($p['config']['calcMedGynobsEPF'] == "Intergrowth") {
          // Intergrowth
          $meanExpected = 4.956737 + 0.0005019687 * pow($SA, 3) - 0.0001227065 * pow($SA, 3) * log($SA);
          $cv = 0.0001 * (-6.997171 + 0.057559 * pow($SA, 3) - 0.01493946 * pow($SA, 3) * log($SA));
          $skewness = -4.57629 - 2162.234 * pow($SA, -2) + 0.0002301829 * pow($SA, 3);
          $lnEFW = log($EPFcalc);
          if ($skewness == 0) {
            $zscore = pow($cv, -1) * log($EPFcalc / $meanExpected);
          } else {
            $zscore = pow(($cv*$skewness),-1)*(-1+pow(($lnEFW/$meanExpected),$skewness));
          }
          $EPF100 = round((1 / (1 + exp(-1.5976 * ($zscore) - 0.0706 * pow(($zscore), 3)))) * 100);
        }
        return round($EPF100);
    }

}
