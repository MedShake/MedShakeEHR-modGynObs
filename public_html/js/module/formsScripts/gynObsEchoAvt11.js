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
 * Js pour le formulaire 12 Echo < 11 SA
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

$(document).ready(function() {

  // observation nombre foetus
  $('body').on("keyup, change", '#id_e11nbembryons_id', function() {
    afficherFxNbFoetus();
  });


  //calcul du terme en fonction lcc
  $('body').on("change, keyup", "#id_e11embryLCCFA_id, #id_e11embryLCCFB_id, #id_e11embryLCCFC_id", function() {
    //E11
    if ($('#id_e11embryLCCFA_id').val() > 0) majLCC2Terme($('#id_e11embryLCCFA_id').val(), '#id_E11termeLCCFA_id');
    if ($('#id_e11embryLCCFB_id').val() > 0) majLCC2Terme($('#id_e11embryLCCFB_id').val(), '#id_E11termeLCCFB_id');
    if ($('#id_e11embryLCCFC_id').val() > 0) majLCC2Terme($('#id_e11embryLCCFC_id').val(), '#id_E11termeLCCFC_id');
  });
  if ($('#id_e11embryLCCFA_id').val() > 0) majLCC2Terme($('#id_e11embryLCCFA_id').val(), '#id_E11termeLCCFA_id');
  if ($('#id_e11embryLCCFB_id').val() > 0) majLCC2Terme($('#id_e11embryLCCFB_id').val(), '#id_E11termeLCCFB_id');
  if ($('#id_e11embryLCCFC_id').val() > 0) majLCC2Terme($('#id_e11embryLCCFC_id').val(), '#id_E11termeLCCFC_id');

  //définir comme DGE
  $('body').on("dblclick", " #id_E11termeLCCFA_id, #id_E11termeLCCFB_id, #id_E11termeLCCFC_id", function(event) {
    setDGE(event);
  });
  $('body').on("click", " #id_E11termeLCCFA_idButton, #id_E11termeLCCFB_idButton, #id_E11termeLCCFC_idButton", function(event) {
    event.preventDefault();
    setDGE(event);
  });

});
