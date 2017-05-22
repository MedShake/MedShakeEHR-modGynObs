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
  $('body').on("keyup, change", '#p_254ID', function() {
    afficherFxNbFoetus();
  });

  // calcul du poids et percentils
  $('body').on("change, keyup", "#p_263ID, #p_287ID, #p_289ID, #p_264ID, #p_265ID, #p_266ID, #p_316ID, #p_314ID, #p_304ID, #p_390ID, #p_315ID, #p_305ID", function() {
    poidsFoetal('#p_264ID', '#p_265ID', '#p_266ID', '#p_267ID');
    poidsFoetal('#p_316ID', '#p_314ID', '#p_304ID', '#p_320ID');
    poidsFoetal('#p_317ID', '#p_315ID', '#p_305ID', '#p_321ID');

    //foetus A
    displayPercentiles('#p_263ID', 'bip');
    displayPercentiles('#p_264ID', 'pc');
    displayPercentiles('#p_265ID', 'pa');
    displayPercentiles('#p_266ID', 'lf');

    //foetus B
    if ($('.foetusB').is(':visible')) {
      displayPercentiles('#p_287ID', 'bip');
      displayPercentiles('#p_316ID', 'pc');
      displayPercentiles('#p_314ID', 'pa');
      displayPercentiles('#p_304ID', 'lf');
    }

    //foetus C
    if ($('.foetusC').is(':visible')) {
      displayPercentiles('#p_289ID', 'bip');
      displayPercentiles('#p_317ID', 'pc');
      displayPercentiles('#p_315ID', 'pa');
      displayPercentiles('#p_305ID', 'lf');
    }
  });

  // MoM
  $('body').on("change, keyup", "#p_275ID, #p_294ID, #p_295ID", function() {
    mom = momCalc($(this).val(), $('#p_50ID').attr('data-tdj4math'));
    idsource=$(this).attr('data-typeid');
    if(idsource == '275') $('#p_276ID').val(mom);
    if(idsource == '294') $('#p_292ID').val(mom);
    if(idsource == '295') $('#p_293ID').val(mom);
  });


});
