<?php
/*
 * This file is part of MedShakeEHR.
 *
 * Copyright (c) 2017
 * fr33z00 <https://github.com/fr33z00>
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
 * Patient : les requêtes ajax (module)
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */


$m=$match['params']['m'];

$acceptedModes=array(
    'extractReglementForm', //enregistrer un règlement
);

if (!in_array($m, $acceptedModes)) {
    die;
}

//formulaire de réglement : permet de délèguer au formulaire général avec actes du module  
if ($m=='extractReglementForm') {
    $delegate=true;
    include($p['config']['homeDirectory'].'controlers/patient/actions/inc-ajax-extractReglementForm.php');
}
