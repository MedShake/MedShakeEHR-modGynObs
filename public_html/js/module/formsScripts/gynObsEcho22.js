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
 * Js pour le formulaire 23 Echo 22 SA
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */


$(document).ready(function() {

  // observation nombre foetus
  $('body').on("keyup, change", '#id_nbFoetusEcho22_id', function() {
    afficherFxNbFoetus();
  });

  // calcul du poids et percentils
  $('body').on("change, keyup", "#id_e22bipFA_id, #id_e22bipFB_id, #id_e22bipFC_id, #id_e22pcFA_id, #id_e22paFA_id, #id_e22femurA_id, #id_e22pcFB_id, #id_e22paFB_id, #id_e22femurB_id, #id_e32pcFC_id, #id_e22paFC_id, #id_e22femurC_id", function() {

    poidsFoetal('#id_e22pcFA_id', '#id_e22paFA_id', '#id_e22femurA_id', '#id_e22poidsFA_id');
    poidsFoetal('#id_e22pcFB_id', '#id_e22paFB_id', '#id_e22femurB_id', '#id_e22poidsFB_id');
    poidsFoetal('#id_e22pcFC_id', '#id_e22paFC_id', '#id_e22femurC_id', '#id_e22poidsFC_id');

    //foetus A
    displayPercentiles('#id_e22bipFA_id', 'bip');
    displayPercentiles('#id_e22pcFA_id', 'pc');
    displayPercentiles('#id_e22paFA_id', 'pa');
    displayPercentiles('#id_e22femurA_id', 'lf');

    //foetus B
    if ($('.foetusB').is(':visible')) {
      displayPercentiles('#id_e22bipFB_id', 'bip');
      displayPercentiles('#id_e22pcFB_id', 'pc');
      displayPercentiles('#id_e22paFB_id', 'pa');
      displayPercentiles('#id_e22femurB_id', 'lf');
    }

    //foetus C
    if ($('.foetusC').is(':visible')) {
      displayPercentiles('#id_e22bipFC_id', 'bip');
      displayPercentiles('#id_e22pcFC_id', 'pc');
      displayPercentiles('#id_e22paFC_id', 'pa');
      displayPercentiles('#id_e22femurC_id', 'lf');
    }
  });

  // MoM
  $('body').on("change, keyup", "#id_e22dopACMVFA_id, #id_e22dopACMVFB_id, #id_e22dopACMVFC_id", function() {
    mom = momCalc($(this).val(), $('#id_termeDuJour_id').attr('data-tdj4math'));
    idsource=$(this).attr('id');
    if(idsource == 'id_e22dopACMVFA_id') $('#id_e22dopACMMoMFA_id').val(mom);
    if(idsource == 'id_e22dopACMVFB_id') $('#id_e22dopACMMoMFB_id').val(mom);
    if(idsource == 'id_e22dopACMVFC_id') $('#id_e22dopACMMoMFC_id').val(mom);
  });


});
