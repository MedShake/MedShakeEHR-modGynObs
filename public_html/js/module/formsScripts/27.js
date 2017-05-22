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
 * Js pour le formulaire 27 Echo gyneco
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

$(document).ready(function() {

  //calculer nb jour du cycle
  $('body').on("focusout", '#p_432ID', function() {

    ddr = $('#p_432ID').val();
    var today = moment().startOf('day');
    var ddrm = moment(ddr, "DD-MM-YYYY");

    if (ddrm.isValid()) {
      jours = today.diff(ddrm, 'days')+1;
      $('#p_432IDAddOnG').text('J'+jours);
    }


  });

});
