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
 * Js pour le formulaire 9 Echo 12 SA
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */


$(document).ready(function() {

  //observation nombre foetus
  $('body').on("keyup, change", '#id_nbFoetusEcho12_id', function() {
    afficherFxNbFoetus();
  });

  //calcul du terme en fonction lcc
  $('body').on("change, keyup", "#id_lccA_id, #id_lccB_id, #id_lccC_id", function() {
    if ($('#id_lccA_id').val() > 0) majLCC2Terme($('#id_lccA_id').val(), '#id_termeLCCFA_id');
    if ($('#id_lccB_id').val() > 0) majLCC2Terme($('#id_lccB_id').val(), '#id_termeLCCFB_id');
    if ($('#id_lccC_id').val() > 0) majLCC2Terme($('#id_lccC_id').val(), '#id_termeLCCFC_id');
  });
  if ($('#id_lccA_id').val() > 0) majLCC2Terme($('#id_lccA_id').val(), '#id_termeLCCFA_id');
  if ($('#id_lccB_id').val() > 0) majLCC2Terme($('#id_lccB_id').val(), '#id_termeLCCFB_id');
  if ($('#id_lccC_id').val() > 0) majLCC2Terme($('#id_lccC_id').val(), '#id_termeLCCFC_id');

  //définir comme DGE
  $('body').on("dblclick", "#id_termeLCCFA_id, #id_termeLCCFB_id, #id_termeLCCFC_id", function(event) {
    setDGE(event);
  });
  $('body').on("click", "#id_termeLCCFA_idAddOn, #id_termeLCCFB_idAddOn, #id_termeLCCFC_idAddOn", function(event) {
    event.preventDefault();
    setDGE(event);
  });

});
