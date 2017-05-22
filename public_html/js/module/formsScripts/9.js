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
  $('body').on("keyup, change", '#p_70ID', function() {
    afficherFxNbFoetus();
  });

  //calcul du terme en fonction lcc
  $('body').on("change, keyup", "#p_31ID, #p_89ID, #p_99ID", function() {
    if ($('#p_31ID').val() > 0) majLCC2Terme($('#p_31ID').val(), 113);
    if ($('#p_89ID').val() > 0) majLCC2Terme($('#p_89ID').val(), 114);
    if ($('#p_99ID').val() > 0) majLCC2Terme($('#p_99ID').val(), 115);
  });


  //définir comme DGE
  $('body').on("dblclick", "#p_113ID, #p_114ID, #p_115ID", function(event) {
    setDGE(event);
  });
  $('body').on("click", "#p_113Button, #p_114Button, #p_115Button", function(event) {
    event.preventDefault();
    setDGE(event);
  });

});
