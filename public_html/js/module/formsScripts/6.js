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
 * Js pour le formulaire 6 Synthèse grossesse en cours
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

$(document).ready(function() {

  // Ajutement de hauteur pour le textarea principal
  $("#formNumber6 textarea").each(function(index) {
    $(this).css("overflow", "hidden");
    auto_grow(this);
  });
  $("#formNumber6 textarea").on("keyup", function() {
    $(this).css("overflow", "auto");
  });

  // Si on change la DDR
  $("#p_45Id").on("dp.change", function(e) {
    calcAndDisplayTdj();
    calcAndDisplayDdgt();
  });


  // Si on change la DDG retenue
  $("#p_49Id").on("dp.change", function(e) {
    calcAndDisplayTdj();
  });

  //close grossesseEnCours
  $('body').on("click", "#closeGro", function(e) {
    if (confirm("Voulez-vous fermer définitivement ce suivi de grossesse ?")) {
      if (confirm("Confirmez-vous réellement ?")) {

      } else {
        e.preventDefault();
      }
    } else {
      e.preventDefault();
    }
  });

  calcAndDisplayDdgt()
  calcAndDisplayTdj();
});

// calculer et afficher terme du jour
function calcAndDisplayTdj() {
  tdj = tdjCalc($('#p_45ID').val(), $('#p_49ID').val());
  if (tdj['status'] == 'ok') {
    $('#p_50ID').val(tdj['human']);
    $('#p_50ID').attr('data-tdj4math', tdj['math']);
  } else {
    $('#p_50ID').val('');
    $('#p_50ID').attr('data-tdj4math', '');
  }
}

//calculer et afficher DDG théo
function calcAndDisplayDdgt() {
  ddgt = ddgtCalc($('#p_45ID').val());
  $('#p_48ID').val(ddgt);
}
