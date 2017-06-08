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
  $('body').on("keyup, change", '#p_131ID', function() {
    afficherFxNbFoetus();
  });


  //calcul du terme en fonction lcc
  $('body').on("change, keyup", "#p_125ID, #p_151ID, #p_165ID", function() {
    //E11
    if ($('#p_125ID').val() > 0) majLCC2Terme($('#p_125ID').val(), 202);
    if ($('#p_151ID').val() > 0) majLCC2Terme($('#p_151ID').val(), 203);
    if ($('#p_165ID').val() > 0) majLCC2Terme($('#p_165ID').val(), 204);
  });
  if ($('#p_125ID').val() > 0) majLCC2Terme($('#p_125ID').val(), 202);
  if ($('#p_151ID').val() > 0) majLCC2Terme($('#p_151ID').val(), 203);
  if ($('#p_165ID').val() > 0) majLCC2Terme($('#p_165ID').val(), 204);

  //définir comme DGE
  $('body').on("dblclick", " #p_202ID, #p_203ID, #p_204ID", function(event) {
    setDGE(event);
  });
  $('body').on("click", " #p_202Button, #p_203Button, #p_204Button", function(event) {
    event.preventDefault();
    setDGE(event);
  });

});
