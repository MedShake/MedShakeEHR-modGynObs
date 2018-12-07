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
 * Actions communes aux formulaires médicaux et calculs médicaux
 * nécessaires au module
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

/**
 * Actions communes aux formulaires médicaux
 *
 */

$(document).ready(function() {
  //observer #nouvelleCs et ajuster le nombre de foetus quand cela est nécessaire
  var observer = new MutationObserver(function() {
    afficherFxNbFoetus();
  });
  observer.observe(document.getElementById('nouvelleCs'), {
    childList: true
  });

});

//function afficher masque en fonction nombre foetus
function afficherFxNbFoetus() {
  if ($('#id_nbFoetusEcho12_id').val()) nombreFoetus = $('#id_nbFoetusEcho12_id').val();
  else if ($('#id_e11nbembryons_id').val()) nombreFoetus = $('#id_e11nbembryons_id').val();
  else if ($('#id_igNbFoetus_id').val()) nombreFoetus = $('#id_igNbFoetus_id').val();
  else if ($('#id_nbFoetusEcho22_id').val()) nombreFoetus = $('#id_nbFoetusEcho22_id').val();
  else if ($('#id_nbFoetusEcho32_id').val()) nombreFoetus = $('#id_nbFoetusEcho32_id').val();
  else return true;

  if (nombreFoetus == 1) {
    $('.foetusA').removeClass('d-none').addClass('d-flex');
    $('.foetusB, .foetusC').removeClass('d-flex').addClass('d-none');
    disabledForm('.foetusB');
    disabledForm('.foetusC');
  } else if (nombreFoetus == 2) {
    $('.foetusA, .foetusB').removeClass('d-none').addClass('d-flex');
    $('.foetusC').removeClass('d-flex').addClass('d-none');
    enabledForm('.foetusB');
    disabledForm('.foetusC');
  } else if (nombreFoetus == 3) {
    $('.foetusA, .foetusB, .foetusC').removeClass('d-none').addClass('d-flex');
    enabledForm('.foetusB');
    enabledForm('.foetusC');
  }

  //activations des autres champs
  //E11
  if ($('#id_e11nbembryons_id').val() > 1) {
    $('#id_e11typeGro_id').removeAttr('disabled');
    $('#id_e11membrane_id').removeAttr('disabled');
  } else {
    $('#id_e11typeGro_id').attr('disabled', 'disabled');
    $('#id_e11membrane_id').attr('disabled', 'disabled');
  }
  //E12
  if ($('#id_nbFoetusEcho12_id').val() > 1) {
    $('#id_e12typeGro_id').removeAttr('disabled');
    $('#id_e12membrane_id').removeAttr('disabled');
  } else {
    $('#id_e12typeGro_id').attr('disabled', 'disabled');
    $('#id_e12membrane_id').attr('disabled', 'disabled');
  }
  //E22
  if ($('#id_nbFoetusEcho22_id').val() > 1) {
    $('#id_e22typeGro_id').removeAttr('disabled');
    $('#id_e22membrane_id').removeAttr('disabled');
  } else {
    $('#id_e22typeGro_id').attr('disabled', 'disabled');
    $('#id_e22membrane_id').attr('disabled', 'disabled');
  }
  //E32
  if ($('#id_nbFoetusEcho32_id').val() > 1) {
    $('#id_e32typeGro_id').removeAttr('disabled');
  } else {
    $('#id_e32typeGro_id').attr('disabled', 'disabled');
  }
}

//disable
function disabledForm(classToDisabled) {
  $(classToDisabled + ' input').attr('disabled', 'disabled');
  $(classToDisabled + ' select').attr('disabled', 'disabled');
  $(classToDisabled + ' textarea').attr('disabled', 'disabled');
}

//enabled
function enabledForm(classToEnabled) {
  $(classToEnabled + ' input').removeAttr('disabled');
  $(classToEnabled + ' select').removeAttr('disabled', 'disabled');
  $(classToEnabled + ' textarea').removeAttr('disabled', 'disabled');
}

//installer un DGE à partir du LCC echo
function setDGE(event) {

  //on calcule
  if ($(event.currentTarget).attr('data-joursa')) {
    jours = $(event.currentTarget).attr('data-joursa');
  } else {
    jours = $(event.currentTarget).parents('div.form-group').find('input[data-joursa]').attr('data-joursa');
  }
  var today = moment();
  dge = today.subtract((jours - 14), 'days').format('DD/MM/YYYY');

  //on demande
  var dgevalid = prompt("Définir le début de grossesse au", dge);

  // on agit
  if (dgevalid != null) {

    $('#id_ddgReel_id').val(dgevalid);

    //on sauvegarde
    patientID = $('#identitePatient').attr("data-patientID");
    typeName = 'ddgReel';
    source = $('#id_ddgReel_id');
    instance = $('#id_ddgReel_id').closest("form").attr("data-instance");
    setPeopleDataByTypeName(dgevalid, patientID, typeName, source, instance);

    //on met à jour le terme du jour
    calcAndDisplayTdj()

  }
}

// Calculer et afficher le terme à partir de la LCC (echo < 11 et echo 12)
function majLCC2Terme(lcc, cible) {

  JA = lcc2terme(lcc);

  //terme
  semaines = Math.floor(JA / 7);
  jours = JA - semaines * 7;
  string = semaines + 'SA';
  if (jours > 0) string = string + ' + ' + jours + 'J';

  //dge
  var today = moment();
  dge = today.subtract((JA - 14), 'days').format('DD/MM/YYYY');

  string = string + ' - ' + dge;

  $(cible).val(string);
  $(cible).attr('data-joursa', JA);
  $(cible + 'Button').attr('data-joursa', JA);
}

//affichage percentiles
function displayPercentiles(inputSource, type) {

  SA = parseFloat($('#id_termeDuJour_id').attr('data-tdj4math'));
  mesure = $(inputSource).val();

  if (type == 'bip') {
    pct = bip100(mesure, SA);
  } else if (type == 'pc') {
    pct = pc100(mesure, SA);
  } else if (type == 'pa') {
    pct = pa100(mesure, SA);
  } else if (type == 'lf') {
    pct = lf100(mesure, SA);
  } else if (type == 'poids') {
    pct = poids100(mesure, SA);
  }

  if (mesure > 0) $('#' + $(inputSource).attr('id') + 'AddOn').html(pct + ' pc');

}

/**
 * Fonctions JS pour les calcules médicaux
 *
 */


// arrondir
function arrondir(nombre) {
  return Math.round(nombre * 1) / 1
}

function arrondir10(nombre) {
  return Math.round(nombre * 10) / 10
}

function arrondir100(nombre) {
  return Math.round(nombre * 100) / 100
}

//percentiles
function pc100(PCm, SA) {
  if (calcMedGynobsBipPcPaFemPercentiles == 'Intergrowth-21st') {
    PC = -28.2849 + 1.69267 * Math.pow((SA), 2) - 0.397485 * Math.pow((SA), 2) * Math.log((SA));
    PCds = 1.98735 + 0.0136772 * Math.pow((SA), 3) - 0.00726264 * Math.pow((SA), 3) * Math.log((SA)) + 0.000976253 * Math.pow((SA), 3) * Math.pow(Math.log((SA)), 2);
    PCzs = arrondir100((PCm - PC) / PCds);
    PC100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (PCzs) - 0.0706 * Math.pow((PCzs), 3)))) * 100);
    return arrondir(PC100);
  } else if (calcMedGynobsBipPcPaFemPercentiles == 'CFEF 2006') {
    PC = arrondir100(44.4924 * 1 - (2.7182 * (SA)) * 1 + (0.6673 * Math.pow((SA), 2)) * 1 - (0.0107 * Math.pow((SA), 3)));
    PCds = arrondir100(2.7945 * 1 + (0.345 * (SA)));
    PCzs = arrondir100((PCm - PC) / PCds);
    PC100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (PCzs) - 0.0706 * Math.pow((PCzs), 3)))) * 100);
    return arrondir(PC100);
  }
}

function bip100(BIPm, SA) {
  if (calcMedGynobsBipPcPaFemPercentiles == 'Intergrowth-21st') {
    BIP = 5.60878 + 0.158369 * Math.pow((SA), 2) - 0.00256379 * Math.pow((SA), 3);
    BIPds = Math.exp(0.101242 + 0.00150557 * Math.pow((SA), 3) - 0.000771535 * Math.pow((SA), 3) * Math.log(SA) + 0.0000999638 * Math.pow((SA), 3) * Math.pow(Math.log(SA), 2));
    BIPzs = arrondir100((BIPm - BIP) / BIPds);
    BIP100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (BIPzs) - 0.0706 * Math.pow((BIPzs), 3)))) * 100);
    return arrondir(BIP100);
  } else if (calcMedGynobsBipPcPaFemPercentiles == 'CFEF 2006') {
    BIP = arrondir100(31.2452 * 1 - (2.8466 * (SA)) * 1 + (0.2577 * Math.pow((SA), 2)) * 1 - (0.0037 * Math.pow((SA), 3)));
    BIPds = arrondir100(1.5022 * 1 + (0.0636 * (SA)));
    BIPzs = arrondir100((BIPm - BIP) / BIPds);
    BIP100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (BIPzs) - 0.0706 * Math.pow((BIPzs), 3)))) * 100);
    return arrondir(BIP100);
  }
}

function pa100(PAm, SA) {
  if (calcMedGynobsBipPcPaFemPercentiles == 'Intergrowth-21st') {
    PA = -81.3243 + 11.6772 * SA - 0.000561865 * Math.pow((SA), 3);
    PAds = -4.36302 + 0.121445 * Math.pow((SA), 2) - 0.0130256 * Math.pow((SA), 3) + 0.00282143 * Math.pow((SA), 3) * Math.log(SA);
    PAzs = arrondir100((PAm - PA) / PAds);
    PA100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (PAzs) - 0.0706 * Math.pow((PAzs), 3)))) * 100);
    return arrondir(PA100);
  } else if (calcMedGynobsBipPcPaFemPercentiles == 'CFEF 2006') {
    PA = arrondir100(42.7794 * 1 - (2.7882 * (SA)) * 1 + (0.5715 * Math.pow((SA), 2)) * 1 - (0.008 * Math.pow((SA), 3)));
    PAds = arrondir100(-2.3658 * 1 + (0.6459 * (SA)));
    PAzs = arrondir100((PAm - PA) / PAds);
    PA100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (PAzs) - 0.0706 * Math.pow((PAzs), 3)))) * 100);
    return arrondir(PA100);
  }
}

function lf100(LFm, SA) {
  if (calcMedGynobsBipPcPaFemPercentiles == 'Intergrowth-21st') {
    LF = -39.9616 + 4.32298 * SA - 0.0380156 * Math.pow((SA), 2);
    LFds = Math.exp(0.605843 - 42.0014 * Math.pow((SA), -2) + 0.00000917972 * Math.pow((SA), 3));
    LFzs = arrondir100((LFm - LF) / LFds);
    LF100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (LFzs) - 0.0706 * Math.pow((LFzs), 3)))) * 100);
    return arrondir(LF100);
  } else if (calcMedGynobsBipPcPaFemPercentiles == 'CFEF 2006') {
    LF = arrondir100(-27.085 * 1 + (2.9223 * (SA)) * 1 + (0.0148 * Math.pow((SA), 2)) * 1 - (0.0006 * Math.pow((SA), 3)));
    LFds = arrondir100(1.0809 * 1 + (0.0609 * (SA)));
    LFzs = arrondir100((LFm - LF) / LFds);
    LF100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (LFzs) - 0.0706 * Math.pow((LFzs), 3)))) * 100);
    return arrondir(LF100);
  }
}

function poids100(EPFcalc, SA) {
  if (calcMedGynobsEPF == 'Intergrowth-21st') {
    meanExpected = 4.956737 + 0.0005019687 * Math.pow(SA, 3) - 0.0001227065 * Math.pow(SA, 3) * Math.log(SA);
    cv = 0.0001 * (-6.997171 + 0.057559 * Math.pow(SA, 3) - 0.01493946 * Math.pow(SA, 3) * Math.log(SA));
    skewness = -4.57629 - 2162.234 * Math.pow(SA, -2) + 0.0002301829 * Math.pow(SA, 3);
    lnEFW = Math.log(EPFcalc);
    if (skewness == 0) {
      zscore = Math.pow(cv, -1) * log(EPFcalc / meanExpected);
    } else {
      zscore = Math.pow((cv * skewness), -1) * (-1 + Math.pow((lnEFW / meanExpected), skewness));
    }
    EPF100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (zscore) - 0.0706 * Math.pow((zscore), 3)))) * 100);
    return arrondir(EPF100);
  } else if (calcMedGynobsEPF == 'Hadlock 1985') {
    EPFatt = arrondir100(Math.pow(2.71828182845904, (0.578 + (0.332 * (SA)) * 1 - (0.00354 * Math.pow((SA), 2)))));
    EPFds = arrondir100(0.127 * (EPFatt));
    EPFzs = arrondir100((EPFcalc - EPFatt) / EPFds);
    EPF100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (EPFzs) - 0.0706 * Math.pow((EPFzs), 3)))) * 100);
    return arrondir(EPF100);
  }
}

// estimation de poids foetal
function poidsFoetal(pc, pa, lf, cible) {
  if (calcMedGynobsEPF == 'Intergrowth-21st') {
    pc = parseFloat($(pc).val());
    pa = parseFloat($(pa).val());
    lf = parseFloat($(lf).val());

    if (pc > 0 && pa > 0) {
      poids = arrondir(Math.pow(2.71828182845905, (5.084820 - 54.06633 * Math.pow((pa / 1000), 3) - 95.80076 * Math.pow((pa / 1000), 3) * Math.log(pa / 1000) + 3.136370 * (pc / 1000))));

      $(cible).val(poids);
      displayPercentiles(cible, 'poids');
    } else {
      $(cible).val('');
    }
  } else if (calcMedGynobsEPF == 'Hadlock 1985') {
    pc = parseFloat($(pc).val());
    pa = parseFloat($(pa).val());
    lf = parseFloat($(lf).val());

    if (pc > 0 && pa > 0 && lf > 0) {
      poids = arrondir(Math.pow(10, (1.326 + 0.00107 * pc + 0.00438 * pa + 0.0158 * lf - 0.0000326 * pa * lf)));
      $(cible).val(poids);
      displayPercentiles(cible, 'poids');
    } else {
      $(cible).val('');
    }
  }
}

// MoM
function momCalc(v, terme) {
  mom = arrondir100(arrondir100(v) / arrondir100(Math.pow(2.7182818284590, (2.31 + 0.0463878 * terme))));
  return mom;
}

// terme en fonction de la LCC
function lcc2terme(lcc) {
  if (calcMedGynobsLcc2Terme == 'Intergrowth-21st') {
    return Math.round(40.9041 + (3.21585 * Math.pow(lcc, 0.5)) + (0.348956 * lcc));
  } else if (calcMedGynobsLcc2Terme == 'Robinson') {
    return Math.floor(8.052 * Math.pow(lcc, 0.5) + 23.73);
  }
}

// calcul IMC
function imcCalc(poids, taille) {

  taille = taille.replace(",", ".") / 100;
  poids = poids.replace(",", ".");

  if (taille > 0 && poids > 0) {
    imc = Math.round(poids / (taille * taille) * 10) / 10;
    if (imc >= 5 && imc < 90) {
      imc = imc;
    } else {
      imc = '';
    }
    return imc;
  }
}

// calcul DDG théo
function ddgtCalc(ddr) {
  if (moment(ddr, 'DD-MM-YYYY').isValid()) {
    ddg = moment(ddr, "DD-MM-YYYY").add(14, 'days').format('DD/MM/YYYY');
    return ddg;
  } else {
    return '';
  }
}

// calcul terme du jour
function tdjCalc(ddr, ddg) {
  var data = new Array();
  data["status"] = 'ko';

  if (ddr.length || ddg.length) {

    //terme du jour
    var tdjm = moment().startOf('day');
    var ddrm = moment(ddr, "DD-MM-YYYY");
    var ddgcm = moment(ddg, "DD-MM-YYYY");

    if (ddgcm.isValid()) {
      debut = ddgcm.subtract(14, 'days');
    } else if (ddrm.isValid()) {
      debut = ddrm;
    }

    if (debut.isValid()) {
      var diffmonths = tdjm.diff(debut, 'months');
      var diffweeks = tdjm.diff(debut, 'weeks');
      var diffweeksnotrounded = tdjm.diff(debut, 'weeks', true);
      var diffdays = tdjm.diff(debut, 'days');
      var plusdays = diffdays - (7 * diffweeks);
      var resultat = diffweeks + 'SA';
      if (plusdays > 0) resultat += ' + ' + plusdays + 'J';
      if (diffmonths <= 10) {
        data["status"] = 'ok';
        data["human"] = resultat;
        data["math"] = diffweeksnotrounded;
      } else {
        data["status"] = 'ko';
      }
    } else {
      data["status"] = 'ko';
    }
  }

  return data;
}

// calcul terme (9 mois)
function terme9mCalc(ddr, ddg) {
  var data = new Array();
  data["status"] = 'ko';

  if (ddr.length || ddg.length) {

    //terme du jour
    var tdjm = moment().startOf('day');
    var ddrm = moment(ddr, "DD-MM-YYYY");
    var ddgcm = moment(ddg, "DD-MM-YYYY");

    if (ddgcm.isValid()) {
      debut = ddgcm;
    } else if (ddrm.isValid()) {
      debut = ddrm.add(14, 'days');
    }

    if (debut.isValid()) {
      t9 = debut.add(9, 'months').format('DD/MM/YYYY');
      data["status"] = 'ok';
      data["human"] = t9;
    } else {
      data["status"] = 'ko';
    }
  }

  return data;
}

// function calcul terme jour accouchement
function termeAccCalc(tdj, ddr, ddg) {

  if (ddr.length || ddg.length) {

    //terme du jour
    var tdjm = moment(tdj, "DD-MM-YYYY");
    var ddrm = moment(ddr, "DD-MM-YYYY");
    var ddgcm = moment(ddg, "DD-MM-YYYY");

    if (ddgcm.isValid()) {
      debut = ddgcm.subtract(14, 'days');
    } else if (ddrm.isValid()) {
      debut = ddrm;
    }

    if (debut.isValid()) {
      var diffmonths = tdjm.diff(debut, 'months');
      var diffweeks = tdjm.diff(debut, 'weeks');
      var diffdays = tdjm.diff(debut, 'days');
      var plusdays = diffdays - (7 * diffweeks);
      var resultat = diffweeks + 'SA';
      if (plusdays > 0) resultat += ' + ' + plusdays + 'J';
      return resultat;
    } else {
      return null;
    }
  }
}
