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

//function afficher masque en fonction nombre foetus
function afficherFxNbFoetus() {
  if ($('#p_70ID').val()) nombreFoetus = $('#p_70ID').val();
  else if ($('#p_131ID').val()) nombreFoetus = $('#p_131ID').val();
  else if ($('#p_244ID').val()) nombreFoetus = $('#p_244ID').val();
  else if ($('#p_254ID').val()) nombreFoetus = $('#p_254ID').val();
  else if ($('#p_327ID').val()) nombreFoetus = $('#p_327ID').val();
  else return true;

  if (nombreFoetus == 1) {
    $('.foetusA').show();
    $('.foetusB').hide();
    $('.foetusC').hide();
    disabledForm('.foetusB');
    disabledForm('.foetusC');
  } else if (nombreFoetus == 2) {
    $('.foetusA').show();
    $('.foetusB').show();
    $('.foetusC').hide();
    enabledForm('.foetusB');
    disabledForm('.foetusC');
  } else if (nombreFoetus == 3) {
    $('.foetusA').show();
    $('.foetusB').show();
    $('.foetusC').show();
    enabledForm('.foetusB');
    enabledForm('.foetusC');
  }

  //activations des autres champs
  //E11
  if ($('#p_131ID').val() > 1) {
    $('#p_171ID').removeAttr('disabled');
    $('#p_172ID').removeAttr('disabled');
  } else {
    $('#p_171ID').attr('disabled', 'disabled');
    $('#p_172ID').attr('disabled', 'disabled');
  }
  //E12
  if ($('#p_70ID').val() > 1) {
    $('#p_209ID').removeAttr('disabled');
    $('#p_210ID').removeAttr('disabled');
  } else {
    $('#p_209ID').attr('disabled', 'disabled');
    $('#p_210ID').attr('disabled', 'disabled');
  }
  //E22
  if ($('#p_254ID').val() > 1) {
    $('#p_255ID').removeAttr('disabled');
    $('#p_256ID').removeAttr('disabled');
  } else {
    $('#p_255ID').attr('disabled', 'disabled');
    $('#p_256ID').attr('disabled', 'disabled');
  }
  //E32
  if ($('#p_327ID').val() > 1) {
    $('#p_328ID').removeAttr('disabled');
  } else {
    $('#p_328ID').attr('disabled', 'disabled');
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

//insatller un DGE à partir du LCC echo
function setDGE(event) {

  //on calcule
  jours = $(event.currentTarget).attr('data-joursa');
  var today = moment();
  dge = today.subtract((jours - 14), 'days').format('DD/MM/YYYY');

  //on demande
  var dgevalid = prompt("Définir le début de grossesse au", dge);

  // on agit
  if (dgevalid != null) {

    $('#p_49ID').val(dgevalid);

    //on sauvegarde
    patientID = $('#identitePatient').attr("data-patientID");
    typeID = 49;
    source = $('#p_49ID');
    instance = $('#p_49ID').closest("form").attr("data-instance");
    setPeopleData(dgevalid, patientID, typeID, source, instance);

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

  $('input[data-typeid="' + cible + '"]').val(string);
  $('input[data-typeid="' + cible + '"]').attr('data-joursa', JA);
  $('#p_' + cible + 'Button').attr('data-joursa', JA);
}

//affichage percentiles
function displayPercentiles(inputSource, type) {

  SA = arrondir10(parseFloat($('#p_50ID').attr('data-tdj4math')));
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
  PC = arrondir100(44.4924 * 1 - (2.7182 * (SA)) * 1 + (0.6673 * Math.pow((SA), 2)) * 1 - (0.0107 * Math.pow((SA), 3)));
  PCds = arrondir100(2.7945 * 1 + (0.345 * (SA)));
  PCzs = arrondir100((PCm - PC) / PCds);
  PC100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (PCzs) - 0.0706 * Math.pow((PCzs), 3)))) * 100);
  return arrondir(PC100);
}

function bip100(BIPm, SA) {
  BIP = arrondir100(31.2452 * 1 - (2.8466 * (SA)) * 1 + (0.2577 * Math.pow((SA), 2)) * 1 - (0.0037 * Math.pow((SA), 3)));
  BIPds = arrondir100(1.5022 * 1 + (0.0636 * (SA)));
  BIPzs = arrondir100((BIPm - BIP) / BIPds);
  BIP100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (BIPzs) - 0.0706 * Math.pow((BIPzs), 3)))) * 100);
  return arrondir(BIP100);
}

function pa100(PAm, SA) {
  PA = arrondir100(42.7794 * 1 - (2.7882 * (SA)) * 1 + (0.5715 * Math.pow((SA), 2)) * 1 - (0.008 * Math.pow((SA), 3)));
  PAds = arrondir100(-2.3658 * 1 + (0.6459 * (SA)));
  PAzs = arrondir100((PAm - PA) / PAds);
  PA100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (PAzs) - 0.0706 * Math.pow((PAzs), 3)))) * 100);
  return arrondir(PA100);
}


function lf100(LFm, SA) {
  LF = arrondir100(-27.085 * 1 + (2.9223 * (SA)) * 1 + (0.0148 * Math.pow((SA), 2)) * 1 - (0.0006 * Math.pow((SA), 3)));
  LFds = arrondir100(1.0809 * 1 + (0.0609 * (SA)));
  LFzs = arrondir100((LFm - LF) / LFds);
  LF100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (LFzs) - 0.0706 * Math.pow((LFzs), 3)))) * 100);
  return arrondir(LF100);
}

function poids100(EPFcalc, SA) {
  EPFatt = arrondir100(Math.pow(2.71828182845904, (0.578 + (0.332 * (SA)) * 1 - (0.00354 * Math.pow((SA), 2)))));
  EPFds = arrondir100(0.127 * (EPFatt));
  EPFzs = arrondir100((EPFcalc - EPFatt) / EPFds);
  EPF100 = arrondir100((1 / (1 + Math.exp(-1.5976 * (EPFzs) - 0.0706 * Math.pow((EPFzs), 3)))) * 100);
  return arrondir(EPF100);
}


// estimation de poids foetal (Hadlock 1985)
function poidsFoetal(pc, pa, lf, cible) {

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

// MoM
function momCalc(v, terme) {
  mom = arrondir100(arrondir100(v) / arrondir100(Math.pow(2.7182818284590, (2.31 + 0.0463878 * terme))));
  return mom;
}

// terme en fonction de la LCC (Robinson)
function lcc2terme(lcc) {
  return Math.floor(8.052 * Math.pow(lcc, 0.5) + 23.73);
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

  if (ddr.length) {

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

// function calcul terme jour accouchement
function termeAccCalc(tdj, ddr, ddg) {

  if (ddr.length) {

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
