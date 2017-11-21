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
 * Js pour le formulaire 5 (synthèse gynéco patiente)
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

$(document).ready(function() {

  // ajustement automatique de la hauteur des textarea
  $("#formName_gynObsSyntheseGyn textarea").each(function( index ) {
    $(this).css("overflow","hidden");
    auto_grow(this);
  });

  $("#formName_gynObsSyntheseGyn textarea").on("keyup", function() {
      $(this).css("overflow","auto");
  });

  //bouton de nouvelle grossesse
  $("a.newGro").on("click", function(e) {
    if (!confirm('Voulez-vous installer un nouveau suivi de grossesse ?')) {
      e.preventDefault();
    }

  });

});
