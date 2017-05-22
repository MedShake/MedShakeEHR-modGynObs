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
  $('body').on("keyup, change", '#p_327ID', function() {
    afficherFxNbFoetus();
  });

  // calcul du poids et percentils
  $('body').on("change, keyup", "#p_336ID, #p_360ID, #p_362ID, #p_337ID, #p_338ID, #p_339ID, #p_389ID, #p_387ID, #p_377ID, #p_390ID, #p_388ID, #p_378ID", function() {
    poidsFoetal('#p_337ID', '#p_338ID', '#p_339ID', '#p_340ID');
    poidsFoetal('#p_389ID', '#p_387ID', '#p_377ID', '#p_393ID');
    poidsFoetal('#p_390ID', '#p_388ID', '#p_378ID', '#p_394ID');

    //foetus A
    displayPercentiles('#p_336ID', 'bip');
    displayPercentiles('#p_337ID', 'pc');
    displayPercentiles('#p_338ID', 'pa');
    displayPercentiles('#p_339ID', 'lf');

    //foetus B
    if ($('.foetusB').is(':visible')) {
      displayPercentiles('#p_360ID', 'bip');
      displayPercentiles('#p_389ID', 'pc');
      displayPercentiles('#p_387ID', 'pa');
      displayPercentiles('#p_377ID', 'lf');
    }

    //foetus C
    if ($('.foetusC').is(':visible')) {
      displayPercentiles('#p_362ID', 'bip');
      displayPercentiles('#p_390ID', 'pc');
      displayPercentiles('#p_388ID', 'pa');
      displayPercentiles('#p_378ID', 'lf');
    }

    // compléter la conclusion
    conclusionComp();

  });

  // MoM
  $('body').on("change, keyup", "#p_348ID, #p_367ID, #p_368ID", function() {
    mom = momCalc($(this).val(), $('#p_50ID').attr('data-tdj4math'));
    idsource = $(this).attr('data-typeid');
    if (idsource == '348') $('#p_349ID').val(mom);
    if (idsource == '367') $('#p_365ID').val(mom);
    if (idsource == '368') $('#p_366ID').val(mom);
  });

  //changement de la présentation : adapter la conclusion automatique complémentaire
  $('body').on("change", "#p_332ID, #p_395ID, #p_396ID", function() {
    conclusionComp();
  });

});

function conclusionComp() {
  txt = '';
  nbFoetus = parseInt($('#p_327ID').val());
  if (nbFoetus == '1') {
    if ($('#p_340ID').val() > 0) txt = 'EPF : ' + $('#p_340ID').val() + 'g (' + $('#p_340IDAddOn').text() + ') - Présentation : ' + $('#p_332ID option:selected').text();
  } else if (nbFoetus > 1) {
    if ($('#p_340ID').val() > 0) txt = $.trim('Foetus A - EPF : ' + $('#p_340ID').val() + 'g (' + $('#p_340IDAddOn').text() + ') / Présentation : ' + $('#p_332ID option:selected').text());

    if ($('#p_393ID').val() > 0) txt = txt + "\n" + $.trim('Foetus B - EPF : ' + $('#p_393ID').val() + 'g (' + $('#p_393IDAddOn').text() + ') / Présentation : ' + $('#p_395ID option:selected').text());

    if ($('#p_394ID').val() > 0) txt = txt + "\n" + $.trim('Foetus C - EPF : ' + $('#p_394ID').val() + 'g (' + $('#p_394IDAddOn').text() + ') / Présentation : ' + $('#p_396ID option:selected').text());

  }

  $('#p_445ID').val(txt);
}
