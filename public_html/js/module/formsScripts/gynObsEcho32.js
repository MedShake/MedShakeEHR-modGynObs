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
 * Js pour le formulaire 24 Echo 32 SA
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

$(document).ready(function() {

  //observation nombre foetus
  $('body').on("keyup, change", '#id_nbFoetusEcho32_id', function() {
    afficherFxNbFoetus();
  });

  // calcul du poids et percentils
  $('body').on("change, keyup", "#id_e32bipFA_id, #id_e32bipFB_id, #id_e32bipFC_id, #id_e32pcFA_id, #id_e32paFA_id, #id_e32femurA_id, #id_e32pcFB_id, #id_e32paFB_id, #id_e32femurB_id, #id_e32pcFC_id, #id_e32paFC_id, #id_e32femurC_id", function() {
    poidsFoetal('#id_e32pcFA_id', '#id_e32paFA_id', '#id_e32femurA_id', '#id_e32poidsFA_id');
    poidsFoetal('#id_e32pcFB_id', '#id_e32paFB_id', '#id_e32femurB_id', '#id_e32poidsFB_id');
    poidsFoetal('#id_e32pcFC_id', '#id_e32paFC_id', '#id_e32femurC_id', '#id_e32poidsFC_id');

    //foetus A
    displayPercentiles('#id_e32bipFA_id', 'bip');
    displayPercentiles('#id_e32pcFA_id', 'pc');
    displayPercentiles('#id_e32paFA_id', 'pa');
    displayPercentiles('#id_e32femurA_id', 'lf');

    //foetus B
    if ($('.foetusB').is(':visible')) {
      displayPercentiles('#id_e32bipFB_id', 'bip');
      displayPercentiles('#id_e32pcFB_id', 'pc');
      displayPercentiles('#id_e32paFB_id', 'pa');
      displayPercentiles('#id_e32femurB_id', 'lf');
    }

    //foetus C
    if ($('.foetusC').is(':visible')) {
      displayPercentiles('#id_e32bipFC_id', 'bip');
      displayPercentiles('#id_e32pcFC_id', 'pc');
      displayPercentiles('#id_e32paFC_id', 'pa');
      displayPercentiles('#id_e32femurC_id', 'lf');
    }

    // compléter la conclusion
    conclusionComp();

  });

  // MoM
  $('body').on("change, keyup", "#id_e32dopACMVFA_id, #id_e32dopACMVFB_id, #id_e32dopACMVFC_id", function() {
    mom = momCalc($(this).val(), $('#id_termeDuJour_id').attr('data-tdj4math'));
    idsource = $(this).attr('id');
    if (idsource == 'id_e32dopACMVFA_id') $('#id_e32dopACMMoMFA_id').val(mom);
    if (idsource == 'id_e32dopACMVFB_id') $('#id_e32dopACMMoMFB_id').val(mom);
    if (idsource == 'id_e32dopACMVFC_id') $('#id_e32dopACMMoMFC_id').val(mom);
  });

  //changement de la présentation : adapter la conclusion automatique complémentaire
  $('body').on("change", "#id_e32presentationFA_id, #id_e32presentationFB_id, #id_e32presentationFC_id", function() {
    conclusionComp();
  });

});

function conclusionComp() {
  txt = '';
  nbFoetus = parseInt($('#id_nbFoetusEcho32_id').val());
  if (nbFoetus == '1') {
    if ($('#id_e32poidsFA_id').val() > 0) txt = 'EPF : ' + $('#id_e32poidsFA_id').val() + 'g (' + $('#id_e32poidsFA_idAddOn').text() + ') - Présentation : ' + $('#id_e32presentationFA_id option:selected').text();
  } else if (nbFoetus > 1) {
    if ($('#id_e32poidsFA_id').val() > 0) txt = $.trim('Foetus A - EPF : ' + $('#id_e32poidsFA_id').val() + 'g (' + $('#id_e32poidsFA_idAddOn').text() + ') / Présentation : ' + $('#id_e32presentationFA_id option:selected').text());

    if ($('#id_e32poidsFB_id').val() > 0) txt = txt + "\n" + $.trim('Foetus B - EPF : ' + $('#id_e32poidsFB_id').val() + 'g (' + $('#id_e32poidsFB_idAddOn').text() + ') / Présentation : ' + $('#id_e32presentationFB_id option:selected').text());

    if ($('#id_e32poidsFC_id').val() > 0) txt = txt + "\n" + $.trim('Foetus C - EPF : ' + $('#id_e32poidsFC_id').val() + 'g (' + $('#id_e32poidsFC_idAddOn').text() + ') / Présentation : ' + $('#id_e32presentationFC_id option:selected').text());

  }

  $('#id_e32concluAutomat_id').val(txt);
}
